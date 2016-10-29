/* cmregdef.h : CMREG LIB internal header */
/*----------------------------------------------------------------------+
|									|
|	system:	COMBI COMMON						|
|									|
|	98.11.21							|
|									|
*-----------------------------------------------------------------------*/

/*----------------------------------------------------------------------+
| ---  history  ------------------------------------------------------- |
| 2000.7.7   김성환. client 제어 추가					|
+----------------------------------------------------------------------*/

#ifndef	CMREGDEF_H
#define	CMREGDEF_H

/*----------------------------------------------------------------------+
|	ERROR NUMBER OF STPAPI						|
+----------------------------------------------------------------------*/
#define ECMR_ARGERR		15200	/* argument error */
#define	ECMR_NOTMYOWNER		15201	/* Not found env-val, "MYOWNER" */
#define ECMR_UNDEFACTION	15202	/* Undefined action code */
#define ECMR_NOTUSERCNTL	15203	/* Undefined $USERCNTL */
#define ECMR_NOTUSERINFO	15204	/* Undefined $USERINFO */
#define ECMR_NOADDUSID		15205	/* Undefined usid */
#define ECMR_NOTTXCNTL		15206	/* Undefined $TXCNTL */
#define ECMR_NOTPSCNTL		15207	/* Undefined $PSCNTL */
#define	ECMR_UNDEFTPHOME	15208	/* Undefined $TPHOME */
#define ECMR_UNDEFTPID		15209	/* Undefined $TPID */
#define ECMR_ASIDNOTFOUND	15210	/* asid is not found in tpcfg */
/*2000.7.7*/
#define	ECMR_NOTTPCNTL		15211	/* Undefined $TPCNTL*/

/*----------------------------------------------------------------------+
|	DEFINE	COMMON	VARIABLE					|
+----------------------------------------------------------------------*/
#define	OP_ADD		'A'
#define	OP_CHANGE	'C'
#define	OP_DELETE	'D'

#define	LEN_ASID	4

/*----------------------------------------------------------------------+
|	Declare Structure						|
+----------------------------------------------------------------------*/
typedef	struct	reg_intvalFORM {
	int	isfd;
	int	isvfd;
	char	action;
	char	*datarec;
} REG_INTVAL;

/*----------------------------------------------------------------------+
|	Extern Variables						|
+----------------------------------------------------------------------*/
extern	int	cm_transtart;

/*----------------------------------------------------------------------+
|	Declare Function Prototype					|
+----------------------------------------------------------------------*/
void	l_errset	CBD2(( char * ));
void	l_sethyerrno	CBD2(( int ));
void	l_reginit	CBD2(( REG_INTVAL *, char *, char ));
int	l_regopen	CBD2(( REG_INTVAL *, char *, char *, char * ));
void	l_regclose	CBD2(( REG_INTVAL * ));
void	tracelog	CBD2(( char *fmt, ... ));
void	l_errlog	CBD2(( char *ftn, char *fmt, ... ));
int	l_chownmod	CBD2(( char *, char * ));
int	l_reggetascfg	CBD2(( char *, char * ));

#endif	/* CMREGDEF_H */
