/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        SPDIF peripheral device driver.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver for WB_SPDIF peripheral.
 */

#include <assert.h>
#include <pal.h>
#include <interrupts.h>
#include <per_spdif.h>
#include <drv_spdif.h>

#include "drv_spdif_cfg_instance.h"

// runtime driver data
struct spdif_s
{
    uintptr_t           baseaddress;
    int32_t             *tx_buffer;
    int                 tx_buffer_size;
    int                 tx_buffer_head;
    volatile int        tx_buffer_tail;
    int32_t             *rx_buffer;
    int                 rx_buffer_size;
    volatile int        rx_buffer_head;
    int                 rx_buffer_tail;

    uint32_t            base_freq;
    uint32_t            samplerate;             // 32000, 44100 or 48000
    spdif_output_mode_t tx_mode;                // Stereo mode: 0 = stereo, 1 = native mono, 2 = copied mono

    int                 lshift;
};

// runtime driver table
static spdif_t drv_table[DRV_SPDIF_INSTANCE_COUNT];

// native interrupt handler
void __INTERRUPT_NATIVE spdif_isr(void);
static unsigned spdif_set_prescaler( spdif_t * restrict drv, unsigned samplerate, unsigned base_freq );

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both an SPDIF core and its driver.
 * You should call it only once per driver instance id.
 *
 * @param id
 *          Valid driver id (defined in devices.h)
 *
 * @return  Driver pointer if successful initialization, NULL otherwise.
 */
spdif_t * spdif_open(unsigned id)
{
    assert( id < DRV_SPDIF_INSTANCE_COUNT );

    spdif_t * restrict drv = &drv_table[id];

    if ( drv->baseaddress == 0 )
    {
        // get configuration of driver (created by plugin system)
        drv_spdif_cfg_instance_t * restrict drv_cfg = &drv_spdif_instance_table[id];
        // get configuration of peripheral below driver (created by plugin system)
        per_spdif_cfg_instance_t * restrict per_cfg = &per_spdif_instance_table[drv_cfg->per_spdif];

        // First stop a possibly operating SPDIF core and reset it
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress      = per_cfg->baseaddress;
        SPDIF_RX_CONFIG(drv->baseaddress) = SPDIF_RX_FIFO_RST | SPDIF_RX_RST;
        SPDIF_TX_CONFIG(drv->baseaddress) = SPDIF_TX_FIFO_RST | SPDIF_TX_RST;

        SPDIF_RX_CONFIG(per_cfg->baseaddress) = 0;
        SPDIF_TX_CONFIG(per_cfg->baseaddress) = SPDIF_TX_FRAME_ENABLE | SPDIF_TX_PARITY_ENABLE;

        drv->samplerate         = drv_cfg->samplerate;
        drv->tx_mode          = drv_cfg->tx_mode;
        drv->lshift             = 0;

        drv->tx_buffer          = drv_cfg->tx_buffer;
        drv->tx_buffer_size     = drv_cfg->tx_buffer_size;
        drv->tx_buffer_head     = 0;
        drv->tx_buffer_tail     = 0;

        drv->rx_buffer          = drv_cfg->rx_buffer;
        drv->rx_buffer_size     = drv_cfg->rx_buffer_size;
        drv->rx_buffer_head     = 0;
        drv->rx_buffer_tail     = 0;

        // Initialize hardware registers
        SPDIF_RX_FIFO_WATERMARK(per_cfg->baseaddress) = drv_cfg->rx_watermark;
        SPDIF_TX_FIFO_WATERMARK(per_cfg->baseaddress) = drv_cfg->tx_watermark;

        drv->base_freq = pal_freq_hz();
        spdif_set_prescaler( drv, drv->samplerate, pal_freq_hz());

        if (((drv->tx_buffer_size != 0) && (drv->tx_buffer != NULL)) ||
            ((drv->rx_buffer_size != 0) && (drv->rx_buffer != NULL)))
        {
        
            if ( drv->rx_buffer_size != 0 )
            {
                SPDIF_RX_CONFIG(per_cfg->baseaddress) |= SPDIF_RX_IE | SPDIF_RX_IE_FIFO_AF;
            }
            if ( drv->tx_buffer_size != 0 )
            {
                SPDIF_TX_CONFIG(per_cfg->baseaddress) |= SPDIF_TX_IE | SPDIF_TX_IE_FIFO_ALMOST_EMPTY;
            }
        
            // driver has a software buffer, use native interrupt
            interrupt_register_native(per_cfg->spdif_interrupt, (void*) drv, spdif_isr );
            interrupt_configure(per_cfg->spdif_interrupt, LEVEL_HIGH );
            interrupt_acknowledge(per_cfg->spdif_interrupt );
            interrupt_enable(per_cfg->spdif_interrupt );
        }
    }
    return drv;
}

