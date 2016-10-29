/* sspapi.h */
/************************************************************************
*	Header for SSPAPI						*
************************************************************************/

#ifndef	__SSPAPI_H
#define	__SSPAPI_H

#include	<sys/types.h>
#include	<stdio.h>

#include	"cbuni.h"

/*
#ifndef	_HYERRNO
#define	_HYERRNO
extern	int	hyerrno;
#endif	* _HYERRNO *
*/

/*----------------------------------------------------------------------+
|	structure define						|
+----------------------------------------------------------------------*/
	/* TCA Layout */
struct	SSP_TCA_FORM		{	/* 464 Bytes */
	/* Client Information	( 48 Bytes ) */
	char	cliid		[ 8];	/* Client ID */	
	char	clinm		[20];	/* Client Name Received from Server */
	char	clikind		[ 1];	/* Client Kind. always 'S' */
					/*  - 'T' : Terminal */
					/*  - 'S' : application Server */
					/*  - 'B' : Branch server */
	char	clios		[ 1];	/* Client O/S. always '3' */
					/*  - '0' : DOS */
					/*  - '1' : Windows V3.1 */
					/*  - '2' : Windows 95 */
					/*  - '3' : UNIX */
	char	filler1		[ 2];
	int	traceloglev;		/* Trace Logging Level */
	int	dataloglev;		/* Data Logging Level */
	char	filler2		[ 8];

	/* AS Information	( 168 Bytes ) */
	char	asid		[ 4];	/* Application System ID */
	char	ascfgpath	[80];	/* <ascfg>.cfg file path */
	char	mainhost	[ 1];	/* Main Server Host ID */
	char	splogpath	[80];	/* log file path */
	char	filler3		[ 3];

	/* User Information	( 80 Bytes ) */
	char	usid		[ 8];	/* logged in User ID */
	char	pswd		[ 8];	/* Password */
	char	usnm		[12];	/* User Name. rcved from server */
	char	ugrp		[ 4];	/* User Group. rcved from server */
	char	ugrpnm		[20];	/* User Group Name. rcved from server */
	char	ulev		[ 1];	/* User Level. rcved from server */
	char	ulevnm		[20];	/* User Level Name. rcved from server */
	char	filler4		[ 7];

	/* Session Information 	( 144 Bytes ) */
	char	ssno		[ 4];	/* Session Number. rcved from server */
	char	proto		[ 1];	/* comm. Protocol */
					/*  - '0' : TCP/IP */
					/*  - '1' : Async */
					/*  - '2' : SNA */
	char	loginmode	[ 1];	/* Login Mode */
					/*  - 'T' : 개발자 모드 */
					/*  - 'U' : 사용자 모드 */
	char	persist		[ 1];	/* Session Persistency */
					/*  - 'T' : Transient */
					/*  - 'R' : Resident */
	char	hostid		[ 1];	/* Current Host ID */
	int	portno;			/* Current Port Number */
	char	hostname	[20];	/* Current Host Name */
	char	txid		[ 8];	/* TXID in Session */
	char	runtxid		[ 8];	/* Current Running TXID */
	char	bind		[ 1];	/* 셰션접속모드 */
					/*  - 'B' : Bound */
					/*  - 'U' : Unbound */
	char	trclogpath	[80];	/* Trace Log File Path */
	char	filler5		[ 3];
	FILE	*trclogfd;		/* Trace Log File Descriptor */
	char	filler6		[ 8];

	/* Status Time Information	( 24 Bytes ) */
	time_t	sslogintm;		/* Session Login Time */
	time_t	tpstarttm;		/* TP Start Time */
	time_t	txstarttm;		/* TX Start Time */
	time_t	ulogintm;		/* User Login Time */
	char	filler7		[ 8];
};

/*----------------------------------------------------------------------+
|	Define Error NO. for SSPAPI					|
+----------------------------------------------------------------------*/

