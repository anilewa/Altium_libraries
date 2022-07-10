/******************************************************************************
 * FILE:        @(#)pthread_attr_getscope.c     1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_getscope() function shall get the contentionscope 
 *      attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief   get the contentionscope attribute
 *
 * Get the value of the contentionscope attribute in the attr argument.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       contentionscope
 *      return (int*) contentionscope value of attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_getscope (const pthread_attr_t *attr, int *scope)
{
        int ret = 0;

        posix_scheduler_lock();
        
        if (attr == NULL || attr->init != _ATTR_INIT_KEY || scope == NULL )
        { 
                ret = EINVAL; 
        }
        else
        {
                *scope = attr->scope;
        }

        posix_scheduler_unlock();

        return ret;
}