/*
 * This is the interrupt handler. It is fired if either the transmit FIFO is almost empty or if the
 * receiver FIFO is almost full.
 */

void __INTERRUPT_NATIVE spdif_isr(void)
{
    uint32_t    intr = interrupt_get_current();
    spdif_t     * drv = interrupt_native_context(intr);
    uintptr_t   baseaddress = drv->baseaddress;

    uint32_t    samples;
    uint32_t    bufsize;
    uint32_t    buftail;
    uint32_t    bufhead;
    int32_t     * buffer;
    uint32_t    chunk;

    if (samples = SPDIF_RX_DATA_COUNT( baseaddress ), samples )
    {
        // Receiver has samples waiting for us
        buffer = drv->rx_buffer;
        bufsize = drv->rx_buffer_size - 1;
        buftail = drv->rx_buffer_tail;
        bufhead = drv->rx_buffer_head;

        chunk = bufsize + bufhead - buftail;
        if ( chunk > bufsize ) chunk -= bufsize;
        if ( chunk > samples )
        {
            chunk = samples;
        }
        else
        {
            // Software buffer full when we're done
            SPDIF_RX_CONFIG( baseaddress ) &= ~SPDIF_RX_IE;
        }

        while( chunk-- )
        {
            buffer[bufhead++] = SPDIF_RX_DATA( baseaddress );
            if ( bufhead == bufsize ) bufhead = 0;
        }
        drv->rx_buffer_head = bufhead;

    }

    if ( samples = SPDIF_TX_FIFO_FREE_SLOTS( baseaddress ), samples )
    {
        // Transmitter has free slots
        buffer = drv->tx_buffer;
        bufsize = drv->tx_buffer_size;
        buftail = drv->tx_buffer_tail;
        bufhead = drv->tx_buffer_head;
        chunk = bufsize + buftail - bufhead;
        if ( chunk > bufsize ) chunk -= bufsize;
        if ( drv->tx_mode != DRV_SPDIF_TX_MODE_STEREO ) chunk /= 2;
        else chunk &= ~1;

        if ( chunk > samples )
        {
            chunk = samples;
        }
        else
        {
            // Software buffer will be empty when we're done
            SPDIF_TX_CONFIG( baseaddress ) &= ~SPDIF_TX_IE;
        }

        switch( drv->tx_mode )
        {
        case DRV_SPDIF_TX_MODE_MONO :   // True mono, set secondary channel to "invalid"
            while( chunk-- )
            {
                SPDIF_TX_DATA( baseaddress ) = buffer[buftail];
                SPDIF_TX_DATA( baseaddress ) = SPDIF_DATA_DV;
                if ( ++buftail == bufsize ) buftail = 0;
            }
            break;
        case DRV_SPDIF_TX_MODE_MONODUP :    // Duplicate mono channel on secondary channel
            while( chunk-- )
            {
                SPDIF_TX_DATA( baseaddress ) = buffer[buftail];
                SPDIF_TX_DATA( baseaddress ) = buffer[buftail];
                if ( ++buftail == bufsize ) buftail = 0;
            }
            break;
        default :                           // Stereo
            while( chunk-- )
            {
                SPDIF_TX_DATA( baseaddress ) = buffer[buftail++];
                if ( buftail == bufsize ) buftail = 0;
            }
            break;
        }
        drv->rx_buffer_tail = buftail;
    }

    interrupt_acknowledge(intr);
}

/*
 * Compute the prescaler and derive the real sample frequency from what is possible
 */

static unsigned spdif_set_prescaler( spdif_t * restrict drv, unsigned samplerate, unsigned base_freq )
{
    assert( drv != NULL );

    uint32_t divisor = base_freq / (samplerate * 128);
    SPDIF_TX_PRESCALER( drv->baseaddress ) = divisor - 1;
    SPDIF_TX_CONFIG( drv->baseaddress ) |= SPDIF_TX_PRESCALER_EN;
    samplerate = base_freq / (128 * divisor);
    drv->samplerate = samplerate;
    return samplerate;
}

