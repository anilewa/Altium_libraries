/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
\*****************************************************************************/

/**
 * @file
 * WB_PRTIO peripheral direct access.
 * If performance is an issue, direct access is faster than access through the driver.
 *
 */

#ifndef _PER_IOPORT_H
#define _PER_IOPORT_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

/**
 * @name Base Registers Access
 */
/** @{ */
#define IOPORT_BASE32(base)     ((volatile uint32_t *) base)    /**< 32-bit register access */
#define IOPORT_BASE16(base)     ((volatile uint16_t *) base)    /**< 16-bit register access */
#define IOPORT_BASE8(base)      ((volatile uint8_t *) base)     /**< 8-bit register access */
/** @} */

extern uint32_t per_ioport_get_base_address ( int id  );

#ifdef  __cplusplus
}
#endif

#endif /* _PER_IOPORT_H */

