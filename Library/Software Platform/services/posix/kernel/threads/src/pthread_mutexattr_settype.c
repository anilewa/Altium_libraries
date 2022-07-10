/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_settype.c        1.6
 * DESCRIPTION:
 *      The 'pthread_mutexattr_settype()' function  shall  set the mutex
 *      type attribute.
 *      The default value of the type attribute is PTHREAD_MUTEX_DEFAULT.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

#if ( __XSI_THREAD_MUTEX_EXT != 0 )

/**
 * @brief   set the mutex type attribute
 *
 * The type of mutex is contained in the type attribute of the mutex attributes.
 *
 * Valid mutex types:
 *      PTHREAD_MUTEX_NORMAL
 *          This type of mutex does not detect deadlock. A thread attempting to
 *          relock this mutex without first unlocking it shall deadlock.
 *          Attempting to unlock a mutex locked by a different thread results in
 *          undefined behavior. Attempting to unlock an unlocked mutex results
 *          in undefined behavior.
 *
 *      PTHREAD_MUTEX_ERRORCHECK
 *          This type of mutex provides error checking. A thread attempting to
 *          relock this mutex without first unlocking it shall return with an error.
 *          A thread attempting to unlock a mutex which another thread has locked
 *          shall return with an error. A thread attempting to unlock an unlocked
 *          mutex shall return with an error.
 *
 *      PTHREAD_MUTEX_RECURSIVE
 *          A thread attempting to relock this mutex without first unlocking it
 *          shall succeed in locking the mutex. The relocking deadlock which can
 *          occur with mutexes of type PTHREAD_MUTEX_NORMAL cannot occur with
 *          this type of mutex. Multiple locks of this mutex shall require the
 *          same number of unlocks to release the mutex before another thread
 *          can acquire the mutex. A thread attempting to unlock a mutex which
 *          another thread has locked shall return with an error. A thread
 *          attempting to unlock an unlocked mutex shall return with an error.
 *
 *      PTHREAD_MUTEX_DEFAULT
 *          Attempting to recursively lock a mutex of this type results in
 *          undefined behavior. Attempting to unlock a mutex of this type which
 *          was not locked by the calling thread results in undefined behavior.
 *          Attempting to unlock a mutex of this type which is not locked results
 *          in undefined behavior.
 *
 * @param   attr
 *      mutex attriubte object
 *
 * @param type
 *      type of the mutex attribute object
 *
 * @return
 *      If successful the function returns zero; otherwise, an error number is
 *      returned to indicate the error.
 */

int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type)
{
        int ret = 0;

        if ( attr == NULL                               ||
             (type != PTHREAD_MUTEX_NORMAL              &&
              type != PTHREAD_MUTEX_DEFAULT             &&
              type != PTHREAD_MUTEX_RECURSIVE           &&
              type != PTHREAD_MUTEX_ERRORCHECK)
           )
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
                attr->type = type;
        }
        posix_scheduler_unlock();

        return ret;
}

#endif /* __XSI_THREAD_MUTEX_EXT != 0 */

