/* cmreg.h */
/*----------------------------------------------------------------------+
| ---  history  ------------------------------------------------------- |
| 2000.7.7   �輺ȯ. client ���� �߰�					|
| 2001.5.21  ksh. build ��� �߰�					|
| 2001.5.22  ksh. stev �߰�						|
+----------------------------------------------------------------------*/
#define	_BUILD		/*2001.5.21*/
#define	_STEV		/*2001.5.22*/

/************************************************************************
*	Header for CMREG						*
************************************************************************/

#ifndef	__CMREG_H
#define	__CMREG_H

/*----------------------------------------------------------------------+
|	Define	Action	Code						|
+----------------------------------------------------------------------*/
#define	REG_DELETE	'D'
#define	REG_READ	'R'
#define	REG_WRITE	'W'
#define	REG_READPR	'P'
#define	REG_READNX	'N'
#ifdef	_BUILD
#define	REG_BUILD	'B'					/*2001.5.21*/
#endif

/*2000.7.7 add----------------------------------------------------------------*/
/* client kind */
#define	CLNT_TERMINAL	'T'
#define	CLNT_APPLSVR	'S'
#define	CLNT_BRANCHSVR	'B'
#define	CLNT_DYNAMIC	'D'

/* client os */
#define	CLNT_DOS	'0'
#define	CLNT_WIN31	'1'
#define	CLNT_WIN95	'2'
#define	CLNT_UNIX	'3'

/* session consistency */
#define	CLNT_RESIDENT	'R'
#define	CLNT_TRANSIENT	'T'

/* ���Ӹ�� */
#define	CLNT_USER	'U'
#define	CLNT_TEST	'T'

/*2000.7.7 end----------------------------------------------------------------*/

/*----------------------------------------------------------------------+
|	structure define						|
+----------------------------------------------------------------------*/

/*2000.7.7 add----------------------------------------------------------------*/
struct	reg_clntFORM	{		
	char	cliid		[ 8];	/* Client ID		   	*/
	char	clinm		[20];	/* Client ��		 	*/
	char	clikind		[ 1];	/* Client Kind 		 	*/
	char	clios		[ 1];	/* Client O/S 		 	*/
	char	persist		[ 1];	/* session consistency. 	*/
	char	loginmode	[ 1];	/* ���Ӹ��			*/
	char	maxssno		[ 4];	/* �ִ� �α������ ���Ǽ�	*/
	char	ipaddr		[15];	/* IP �ּ�(TCP/IP)		*/
					/* ex. "123.23.45.8" 		*/
	char	redir		[60];	/* ǥ������� ȭ�� redirect ���*/
	char	tracelog	[1];	/* Trace �α� ���� (0~9)	*/
	char	cmdlog		[1];	/* Data�α� ����:CMD(User Data Block)*/
	char	pktlog		[1];	/* Data�α� ����:Packet ����	*/
	char	blklog		[1];	/* Data�α� ����:Block ���� 	*/
	char	rawlog		[1];	/* Data�α� ����:Raw ���� 	*/
					/* 		:('0',' '/'1')	*/
};
/*2000.7.7 end----------------------------------------------------------------*/

	/* user Layout */
struct	reg_userFORM	{
	char	asid[4];		/* Application System ID	*/
	char	usid[8];		/* ����� ID		   	*/
	char	usnm[12];		/* ����� ��		 	*/
	char	ugrp[4];		/* �Ҽ� ����� �׷� ID 	 	*/
	char	ulev[1];		/* ����� ����			*/
	char	upwd[8];		/* ��й�ȣ			*/
};

	/* usid Layout */
struct	reg_usidFORM	{
	char	usid[8];		/* ����� ID		   	*/
	char	usnm[12];		/* ����� ��		 	*/
	char	ugrp[4];		/* �Ҽ� ����� �׷� ID 	 	*/
	char	ulev[1];		/* ����� ����			*/
	char	upwd[8];		/* ��й�ȣ			*/
};

	/* login user Layout */
struct	reg_lusrFORM	{
	char	asid[4];		/* Application System ID	*/
	char	usid[8];		/* ����� ID		   	*/
};

	/* txid Layout */
struct	reg_txidFORM	{
	char	txid	[  8];		/* Transaction ID		*/
	char	txnm	[ 30];		/* TX Name			*/
	char	hostid	[  1];		/* TX Server HOST ID		*/
					/*   'A' - 'z',			*/
					/*   '0' = End UserClient	*/
	char	pgid	[  8];		/* Program ID			*/
	char	pgfpath	[ 80];		/* Program File Path		*/
	char	pgsts	[  1];		/* Program Status		*/
					/*   'G' = ������		*/
					/*   'R' = ���		*/
					/*   'M' = ������		*/
					/*   'D' = ���			*/
	char	resists	[  1];		/* appl resident status		*/
					/* ('R'=Resident, else Ab-Resident) */
	char	runmethod[ 1];
};

	/* fmid Layout */
struct	reg_fmidFORM	{
	char	fmid	[  8];		/* Screen Form ID		*/
	char	formnm	[ 40];		/* Screen Form Name		*/
	char	fmgrp	[  4];		/* Screen Group			*/
	char	cpgid	[  8];		/* Client Program ID		*/
	char	txid	[  8];		/* default Server TXID		*/
	char	ulev	[  1];		/* User Level for Using		*/
	char	runkind	[  1];		/* 'A' or ' ' Application	*/
					/* 'M' Menu			*/
					/* 'L' Logo			*/
	char	formkind[  1];		/* 'G' or ' ' GUI Form		*/
					/* 'T' Text Form		*/
};

	/* evid Layout */
