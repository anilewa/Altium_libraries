/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:
|*
 */

/**
 * @file
 * Device driver for National Semiconductor DAC084S085
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


#include <drv_spi.h>
#include <drv_dac084s085.h>
#include <drv_dac084s085_cfg_instance.h>
#include <util_endian.h>

/*
 * driver data
 */
struct drv_dac084s085_s
{
    spi_t   *spi;
    bool    bus_sharing;
    uint8_t spi_channel;
};


/*
 * driver table
 */
static dac084s085_t drv_table[DRV_DAC084S085_INSTANCE_COUNT];



/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the DAC084S085 device driver.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

dac084s085_t * dac084s085_open( unsigned int id )
{
    assert( id < DRV_DAC084S085_INSTANCE_COUNT );

    dac084s085_t * restrict drv = &drv_table[id];

    if (drv->spi == NULL)
    {
        // Copy peripheral data to driver table
        const drv_dac084s085_cfg_instance_t * restrict drv_cfg = &drv_dac084s085_instance_table[id];
        spi_t   *spi;

        drv->spi_channel = drv_cfg->spi_channel;
        drv->bus_sharing = drv_cfg->bus_sharing;

        spi = spi_open(drv_cfg->drv_spi);
        if (spi == NULL)
        {
            return NULL;    // Could not open SPI driver for some reason
        }

        // the DAC expects the MSB first
        spi_set_endianess(spi, true);
        drv->spi = spi;
        spi_cs_hi(drv->spi);
    }
    return drv;
}

/**
 * @brief    Write value to DAC
 *
 * @param   drv     Pointer to DAC device driver
 * @param   channel Channel number to write value to (range 0..3)
 * @param   value   Value to write (range 0..255)
 * @param   flush   make new values available on the output ports
 *
 * @return 0: OK, -1 on failure
 */

int dac084s085_write( dac084s085_t * drv, uint8_t channel, uint8_t value, bool flush )
{
    int retval;

    assert( drv != NULL );
    assert( channel < 4 );
    if (drv->bus_sharing)
    {
        spi_set_mode(drv->spi, SPI_MODE2); //$
        while (!spi_get_bus(drv->spi, drv->spi_channel)); //$
    }
    spi_cs_lo(drv->spi);
    retval = spi_transceive16(drv->spi, channel << 14 | flush << 12 | value << 4);
    spi_cs_hi(drv->spi);
    if (drv->bus_sharing)
    {
        spi_release_bus(drv->spi); //$
    }

    return retval;
}

