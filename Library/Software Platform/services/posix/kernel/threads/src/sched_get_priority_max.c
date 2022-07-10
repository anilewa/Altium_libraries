/*****************************************************************************
 * FILE:        @(#)sched_get_priority_max.c    1.2 06/09/29
 * DESCRIPTION:
 *      The sched_get_priority_max() function shall return the appropriate 
 *      maximum priority for the scheduling policy specified by policy.
 ****************************************************************************/
#include <sched.h>

/**
 * @brief   get priority limits
 *
 * Return the appropriate maximum for the scheduling policy specified by policy.
 *
 * @param   policy
 *      scheduling policy to return maximum priority for
 *
 * @return
 *      If successful, return the maximum priority for the given scheduling policy.
 *      If unsuccessful, return a value of -1 and set errno to indicate the error.
 */
int sched_get_priority_max(int policy)
{
        return SCHED_PRIORITY_MAX;
}

