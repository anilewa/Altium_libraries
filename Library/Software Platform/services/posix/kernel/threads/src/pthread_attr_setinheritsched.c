/******************************************************************************
 * FILE:        @(#)pthread_attr_setinheritsched.c      1.3 06/05/22
 * DESCRIPTION:
 *      The pthread_attr_setinheritsched() function shall set the
 *      inheritsched attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief   set the inheritsched attribute
 *
 * The pthread_attr_setinheritsched() function sets the inheritsched attribute
 * in the attr argument.
 * When the attributes objects are used by pthread_create(), the inheritsched
 * attribute determines how the other scheduling attributes of the created
 * thread shall be set.
 *
 * The supported values of inheritsched are:
 *
 *  PTHREAD_INHERIT_SCHED
 *          Specifies that the thread scheduling attributes shall be inherited
 *          from the creating thread, and the scheduling attributes in this
 *          attr argument shall be ignored.
 *
 *  PTHREAD_EXPLICIT_SCHED
 *          Specifies that the thread scheduling attributes shall be set to the
 *          corresponding values from this attributes object.
 *
 * The following thread scheduling attributes are affected by the inheritsched
 * attribute: scheduling policy (schedpolicy), scheduling parameters (schedparam),
 * and scheduling contention scope (contentionscope).
 *
 * Note: scheduling contention scope is ignored by the current implementation.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       inheritsched
 *      value for the inheritsched attribute
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_setinheritsched (pthread_attr_t *attr, int inheritsched)
{
        int ret = 0;

        if (    attr == NULL                            ||
                (inheritsched != PTHREAD_INHERIT_SCHED  &&
                 inheritsched != PTHREAD_EXPLICIT_SCHED )
        )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                attr->inheritsched = inheritsched;
        }
        
        posix_scheduler_unlock();

        return ret;
}


