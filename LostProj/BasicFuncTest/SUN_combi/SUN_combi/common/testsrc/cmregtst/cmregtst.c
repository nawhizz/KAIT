/*======================================================================*/
/*	cmregtst.c							*/
/*======================================================================*/
/*	Description   : cmreg test					*/
/*	System	      : COMBI						*/
/*	Project	      : COMMON						*/
/*	Group	      : TESTSRC						*/
/*	Written Date  : 2001.05.25					*/
/*	Written by    : 김성환						*/
/*======================================================================*/
/*----------------------------------------------------------------------*/
/*	SOURCE HISTORY							*/
/*----------------------------------------------------------------------*/
/*									*/
/*----------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	INCLUDE FILES							*/
/*----------------------------------------------------------------------*/

/*-----	System Library Headers	----------------------------------------*/
#include	<stdio.h>
#include	<string.h>
#include	<errno.h>

/*----- Common Library Headers -----------------------------------------*/
#include	"gps.h"
#include	"stpapi.h"
#include	"cmreg.h"

/*-----	Define Variables -----------------------------------------------*/
#define	MAX_INF		14
#define	MAX_BUF		128

#define	MOVESTR(a,b)		move(a,strlen(a),b,sizeof(b))
#define	move(a,alen,b,blen)	(alen<blen? memcpy(b,a,alen),memset(b+alen,' ',blen-alen):memcpy(b,a,blen))
#define	COPYNULL(a,b)		copynull(a,sizeof(a),b,sizeof(b))

/*-----	Global Variables -----------------------------------------------*/
struct	SCRFORM {
	char	version	[1];
	char	fcode	[1];
	char	ftnname	[16];
	char	action	[1];
	char	data	[MAX_INF][MAX_BUF];
} SCR;

/*-----	Internal Function Prototype ------------------------------------*/
static	void	CmRegAscl_rtn	CBD2( ( void ) );
static	void	CmRegClnt_rtn	CBD2( ( void ) );
static	void	CmRegEvct_rtn	CBD2( ( void ) );
static	void	CmRegFmid_rtn	CBD2( ( void ) );
static	void	CmRegLusr_rtn	CBD2( ( void ) );
static	void	CmRegStev_rtn	CBD2( ( void ) );
static	void	CmRegTxid_rtn	CBD2( ( void ) );
static	void	CmRegUser_rtn	CBD2( ( void ) );
static	void	CmRegUsid_rtn	CBD2( ( void ) );
static	void	copynull	CBD2( ( char *, int, char *, int ) );
static	void	MYSCR_RTN	CBD2( ( void ) );
static	void	senddata	CBD2(( char gubun, char *item1, char *item2 ));
static	void	sendend		CBD2(( void ));
static	void	ERROREND	CBD2(( char *message ));

/*-----	main Functions -------------------------------------------------*/
#ifdef	WIN32
int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance,
		   PSTR lpszCmdLine, int nCmdShow)
#else
int
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
#endif
{
	if( Zapiinit() )					/* init API */
	{
		Zapiend();
	}

	if( Zrecv( (char *)&SCR ) < 0 )
	{
		Zerrlog( "수신 오류" );
		Zapiend();
	}

	MYSCR_RTN();

	if( Zsend( (char *)&SCR, sizeof( SCR ) ) < 0 )
	{
		Zerrlog( "송신 오류" );
	}

	Zapiend();					/* 프로그램 정상종료 */

#ifdef	WIN32
	return(0);
#endif
}

