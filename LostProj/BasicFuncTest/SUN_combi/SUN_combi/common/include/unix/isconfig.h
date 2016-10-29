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
 
  2001.2.2. ksh. HP porting
----------------------------------------------------------------------
*/

/* configuration options - adjust as required --------------------- */

/* features */
#define ISADMIN     1                   /* global administration */
#define ISAUDIT     1                   /* 0:off 1:standard */
#define ISLOGGING   1                   /* 0:off 1:standard */
#define ISVARIABLE  1                   /* 0:off 1:std 2:pack */
#define ISLOCKING   2                   /* 0:off 1:old 2:std 3:lck */
#define ISDUPLOCKS  0                   /* honour locks in dup opens */
/*2001.2.2. change--------------------------------------------------------------
#define ISDECLARE   1                   * declare parameters *
------------------------------------------------------------------------------*/
#ifdef	HYSYS_HP
#define ISDECLARE   0                   /* declare parameters */
#else
#define ISDECLARE   1                   /* declare parameters */
#endif
/*end of 2001.2.2-------------------------------------------------------------*/
#define ISDATAVOID  0                   /* void data pointers */
#define ISCUSTOM    0                   /* include custom extensions */
#define ISBERKELY   0                   /* 0:memcpy() 1: bcopy() */
#define ISHUGE      0                   /* 0:off 1:hp-ux */

/* values */
#define ISIDXBLK    1024                /* default index block size */
#define ISDUPLEN    4                   /* default duplicate width */
#define ISMAXIDX    10                  /* indexes per file */
#define ISMAXPARTS  10                  /* parts per key */
#define ISMAXKEY    240                 /* bytes per key */
#define ISMAXBUF    20                  /* buffers per index */
#define ISERRBASE   100                 /* start error codes at */

/* platform specific locking function return values -------------------*/
#define ISLKFAIL         EACCES          /* sco-EACCESS linux-EAGAIN    */
/*2000.12.25. change------------------------------------------------------------
#define ISLKDEAD         EDEADLOCK       * sco-EDEADLOCK linux-EDEADLK *
------------------------------------------------------------------------------*/
#if	defined(__digital__) || defined(HYSYS_HP) /*2000.12.15. 3 line add. 대한생명*/
#define ISLKDEAD         EDEADLK       /* sco-EDEADLOCK linux-EDEADLK */
#else
#define ISLKDEAD         EDEADLOCK       /* sco-EDEADLOCK linux-EDEADLK */
#endif
/*end of 2001.2.2-------------------------------------------------------------*/

/* set for C-ISAM compatible no-wait on open and auto record locks -----*/
#define C7NOWAIT 0                       /* 0: default  1: no-wait     */

/* setfor C-ISAM 5.0 -> 7.1 locking concurrency -----------------------*/
/* PORTING */
#define C7LOCKING 1                      /* 0: disam/cisam pre 5.0     */
                                         /* 1: cisam 5.0 -> 7.1         */

/* threadsafe configuration -------------------------------------- */

/* 0 - disabled
   1 - SunOS
   2 - Solaris
   5 - pthreads */
   
#define ISTHREADED  0

/* the rest are internals ---------------------------------------- */
#define ISMODE      0666                /* full access */

/* not configurable */
#define ISDYNAMIC   0                   /* not available */
#define ISMIFCODE   0                   /* not available */

/* conflicting options check */
#if( ISLOGGING > 0 && ISADMIN == 0 )
#pragma error /* logging requires the administration facility */
#endif

