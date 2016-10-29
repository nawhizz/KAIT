/*
----------------------------------------------------------------------
configuration options
----------------------------------------------------------------------

         +----------------------------------------------------+
         |  Worldwide Copyright (c) Byte Designs Ltd (1997)   |    
         |                                                    |
         |               20568 - 32 Avenue                    |
         |               LANGLEY, BC                          |
         |               V3A 4P5 CANADA                       |
         |                                                    |
         | Sales: sales@byted.com  Support: support@byted.com |
         | Phone: (604) 534 0722   Fax: (604) 534 2601        |
         +----------------------------------------------------+
                            Version 6.12
 
----------------------------------------------------------------------
수정이력
----------------------------------------------------------------------
2000.7.19.  김성환. key maximum 값을 증가
*/

/* configuration options - adjust as required --------------------- */

/* features */
#define ISADMIN     1                   /* global administration */
#define ISAUDIT     1                   /* 0:off 1:standard */
#define ISLOGGING   1                   /* 0:off 1:standard */
#define ISVARIABLE  1                   /* 0:off 1:std 2:pack */
#define ISLOCKING   3                   /* 0:off 3:lck */
#define ISDECLARE   1                   /* declare parameters */
#define ISDATAVOID  0                   /* void data pointers */
#define ISCUSTOM    0                   /* include custom extensions */
#define ISWINDOWS   0			/* microsoft windows */
/* PORTING 980422 changed by SJW ***********************************************
#define ISDYNAMIC   0			* 0:static 1:base16 2:base32
                                                    3:wrap16 4:wrap32 *
*******************************************************************************/
#define ISDYNAMIC   4			/* 0:static 1:base16 2:base32
                                                    3:wrap16 4:wrap32 */
/******************************************************************************/

#define ISHUGE      0                   /* 0:lseek 1:lseeki64         */

/* values */
#define ISIDXBLK    1024                /* default index block size */
#define ISDUPLEN    4                   /* default duplicate width */
#define ISMAXIDX    10                  /* indexes per file */
#define ISMAXPARTS  10                  /* parts per key */
#define ISMAXKEY    256                 /* bytes per key. 2000.7.19. 128->256 */
#define ISMAXBUF    20                  /* buffers per index */
#define ISERRBASE   100                 /* start error codes at */

/* locking error return values */
#define ISLKFAIL	EACCES		/* set to the platform locking */
                                        /* function return error code  */
#define ISLKDEAD	EDEADLOCK	/* set to the platform locking */
                                        /* function deadlock error code */

/* set for C-ISAM compatible no-wait on autolock ------------------*/
#define C7NOWAIT    0                   /* 0: default 1:no-wait    */


/* threadsafe configuration -------------------------------------- */

/* 0 - disabled
   3 - Windows 95 and NT
   4 - OS/2 (unstable) */
   
#define ISTHREADED  0

/* the rest are internals ---------------------------------------- */

/* not configurable */
#define ISDUPLOCKS  1                   /* do not change */
#define ISBERKELY   0                   /* not supported */
#define ISMIFCODE   0                   /* not available */

/* conflicting options check */
#if( ISLOGGING > 0 && ISADMIN == 0 )
#error /* logging requires the administration facility */
#endif