/**
 * @brief Set samplefrequency
 *
 * This function tries to set a samplerate for the transmitter (either 32k, 44k1 or 48k)
 *
 * @param drv   device pointer obtained from the spdif_open routine
 * @param samplerate  Samplerate to be set (32000, 44100 or 48000)
 *
 * @return Samplerate actually set (this may be different if samplerates could not be realized).
 */

unsigned spdif_set_samplefrequency( spdif_t * restrict drv, unsigned samplerate )
{
    assert( drv != NULL );

    if ( (samplerate == 32000) || (samplerate == 44100) || (samplerate == 48000))
    {
        spdif_set_prescaler( drv, samplerate, drv->base_freq );
    }
    return drv->samplerate;
}

/**
 * @brief write a number of 32-bit aligned samples.
 *
 * @param   drv   device pointer obtained from the spdif_open routine
 * @param   buffer          start address of buffer with samples, starting with left channel
 * @param   samples         number of samples
 *
 * @return  Number of samples actually written
 */
int spdif_write32(spdif_t * restrict drv, int32_t * buffer, int samples)
{
    uintptr_t baseaddress = drv->baseaddress;
    int32_t * drv_buffer;
    int drv_bufsize = drv->tx_buffer_size;
    int lshift = drv->lshift;
    int drv_buffree;
    int head;
    int tail;
    int i;

    assert( drv != NULL );
    assert( buffer != NULL );

    if (samples == 0) return 0;

    if ( drv_bufsize > 0 )
    {
        // Interrupt mode, just write data to our buffer and enable writing
        drv_buffer = drv->tx_buffer;

        // First determine how much space there is in the software buffer
        head = drv->tx_buffer_head;
        tail = drv->tx_buffer_tail;
        drv_buffree = drv_bufsize - head + tail - 1;
        if ( drv_buffree >= drv_bufsize ) drv_buffree -= drv_bufsize;
        if ( drv_buffree < samples ) samples = drv_buffree;

        // In stereo, we make sure to always provide both, left and right channels at the same time.
        // This may not be needed when everything goes as it should, but in case of an underflow we
        // don't want the channels to swap unexpectedly.
        if ( drv->tx_mode == DRV_SPDIF_TX_MODE_STEREO ) samples &= ~1;

        // Now simply dump 'm
        for ( i = 0; i < samples; i++ )
        {
            drv_buffer[head++] = (buffer[i] << lshift) & SPDIF_DATA_MASK;
            if ( head == drv_bufsize ) head = 0;

        }
        drv->tx_buffer_head = head;
        SPDIF_TX_CONFIG( baseaddress ) |= SPDIF_TX_IE;
    }
    else
    {
        // No software buffering, just put the samples in the hardware
        i = SPDIF_TX_FIFO_FREE_SLOTS( baseaddress );

        // In mono, we either duplicate the secondary channel or mark it invalid - we must write it though.
        // Thus, the real space is half the number of samples. The division by two also takes care of
        // channel swapping problems in case of underflow.
        if ( drv->tx_mode != DRV_SPDIF_TX_MODE_STEREO ) i /= 2;

        if ( samples > i ) samples = i;

        switch( drv->tx_mode )
        {
        case DRV_SPDIF_TX_MODE_MONO :                   // Transmit secondary channel as "invalid"
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (buffer[i] << lshift) & SPDIF_DATA_MASK;
            }
            break;
        case DRV_SPDIF_TX_MODE_MONODUP :      // Repeat primary channel in secondary slot
            for ( i = 0; i < samples; i++ )
            {
                int32_t sample = (buffer[i] << lshift) & SPDIF_DATA_MASK;
                SPDIF_TX_DATA( baseaddress ) = sample;
                SPDIF_TX_DATA( baseaddress ) = sample;
            }
            break;
        default :                               // True stereo
            samples &= ~1;                      // Always write an even number of samples,
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (buffer[i] << lshift) & SPDIF_DATA_MASK;
            }
        }
    }
    return samples;

}

/**
 * @brief write a number of 16-bit samples.
 *
 * @param   drv     device pointer obtained from the spdif_open routine
 * @param   buffer  start address of buffer with samples, starting with left channel
 * @param   samples number of samples
 *
 * @return  Number of samples actually written
 */