#define ESSP_APIINITALREADY	15101	/* ZTapiinit() already */
#define ESSP_ARGERR		15102	/* argument error */
#define	ESSP_NOAPIINIT		15103   /* ZTapiinit() not called before */
#define ESSP_INVALIDDATALEN	15104	/* rcvd datalen invalid */
#define ESSP_INVALIDPKT		15105	/* rcvd pktno invalid */
#define ESSP_RECEIVEPKTERR	15106	/* recv pkt error */
#define ESSP_SENDPKTERR		15107	/* send pkt error */
#define ESSP_TXIDSPACE		15108	/* invalid space entered txid */
#define ESSP_RCVSIGNAL		15109	/* rcv signal, then terminate */
#define ESSP_BEINGCLOSEDFD	15110	/* Closed Socket FD */
#define ESSP_CONNECTERR		15111	/* Connect Error */
#define ESSP_ERRORRESP		15112	/* Error Response */
#define ESSP_FULLSESSION	15113	/* Full Session */
#define ESSP_INITDTPERR		15114	/* x_initdtp() Error */
#define ESSP_INVALIDPORTNO	15115	/* Invalid Port Number */
#define ESSP_INVALIDSESS	15116	/* Invalid Session */
#define ESSP_INVALIDSSD		15117	/* Invalid Session Descriptor */
#define ESSP_NODEFASID		15118	/* No Define $(ASID) */
#define ESSP_NODEFMAINHOST	15119	/* No Define $(MAINHOST) */
#define ESSP_NODEFMYCLIID	15120	/* No Define $(MYCLIID) */
#define ESSP_NODEFSPLOG		15121	/* No Define $(SPLOG) */
#define ESSP_NOENTRYHOSTNAME	15122	/* No Define $(HOSTNAME) */
#define ESSP_NOENTRYPORTNO	15123	/* No Define $(PORTNO) */
#define ESSP_NOENTRYPROTO	15124	/* No Define $(PROTO) */
#define ESSP_NOSETASCFG		15125	/* No Set Env. $(ASCFG) */
#define ESSP_NOSSLOGIN		15126	/* No Session Login */
#define ESSP_OPENSOCKERR	15127	/* Open Socket Error */
#define ESSP_RECEIVETIMEOUT	15128	/* Receive Time Out */
#define ESSP_RECVEDTXEND	15129	/* Received TX End */
#define ESSP_SETDTPERR		15130	/* x_setdtp() Error */
#define ESSP_SHUTDOWN		15131	/* Remote Server is Shutdown */
#define ESSP_TPERROREND		15132	/* TP Error End */
#define ESSP_TXEND		15133	/* TX End */
#define ESSP_TXERROREND		15134	/* TX Error End */
#define ESSP_TXSTARTALREADY	15135	/* TX Start Already */
#define	ESSP_INVALIDFILESIZE	15136	/* invalid recv file size */

