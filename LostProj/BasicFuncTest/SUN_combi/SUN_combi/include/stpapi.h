/* stpapi.h */
/************************************************************************
*	Header for STPAPI						*
************************************************************************/

#ifndef	__STPAPI_H
#define	__STPAPI_H

#include	<sys/types.h>
#include	"cbuni.h"

#ifndef	_WHYCANCEL
#define	_WHYCANCEL
extern	int	WHYCANCEL;
#endif	/* _WHYCANCEL */

/*----------------------------------------------------------------------+
|	FTP in STPAPI							|
+----------------------------------------------------------------------*/
#define	FILEEXIST	'E'		/* FTP   전 catch file-existance*/
#define	INTRUSER	'I'		/* FTP 도중 USER 에 의해 중단	*/

/*----------------------------------------------------------------------+
|	DLTP Control Isam-Data-File Symbolic Identifier			|
+----------------------------------------------------------------------*/

#ifndef	DLTP_CLNT
#define	DLTP_CLNT	'a'	/* "clnt"   Client       등록 자료 화일	*/
#define	DLTP_USID	'b'	/* "usid"   사용자       등록 자료 화일	*/
#define	DLTP_UGRP	'c'	/* "ugrp"   사용자 그룹  등록 자료 화일	*/
#define	DLTP_ULEV	'd'	/* "ulev"   사용자 레벨  등록 자료 화일	*/

#define	DLTP_TXID	'e'	/* "txid"   트랜젝션     등록 자료 화일	*/
#define	DLTP_LUSR	'f'	/* "lusr"   LOGIN 사용자 등록 자료 화일	*/
#endif	/* DLTP_CLNT */
/*----------------------------------------------------------------------+
|	structure define						|
+----------------------------------------------------------------------*/
	/* TCA Layout */
struct	TCA_FORM		{
	/* Client Information */
	char	cliid		[ 8];
	char	clinm		[20];
	char	clikind		[ 1];
	char	filler1		[ 3];

	/* Session Information */
	char	termid		[ 8];
	char	clihostnm	[16];
	time_t	tpstarttm;
#ifdef	WIN32
	DWORD	svpid;
#else
	pid_t	svpid;
#endif

	/* AS Information */
	char	asid		[ 4];
	char	ashome		[80];
	char	ascfg		[80];
	char	myhostid	[ 1];
	char	txcntl		[80];
	char	usercntl	[80];
	char	txappl		[80];
	char	myowner		[16];
	char	mainrhostid	[ 1];
	char	filler2		[ 2];
#ifdef	WIN32
	unsigned int	myownid;
	unsigned int	mygrpid;
#else
	uid_t	myownid;
	gid_t	mygrpid;
#endif

	/* User Information */
	char	usid		[ 8];
	char	usnm		[12];
	char	ugrp		[ 4];
	char	ugrpnm		[20];
	char	ulev		[ 1];
	char	ulevnm		[20];
	char	filler3		[ 3];
	long	ulogintm;

	/* TX Information */
	char	txid		[ 8];
	char	pgid		[ 8];
	char	pgfpath		[80];
/*	char	xctltxid	[ 8];       97.01.30  JJH DELETE */
	time_t	txstarttm;
#ifdef	WIN32
	DWORD	appid;
#else
	pid_t	appid;
#endif
};

struct	CLI_INFORM	{	/* cha FORM */
	char	cliid	[ 8];		/* client id. space terminated */
	char	clinm	[20];		/* clinet name. space terminated */
	char	clikind [ 1];		/* client kind. */
					/* 'T'=terminal, 'S'=appl.server */
					/* 'B'=branch server */
	char	clios	[ 1];		/* client o/s */
					/* '0' = dos */
					/* '1' = win3.1 */
					/* '2' = win95 */
					/* '3' = unix */
	char	persist	[ 1];		/* session consistency. */
					/* 'R'=resident, 'T'=transient */
	char	loginmode[ 1];		/* default login mode */
					/* 'U'=user mode, 'T'=developer mode */
	int	maxssno;		/* 최대로그인 허용세션수 */
	char	ipaddr	[16];		/* network ip addr. null term. */
					/* ex. "123.23.45.8" */
	char	redir	[80];		/* stdout redirection file path */

	int	tracelev;		/* Trace logging level (0~9) */
	int	datalev;		/* Data logging level (0~15) */
};

/*----------------------------------------------------------------------+
|	external function proto type					|
+----------------------------------------------------------------------*/