int spdif_write16(spdif_t * restrict drv, int16_t * buffer, int samples )
{
    uintptr_t baseaddress = drv->baseaddress;
    int32_t * drv_buffer;
    int drv_bufsize = drv->tx_buffer_size;
    int drv_buffree;
    int head;
    int tail;
    int i;

    assert( drv != NULL );
    assert( buffer != NULL );

    if (samples == 0) return 0;

    if ( drv_bufsize > 0 )
    {
        // Interrupt mode, just write data to our buffer and enable writing
        drv_buffer = drv->tx_buffer;
        head = drv->tx_buffer_head;
        tail = drv->tx_buffer_tail;
        drv_buffree = drv_bufsize - head + tail - 1;
        if ( drv_buffree >= drv_bufsize ) drv_buffree -= drv_bufsize;
        if ( drv_buffree < samples ) samples = drv_buffree;
        if ( drv->tx_mode == DRV_SPDIF_TX_MODE_STEREO ) samples &= ~1;

        for ( i = 0; i < samples; i++ )
        {
            drv_buffer[head++] = (((int32_t)buffer[i]) << 8) & SPDIF_DATA_MASK;
            if ( head == drv_bufsize ) head = 0;
        }
        drv->tx_buffer_head = head;
        SPDIF_TX_CONFIG( baseaddress ) |= SPDIF_TX_IE;
    }
    else
    {
        // Polling mode, send data immediately

        i = SPDIF_TX_FIFO_FREE_SLOTS( baseaddress );
        if ( drv->tx_mode != DRV_SPDIF_TX_MODE_STEREO ) i /= 2;
        if ( samples > i ) samples = i;

        switch( drv->tx_mode )
        {
        case DRV_SPDIF_TX_MODE_MONO :         // Transmit secondary channel as "invalid"
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (((int32_t)buffer[i]) << 8) & SPDIF_DATA_MASK;
                SPDIF_TX_DATA( baseaddress ) = SPDIF_DATA_DV;
            }
            break;
        case DRV_SPDIF_TX_MODE_MONODUP :      // Repeat primary channel in secondary slot
            for ( i = 0; i < samples; i++ )
            {
                int32_t sample = (((int32_t)buffer[i]) << 8) & SPDIF_DATA_MASK;
                SPDIF_TX_DATA( baseaddress ) = sample;
                SPDIF_TX_DATA( baseaddress ) = sample;
            }
            break;
        default :                               // True stereo
            samples &= ~1;                            // Make even
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (((int32_t)buffer[i]) << 8) & SPDIF_DATA_MASK;
            }
        }
    }
    return samples;

}

/**
 * @brief write a number of 8-bit samples.
 *
 * @param   drv     device pointer obtained from the spdif_open routine
 * @param   buffer  start address of buffer with samples, starting with left channel
 * @param   samples number of samples
 *
 * @return  Number of samples actually written
 */
int spdif_write8(spdif_t * restrict drv, int8_t * buffer, int samples )
{
    uintptr_t baseaddress = drv->baseaddress;
    int32_t * drv_buffer;
    int drv_bufsize = drv->tx_buffer_size;
    int drv_buffree;
    int head;
    int tail;
    int i;

    assert( drv != NULL );
    assert( buffer != NULL );

    if (samples == 0) return 0;

    if ( drv_bufsize > 0 )
    {
        // Interrupt mode, just write data to our buffer and enable writing
        drv_buffer = drv->tx_buffer;
        head = drv->tx_buffer_head;
        tail = drv->tx_buffer_tail;
        drv_buffree = drv_bufsize - head + tail - 1;
        if ( drv_buffree >= drv_bufsize ) drv_buffree -= drv_bufsize;
        if ( drv_buffree < samples ) samples = drv_buffree;          
        if ( drv->tx_mode == DRV_SPDIF_TX_MODE_STEREO ) samples &= ~1;

        for ( i = 0; i < samples; i++ )
        {
            drv_buffer[head++] = (((int32_t)buffer[i]) << 16) & SPDIF_DATA_MASK;
            if ( head == drv_bufsize ) head = 0;
        }
        drv->tx_buffer_head = head;
        SPDIF_TX_CONFIG( baseaddress ) |= SPDIF_TX_IE;
    }
    else
    {
        i = SPDIF_TX_FIFO_FREE_SLOTS( baseaddress );
        if ( drv->tx_mode != DRV_SPDIF_TX_MODE_STEREO ) i /= 2;
        if ( samples > i ) samples = i;
        
        switch( drv->tx_mode )
        {
        case DRV_SPDIF_TX_MODE_MONO :         // Transmit secondary channel as "invalid"
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (((int32_t)buffer[i]) << 16) & SPDIF_DATA_MASK;
                SPDIF_TX_DATA( baseaddress ) = SPDIF_DATA_DV;
            }
            break;
        case DRV_SPDIF_TX_MODE_MONODUP :      // Repeat primary channel in secondary slot
            for ( i = 0; i < samples; i++ )
            {
                int32_t sample = (((int32_t)buffer[i]) << 16) & SPDIF_DATA_MASK;
                SPDIF_TX_DATA( baseaddress ) = sample;
                SPDIF_TX_DATA( baseaddress ) = sample;
            }
            break;
        default :                               // True stereo
            samples &= ~1;                            // Make even
            for ( i = 0; i < samples; i++ )
            {
                SPDIF_TX_DATA( baseaddress ) = (((int32_t)buffer[i]) << 16) & SPDIF_DATA_MASK;
            }
        
        }
    }
    return samples;

}

