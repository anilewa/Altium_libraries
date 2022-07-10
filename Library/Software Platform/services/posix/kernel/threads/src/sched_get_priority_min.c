/*****************************************************************************
 * FILE:        @(#)sched_get_priority_min.c    1.2 06/09/29
 * DESCRIPTION:
 *      The sched_get_priority_min() function shall return the appropriate
 *      minimum priority for the scheduling policy specified by policy.
 ****************************************************************************/
#include <sched.h>

/**
 * @brief   get priority limits
 *
 * Return the appropriate minimum for the scheduling policy specified by policy.
 *
 * @param   policy
 *      scheduling policy to return minimum priority for
 *
 * @return
 *      If successful, return the minimum priority for the given scheduling policy.
 *      If unsuccessful, return a value of -1 and set errno to indicate the error.
 */
int sched_get_priority_min(int policy)
{
        return SCHED_PRIORITY_MIN;
}

