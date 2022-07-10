/*****************************************************************************
 * FILE:            @(#)pthread_getcpuclockid.c 1.1 06/07/04
 * DESCRIPTION:
 *      The pthread_getcpuclockid() function shall return in clock_id the
 *      clock ID of the CPU-time clock of the thread specified by thread_id, 
 *      if the thread specified by thread_id exists.
 ****************************************************************************/
#include <time.h>
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

#if ( __POSIX_THREAD_CPUTIME != 0 )

/**
 * @brief   access a thread CPU-time clock
 *
 * Return in clock_id the clock ID of the CPU-time clock of the thread specified
 * by thread_id, if the thread specified by thread_id exists.
 *
 * @param       thread_id
 *      id of the thread to get clock ID of the CPU-time clock form
 * @param       clock_id
 *      returns CPU-time clock id for the thread
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int
pthread_getcpuclockid (pthread_t thread_id, clockid_t *clock_id)
{
        int ret = 0;
        
        posix_scheduler_lock();
        
        if ( _posix_thread_table[thread_id] == NULL )
        {
                ret = ESRCH;
        }
        else
        {
          *clock_id = CLOCK_THREAD_CPUTIME_ID;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif /* __POSIX_THREAD_CPUTIME != 0 */

