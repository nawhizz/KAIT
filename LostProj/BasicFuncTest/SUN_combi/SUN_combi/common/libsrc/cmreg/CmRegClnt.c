/* CmRegClnt() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegClnt() : Handle clnt isam					|
|									|
|	return	 0	OK						|
|		-1	error						|
|									|
| 2000.7.7   김성환. client 제어 추가					|
| 2001.5.21  ksh. build 기능 추가					|
|									|
+----------------------------------------------------------------------*/
#define	_BUILD		/*2001.5.21*/


#include	<string.h>	/*memcpy,memset,strcat*/
#include	<stdlib.h>	/*atoi*/
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"clnt.h"
#include	"clntv.h"

/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildclnt	CBD2(( void ));
static	int	ll_getclntpath	CBD2(( char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_clntFORM *, char ));
static	int	ll_openclnt	CBD2(( REG_INTVAL * ));
static	int	ll_deleteclnt	CBD2(( REG_INTVAL * ));
static	int	ll_readclnt	CBD2(( REG_INTVAL * ));
static	int	ll_readnxclnt	CBD2(( REG_INTVAL * ));
static	int	ll_readprclnt	CBD2(( REG_INTVAL * ));
static	int	ll_writeclnt	CBD2(( REG_INTVAL * ));
static	int	ll_writeclntv	CBD2(( REG_INTVAL *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegClnt( struct reg_clntFORM *regclnt, char action )
#else
CmRegClnt( regclnt, action )
struct	reg_clntFORM	*regclnt;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

	tracelog("CmRegClnt(). start. action is %c\n", action);

	if( ll_chkinput( regclnt, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regclnt, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildclnt() );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openclnt( &regiv ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deleteclnt( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readclnt( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writeclnt( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxclnt( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprclnt( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegClnt()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegClnt(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildclnt( void )
#else
ll_buildclnt()
#endif
{
	int	fd;
	char	datapath[128];

	if( ll_getclntpath( datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "clnt" );
	if( fd < 0 )
	{
		l_errlog("CmRegClnt()", "PI_BUILD(clnt) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "clntv" );
	if( fd < 0 )
	{
		l_errlog("CmRegClnt()", "PI_BUILD(clntv) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	return( 0 );
}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_chkinput( struct reg_clntFORM *regclnt, char action )
#else
ll_chkinput( regclnt, action )
struct	reg_clntFORM	*regclnt;
char			action;
#endif
{
	char	tmaxssno[5];

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regclnt )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegClnt()", "regclnt is null\n");
		tracelog("CmRegClnt(). error. regclnt is null\n");
		return( -1 );
	}

	if( ( action == REG_READNX ) || ( action == REG_READPR ) )
		return( 0 );
		
	if( ISSPACE( regclnt->cliid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegClnt()", "clnt is space\n");
		tracelog("CmRegClnt(). error. clnt is space\n");
		return( -1 );
	}

	if( ( action == REG_READ ) || ( action == REG_DELETE ) )
		return( 0 );

	if( !memcmp( regclnt->cliid, "_dyncli_", 8 ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegClnt()", "clnt(%-.8s) is not used client id\n");
		tracelog("CmRegClnt(). err. clnt(%-.8s) is not used client\n");
		return( -1 );
	}

	switch( regclnt->clikind[0] )
	{
	case	CLNT_TERMINAL	:
	case	CLNT_APPLSVR	:
	case	CLNT_BRANCHSVR	:
	case	CLNT_DYNAMIC	:
		break;

	default			:
		regclnt->clikind[0] = CLNT_TERMINAL;
	}

	switch( regclnt->clios[0] )
	{
	case	CLNT_DOS	:
	case	CLNT_WIN31	:
	case	CLNT_WIN95	:
	case	CLNT_UNIX	:
		break;

	default			:
		regclnt->clios[0] = CLNT_WIN95;
	}

	if( ( regclnt->persist[0] != CLNT_RESIDENT ) &&
	    ( regclnt->persist[0] != CLNT_TRANSIENT ) )
	{
		regclnt->persist[0] = CLNT_TRANSIENT;
	}

	if( ( regclnt->loginmode[0] != CLNT_USER ) &&
	    ( regclnt->loginmode[0] != CLNT_TEST ) )
	{
		regclnt->loginmode[0] = CLNT_USER;
	}

	d_leftalign( regclnt->maxssno, sizeof(regclnt->maxssno), tmaxssno, 0 );
	tmaxssno[4] = 0;
	if( atoi( tmaxssno ) <= 0 )
		memcpy( regclnt->maxssno, "0001", 4 );

	if( ( regclnt->tracelog[0] < '0' ) || ( regclnt->tracelog[0] > '9' ) )
		regclnt->tracelog[0] = '0';

	switch( regclnt->cmdlog[0] )
	{
	case	' ' :
	case	'0' :
	case	'1' :
		break;
	default :
		regclnt->cmdlog[0] = ' ';
		break;
	}

	switch( regclnt->pktlog[0] )
	{
	case	' ' :
	case	'0' :
	case	'1' :
		break;
	default :
		regclnt->pktlog[0] = ' ';
		break;
	}

	switch( regclnt->blklog[0] )
	{
	case	' ' :
	case	'0' :
	case	'1' :
		break;
	default :
		regclnt->blklog[0] = ' ';
		break;
	}

	switch( regclnt->rawlog[0] )
	{
	case	' ' :
	case	'0' :
	case	'1' :
		break;
	default :
		regclnt->rawlog[0] = ' ';
		break;
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getclntpath( char *datapath )
#else
ll_getclntpath( datapath )
char	*datapath;
#endif
{
	if( e_getenv( "TPCNTL", datapath ) < 0 )
	{
		if( e_getenv( "IEAPHOME", datapath ) < 0 )
		{
			l_errlog("CmRegClnt()", "Undefined TPCNTL\n");
			l_sethyerrno( ECMR_NOTTPCNTL );
			return( -1 );
		}
		strcat( datapath, "/syscntl/clnt" );
	}
	else
		strcat( datapath, "/clnt" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openclnt( REG_INTVAL *regiv )
#else
ll_openclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	char	datapath[128];
	int	ret;

	if( ll_getclntpath( datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, (char *)0, datapath, "clnt" );
	if( ret < 0 )
		l_errlog("CmRegClnt()", "l_regopen error\n");

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deleteclnt( REG_INTVAL *regiv )
#else
ll_deleteclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	clntFORM	clnt;
	struct	reg_clntFORM	*rclnt;

	rclnt = (struct	reg_clntFORM *)regiv->datarec;
	memcpy( clnt.cliid, rclnt->cliid, sizeof(clnt.cliid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&clnt ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&clnt ) < 0 )
		{
l_errlog("CmRegClnt()","can't delete. cliid=%.8s, iserrno=%d\n",clnt.cliid,iserrno);
			return( -1 );
		}
	}
	return( ll_writeclntv( regiv, rclnt->cliid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readclnt( REG_INTVAL *regiv )
#else
ll_readclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	clntFORM	clnt;
	struct	reg_clntFORM	*rclnt;

	rclnt = (struct	reg_clntFORM *)regiv->datarec;
	memcpy( clnt.cliid, rclnt->cliid, sizeof(clnt.cliid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&clnt ) < 0 )
	{
l_errlog("CmRegClnt()","Not found. cliid=%.8s, iserrno=%d\n",clnt.cliid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&clnt, (char *)rclnt );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxclnt( REG_INTVAL *regiv )
#else
ll_readnxclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	clntFORM	clnt;
	struct	reg_clntFORM	*rclnt;

	rclnt = (struct	reg_clntFORM *)regiv->datarec;
	memcpy( clnt.cliid, rclnt->cliid, sizeof(clnt.cliid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&clnt ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
		l_errlog("CmRegClnt()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&clnt, (char *)rclnt );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprclnt( REG_INTVAL *regiv )
#else
ll_readprclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	clntFORM	clnt;
	struct	reg_clntFORM	*rclnt;

	rclnt = (struct	reg_clntFORM *)regiv->datarec;
	memcpy( clnt.cliid, rclnt->cliid, sizeof(clnt.cliid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&clnt ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
		l_errlog("CmRegClnt()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&clnt, (char *)rclnt );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeclnt( REG_INTVAL *regiv )
#else
ll_writeclnt( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	clntFORM	clnt;
	struct	reg_clntFORM	*rclnt;
	int	ret;

	memset( (char *)&clnt, ' ', sizeof(clnt) );
	rclnt = (struct	reg_clntFORM *)regiv->datarec;
	memcpy( clnt.cliid, rclnt->cliid, sizeof(clnt.cliid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&clnt );
	memcpy( clnt.clinm    , rclnt->clinm	, sizeof(clnt.clinm)	);
	memcpy( clnt.clikind  , rclnt->clikind	, sizeof(clnt.clikind)	);
	memcpy( clnt.clios    , rclnt->clios	, sizeof(clnt.clios)	);
	memcpy( clnt.persist  , rclnt->persist	, sizeof(clnt.persist)	);
	memcpy( clnt.loginmode, rclnt->loginmode, sizeof(clnt.loginmode));
	memcpy( clnt.maxssno  , rclnt->maxssno	, sizeof(clnt.maxssno)	);
	memcpy( clnt.ipaddr   , rclnt->ipaddr	, sizeof(clnt.ipaddr)	);
	memcpy( clnt.redir    , rclnt->redir	, sizeof(clnt.redir)	);
	memcpy( clnt.tracelog , rclnt->tracelog	, sizeof(clnt.tracelog)	);
	memcpy( clnt.cmdlog   , rclnt->cmdlog	, sizeof(clnt.cmdlog)	);
	memcpy( clnt.pktlog   , rclnt->pktlog	, sizeof(clnt.pktlog)	);
	memcpy( clnt.blklog   , rclnt->blklog	, sizeof(clnt.blklog)	);
	memcpy( clnt.rawlog   , rclnt->rawlog	, sizeof(clnt.rawlog)	);
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&clnt ) < 0 )
		{
l_errlog("CmRegClnt()","can't addit. cliid=%.8s, iserrno=%d\n",clnt.cliid,iserrno);
			return( -1 );
		}
		return( ll_writeclntv( regiv, rclnt->cliid, OP_ADD ) );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&clnt ) < 0 )
		{
l_errlog("CmRegClnt()","can't updat. cliid=%.8s, iserrno=%d\n",clnt.cliid,iserrno);
			return( -1 );
		}
		return( ll_writeclntv( regiv, rclnt->cliid, OP_CHANGE ) );
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeclntv( REG_INTVAL *regiv, char *cliid, char opcode )
#else
ll_writeclntv( regiv, cliid, opcode )
REG_INTVAL	*regiv;
char		*cliid;
char		opcode;
#endif
{
	struct	clntvFORM	clntv;
	int	ret;

	memset( (char *)&clntv, ' ', sizeof(clntv) );
	memcpy( clntv.cliid, cliid, sizeof(clntv.cliid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&clntv );
	e_getsysdate( 31, clntv.verid, &clntv.verid[8] );
	clntv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&clntv );
		if( ret < 0 )
		{
l_errlog("CmRegClnt()","can't addit. cliid=%.8s, iserrno=%d\n",clntv.cliid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&clntv );
		if( ret < 0 )
		{
l_errlog("CmRegClnt()","can't updat. cliid=%.8s, iserrno=%d\n",clntv.cliid,iserrno);
		}
	}
	return( ret );
}

/*----------------------------------------------------------------------*/
static	void
#if	defined(__CB_STDC__)
ll_movedata( char *src, char *dest )
#else
ll_movedata( src, dest )
char	*src;
char	*dest;
#endif
{
	struct	clntFORM	*clnt;
	struct	reg_clntFORM	*rclnt;

	clnt  = (struct clntFORM *)src;
	rclnt = (struct reg_clntFORM *)dest;

	memcpy( rclnt->cliid	, clnt->cliid	, sizeof(clnt->cliid)	);
	memcpy( rclnt->clinm    , clnt->clinm	, sizeof(clnt->clinm)	);
	memcpy( rclnt->clikind  , clnt->clikind	, sizeof(clnt->clikind)	);
	memcpy( rclnt->clios    , clnt->clios	, sizeof(clnt->clios)	);
	memcpy( rclnt->persist  , clnt->persist	, sizeof(clnt->persist)	);
	memcpy( rclnt->loginmode, clnt->loginmode, sizeof(clnt->loginmode));
	memcpy( rclnt->maxssno  , clnt->maxssno	, sizeof(clnt->maxssno)	);
	memcpy( rclnt->ipaddr   , clnt->ipaddr	, sizeof(clnt->ipaddr)	);
	memcpy( rclnt->redir    , clnt->redir	, sizeof(clnt->redir)	);
	memcpy( rclnt->tracelog , clnt->tracelog, sizeof(clnt->tracelog));
	memcpy( rclnt->cmdlog   , clnt->cmdlog	, sizeof(clnt->cmdlog)	);
	memcpy( rclnt->pktlog   , clnt->pktlog	, sizeof(clnt->pktlog)	);
	memcpy( rclnt->blklog   , clnt->blklog	, sizeof(clnt->blklog)	);
	memcpy( rclnt->rawlog   , clnt->rawlog	, sizeof(clnt->rawlog)	);
}
/*----------------------------------------------------------------------*/
/* end of CmRegClnt.c */