/*----------------------------------------------------------------------+
|	external function proto type					|
+----------------------------------------------------------------------*/
/* for C */
extern	int	ZTapiend CBD2( ( void ) );
extern	int	ZTapiinit CBD2( ( void ) );
extern	int	ZTcoretx CBD2( ( int ssd, char *txid, char *data, int datalen ) );
extern	int	ZTendtx CBD2( ( int ssd ) );
/********** Changed 1 line to 1 line by YI, 990512 *****************************
extern	void	ZTerrend CBD2( ( int errno, char *errmsg ) );
*******************************************************************************/
extern	void	ZTerrend CBD2( ( int errnum, char *errmsg ) );
/******************************************************************************/
extern	int	ZTerrlog CBD2( ( char *msg_format, ... ) );
extern	int	ZTflush CBD2( ( int ssd ) );
extern	int	ZTgettca CBD2( ( int ssd, struct SSP_TCA_FORM *tca ) );
extern	int	ZTputtca CBD2( ( int ssd, struct SSP_TCA_FORM *tca ) );
extern	int	ZTrecv CBD2( ( int ssd, char *data ) );
extern	int	ZTsend CBD2( ( int ssd, char *data, int datalen ) );
extern	int	ZTsslogin CBD2( ( char hostid, char persist, char loginmode ) );
extern	int	ZTsslogout CBD2( ( int ssd ) );
extern	int	ZTstarttx CBD2( ( int ssd, char *txid, char *data, int datalen ) );
extern	int	ZTsupertx CBD2( ( int ssd, char *txid, char *data, int datalen ) );
extern	int	ZTtrclog CBD2( ( int ssd, char *msg_format, ... ) );
extern	int	ZTulogin CBD2( ( int ssd, char *usid, char *pswd ) );
extern	int	ZTulogout CBD2( ( int ssd ) );
extern	void	ZTerrset CBD2( ( char *retcode ) );
extern	int	ZTdownfile CBD2( ( int ssd, char *myfpath, char hostid, char *hostfpath, char ftype, char compress, char overwrite ) );
extern	int	ZTupfile CBD2( ( int ssd, char *myfpath, char hostid, char *hostfpath, char ftype, char compress, char overwrite ) );
extern	int	ZTrecvfile CBD2( ( int ssd, char *myfpath, char overwrite ) );
extern	int	ZTsendfile CBD2( ( int ssd, char *myfpath, char ftype, char compress ) );
/* for COBOL */
extern	void	OZTAPIEND CBD2( ( char *retcode ) );
extern	void	OZTAPIINIT CBD2( ( char *retcode ) );
extern	void	OZTCORETX CBD2( ( int *ssd, char *txid, char *data, int *datalen, char *retcode ) );
extern	void	OZTENDTX CBD2( ( int *ssd, char *retcode ) );
extern	void	OZTERREND CBD2( ( int *errnum, char *errmsg, char *retcode ) );
extern	void	OZTERRLOG CBD2( ( char *logmsg, char *retcode ) );
extern	void	OZTFLUSH CBD2( ( int *ssd, char *retcode ) );
extern	void	OZTGETTCA CBD2( ( int *ssd, struct SSP_TCA_FORM *tca, char *retcode ) );
extern	void	OZTPUTTCA CBD2( ( int *ssd, struct SSP_TCA_FORM *tca, char *retcode ) );
extern	void	OZTRECV CBD2( ( int *ssd, char *data, int *datalen, char *retcode ) );
extern	void	OZTSEND CBD2( ( int *ssd, char *data, int *datalen, char *retcode ) );
extern	void	OZTSSLOGIN CBD2( ( int *ssd, char *hostid, char *persist, char *loginmode, char *retcode ) );
extern	void	OZTSSLOGOUT CBD2( ( int *ssd, char *retcode ) );
extern	void	OZTSTARTTX CBD2( ( int *ssd, char *txid, char *data, int *datalen, char *retcode ) );
extern	void	OZTSUPERTX CBD2( ( int *ssd, char *txid, char *data, int *datalen, char *retcode ) );
extern	void	OZTTRCLOG CBD2( ( int *ssd, char *logmsg, char *retcode ) );
extern	void	OZTULOGIN CBD2( ( int *ssd, char *usid, char *pswd, char *retcode ) );
extern	void	OZTULOGOUT CBD2( ( int *ssd, char *retcode ) );
extern	void	OZTDOWNFILE CBD2( ( int *ssd, char *myfpath, char *hostid, char *hostfpath, char *ftype, char *compress, char *overwrite, int *filesize, char *retcode ) );
extern	void	OZTUPFILE CBD2( ( int *ssd, char *myfpath, char *hostid, char *hostfpath, char *ftype, char *compress, char *overwrite, char *retcode ) );
extern	void	OZTRECVFILE CBD2( ( int *ssd, char *myfpath, char *overwrite, int *filesize, char *retcode ) );
extern	void	OZTSENDFILE CBD2( ( int *ssd, char *myfpath, char *ftype, char *compress, char *retcode ) );

#endif	/* __SSPAPI_H */

/************************************************************************
*	End of Header							*
************************************************************************/
