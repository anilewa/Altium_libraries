/******************************************************************************
 * FILE:        @(#)pthread_attr_setstack.c     1.6 07/02/21
 * DESCRIPTION:    
 *      
 *      The pthread_attr_setstack() shall set the thread creation stack 
 *      attributes stackaddr and stacksize in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

/**
 * @brief   set stack attributes
 *
 * Set the thread creation stack attributes stackaddr and stacksize in the attr object.
 *
 * The stack attributes specify the area of storage to be used for the created
 * thread's stack. The base (lowest addressable byte) of the storage shall be
 * stackaddr, and the size of the storage shall be stacksize bytes.
 * The stacksize shall be at least {PTHREAD_STACK_MIN}.
 *
 * @param       attr
 *      pointer to a thread attribute object
 * @param       stackaddr
 *      begin of stack area (must be four bytes aligned)
 * @param       stacksize
 *      size of the stack (must be multiple of four)
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */
int pthread_attr_setstack(      pthread_attr_t *attr,
                                void *stackaddr,
                                size_t stacksize )
{
        int ret = 0;
        
        if (    attr == NULL       || 
                stacksize < PTHREAD_STACK_MIN ||
                stackaddr == NULL  || 
                ((uintptr_t)stackaddr & 0x3 ) ||
                (((uintptr_t)stackaddr + stacksize) & 0x3)
                )
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (    attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
                attr->stacksize = stacksize;
                attr->stackaddr = stackaddr;
                attr->guardsize = 0;
        }

        posix_scheduler_unlock();

        return ret;
}

#endif /* __XSI_THREAD_EXIT */

