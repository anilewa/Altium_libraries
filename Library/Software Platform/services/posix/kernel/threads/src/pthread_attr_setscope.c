/******************************************************************************
 * FILE:        @(#)pthread_attr_setscope.c     1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_setscope() function shall set the 
 *      scope attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief   set the contentionscope attribute
 *
 * Set the value of the contentionscope attribute in the attr object.
 *
 * Note: the value of contentionscope is ignored by the current implementation.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       contentionscope
 *      value for the contentionscope attribute
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_setscope (pthread_attr_t *attr, int contentionscope)
{
        int ret = 0;

        if (    attr == NULL                            ||
                ( contentionscope != PTHREAD_SCOPE_SYSTEM       &&
                  contentionscope != PTHREAD_SCOPE_PROCESS )
        )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY)
        {
                ret = EINVAL;
        }
        else
        {
                attr->scope = contentionscope;
        }

        posix_scheduler_unlock();

        return ret;
}

