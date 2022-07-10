/******************************************************************************
 * FILE:        @(#)sched_yield.c       1.3 06/05/22
 * DESCRIPTION:
 *      The sched_yield() function shall force the running thread to 
 *      relinquish the processor until it again becomes the head of 
 *      its thread list. It takes no arguments.
 *****************************************************************************/
#include <sched.h>
#include "kernel.h"

/**
 * @brief   yield the processor
 *
 * The sched_yield() function shall force the running thread to relinquish the
 * processor until it again becomes the head of its thread list.
 *
 * @param   none
 *
 * @return
 *      If successful, return 0.
 *      If unsuccessful, return -1 and set errno to indicate the error.
 */
int sched_yield(void)
{
        posix_thread_yield();
        return 0;
}

