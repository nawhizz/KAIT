/* CmRegTxid() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegTxid() : Handle txid isam					|
|									|
|	return	 0	OK						|
|		-1	error						|
|									|
| 2001.5.21  ksh. build 기능 추가					|
|									|
+----------------------------------------------------------------------*/
#define	_BUILD		/*2001.5.21*/

#include	<string.h>    /*memcpy,memset,strcat*/
#include	<errno.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"stpapi.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"txid.h"
#include	"txidv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildtxid	CBD2(( char * ));
static	int	ll_gettxidpath	CBD2(( char *, char *, char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_txidFORM *, char ));
static	int	ll_opentxid	CBD2(( REG_INTVAL *, char * ));
static	int	ll_deletetxid	CBD2(( REG_INTVAL * ));
static	int	ll_readtxid	CBD2(( REG_INTVAL * ));
static	int	ll_readnxtxid	CBD2(( REG_INTVAL * ));
static	int	ll_readprtxid	CBD2(( REG_INTVAL * ));
static	int	ll_writetxid	CBD2(( REG_INTVAL * ));
static	int	ll_writetxidv	CBD2(( REG_INTVAL *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegTxid( char *asid, struct reg_txidFORM *regtxid, char action )
#else
CmRegTxid( asid, regtxid, action )
char			*asid;
struct	reg_txidFORM	*regtxid;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

	tracelog("CmRegTxid(). start. asid is %.4s, action=%c\n",asid,action);

	if( !asid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegTxid()", "asid is null\n");
		tracelog("CmRegTxid(). error. asid is null\n");
		return( -1 );
	}

	if( ll_chkinput( regtxid, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regtxid, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildtxid( asid ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_opentxid( &regiv, asid ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deletetxid( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readtxid( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writetxid( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxtxid( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprtxid( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegTxid()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegTxid(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildtxid( char *asid )
#else
ll_buildtxid( asid )
char		*asid;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_gettxidpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "txid" );
	if( fd < 0 )
	{
		l_errlog("CmRegTxid()", "PI_BUILD(txid) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "txidv" );
	if( fd < 0 )
	{
		l_errlog("CmRegTxid()", "PI_BUILD(txidv) error\n");
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
ll_chkinput( struct reg_txidFORM *regtxid, char action )
#else
ll_chkinput( regtxid, action )
struct	reg_txidFORM	*regtxid;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regtxid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegTxid()", "regtxid is null\n");
		tracelog("CmRegTxid(). error. regtxid is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( regtxid->txid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegTxid()", "txid is space\n");
		tracelog("CmRegTxid(). error. txid is space\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_gettxidpath( char *asid, char *cfgpath, char *datapath )
#else
ll_gettxidpath( asid, cfgpath, datapath )
char	*asid;
char	*cfgpath;
char	*datapath;
#endif
{
	if( l_reggetascfg( asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegTxid()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "TXCNTL", datapath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", datapath ) < 0 )
		{
l_errlog("CmRegTxid()","Undefind TXID at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTTXCNTL );
			return( -1 );
		}
		strcat( datapath, "/cntl/txid" );
	}
	else
		strcat( datapath, "/txid" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_opentxid( REG_INTVAL *regiv, char *asid )
#else
ll_opentxid( regiv, asid )
REG_INTVAL	*regiv;
char		*asid;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_gettxidpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, cfgpath, datapath, "txid" );
	if( ret < 0 )
		l_errlog("CmRegTxid()", "l_regopen error\n");
	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deletetxid( REG_INTVAL *regiv )
#else
ll_deletetxid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	txidFORM	txid;
	struct	reg_txidFORM	*rtxid;

	rtxid = (struct	reg_txidFORM *)regiv->datarec;
	memcpy( txid.txid, rtxid->txid, sizeof(txid.txid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&txid ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&txid ) < 0 )
		{
l_errlog("CmRegTxid()","can't delete. txid=%.8s. iserrno=%d\n",txid.txid,iserrno);
			return( -1 );
		}
	}
	return( ll_writetxidv( regiv, rtxid->txid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readtxid( REG_INTVAL *regiv )
#else
ll_readtxid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	txidFORM	txid;
	struct	reg_txidFORM	*rtxid;

	rtxid = (struct	reg_txidFORM *)regiv->datarec;
	memcpy( txid.txid, rtxid->txid, sizeof(txid.txid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&txid ) < 0 )
	{
l_errlog("CmRegTxid()","Not found. txid=%.8s. iserrno=%d\n",txid.txid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&txid, (char *)rtxid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxtxid( REG_INTVAL *regiv )
#else
ll_readnxtxid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	txidFORM	txid;
	struct	reg_txidFORM	*rtxid;

	rtxid = (struct	reg_txidFORM *)regiv->datarec;
	memcpy( txid.txid, rtxid->txid, sizeof(txid.txid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&txid ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegTxid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&txid, (char *)rtxid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprtxid( REG_INTVAL *regiv )
#else
ll_readprtxid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	txidFORM	txid;
	struct	reg_txidFORM	*rtxid;

	rtxid = (struct	reg_txidFORM *)regiv->datarec;
	memcpy( txid.txid, rtxid->txid, sizeof(txid.txid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&txid ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegTxid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&txid, (char *)rtxid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writetxid( REG_INTVAL *regiv )
#else
ll_writetxid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	txidFORM	txid;
	struct	reg_txidFORM	*rtxid;
	int	ret;

	memset( (char *)&txid, ' ', sizeof(txid) );
	rtxid = (struct	reg_txidFORM *)regiv->datarec;
	memcpy( txid.txid, rtxid->txid, sizeof(txid.txid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&txid );
	memcpy( txid.txnm	,rtxid->txnm	 , sizeof(txid.txnm)	 );
	memcpy( txid.hostid	,rtxid->hostid	 , sizeof(txid.hostid)	 );
	memcpy( txid.pgid	,rtxid->pgid	 , sizeof(txid.pgid)	 );
	memcpy( txid.pgfpath	,rtxid->pgfpath	 , sizeof(txid.pgfpath)	 );
	memcpy( txid.pgsts	,rtxid->pgsts	 , sizeof(txid.pgsts)	 );
	memcpy( txid.resists	,rtxid->resists	 , sizeof(txid.resists)	 );
	memcpy( txid.runmethod	,rtxid->runmethod, sizeof(txid.runmethod));
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&txid ) < 0 )
		{
l_errlog("CmRegTxid()","can't addit. txid=%.8s. iserrno=%d\n",txid.txid,iserrno);
			return( -1 );
		}
		return( ll_writetxidv( regiv, rtxid->txid, OP_ADD ) );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&txid ) < 0 )
		{
l_errlog("CmRegTxid()","can't updat. txid=%.8s. iserrno=%d\n",txid.txid,iserrno);
			return( -1 );
		}
		return( ll_writetxidv( regiv, rtxid->txid, OP_CHANGE ) );
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writetxidv( REG_INTVAL *regiv, char *txid, char opcode )
#else
ll_writetxidv( regiv, txid, opcode )
REG_INTVAL	*regiv;
char		*txid;
char		opcode;
#endif
{
	struct	txidvFORM	txidv;
	int	ret;

	memset( (char *)&txidv, ' ', sizeof(txidv) );
	memcpy( txidv.txid, txid, sizeof(txidv.txid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&txidv );
	e_getsysdate( 31, txidv.verid, &txidv.verid[8] );
	txidv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&txidv );
		if( ret < 0 )
		{
l_errlog("CmRegTxid()","can't addit. txid=%.8s. iserrno=%d\n",txidv.txid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&txidv );
		if( ret < 0 )
		{
l_errlog("CmRegTxid()","can't updat. txid=%.8s. iserrno=%d\n",txidv.txid,iserrno);
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
	struct	txidFORM	*txid;
	struct	reg_txidFORM	*rtxid;

	txid  = (struct txidFORM *)src;
	rtxid = (struct reg_txidFORM *)dest;

	memcpy( rtxid->txid	, txid->txid	 , sizeof(txid->txid)	  );
	memcpy( rtxid->txnm	, txid->txnm	 , sizeof(txid->txnm)	  );
	memcpy( rtxid->hostid	, txid->hostid	 , sizeof(txid->hostid)	  );
	memcpy( rtxid->pgid	, txid->pgid	 , sizeof(txid->pgid)	  );
	memcpy( rtxid->pgfpath	, txid->pgfpath	 , sizeof(txid->pgfpath)  );
	memcpy( rtxid->pgsts	, txid->pgsts	 , sizeof(txid->pgsts)	  );
	memcpy( rtxid->resists	, txid->resists	 , sizeof(txid->resists)  );
	memcpy( rtxid->runmethod, txid->runmethod, sizeof(txid->runmethod));
}

/*----------------------------------------------------------------------*/
/* end of CmRegTxid.c */
