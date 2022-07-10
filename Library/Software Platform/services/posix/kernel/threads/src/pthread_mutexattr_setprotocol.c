/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_setprotocol.c    1.5
 * DESCRIPTION:
 *              The 'pthread_mutexattr_setprotocol()' function shall set the
 *              protocol attribute of a mutex attributes object pointed to by 'attr'
 *              which was previously created by the function
 *              'pthread_mutexattr_init()'.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief   set the protocol attribute of the mutex attributes object
 *
 * The protocol attribute defines the protocol to be followed in utilizing mutexes.
 * The value of protocol may be one of: PTHREAD_PRIO_INHERIT, PTHREAD_PRIO_NONE and
 * PTHREAD_PRIO_PROTECT which are defined in the <pthread.h> header.
 * The default value of the attribute is PTHREAD_PRIO_NONE.
 *
 * @param       attr
 *      mutex attributes object
 * @param       protocol
 *      protocol attribute of a mutex attributes object pointed to by attr
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr,
                        int protocol)
{
        int ret = 0;

        if ( attr == NULL)
        {
                return EINVAL;
        }
        else if ( protocol != PTHREAD_PRIO_NONE &&
                  protocol != PTHREAD_PRIO_INHERIT &&
                  protocol != PTHREAD_PRIO_PROTECT )
        {
                return ENOTSUP;
        }

        posix_scheduler_lock();

        if (attr->init!=_ATTR_INIT_KEY)
        {
                ret = EINVAL;
        }
        else
        {
                attr->protocol = protocol;
        }

        posix_scheduler_unlock();

        return ret;
}

