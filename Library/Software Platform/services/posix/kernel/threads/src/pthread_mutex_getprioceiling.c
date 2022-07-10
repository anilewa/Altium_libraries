/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutex_getprioceiling.c     1.7
 * DESCRIPTION:
 *      The 'pthread_mutex_getprioceiling()' function shall return the 
 *      current priority ceiling of the mutex.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include <limits.h>
#include "kernel.h"

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )

/**
 * @brief   get the priority ceiling of a mutex
 *
 * @param   mutex
 *      the mutex
 * @param   prioceiling
 *      returns the priority ceiling of the mutex
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutex_getprioceiling (      const pthread_mutex_t *mutex,
                                        int *prioceiling )
{
        int prio;

        if ( mutex == NULL || prioceiling==NULL ) 
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();
        prio = mutex->prioceiling;
        posix_scheduler_unlock();

        if ( prio <  SCHED_PRIORITY_MIN ||
             prio >  SCHED_PRIORITY_MAX  )
        {
                return EINVAL;
        }
        *prioceiling = prio;
        return 0;
}

#endif /* __POSIX_THREAD_PRIO_PROTECT != 0 */

