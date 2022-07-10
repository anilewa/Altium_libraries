#include "ad_adc_max1037_cfg_instance.h"
#include "drv_max1037_cfg_instance.h"
#include "adc_cfg_instance.h"
#include "adc_cfg.h"
#include <drv_max1037.h>
#include <adc.h>
#include <adc_i.h>

extern adc_t adc_table[ADC_INSTANCE_COUNT];
static int32_t ad_max1037_read(max1037_t *drv, unsigned channel);
static int32_t ad_max1037_read_multi(max1037_t *drv, int *data, size_t nr);

void ad_max1037_init(void)
{
    int adc_id;
    int drv_id;

    for (int adaptor_id = 0; adaptor_id < AD_ADC_MAX1037_INSTANCE_COUNT; adaptor_id++)
    {
        adc_id = ad_adc_max1037_instance_table[adaptor_id].ad_adc;
        drv_id = ad_adc_max1037_instance_table[adaptor_id].drv_max1037;

        adc_register_adaptor( adc_id,
                              drv_id,
                              (void*)max1037_open,
                              (void*)ad_max1037_read,
                              (void*)ad_max1037_read_multi );
    }
}

int ad_max1037_read(max1037_t *drv, unsigned channel)
{
    int32_t val;
    uint8_t config;

    config = max1037_read_config(drv);
    if (((config & MAX1037_CONFIG_CS_MASK) != (channel << 1)) || ((config & MAX1037_CONFIG_SCAN_MASK) != MAX1037_CONFIG_SCAN_MASK))
    {
        val = max1037_select_channel(drv, (uint8_t)channel);
        if (val == MAX1037_ERR)
        {
            return ADC_ERR;
        }
    }

    val = max1037_read(drv);
    return val == MAX1037_ERR ? ADC_ERR : val;
}


int ad_max1037_read_multi(max1037_t *drv, int *data, size_t channels)
{
    int val;
    uint8_t values[4];
    uint8_t config;
    uint8_t setup;

    config = max1037_read_config(drv);
    if (((config & MAX1037_CONFIG_CS_MASK) != (channels-1 << 1)) || (config & MAX1037_CONFIG_SCAN_MASK))
    {
        val = max1037_select_multichannel(drv, (uint8_t)channels);
        if (val == MAX1037_ERR)
        {
            return ADC_ERR;
        }
    }

    val = max1037_multiread(drv, values, channels);
    if (val == MAX1037_ERR)
    {
        return ADC_ERR;
    }


    setup = max1037_read_setup(drv);
    if ((setup & MAX1037_SETUP_BIPOLAIR) && !(config & MAX1037_CONFIG_SGL))
    {
        for (int i = 0; i < channels; i++)
        {
            data[i] = (int8_t)values[i];
        }
    }
    else
    {
        for (int i = 0; i < channels; i++)
        {
            data[i] = values[i];
        }
    }

    return ADC_OK;
}


