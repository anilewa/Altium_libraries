/******************************************************************************
 * FILE:        @(#)pthread_attr_getinheritsched.c      1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_getinheritsched() function shall get the
 *      inheritsched attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief   get the inheritsched attribute
 *
 * Get the value of the inheritsched attribute in the attr argument.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       inheritsched
 *      return (int*) inheritsched value of attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_getinheritsched (const pthread_attr_t *attr, int *inheritsched)
{
        int     ret = 0;        

        posix_scheduler_lock();
        
        if (attr == NULL || attr->init != _ATTR_INIT_KEY || inheritsched == NULL )
        {
                ret = EINVAL;
        }
        else
        {
                *inheritsched = attr->inheritsched;
        }
        
        posix_scheduler_unlock();
        
        return ret;
}

