/******************************************************************************
 * FILE:        @(#)pthread_attr_setstacksize.c 1.4 06/06/09
 * DESCRIPTION:
 *      The pthread_attr_setstacksize() function shall set the thread
 *      creation stacksize attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <limits.h>
#include <errno.h>
#include "kernel.h"

#if (__POSIX_THREAD_ATTR_STACKSIZE != 0 )

/**
 * @brief   set stacksize attribute
 *
 * Set the thread creation stacksize attribute in the attr object.
 * The stacksize attribute specifies the size of the created thread's stack.
 * The size of the storage shall be at least PTHREAD_STACK_MIN.
 * The system will allocate the stack when only the stacksize is specificed.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       stackaddr
 *      return stackaddr value of attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_setstacksize (pthread_attr_t *attr, size_t stacksize)
{
    int ret = 0;

    if (attr == NULL || stacksize < PTHREAD_STACK_MIN)
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
        attr->stacksize = stacksize;
    }

    posix_scheduler_unlock();

    return ret;
}

#endif

