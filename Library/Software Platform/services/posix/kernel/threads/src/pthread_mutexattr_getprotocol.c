/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_getprotocol.c    1.4
 * DESCRIPTION:
 *      The pthread_mutexattr_getprotocol() function shall get the protocol 
 *      attribute of a mutex attributes object pointed to by attr which was 
 *      previously created by the function pthread_mutexattr_init().
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

/**
 * @brief   get the protocol attribute of the mutex attributes object
 *
 * @param       attr
 *      mutex attributes object
 * @param       protocol
 *      return the protocol attribute of a mutex attributes object pointed to by attr
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutexattr_getprotocol ( const pthread_mutexattr_t *attr, int *protocol)
{
        int ret = 0;

        posix_scheduler_lock();

        if ( attr == NULL || attr->init != _ATTR_INIT_KEY || protocol == NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *protocol = attr->protocol;
        }

        posix_scheduler_unlock();

        return ret;
}

