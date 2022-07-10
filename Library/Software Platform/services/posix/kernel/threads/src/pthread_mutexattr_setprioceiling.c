/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_setprioceiling.c 1.7
 * DESCRIPTION:
 *      The 'pthread_mutexattr_setprioceiling()' function shall  set 
 *      the priority ceiling attribute of a mutex attributes object 
 *      pointed to by attr which was previously created by the 
 *      function 'pthread_mutexattr_init()'.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include <limits.h>
#include "kernel.h"

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )

/**
 * @brief   set the prioceiling attribute of a mutex attributes object
 *
 * The prioceiling attribute defines the priority ceiling of initialized mutexes,
 * which is the minimum priority level at which the critical section guarded by
 * the mutex is executed. In order to avoid priority inversion, the priority
 * ceiling of the mutex shall be set to a priority higher than or equal to the
 * highest priority of all the threads that may lock that mutex.
 *
 * @param       attr
 *      mutex attributes object
 * @param       prioceiling
 *      priority ceiling value for the mutex attributes object pointed to by attr
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutexattr_setprioceiling(pthread_mutexattr_t *attr,
                        int prioceiling)
{
        int ret = 0;

        if ( attr == NULL || prioceiling <  SCHED_PRIORITY_MIN  ||
                             prioceiling >  SCHED_PRIORITY_MAX )
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
                attr->prioceiling = prioceiling;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif /* __POSIX_THREAD_PRIO_PROTECT != 0 */