#ifdef	__cplusplus
extern "C" {
#endif

void CBD1	Zapiend CBD2(( void ));
int CBD1	Zapiinit CBD2(( void ));
int CBD1	Zcoretx CBD2(( char *txid, char *data, int datalen ));
int CBD1	Zendtx CBD2(( void ));
int CBD1	Zerrend CBD2(( int errnum, char *errmsg ));
int CBD1	Zerrlog CBD2(( char *format, ... ));
int CBD1	Zerrlog_close CBD2(( void ));
int CBD1	Zexecpgid CBD2(( char *pgid, char *argstr ));
int CBD1	Zflush CBD2(( void ));
int CBD1	Zgettca CBD2(( struct TCA_FORM *tca ));
int CBD1	Zgoback CBD2(( void ));
int CBD1	Zlightmsg CBD2(( char *msgstr ));
int CBD1	Zputtca CBD2(( struct TCA_FORM *tca ));
int CBD1	Zreadtsa CBD2(( char *data, int length, int offset ));
int CBD1	Zreaduca CBD2(( char *data, int length, int offset ));
int CBD1	Zrecv CBD2(( char *data ));
int CBD1	Zsend CBD2(( char *data, int datalen ));
int CBD1	Ztpmsg CBD2(( char *msg ));
int CBD1	Zstarttx CBD2(( char *txid, char *data, int datalen ));
int CBD1	Zsupertx CBD2(( char *txid, char *data, int datalen ));
int CBD1	Zwrttsa CBD2(( char *data, int length, int offset ));
int CBD1	Zwrtuca CBD2(( char *data, int length, int offset ));
int CBD1	Zrflush CBD2(( void ));
int CBD1	Zrrecv CBD2(( char *data ));
int CBD1	Zrsend CBD2(( char *data, int datalen ));
void CBD1	Zerrset CBD2(( char *retcode ));
int CBD1	Zsendfile CBD2(( char *myfpath, char ftype, char compress ));
int CBD1	ZsendfileX CBD2(( char *mflst ));
int CBD1	Zrecvfile CBD2(( char *myfpath, char overwrite ));
int CBD1	Zrupfile CBD2(( char *myfpath, char hostid,   char *hostfpath,
		  char ftype,    char compress, char overwrite ));
int CBD1	Zrdownfile CBD2(( char *myfpath, char hostid,   char *hostfpath,
		    char ftype,    char compress, char overwrite ));
int CBD1	Zrsendfile CBD2(( char *myfpath, char ftype, char compress ));
int CBD1	Zrrecvfile CBD2(( char *myfpath, char overwrite ));
int CBD1	Zgetascfg CBD2(( char *asid, char *ascfgpath ));
int CBD1	Zgetascfgex CBD2(( char *tpid, char *asid, char *ascfgpath ));
int CBD1	Zdltpopen CBD2(( char fkind ));
int CBD1	Zdlasopen CBD2(( char fkind, char *asid ));
int CBD1	Zdltptropen CBD2(( char fkind ));
int CBD1	Zdlastropen CBD2(( char fkind, char *asid ));
int CBD1	Zdlisclnt CBD2(( char *cliid ));
int CBD1	Zdlisusid CBD2(( char *usid ));
int CBD1	Zdlisugrp CBD2(( char *ugrp ));
int CBD1	Zdlisulev CBD2(( char *ulev ));
int CBD1	Zdlistxid CBD2(( char *asid, char *txid ));
int CBD1	Zdlislusr CBD2(( char *asid, char *usid ));
int CBD1	Zdlclose CBD2(( int cntlFD ));
int CBD1	Zdlredeq CBD2(( int cntlFD, char *keyname, char *record ));
int CBD1	Zdlclose CBD2(( int cntlFD ));
int CBD1	Zdlredge CBD2(( int cntlFD, char *keyname, char *record ));
int CBD1	Zdlredgt CBD2(( int cntlFD, char *keyname, char *record ));
int CBD1	Zdlredle CBD2(( int cntlFD, char *keyname, char *record ));
int CBD1	Zdlredlt CBD2(( int cntlFD, char *keyname, char *record ));
int CBD1	Zdlrednx CBD2(( int cntlFD, char *record ));
int CBD1	Zdlredpr CBD2(( int cntlFD, char *record ));
int CBD1	Zdladdit CBD2(( int cntlFD, char *record ));
int CBD1	Zdlupdat CBD2(( int cntlFD, char *record ));
int CBD1	Zdldelet CBD2(( int cntlFD, char *record ));
/* JJH ADD 97.12.02 */
int CBD1	Zgetcliinf CBD2(( char *cliid, struct CLI_INFORM *cli_inf ));
int CBD1	Zcvadd CBD2(( char *asid, char clios, char group, char *fname, 
			    char *dnpath, char *srcpath ));
int CBD1	Zreadtsan CBD2(( char *tsaname, char *data, int len, int offset ));
int CBD1	Zwrttsan CBD2(( char *tsaname, char *data, int len, int offset ));
int CBD1	Zfmuladd CBD2(( char *asid, char *fname, char *srcpath ));
int CBD1	Zgettpcfg CBD2(( char *ascfgpath ));
#ifdef	WIN32
void CBD1	Zcancelio CBD2(( void ));
#endif
int CBD1	Zcvaddex CBD2(( char *tpid,char *asid,char clios,char *fname ));

void CBD1	OZAPIEND CBD2(( char *retcode ));
void CBD1	OZAPIINIT CBD2(( char *retcode ));
void CBD1	OZCORETX CBD2(( char *txid, char *data, int *datalen, char *retcode ));
void CBD1	OZENDTX CBD2(( char *retcode ));
void CBD1	OZERREND CBD2(( int *errnum, char *errmsg, char *retcode ));
void CBD1	OZERRLOG CBD2(( char *msgstr, char *retcode ));
void CBD1	OZEXECPGID CBD2(( char *pgid, char *argstr, char *retcode ));
void CBD1	OZFLUSH CBD2(( char *retcode ));
void CBD1	OZGETTCA CBD2(( struct TCA_FORM *tca, char *retcode ));
void CBD1	OZGOBACK CBD2(( char *retcode ));
void CBD1	OZLIGHTMSG CBD2(( char *msgstr, char *retcode ));
void CBD1	OZPUTTCA CBD2(( struct TCA_FORM *tca, char *retcode ));
void CBD1	OZREADTSA CBD2(( char *data, int *length, int *offset, char *retcode));
void CBD1	OZREADUCA CBD2(( char *data, int *length, int *offset, char *retcode));
void CBD1	OZRECV CBD2(( char *data, int *datelen, char *retcode ));
void CBD1	OZSEND CBD2(( char *data, int *datalen, char *retcode ));
void CBD1	OZTPMSG CBD2(( char *msg, char *retcode ));
void CBD1	OZSTARTTX CBD2(( char *txid, char *data, int *datalen, char *retcode));
void CBD1	OZSUPERTX CBD2(( char *txid, char *data, int *datalen, char *retcode));
void CBD1	OZWRTTSA CBD2(( char *data, int *length, int *offset, char *retcode ));
void CBD1	OZWRTUCA CBD2(( char *data, int *length, int *offset, char *retcode ));
void CBD1	OZRRECV CBD2(( char *data, int *datelen, char *retcode ));
void CBD1	OZRSEND CBD2(( char *data, int *datalen, char *retcode ));
void CBD1	OZRFLUSH CBD2(( char *retcode ));
void CBD1	OZSENDFILE CBD2(( char *myfpath, char *ftype, char *compress,
			char *retcode ));
void CBD1	OZRSENDFILE CBD2(( char *myfpath, char *ftype, char *compress,
			char *retcode ));
void CBD1	OZRECVFILE CBD2(( char *myfpath, char *overwrite, int *recvlen,
			char *retcode ));
void CBD1	OZRRECVFILE CBD2(( char *myfpath, char *overwrite, int *recvlen,
			char *retcode ));
void CBD1	OZRUPFILE CBD2(( char *myfpath, char *hostid, char *hostfpath,
			char *ftype, char *compress, char *overwrite,
			char *retcode ));
void CBD1	OZRDOWNFILE CBD2(( char *myfpath, char *hostid, char *hostfpath,
			char *ftype, char *compress, char *overwrite,
			int *downlen, char *retcode ));
void CBD1	OZGETASCFG CBD2(( char *asid, char *ascfgpath, char *retcode ));
void CBD1	OZGETASCFGEX CBD2(( char *tpid, char *asid, char *ascfgpath, char *retcode ));
void CBD1	OZCVADD CBD2(( char *asid, char *clios, char *group, char *fname,
			    char *dnpath, char *srcpath, char *retcode ));
void CBD1	OZREADTSAN CBD2(( char *tsaname, char *data, 
				int *len, int *offset, char *retcode ));
void CBD1	OZWRTTSAN CBD2(( char *tsaname, char *data, 
			       int *len, int *offset, char *retcode ));

/* for stapix */
int CBD1	Zxpermchk CBD2(( struct TCA_FORM *tca, 
			       char *tofmid, char *msgstr ));

void CBD1	OZXPERMCHK CBD2(( struct TCA_FORM *tca, char *tofmid, 
				char *msgstr, char *retcode ));
void CBD1	OZFMULADD CBD2(( char *asid, char *fname, char *srcpath, char *retcode ));
void CBD1	OZGETTPCFG CBD2(( char *ascfgpath, char *retcode ));
void CBD1	OZCVADDEX CBD2(( char *tpid, char *asid, char *clios,
				char *fname, char *retcode ));



#ifdef	__cplusplus
}
#endif

#endif	/* __STPAPI_H */

/************************************************************************
*	End of Header							*
************************************************************************/