/**
 * @brief   read a number of samples
 *
 * @param   drv     device pointer (obtained from the spdif_open routine)
 * @param   buffer      start address of buffer for samples
 * @param   n           number of requested samples
 *
 * @return  Number of samples actually read
 */
int spdif_read(spdif_t * restrict drv, int32_t * buffer, int n)
{
    uintptr_t baseaddress = drv->baseaddress;
    int rx_buffer_size = drv->rx_buffer_size;
    int i;

    assert( drv != NULL );
    assert( buffer != NULL );

    if (n == 0) return 0;

    if ( rx_buffer_size > 0 )
    {
        //  Interrupt mode, fetch data from software buffer
        int32_t * rx_buffer = drv->rx_buffer;
        int rx_buffer_tail = drv->rx_buffer_tail;

        i = drv->rx_buffer_head - rx_buffer_tail;   // Compute number of samples in receive buffer
        if ( i < 0 ) i += rx_buffer_size;           // Correction if head has wrapped and tail has not
        if ( i < n ) n = i;                         // Correct request size if number of bytes requested > number of bytes available

        for ( i = 0; i < n; i++ )
        {
            buffer[i] = rx_buffer[rx_buffer_tail++];
            if ( rx_buffer_tail == rx_buffer_size ) rx_buffer_tail = 0;
        }
        drv->rx_buffer_tail = rx_buffer_tail;
        SPDIF_RX_CONFIG( baseaddress ) |= SPDIF_RX_IE;   // Re-enable interrupt mechanism (could be switched off!)
    }
    else
    {
        // Polling mode, fetch data directly from hardware
        i = SPDIF_RX_DATA_COUNT( baseaddress );
        if ( i < n ) n = i;
        for ( i = 0; i < n; i++ )
        {
            buffer[i] = SPDIF_RX_DATA( baseaddress );
        }
    }
    return n;
}

/**
 * @brief   get the number of samples that are available in the receive buffer
 *
 * @param   drv device pointer (obtained from the spdif_open routine)
 *
 * @return  number of samples that can be read from receive buffer
 */

unsigned int spdif_rx_avail(spdif_t * restrict drv)
{
    unsigned int retval;

    assert( drv != NULL );

    if (drv->rx_buffer_size > 0)
    {
        /* Software buffer, if (head == tail) then empty */
        retval = drv->rx_buffer_size + drv->rx_buffer_head - drv->rx_buffer_tail;
        if (retval >= drv->rx_buffer_size)
        {
            retval -= drv->rx_buffer_size;
        }
    }
    else
    {
        /* Hardware buffer, if (head == tail) then full */
        retval = SPDIF_RX_DATA_COUNT( drv->baseaddress );
    }
    return retval;
}

/**
 * @brief   Set the output mode
 *
 * This function sets the transmitter to stereo, mono or monodup. Note: this will flush the transmitter!
 *
 * @param   drv  device pointer
 * @param   mode mode to set transmitter to
 *
 * @return  None
 */

void spdif_set_outputmode( spdif_t * restrict drv, spdif_output_mode_t mode )
{
    SPDIF_TX_CONFIG( drv->baseaddress ) &= ~SPDIF_TX_ENABLE;
    spdif_tx_fifo_reset( drv );
    drv->tx_buffer_head = 0;
    drv->tx_buffer_tail = 0;
    drv->tx_mode = mode;
}

