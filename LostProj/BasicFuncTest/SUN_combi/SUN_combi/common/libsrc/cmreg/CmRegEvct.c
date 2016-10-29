/* CmRegEvct() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegEvct() : Handle evct isam					|
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

#include	"evct.h"
#include	"evctv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildevct	CBD2(( char * ));
static	int	ll_getevctpath	CBD2(( char *, char *, char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_evctFORM *, char ));
static	int	ll_openevct	CBD2(( REG_INTVAL *, char * ));
static	int	ll_deleteevct	CBD2(( REG_INTVAL * ));
static	int	ll_readevct	CBD2(( REG_INTVAL * ));
static	int	ll_readnxevct	CBD2(( REG_INTVAL * ));
static	int	ll_readprevct	CBD2(( REG_INTVAL * ));
static	int	ll_writeevct	CBD2(( REG_INTVAL * ));
static	int	ll_writeevctv	CBD2(( REG_INTVAL *, char *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegEvct( char *asid, struct reg_evctFORM *regevct, char action )
#else
CmRegEvct( asid, regevct, action )
char			*asid;
struct	reg_evctFORM	*regevct;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

tracelog("CmRegEvct(). start. asid is %.4s, action is %c\n",asid,action);

	if( !asid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegEvct()", "asid is null\n");
		tracelog("CmRegEvct(). error. asid is null\n");
		return( -1 );
	}

	if( ll_chkinput( regevct, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regevct, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildevct( asid ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openevct( &regiv, asid ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deleteevct( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readevct( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writeevct( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxevct( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprevct( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegEvct()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegEvct(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildevct( char *asid )
#else
ll_buildevct( asid )
char		*asid;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_getevctpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "evct" );
	if( fd < 0 )
	{
		l_errlog("CmRegEvct()", "PI_BUILD(evct) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "evctv" );
	if( fd < 0 )
	{
		l_errlog("CmRegEvct()", "PI_BUILD(evctv) error\n");
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
ll_chkinput( struct reg_evctFORM *regevct, char action )
#else
ll_chkinput( regevct, action )
struct	reg_evctFORM	*regevct;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regevct )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegEvct()", "regevct is null\n");
		tracelog("CmRegEvct(). error. regevct is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( regevct->fmid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegEvct()", "fmid is space\n");
		tracelog("CmRegEvct(). error. fmid is space\n");
		return( -1 );
	}

	if( ISSPACE( regevct->evid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegEvct()", "evid is space\n");
		tracelog("CmRegEvct(). error. evid is space\n");
		return( -1 );
	}
	
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getevctpath( char *asid, char *cfgpath, char *datapath )
#else
ll_getevctpath( asid, cfgpath, datapath )
char	*asid;
char	*cfgpath;
char	*datapath;
#endif
{
	if( l_reggetascfg( asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegEvct()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "PSCNTL", datapath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", datapath ) < 0 )
		{
l_errlog("CmRegEvct()","Undefined PSCNTL at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTUSERINFO );
			return( -1 );
		}
		strcat( datapath, "/cntl/evct" );
	}
	else
		strcat( datapath, "/evct" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openevct( REG_INTVAL *regiv, char *asid )
#else
ll_openevct( regiv, asid )
REG_INTVAL	*regiv;
char		*asid;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_getevctpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, cfgpath, datapath, "evct" );
	if( ret < 0 )
		l_errlog("CmRegEvct()", "l_regopen error\n");
	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deleteevct( REG_INTVAL *regiv )
#else
ll_deleteevct( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	evctFORM	evct;
	struct	reg_evctFORM	*revct;

	revct = (struct	reg_evctFORM *)regiv->datarec;
	memcpy( evct.fmid, revct->fmid, sizeof(evct.fmid) );
	memcpy( evct.evid, revct->evid, sizeof(evct.evid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&evct ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&evct ) < 0 )
		{
l_errlog("CmRegEvct()","can't delete. fmid=%.8s, evid=%.8s. iserrno=%d\n",
evct.fmid,evct.evid,iserrno);
			return( -1 );
		}
	}
	return( ll_writeevctv( regiv, revct->fmid, revct->evid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readevct( REG_INTVAL *regiv )
#else
ll_readevct( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	evctFORM	evct;
	struct	reg_evctFORM	*revct;

	revct = (struct	reg_evctFORM *)regiv->datarec;
	memcpy( evct.fmid, revct->fmid, sizeof(evct.fmid) );
	memcpy( evct.evid, revct->evid, sizeof(evct.evid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&evct ) < 0 )
	{
l_errlog("CmRegEvct()","Not found. fmid=%.8s,evid=%.8s. iserrno=%d\n",
evct.fmid,evct.evid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&evct, (char *)revct );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxevct( REG_INTVAL *regiv )
#else
ll_readnxevct( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	evctFORM	evct;
	struct	reg_evctFORM	*revct;

	revct = (struct	reg_evctFORM *)regiv->datarec;
	memcpy( evct.fmid, revct->fmid, sizeof(evct.fmid) );
	memcpy( evct.evid, revct->evid, sizeof(evct.evid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&evct ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegEvct()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&evct, (char *)revct );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprevct( REG_INTVAL *regiv )
#else
ll_readprevct( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	evctFORM	evct;
	struct	reg_evctFORM	*revct;

	revct = (struct	reg_evctFORM *)regiv->datarec;
	memcpy( evct.fmid, revct->fmid, sizeof(evct.fmid) );
	memcpy( evct.evid, revct->evid, sizeof(evct.evid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&evct ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegEvct()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&evct, (char *)revct );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeevct( REG_INTVAL *regiv )
#else
ll_writeevct( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	evctFORM	evct;
	struct	reg_evctFORM	*revct;
	int	ret;

	memset( (char *)&evct, ' ', sizeof(evct) );
	revct = (struct	reg_evctFORM *)regiv->datarec;
	memcpy( evct.fmid, revct->fmid, sizeof(evct.fmid) );
	memcpy( evct.evid, revct->evid, sizeof(evct.evid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&evct );
	memcpy( evct.rkind  , revct->rkind  , sizeof(evct.rkind)   );
	memcpy( evct.fcode  , revct->fcode  , sizeof(evct.fcode)   );
	memcpy( evct.txid   , revct->txid   , sizeof(evct.txid)    );
	memcpy( evct.chg    , revct->chg    , sizeof(evct.chg)     );
	memcpy( evct.tofmid , revct->tofmid , sizeof(evct.tofmid)  );
	memcpy( evct.torkind, revct->torkind, sizeof(evct.torkind) );
	memcpy( evct.tofcode, revct->tofcode, sizeof(evct.tofcode) );
	memcpy( evct.totxid , revct->totxid , sizeof(evct.totxid)  );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&evct ) < 0 )
		{
l_errlog("CmRegEvct()","can't addit. fmid=%.8s,evid=%.8s. iserrno=%d\n",
evct.fmid,evct.evid,iserrno);
			return( -1 );
		}
		return(ll_writeevctv(regiv, revct->fmid, revct->evid, OP_ADD));
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&evct ) < 0 )
		{
l_errlog("CmRegEvct()","can't updat. fmid=%.8s,evid=%.8s. iserrno=%d\n",
evct.fmid,evct.evid,iserrno);
			return( -1 );
		}
		return(ll_writeevctv(regiv,revct->fmid,revct->evid,OP_CHANGE));
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeevctv( REG_INTVAL *regiv, char *fmid, char *evid, char opcode )
#else
ll_writeevctv( regiv, fmid, evid, opcode )
REG_INTVAL	*regiv;
char		*fmid;
char		*evid;
char		opcode;
#endif
{
	struct	evctvFORM	evctv;
	int	ret;

	memset( (char *)&evctv, ' ', sizeof(evctv) );
	memcpy( evctv.fmid, fmid, sizeof(evctv.fmid) );
	memcpy( evctv.evid, evid, sizeof(evctv.evid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&evctv );
	e_getsysdate( 31, evctv.verid, &evctv.verid[8] );
	evctv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&evctv );
		if( ret < 0 )
		{
l_errlog("CmRegEvct()","can't addit. fmid=%.8s,evid=%.8s. iserrno=%d\n",
evctv.fmid,evctv.evid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&evctv );
		if( ret < 0 )
		{
l_errlog("CmRegEvct()","can't updat. fmid=%.8s,evid=%.8s. iserrno=%d\n",
evctv.fmid,evctv.evid,iserrno);
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
char		*src;
char		*dest;
#endif
{
	struct	evctFORM	*evct;
	struct	reg_evctFORM	*revct;

	evct = (struct evctFORM *)src;
	revct = (struct reg_evctFORM *)dest;

	memcpy( revct->fmid   , evct->fmid   , sizeof(evct->fmid)    );
	memcpy( revct->evid   , evct->evid   , sizeof(evct->evid)    );
	memcpy( revct->rkind  , evct->rkind  , sizeof(evct->rkind)   );
	memcpy( revct->fcode  , evct->fcode  , sizeof(evct->fcode)   );
	memcpy( revct->txid   , evct->txid   , sizeof(evct->txid)    );
	memcpy( revct->chg    , evct->chg    , sizeof(evct->chg)     );
	memcpy( revct->tofmid , evct->tofmid , sizeof(evct->tofmid)  );
	memcpy( revct->torkind, evct->torkind, sizeof(evct->torkind) );
	memcpy( revct->tofcode, evct->tofcode, sizeof(evct->tofcode) );
	memcpy( revct->totxid , evct->totxid , sizeof(evct->totxid)  );
}
/*----------------------------------------------------------------------*/
/* end of CmRegEvct.c */
