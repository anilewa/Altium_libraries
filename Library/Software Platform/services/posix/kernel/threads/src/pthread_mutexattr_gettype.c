/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_gettype.c        1.6
 * DESCRIPTION:
 *              The pthread_mutexattr_gettype() function shall get 
 *              the mutex type attribute
 *              (see also pthread_mutexattr_settype)
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

#if ( __XSI_THREAD_MUTEX_EXT != 0 )

/**
 * @brief   get the mutex type attribute
 *
 * @param   attr
 *      mutex attribute object
 *
 * @param type
 *      returns the type of the mutex attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutexattr_gettype( const pthread_mutexattr_t *attr, int *type)
{
        int ret = 0;

        posix_scheduler_lock();

        if ( attr == NULL || attr->init != _ATTR_INIT_KEY || type==NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *type = attr->type;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif /* __XSI_THREAD_MUTEX_EXT != 0 */