/**
 * @brief   start transmitting audio samples
 *
 * @param   drv     device pointer
 *
 * @return  None
 */
void spdif_tx_start(spdif_t * restrict drv)
{
    assert( drv != NULL );
    SPDIF_TX_CONFIG(drv->baseaddress) |= SPDIF_TX_ENABLE;
}


/**
 * @brief   stop transmitting audio samples
 *
 * @param   drv     device pointer
 *
 * @return  None
 */
void spdif_tx_stop(spdif_t * restrict drv)
{
    assert( drv != NULL );
    SPDIF_TX_CONFIG(drv->baseaddress) &= ~SPDIF_TX_ENABLE;
}


/**
 * @brief   start receiving audio samples
 *
 * @param   drv     device pointer
 *
 * @return  None
 */
void spdif_rx_start(spdif_t * restrict drv)
{
    assert( drv != NULL );
    SPDIF_RX_CONFIG(drv->baseaddress) |= SPDIF_RX_ENABLE;
}


/**
 * @brief   stop receiving audio samples
 *
 * @param   drv     device pointer
 *
 * @return  None
 */
void spdif_rx_stop(spdif_t * restrict drv)
{
    assert( drv != NULL );
    SPDIF_RX_CONFIG(drv->baseaddress) &= ~SPDIF_RX_ENABLE;
}

/**
 * @brief Define the number of bits a sample must be shifted to the left for 32-bit write interface
 *
 * Use this function to force the device driver to shift the samples before transmitting them. Since spdif
 * supports wordlength of 20 or 24 bit only, use this function to shift the samples into position.

 * For example: if you have 20-bit samples (right aligned) set this to 4.
 * If you actually use 32-bit samples, set the shift value to -8.
 *
 * Note: this function works for 32-bit write interface only!
 *
 * @param drv   device pointer obtained from the spdif_open routine
 * @param shift amount of bits to shift
 *
 * @return Nothing
 */

void spdif_set_shift(spdif_t * restrict drv, int shift )
{
    assert( drv != NULL );

    if ( shift > 15 ) shift = 0;

    drv->lshift = shift;
}

/**
 * @brief   set transmitter watermark
 *
 * @param   drv   device pointer
 * @param   value           new watermark value
 *
 * @return  none
 */
void spdif_set_tx_watermark(spdif_t * restrict drv, uint16_t value)
{
    assert( drv != NULL );

    SPDIF_TX_FIFO_WATERMARK(drv->baseaddress) = value;
}

/**
 * @brief   set receiver watermark
 *
 * @param   drv   device pointer
 * @param   value           new watermark value
 *
 * @return  none
 */
void spdif_set_rx_watermark(spdif_t * restrict drv, uint16_t value)
{
    assert( drv != NULL );

    SPDIF_RX_FIFO_WATERMARK(drv->baseaddress) = value;
}


/**
 * @brief Reset the receiver
 *
 * @param    drv   device pointer
 *
 * @return Nothing
 */

void spdif_rx_reset( spdif_t * restrict drv )
{
    assert( drv != NULL );

    uint32_t cfg = SPDIF_RX_CONFIG(drv->baseaddress);
    SPDIF_RX_CONFIG(drv->baseaddress) = cfg | SPDIF_RX_FIFO_RST | SPDIF_RX_RST;
    SPDIF_RX_CONFIG(drv->baseaddress) = cfg;
}

/**
 * @brief Reset the receiver's FIFO only
 *
 * @param    drv   device pointer
 *
 * @return Nothing
 */

void spdif_rx_fifo_reset( spdif_t * restrict drv )
{
    assert( drv != NULL );

    uint32_t cfg = SPDIF_RX_CONFIG(drv->baseaddress);
    SPDIF_RX_CONFIG(drv->baseaddress) = cfg | SPDIF_RX_FIFO_RST;
    SPDIF_RX_CONFIG(drv->baseaddress) = cfg;
}

/**
 * @brief Reset the transmitter
 *
 * @param    drv   device pointer
 *
 * @return Nothing
 */

void spdif_tx_reset( spdif_t * restrict drv )
{
    assert( drv != NULL );

    uint32_t cfg = SPDIF_TX_CONFIG(drv->baseaddress);
    SPDIF_TX_CONFIG(drv->baseaddress) = cfg | SPDIF_TX_FIFO_RST | SPDIF_TX_RST;
    SPDIF_TX_CONFIG(drv->baseaddress) = cfg;
}

