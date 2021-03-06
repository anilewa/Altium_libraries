/******************************************************************************
 * FILE:        @(#)pthread_attr_getstackaddr.c 1.4 06/06/09
 * DESCRIPTION:
 *      The pthread_attr_getstackaddr() function shall get the thread 
 *      creation stackaddr attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if ( __POSIX_THREAD_ATTR_STACKADDR != 0 )

/**
 * @brief   get stackaddr attribute
 *
 * Get the thread creation stackaddr attribute in the attr object.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       stackaddr
 *      return stackaddr value of attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_getstackaddr (const pthread_attr_t *attr, void **stackaddr)
{       
        int ret = 0;

        posix_scheduler_lock();

        if ( attr == NULL || attr->init != _ATTR_INIT_KEY || (void*)stackaddr == NULL )
        {
                ret =  EINVAL;
        }
        else
        {
                *stackaddr = attr->stackaddr;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif /* __POSIX_THREAD_ATTR_STACKADDR != 0 */

