/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2011, Altium
|*
|*  Description:    pthread_setschedprio
|*
\*****************************************************************************/
#include <errno.h>
#include <pthread.h>
#include "posix_pthread.h"
#include "kernel.h"
#include "k_schedule.h"


/**
 * @brief
 *      The pthread_setschedprio() function shall set the scheduling priority
 *      for the thread whose thread ID is given by thread to the value given
 *      by prio.
 *
 * @param   thread,     thread id of thread to change priority
 * @param   prio,       new priority for thread
 *
 * @retrun
 *      If successful, the pthread_setschedprio() function shall return zero;
 *      otherwise, an error number shall be returned to indicate the error.
 */
int pthread_setschedprio(pthread_t thread, int prio)
{
    int ret         = 0;
    posix_thread_t  *th;

    pthread_mutex_lock(&_posix_threads_mutex);

    th =  posix_get_thread(thread);

    if (th == NULL)
    {
        ret = ESRCH;
    }
    else
    {
        if (   prio < sched_get_priority_min(th->schedpolicy)
            || prio > sched_get_priority_max(th->schedpolicy))
        {
            ret = ENOTSUP;
        }
        else
        {
            posix_thread_set_priority(th, prio);
        }
    }

    pthread_mutex_unlock(&_posix_threads_mutex);

    return ret;
}