/**
 * @brief Reset the transmitter's FIFO only
 *
 * @param    drv device pointer
 *
 * @return Nothing
 */

void spdif_tx_fifo_reset( spdif_t * restrict drv )
{
    assert( drv != NULL );

    uint32_t cfg = SPDIF_TX_CONFIG(drv->baseaddress);
    SPDIF_TX_CONFIG(drv->baseaddress) = cfg | SPDIF_TX_FIFO_RST;
    SPDIF_TX_CONFIG(drv->baseaddress) = cfg;
}

/**
 * @brief Set status channel bitstream
 *
 * This function sets the channel status. Use this function to inject channel status information
 * in the transmitter. You can send up to 192 bits per channel, 2 channels = 384 bits. The channel
 * status should conform to either IEC60958-3 for linear PCM audio in a consumer application or
 * to IEC60958-4 for linear PCM audio in a professional application. For non-linear PCM refer to
 * IEC61937 or to IEC62105 for generic data transfer.
 *
 * Data organization should be: bit 0 = element #0, bit 0, bit 15 = element #0, bit 15, bit 16 = element #1 bit 0 etc.
 *
 * @param drv device pointer obtained from the spdif_open routine
 * @param left pointer to channel status array for left channel
 * @param right pointer to  channel status array for right channel
 * @param size number of bits per channel (max 192)
 *
 * @return Nothing
*/

void spdif_write_status_bitstream( spdif_t * restrict drv, uint16_t * left, uint16_t * right, int size )
{
    int i;

    assert( drv != NULL );
    assert( left != NULL );
    assert( right != NULL );

    if ( size > 192 ) size = 192;
    if ( size < 1 ) return;

    SPDIF_TX_CONFIG( drv->baseaddress ) &= ~SPDIF_TX_USE_USER_DATA;
    for ( i = 0; i < size / 16; i++ )
    {
        SPDIF_TX_CHANNEL_STATUS( drv->baseaddress ) = ((uint32_t)left[i]) << 16 | right[i];
    }
    size &= 0x0F;
    if ( size )
    {
        uint32_t mask = (0x0000FFFF << size) & 0xFFFF;
        mask = ~(mask | (mask << 16));
        SPDIF_TX_CHANNEL_STATUS( drv->baseaddress ) = mask & (((uint32_t)left[i]) << 16 | right[i]);
    }
    SPDIF_TX_CONFIG( drv->baseaddress ) |= SPDIF_TX_USE_USER_DATA;
}

/**
 * @brief Set user data bitstream
 *
 * This function defines the user data bitstream. Use this function to inject user information
 * in the transmitter. You can send up to 192 bits per channel, 2 channels = 384 bits. The user
 * stream should conform to either IEC60958-3 for linear PCM audio in a consumer application or
 * to IEC60958-4 for linear PCM audio in a professional application. For non-linear PCM refer to
 * IEC61937 or to IEC62105 for generic data transfer.
 *
 * Data organization should be: bit 0 = element #0, bit 0, bit 15 = element #0, bit 15, bit 16 = element #1 bit 0 etc.
 *
 * @param drv device pointer obtained from the spdif_open routine
 * @param left pointer to user bits array for left channel
 * @param right pointer to  user bits array for right channel
 * @param size number of bits per channel (max 192)
 *
 * @return Nothing
*/

void spdif_write_user_bitstream( spdif_t * restrict drv, uint16_t * left, uint16_t * right, int size )
{
    int i;

    assert( drv != NULL );
    assert( left != NULL );
    assert( right != NULL );

    if ( size > 192 ) size = 192;
    if ( size < 1 ) return;

    SPDIF_TX_CONFIG( drv->baseaddress ) &= ~SPDIF_TX_USE_USER_DATA;
    for ( i = 0; i < size / 16; i++ )
    {
        SPDIF_TX_USER_DATA( drv->baseaddress ) = ((uint32_t)left[i]) << 16 | right[i];
    }
    size &= 0x0F;
    if ( size )
    {
        uint32_t mask = (0x0000FFFF << size) & 0xFFFF;
        mask = ~(mask | (mask << 16));
        SPDIF_TX_USER_DATA( drv->baseaddress ) = mask & (((uint32_t)left[i]) << 16 | right[i]);
    }
    SPDIF_TX_CONFIG( drv->baseaddress ) |= SPDIF_TX_USE_USER_DATA;
}



















