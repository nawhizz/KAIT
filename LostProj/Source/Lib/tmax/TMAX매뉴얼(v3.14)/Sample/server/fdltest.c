
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned long magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* Object support */
struct sqltvn
{
  unsigned char *tvnvsn; 
  unsigned short tvnvsnl; 
  unsigned char *tvnnm;
  unsigned short tvnnml; 
  unsigned char *tvnsnm;
  unsigned short tvnsnml;
};
typedef struct sqltvn sqltvn;

struct sqladts
{
  unsigned int adtvsn; 
  unsigned short adtmode; 
  unsigned short adtnum;  
  sqltvn adttvn[1];       
};
typedef struct sqladts sqladts;

static struct sqladts sqladt = {
  1,1,0,
};

/* Binding to PL/SQL Records */
struct sqltdss
{
  unsigned int tdsvsn; 
  unsigned short tdsnum; 
  unsigned char *tdsval[1]; 
};
typedef struct sqltdss sqltdss;
static struct sqltdss sqltds =
{
  1,
  0,
};

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[11];
};
static struct sqlcxp sqlfpn =
{
    10,
    "fdltest.pc"
};


static unsigned long sqlctx = 72971;


static struct sqlexd {
   unsigned int   sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
            short *cud;
   unsigned char  *sqlest;
            char  *stmt;
   sqladts *sqladtp;
   sqltdss *sqltdsp;
            void  **sqphsv;
   unsigned int   *sqphsl;
            int   *sqphss;
            void  **sqpind;
            int   *sqpins;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
            void  *sqhstv[8];
   unsigned int   sqhstl[8];
            int   sqhsts[8];
            void  *sqindv[8];
            int   sqinds[8];
   unsigned int   sqharm[8];
   unsigned int   *sqharc[8];
   unsigned short  sqadto[8];
   unsigned short  sqtdso[8];
} sqlstm = {10,8};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned long *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{10,4130,0,0,0,
5,0,0,1,121,0,3,43,0,0,8,8,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,
4,0,0,1,4,0,0,1,3,0,0,
52,0,0,2,33,0,2,63,0,0,1,1,0,1,0,1,3,0,0,
71,0,0,3,183,0,4,89,0,0,8,1,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,
4,0,0,2,3,0,0,1,3,0,0,
118,0,0,4,49,0,5,125,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,
145,0,0,5,40,0,3,161,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
};


#include <stdio.h>
#include <ctype.h>
#include <usrinc/atmi.h>
#include <usrinc/fbuf.h>
#include "../fdl/demo_fdl.h"
#include <usrinc/tx.h>

/* EXEC SQL include sqlca.h;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */


/* EXEC SQL begin declare section; */ 

	int  h_empno;
	char h_ename[11];
	char h_job[10];
	int  h_mgr;
	char h_date[11];
	float h_sal;
	float h_comm;
	int  h_deptno;
	int  h_no;
/* EXEC SQL end declare section; */ 


