/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    ISP1760 USB Host Controller device.
|*
\*****************************************************************************/

#ifndef _DRV_ISP1760_H
#define _DRV_ISP1760_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

#include <usbhost_core.h>

typedef struct isp1760_s isp1760_t;

extern int32_t isp1760_reset(isp1760_t * restrict drv);
extern int32_t isp1760_start(isp1760_t * restrict drv);
extern int32_t isp1760_stop(isp1760_t * restrict drv);
extern int32_t isp1760_shutdown(isp1760_t * restrict drv);
extern int32_t isp1760_enqueue_urb(isp1760_t * restrict drv, usbhost_urb_t *urb);
extern int32_t isp1760_dequeue_urb(isp1760_t * restrict drv, usbhost_urb_t *urb, int32_t status);
extern int32_t isp1760_hubstatus(isp1760_t * restrict drv, uint8_t *buf);
extern int32_t isp1760_hubcontrol(isp1760_t * restrict drv, uint16_t typeReq, int16_t wValue,
                                  uint16_t wIndex, uint8_t *buf, uint16_t wLength);
extern uint32_t isp1760_getstate(isp1760_t * restrict drv);

extern isp1760_t *isp1760_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_ISP1760_H */

