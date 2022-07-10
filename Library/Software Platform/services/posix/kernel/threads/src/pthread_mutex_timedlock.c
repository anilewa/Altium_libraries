/******************************************************************************
 * FILE:        @(#)pthread_mutex_timedlock.c   1.9 07/06/06
 * DESCRIPTION:
 *       The pthread_mutex_timedlock() function shall lock the mutex object
 *       referenced by mutex. 
 *****************************************************************************/
#include <pthread.h>
#include <stdbool.h>
#include <errno.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_TIMEOUTS != 0 )

/**
 * @brief   lock a mutex
 *
 * If the mutex is already locked, the calling thread shall block until the mutex
 * becomes available as in the pthread_mutex_lock() function. If the mutex cannot
 * be locked without waiting for another thread to unlock the mutex, this wait
 * shall be terminated when the specified timeout expires.
 *
 * @param   mutex
 *      mutex object to lock
 * @param   abstime
 *      absolute time value for trying to lock the mutex, based on the CLOCK_REALTIME clock
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_mutex_timedlock(    pthread_mutex_t *mutex,
                                const struct timespec * abstime )
{
        clock_t                 trigger;

        if ( mutex      == (pthread_mutex_t *)NULL      ||
             abstime    == (struct timespec *)NULL)
        {
                return EINVAL;
        }

        trigger = posix_timespec_to_ticks (&_posix_system_clock, abstime);

        return  __pthread_mutex_timedlock(mutex, trigger, 0);
}

#endif /* __POSIX_TIMEOUTS != 0 */

