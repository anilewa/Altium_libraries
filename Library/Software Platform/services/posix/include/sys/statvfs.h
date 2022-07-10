/*
 * NAME
 *
 *      sys/statvfs.h - VFS File System information structure
 *
 * SYNOPSIS
 *
 *      #include <sys/statvfs.h>
 */

#ifndef SYS_STATVFS_H_
#define SYS_STATVFS_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <sys/types.h>
#include <sys/statvfs.h>

struct statvfs {
    unsigned long   f_bsize;        /* File system block size.                                      */
    unsigned long   f_frsize;       /* Fundamental file system block size.                          */
    fsblkcnt_t      f_blocks;       /* Total number of blocks on file system in units of f_frsize.  */
    fsblkcnt_t      f_bfree;        /* Total number of free blocks.                                 */
    fsblkcnt_t      f_bavail;       /* Number of free blocks available to non-privileged process.   */
    fsfilcnt_t      f_files;        /* Total number of file serial numbers.                         */
    fsfilcnt_t      f_ffree;        /* Total number of free file serial numbers.                    */
    fsfilcnt_t      f_favail;       /* Number of file serial numbers available to non-privileged process.   */
    unsigned long   f_fsid;         /* File system ID.                                              */
    unsigned long   f_flag;         /* Bit mask of f_flag values.                                   */
    unsigned long   f_namemax;      /* Maximum filename length.                                     */
};

/*
 * constants for the f_flag member
 */
#define ST_RDONLY       (1 << 0)    /* Read-only file system.       */
#define ST_NOSUID       (1 << 1)    /* Does not support the semantics of the ST_ISUID and ST_ISGID file mode bits. */

extern int fstatvfs(int fildes, struct statvfs *buf);
extern int statvfs(const char *restrict path, struct statvfs *restrict buf);

#ifdef  __cplusplus
}
#endif

#endif /* ndef SYS_STATVFS_H_ */