/*----------------------------------------------------------------------*/
/*	FIXED APPLICATION FUNCTIONS called by main()			*/
/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
MYSCR_RTN( void )
#else
MYSCR_RTN()
#endif
{
	if( SCR.version[0] != ' ' )
	{
		ERROREND( "지원하지 않는 버전입니다" );
	}

	if( SCR.fcode[0] != 'A' )
	{
		ERROREND( "잘못된 fcode 입니다" );
	}

	if( !strcmp( SCR.ftnname, "CmRegAscl()" ) )
		CmRegAscl_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegClnt()" ) )
		CmRegClnt_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegEvct()" ) )
		CmRegEvct_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegFmid()" ) )
		CmRegFmid_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegLusr()" ) )
		CmRegLusr_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegStev()" ) )
		CmRegStev_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegTxid()" ) )
		CmRegTxid_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegUser()" ) )
		CmRegUser_rtn();
	else if( !strcmp( SCR.ftnname, "CmRegUsid()" ) )
		CmRegUsid_rtn();
	else
		ERROREND( "잘못된 ftnname" );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegAscl_rtn( void )
#else
CmRegAscl_rtn()
#endif
{
	struct	reg_asclFORM	regascl;

	MOVESTR( SCR.data[1],	regascl.fname	);
	MOVESTR( SCR.data[2],	regascl.clios	);
	MOVESTR( SCR.data[3],	regascl.group	);
	MOVESTR( SCR.data[4],	regascl.dnpath	);
	MOVESTR( SCR.data[5],	regascl.fsize	);
	MOVESTR( SCR.data[6],	regascl.compress);
	MOVESTR( SCR.data[7],	regascl.csize	);
	MOVESTR( SCR.data[8],	regascl.usid	);
	MOVESTR( SCR.data[9],	regascl.filler	);

	if(CmRegAscl( SCR.data[0], &regascl, SCR.data[10], SCR.action[0] ) < 0)
		ERROREND( "CmRegAscl() 실패" );

	COPYNULL( regascl.fname,	SCR.data[1] );
	COPYNULL( regascl.clios,	SCR.data[2] );
	COPYNULL( regascl.group,	SCR.data[3] );
	COPYNULL( regascl.dnpath,	SCR.data[4] );
	COPYNULL( regascl.fsize,	SCR.data[5] );
	COPYNULL( regascl.compress,	SCR.data[6] );
	COPYNULL( regascl.csize,	SCR.data[7] );
	COPYNULL( regascl.usid,		SCR.data[8] );
	COPYNULL( regascl.filler,	SCR.data[9] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegClnt_rtn( void )
#else
CmRegClnt_rtn()
#endif
{
	struct	reg_clntFORM	regclnt;

	MOVESTR( SCR.data[0],	regclnt.cliid		);
	MOVESTR( SCR.data[1],	regclnt.clinm		);
	MOVESTR( SCR.data[2],	regclnt.clikind		);
	MOVESTR( SCR.data[3],	regclnt.clios		);
	MOVESTR( SCR.data[4],	regclnt.persist		);
	MOVESTR( SCR.data[5],	regclnt.loginmode	);
	MOVESTR( SCR.data[6],	regclnt.maxssno		);
	MOVESTR( SCR.data[7],	regclnt.ipaddr		);
	MOVESTR( SCR.data[8],	regclnt.redir		);
	MOVESTR( SCR.data[9],	regclnt.tracelog	);
	MOVESTR( SCR.data[10],	regclnt.cmdlog		);
	MOVESTR( SCR.data[11],	regclnt.pktlog		);
	MOVESTR( SCR.data[12],	regclnt.blklog		);
	MOVESTR( SCR.data[13],	regclnt.rawlog		);

	if( CmRegClnt( &regclnt, SCR.action[0] ) < 0 )
		ERROREND( "CmRegClnt() 실패" );

	COPYNULL( regclnt.cliid		, SCR.data[0]  );
	COPYNULL( regclnt.clinm		, SCR.data[1]  );
	COPYNULL( regclnt.clikind	, SCR.data[2]  );
	COPYNULL( regclnt.clios		, SCR.data[3]  );
	COPYNULL( regclnt.persist	, SCR.data[4]  );
	COPYNULL( regclnt.loginmode	, SCR.data[5]  );
	COPYNULL( regclnt.maxssno	, SCR.data[6]  );
	COPYNULL( regclnt.ipaddr	, SCR.data[7]  );
	COPYNULL( regclnt.redir		, SCR.data[8]  );
	COPYNULL( regclnt.tracelog	, SCR.data[9]  );
	COPYNULL( regclnt.cmdlog	, SCR.data[10] );
	COPYNULL( regclnt.pktlog	, SCR.data[11] );
	COPYNULL( regclnt.blklog	, SCR.data[12] );
	COPYNULL( regclnt.rawlog	, SCR.data[13] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegEvct_rtn( void )
#else
CmRegEvct_rtn()
#endif
{
	struct	reg_evctFORM	regevct;

	MOVESTR( SCR.data[1],	regevct.fmid	);
	MOVESTR( SCR.data[2],	regevct.evid	);
	MOVESTR( SCR.data[3],	regevct.rkind	);
	MOVESTR( SCR.data[4],	regevct.fcode	);
	MOVESTR( SCR.data[5],	regevct.txid	);
	MOVESTR( SCR.data[6],	regevct.chg	);
	MOVESTR( SCR.data[7],	regevct.tofmid	);
	MOVESTR( SCR.data[8],	regevct.torkind	);
	MOVESTR( SCR.data[9],	regevct.tofcode	);
	MOVESTR( SCR.data[10],	regevct.totxid	);

	if( CmRegEvct( SCR.data[0], &regevct, SCR.action[0] ) < 0 )
		ERROREND( "CmRegEvct() 실패" );

	COPYNULL( regevct.fmid		, SCR.data[1] );
	COPYNULL( regevct.evid		, SCR.data[2] );
	COPYNULL( regevct.rkind		, SCR.data[3] );
	COPYNULL( regevct.fcode		, SCR.data[4] );
	COPYNULL( regevct.txid		, SCR.data[5] );
	COPYNULL( regevct.chg		, SCR.data[6] );
	COPYNULL( regevct.tofmid	, SCR.data[7] );
	COPYNULL( regevct.torkind	, SCR.data[8] );
	COPYNULL( regevct.tofcode	, SCR.data[9] );
	COPYNULL( regevct.totxid	, SCR.data[10] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegFmid_rtn( void )
#else
CmRegFmid_rtn()
#endif
{
	struct	reg_fmidFORM	regfmid;

	MOVESTR( SCR.data[1],	regfmid.fmid	);
	MOVESTR( SCR.data[2],	regfmid.formnm	);
	MOVESTR( SCR.data[3],	regfmid.fmgrp	);
	MOVESTR( SCR.data[4],	regfmid.cpgid	);
	MOVESTR( SCR.data[5],	regfmid.txid	);
	MOVESTR( SCR.data[6],	regfmid.ulev	);
	MOVESTR( SCR.data[7],	regfmid.runkind	);
	MOVESTR( SCR.data[8],	regfmid.formkind);

	if( CmRegFmid( SCR.data[0], &regfmid, SCR.action[0] ) < 0 )
		ERROREND( "CmRegFmid() 실패" );

	COPYNULL( regfmid.fmid		, SCR.data[1] );
	COPYNULL( regfmid.formnm	, SCR.data[2] );
	COPYNULL( regfmid.fmgrp		, SCR.data[3] );
	COPYNULL( regfmid.cpgid		, SCR.data[4] );
	COPYNULL( regfmid.txid		, SCR.data[5] );
	COPYNULL( regfmid.ulev		, SCR.data[6] );
	COPYNULL( regfmid.runkind	, SCR.data[7] );
	COPYNULL( regfmid.formkind	, SCR.data[8] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegLusr_rtn( void )
#else
CmRegLusr_rtn()
#endif
{
	struct	reg_lusrFORM	reglusr;

	MOVESTR( SCR.data[0],	reglusr.asid	);
	MOVESTR( SCR.data[1],	reglusr.usid	);

	if( CmRegLusr( &reglusr, SCR.action[0] ) < 0 )
		ERROREND( "CmRegLusr() 실패" );

	COPYNULL( reglusr.asid	, SCR.data[0] );
	COPYNULL( reglusr.usid	, SCR.data[1] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegStev_rtn( void )
#else
CmRegStev_rtn()
#endif
{
	struct	reg_stevFORM	regstev;

	MOVESTR( SCR.data[1],	regstev.evid	);
	MOVESTR( SCR.data[2],	regstev.fcode	);
	MOVESTR( SCR.data[3],	regstev.evnm	);
	MOVESTR( SCR.data[4],	regstev.filler	);

	if( CmRegStev( SCR.data[0], &regstev, SCR.action[0] ) < 0 )
		ERROREND( "CmRegStev() 실패" );

	COPYNULL( regstev.evid	, SCR.data[1] );
	COPYNULL( regstev.fcode	, SCR.data[2] );
	COPYNULL( regstev.evnm	, SCR.data[3] );
	COPYNULL( regstev.filler, SCR.data[4] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegTxid_rtn( void )
#else
CmRegTxid_rtn()
#endif
{
	struct	reg_txidFORM	regtxid;

	MOVESTR( SCR.data[1],	regtxid.txid		);
	MOVESTR( SCR.data[2],	regtxid.txnm		);
	MOVESTR( SCR.data[3],	regtxid.hostid		);
	MOVESTR( SCR.data[4],	regtxid.pgid		);
	MOVESTR( SCR.data[5],	regtxid.pgfpath		);
	MOVESTR( SCR.data[6],	regtxid.pgsts		);
	MOVESTR( SCR.data[7],	regtxid.resists		);
	MOVESTR( SCR.data[8],	regtxid.runmethod	);

	if( CmRegTxid( SCR.data[0], &regtxid, SCR.action[0] ) < 0 )
		ERROREND( "CmRegTxid() 실패" );

	COPYNULL( regtxid.txid		, SCR.data[1] );
	COPYNULL( regtxid.txnm		, SCR.data[2] );
	COPYNULL( regtxid.hostid	, SCR.data[3] );
	COPYNULL( regtxid.pgid		, SCR.data[4] );
	COPYNULL( regtxid.pgfpath	, SCR.data[5] );
	COPYNULL( regtxid.pgsts		, SCR.data[6] );
	COPYNULL( regtxid.resists	, SCR.data[7] );
	COPYNULL( regtxid.runmethod	, SCR.data[8] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegUser_rtn( void )
#else
CmRegUser_rtn()
#endif
{
	struct	reg_userFORM	reguser;

	MOVESTR( SCR.data[0],	reguser.asid	);
	MOVESTR( SCR.data[1],	reguser.usid	);
	MOVESTR( SCR.data[2],	reguser.usnm	);
	MOVESTR( SCR.data[3],	reguser.ugrp	);
	MOVESTR( SCR.data[4],	reguser.ulev	);
	MOVESTR( SCR.data[5],	reguser.upwd	);

	if( CmRegUser( &reguser, SCR.action[0] ) < 0 )
		ERROREND( "CmRegUser() 실패" );

	COPYNULL( reguser.asid, SCR.data[0] );
	COPYNULL( reguser.usid, SCR.data[1] );
	COPYNULL( reguser.usnm, SCR.data[2] );
	COPYNULL( reguser.ugrp, SCR.data[3] );
	COPYNULL( reguser.ulev, SCR.data[4] );
	COPYNULL( reguser.upwd, SCR.data[5] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
CmRegUsid_rtn( void )
#else
CmRegUsid_rtn()
#endif
{
	struct	reg_usidFORM	regusid;

	MOVESTR( SCR.data[0],	regusid.usid	);
	MOVESTR( SCR.data[1],	regusid.usnm	);
	MOVESTR( SCR.data[2],	regusid.ugrp	);
	MOVESTR( SCR.data[3],	regusid.ulev	);
	MOVESTR( SCR.data[4],	regusid.upwd	);

	if( CmRegUsid( &regusid, SCR.action[0] ) < 0 )
		ERROREND( "CmRegUsid() 실패" );

	COPYNULL( regusid.usid, SCR.data[0] );
	COPYNULL( regusid.usnm, SCR.data[1] );
	COPYNULL( regusid.ugrp, SCR.data[2] );
	COPYNULL( regusid.ulev, SCR.data[3] );
	COPYNULL( regusid.upwd, SCR.data[4] );
}

/*----------------------------------------------------------------------*/
static	void
#ifdef	__CB_STDC__
copynull( char *src, int srclen, char *dest, int destlen )
#else
copynull( src, srclen, dest, destlen )
char	*src;
int	srclen;
char	*dest;
int	destlen;
#endif
{
	register	i;

	for( i=srclen-1; i>=0; i-- )
	{
		if( src[i] != ' ' && src[i] != '\0' )
			break;
	}
	if( i == -1 )
		i = srclen;
	else
		i++;

	if( i < destlen )
	{
		memcpy( dest, src, i );
		memset( &dest[i], 0, destlen - i );
	}
	else
	{
		memcpy( dest, src, destlen - 1 );
		dest[destlen-1] = 0;
	}
}

/*----------------------------------------------------------------------*/
static	void
#if defined( __STDC__ )
ERROREND( char *message )
#else
ERROREND(message)
char    *message;
#endif
{
	char	temp[32];

	SCR.version[0] = '0';
	SCR.fcode[0] = 'E';
	strcpy( SCR.ftnname, message );
	if( ( hyerrno > 0 ) && ( hyerrno != errno ) )
	{
		sprintf( temp, " [hyerrno=%d]", hyerrno );
		strcat( SCR.ftnname, temp );
	}
	if( errno )
	{
		sprintf( temp, " [errno=%d]", errno );
		strcat( SCR.ftnname, temp );
	}

	if( Zsend( (char *)&SCR, strlen( (char *)&SCR ) + 1 ) < 0 )
	{
		Zerrlog( "송신 오류" );
	}

	Zapiend();					/* 프로그램 정상종료 */
}
/*----------------------------------------------------------------------*/
/* end of cmreg.c */
/*----------------------------------------------------------------------*/
