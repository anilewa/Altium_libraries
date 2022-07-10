/******************************************************************************
 * FILE:        @(#)pthread_setconcurrency.c    1.4 07/02/21
 * DESCRIPTION:
 *      The pthread_setconcurrency() function allows an application to inform
 *      the threads implementation of its desired concurrency level, new_level.
 ******************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

int _posix_concurrency_level = 0;

/**
 * @brief   set the level of concurrency
 *
 * Concurrency level is not implemented in the current implementation.
 *
 * @param   new_level
 *      desired concurrency level
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_setconcurrency(int new_level)
{
        if ( new_level < 0 ) return EINVAL;

        posix_scheduler_lock();
        _posix_concurrency_level = new_level;
        posix_scheduler_unlock();

        return 0;
}

#endif /* __XSI_THREAD_EXIT != 0 */