FDLINS( TPSVCINFO *msg )
{
	FBUF *sndbuf;

	sndbuf = (FBUF *)msg->data;

	h_empno = h_mgr = h_sal = h_comm = h_deptno = 0;

	memset( h_ename, 0x00, sizeof( h_ename ) );
	memset( h_job, 0x00, sizeof( h_job ) );
	memset( h_date, 0x00, sizeof( h_date ) );

	fbget( sndbuf, EMPNO, (char *)&h_empno, 0 );
	fbget( sndbuf, MGR,   (char *)&h_mgr, 0 );
	fbget( sndbuf, SAL,   (char *)&h_sal, 0 );
	fbget( sndbuf, COMM,  (char *)&h_comm, 0 );
	fbget( sndbuf, DEPTNO,(char *)&h_deptno, 0 );
	fbget( sndbuf, ENAME, (char *)h_ename, 0 );
	fbget( sndbuf, JOB  , (char *)h_job, 0 );
	fbget( sndbuf, DATE , (char *)h_date, 0 );

	/* EXEC SQL INSERT 
	INTO emp( empno, ename, job, mgr, hiredate,sal,comm,deptno)
	VALUES ( :h_empno, :h_ename, :h_job, :h_mgr, to_date(:h_date,'yymmdd'), :h_sal, :h_comm, :h_deptno ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 10;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into emp (empno,ename,job,mgr,hiredate,sal,comm,dept\
no) values (:b0,:b1,:b2,:b3,to_date(:b4,'yymmdd'),:b5,:b6,:b7)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)&h_empno;
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (         void  *)h_ename;
 sqlstm.sqhstl[1] = (unsigned int  )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         void  *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (         void  *)h_job;
 sqlstm.sqhstl[2] = (unsigned int  )10;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         void  *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (         void  *)&h_mgr;
 sqlstm.sqhstl[3] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         void  *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned int  )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (         void  *)h_date;
 sqlstm.sqhstl[4] = (unsigned int  )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         void  *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned int  )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (         void  *)&h_sal;
 sqlstm.sqhstl[5] = (unsigned int  )sizeof(float);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         void  *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned int  )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (         void  *)&h_comm;
 sqlstm.sqhstl[6] = (unsigned int  )sizeof(float);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         void  *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned int  )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (         void  *)&h_deptno;
 sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         void  *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned int  )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != 0 ){
		printf( "insert failed sqlcode = %d\n",sqlca.sqlcode );
		tpreturn( TPFAIL, -1, NULL, 0, 0 );
	}

	tpreturn( TPSUCCESS, 0, NULL, 0, 0 );
}

FDLDEL( TPSVCINFO *msg )
{
	FBUF *sndbuf;

	sndbuf = ( FBUF *)msg->data;

	fbget(sndbuf, EMPNO, (char *)&h_empno , 0);

	/* EXEC SQL DELETE
	FROM emp
	WHERE empno = :h_empno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 10;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from emp  where empno=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )52;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)&h_empno;
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != 0 ){
		printf( "delete failed sqlcode = %d\n",sqlca.sqlcode );
		tpreturn( TPFAIL, sqlca.sqlcode, NULL, 0, 0 );
	}

	tpreturn( TPSUCCESS, sqlca.sqlcode, (char *)sndbuf, sizeof(sndbuf), 0 );
}

FDLSEL( TPSVCINFO *msg )
{
	FBUF *sndbuf;

	sndbuf = ( FBUF *)msg->data;

	h_empno = h_mgr = h_sal = h_comm = h_deptno = 0;

	memset( h_ename, 0x00, sizeof( h_ename ) );
	memset( h_job, 0x00, sizeof( h_job ) );
	memset( h_date, 0x00, sizeof( h_date ) );

	fbget( sndbuf, EMPNO, (char *)&h_empno, 0);

	/* EXEC SQL SELECT NVL(ename,' '), NVL(job,' '), NVL(mgr,0), NVL(to_char(hiredate,'yymmdd'), ' '),NVL(sal,0),NVL(comm,0),NVL(deptno,0)
	INTO :h_ename, :h_job, :h_mgr, :h_date, :h_sal, :h_comm, :h_deptno 
	FROM emp
	WHERE empno = :h_empno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 10;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(ename,' ') ,NVL(job,' ') ,NVL(mgr,0) ,NVL(to_cha\
r(hiredate,'yymmdd'),' ') ,NVL(sal,0) ,NVL(comm,0) ,NVL(deptno,0) into :b0,:b\
1,:b2,:b3,:b4,:b5,:b6  from emp where empno=:b7";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )71;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)h_ename;
 sqlstm.sqhstl[0] = (unsigned int  )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (         void  *)h_job;
 sqlstm.sqhstl[1] = (unsigned int  )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         void  *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (         void  *)&h_mgr;
 sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         void  *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (         void  *)h_date;
 sqlstm.sqhstl[3] = (unsigned int  )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         void  *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned int  )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (         void  *)&h_sal;
 sqlstm.sqhstl[4] = (unsigned int  )sizeof(float);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         void  *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned int  )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (         void  *)&h_comm;
 sqlstm.sqhstl[5] = (unsigned int  )sizeof(float);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         void  *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned int  )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (         void  *)&h_deptno;
 sqlstm.sqhstl[6] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         void  *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned int  )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (         void  *)&h_empno;
 sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         void  *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned int  )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != 0 && sqlca.sqlcode != 1403 ){
		printf( "select failed sqlcode = %d\n",sqlca.sqlcode );
		tpreturn( TPFAIL, sqlca.sqlcode, NULL, 0, 0 );
	}

	fbchg_tu(sndbuf, MGR,    0,(char *)&h_mgr, 0);
	fbchg_tu(sndbuf, SAL,    0,(char *)&h_sal, 0);
	fbchg_tu(sndbuf, DEPTNO, 0,(char *)&h_deptno, 0);
	fbchg_tu(sndbuf, COMM,   0,(char *)&h_comm, 0);
	fbchg_tu(sndbuf, ENAME,  0,(char *)h_ename, 0);
	fbchg_tu(sndbuf, JOB,    0,(char *)h_job, 0);
	fbchg_tu(sndbuf, DATE,   0,(char *)h_date, 0);

	tpreturn( TPSUCCESS, sqlca.sqlcode, (char *)sndbuf, sizeof(sndbuf), 0 );
}
FDLUPT( TPSVCINFO *msg )
{
	FBUF *sndbuf;

	sndbuf = ( FBUF *)msg->data;

	h_empno = h_mgr = h_sal = h_comm = h_deptno = 0;

	memset( h_ename, 0x00, sizeof( h_ename ) );
	memset( h_job, 0x00, sizeof( h_job ) );
	memset( h_date, 0x00, sizeof( h_date ) );

	fbget( sndbuf, EMPNO, (char *)&h_empno, 0);
	fbget( sndbuf, ENAME, (char *)h_ename, 0);
	fbget( sndbuf, JOB,   (char *)h_job, 0);

	/* EXEC SQL UPDATE emp 
	SET ename = :h_ename, job = :h_job
	WHERE empno = :h_empno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 10;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update emp  set ename=:b0,job=:b1 where empno=:b2";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )118;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)h_ename;
 sqlstm.sqhstl[0] = (unsigned int  )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (         void  *)h_job;
 sqlstm.sqhstl[1] = (unsigned int  )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         void  *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (         void  *)&h_empno;
 sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         void  *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if ( sqlca.sqlcode != 0 ){
		printf( "update failed sqlcode = %d\n",sqlca.sqlcode );
		tpreturn( TPFAIL, sqlca.sqlcode, NULL, 0, 0 );
	}

	tpreturn( TPSUCCESS, sqlca.sqlcode, NULL, 0, 0 );
}
/*
FDLAAA(TPSVCINFO *msg)
{

	h_empno = atoi(msg->data);

	EXEC SQL prepare pre_16384 from "UPDATE emp set ename = 'baboo'";

        EXEC SQL execute pre_16384;

	tpreturn( TPSUCCESS, sqlca.sqlcode, msg->data, 0, 0);
}
*/
FDLAAA(TPSVCINFO *msg)
{
	int ret;
	long rlen;
	char *sndbuf, *rcvbuf;

	h_no = atoi(msg->data);

printf( "tx_begin start\n");
	ret = tx_begin();
printf( "tx_begin [%d]\n",ret);

	/* EXEC SQL INSERT INTO test VALUES ( :h_no,:h_no+100); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 10;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into test  values (:b0,(:b0+100))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )145;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)&h_no;
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (         void  *)&h_no;
 sqlstm.sqhstl[1] = (unsigned int  )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         void  *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if (sqlca.sqlcode != 0){
		tpreturn(TPFAIL, sqlca.sqlcode, (char *)msg->data, 0, 0);
	}
	sndbuf = tpalloc("STRING", NULL, 0);
	rcvbuf = tpalloc("STRING", NULL, 0);

	if (sndbuf == NULL || rcvbuf == NULL)
		tpreturn(TPFAIL, -9999, (char *)msg->data, 0, 0);

	memcpy(sndbuf, msg->data, msg->len);
	sndbuf[msg->len] = 0x00;

printf( "tpcall start\n");
	ret = tpcall("TESTSVC2", (char *)sndbuf, 0, (char **)&rcvbuf, (long *)&rlen, 0);
	if (ret < 0){
		printf( "TESTSVC2 tpcall fail[%d][%d]\n",tperrno, tpurcode );
		tx_rollback();
		tpreturn(TPFAIL, tpurcode, (char *)msg->data, 0, 0);
	}
	sleep(10);

printf( "tx_rollback start\n");
	tx_rollback();

	tpreturn(TPSUCCESS, 100, (char *)msg->data, 0, 0);

}

tpsvctimeout(TPSVCINFO *msg)
{
	tpreturn(TPEXIT, -444, (char *)msg->data, 0, 0);

}