struct	reg_evctFORM	{
	char	fmid	[  8];		/* Screen Form ID		*/
	char	evid	[  8];		/* Event ID			*/
	char	rkind	[  1];		/* Running Kind			*/
					/*  'U' = User Procedure	*/
					/*  'C' = Client Pgm �⵿	*/
					/*  'T' = Transaction		*/
					/*  ' ' = No Action		*/
	char	fcode	[  1];		/* Function Code		*/
	char	txid	[  8];		/* TXID / Program ID		*/
	char	chg	[  1];		/* Screen Change Method		*/
					/*  ' ' = ȭ�� ����		*/
					/*  'N' = New Form		*/
					/*  'M' = Move Focus		*/
					/*  'C' = Change Form		*/
					/*  'L' = Link Form		*/
					/*  'B' = Back Form		*/
					/*  'X' = Exit System		*/
					/*  'E' = End Form		*/
	char	tofmid	[  8];		/* ��ȯ�� Screen Form ID	*/
	char	torkind	[  1];		/* ��ȯ���� Running Kind	*/
	char	tofcode	[  1];		/* ��ȯ�� �߻���ų Function Code*/
	char	totxid	[  8];		/* ��ȯ���� TXID		*/
};

	/* ascl Layout */
struct	reg_asclFORM	{
	char	fname	[20];		/* file name			*/
	char	clios	[ 1];		/* client OS			
					   '0' : dos
					   '1' : win31
					   '2' : win95
					   ' ' : all			*/
	char	group	[ 1];		/* group			
					   '0' : win
					   '1' : sys
					   '2' : bin
					   '3' : run
					   ' ' : user define		*/
	char	dnpath	[60];		/* file path of down host	*/
	char	fsize	[10];		/* file real size		*/
	char	compress[ 1];		/* compress kind			
					   'a' : arj
					   'z' : zip
					   'l' : lha
					   ' ' : none			*/
	char	csize	[10];		/* compressed size		*/
	char	usid	[ 8];		/* add user			*/
	char	filler	[ 9];		/* ����				*/
};

#ifdef	_STEV
/*2001.5.22. add--------------------------------------------------------------*/
	/* stev Layout */
struct	reg_stevFORM	{
	char	evid	[  8];		/* Event ID			*/
	char	fcode	[  1];		/* Function Code		*/
	char	evnm	[ 30];		/* Event Name		 	*/
	char	filler 	[  9];		/* Filler			*/
};
/*end of 2001.5.22------------------------------------------------------------*/
#endif

/*----------------------------------------------------------------------+
|	external function proto type					|
+----------------------------------------------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

void CBD1	CmRegClose	CBD2(( void ));
int CBD1	CmRegOpen	CBD2(( void ));
void CBD1	CmRegCommit	CBD2(( void ));
void CBD1	CmRegRollback	CBD2(( void ));

/*2000.7.7*/
int CBD1	CmRegClnt	CBD2(( struct reg_clntFORM *, char ));
int CBD1	CmRegEvct	CBD2(( char *, struct reg_evctFORM *, char ));
int CBD1	CmRegFmid	CBD2(( char *, struct reg_fmidFORM *, char ));
int CBD1	CmRegLusr	CBD2(( struct reg_lusrFORM *, char ));
int CBD1	CmRegTxid	CBD2(( char *, struct reg_txidFORM *, char ));
int CBD1	CmRegUser	CBD2(( struct reg_userFORM *, char ));
int CBD1	CmRegUsid	CBD2(( struct reg_usidFORM *, char ));
int CBD1	CmRegAscl	CBD2(( char *, struct reg_asclFORM *, char *, char));
#ifdef	_STEV
/*2001.5.22. add--------------------------------------------------------------*/
int CBD1	CmRegStev	CBD2(( char *, struct reg_stevFORM *, char ));
/*end of 2001.5.22------------------------------------------------------------*/
#endif

void CBD1	OCMREGCLOSE	CBD2(( void ));
void CBD1	OCMREGOPEN	CBD2(( char * ));
void CBD1	OCMREGCOMMIT	CBD2(( void ));
void CBD1	OCMREGROLLBACK	CBD2(( void ));

/*2000.7.7*/
void CBD1	OCMREGCLNT	CBD2(( char *, char *, char * ));
void CBD1	OCMREGEVCT	CBD2(( char *, char *, char *, char * ));
void CBD1	OCMREGFMID	CBD2(( char *, char *, char *, char * ));
void CBD1	OCMREGLUSR	CBD2(( char *, char *, char * ));
void CBD1	OCMREGTXID	CBD2(( char *, char *, char *, char * ));
void CBD1	OCMREGUSER	CBD2(( char *, char *, char * ));
void CBD1	OCMREGUSID	CBD2(( char *, char *, char * ));
void CBD1	OCMREGASCL	CBD2(( char *, char *, char *, char *, char *));

#ifdef	__cplusplus
}
#endif

#endif	/* __CMREG_H */

/************************************************************************
*	End of Header							*
************************************************************************/
