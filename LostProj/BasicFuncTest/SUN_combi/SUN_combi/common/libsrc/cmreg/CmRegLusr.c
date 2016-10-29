/* CmRegLusr() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegLusr() : Handle lusr isam					|
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

#include	"lusr.h"
#include	"lusrv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildlusr	CBD2(( REG_INTVAL * ));
static	int	ll_getlusrpath	CBD2(( REG_INTVAL *, char *, char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_lusrFORM *, char ));
static	int	ll_openlusr	CBD2(( REG_INTVAL * ));
static	int	ll_deletelusr	CBD2(( REG_INTVAL * ));
static	int	ll_readlusr	CBD2(( REG_INTVAL * ));
static	int	ll_readnxlusr	CBD2(( REG_INTVAL * ));
static	int	ll_readprlusr	CBD2(( REG_INTVAL * ));
static	int	ll_writelusr	CBD2(( REG_INTVAL * ));
static	int	ll_writelusrv	CBD2(( REG_INTVAL *, char *, char ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegLusr( struct reg_lusrFORM *reglusr, char action )
#else
CmRegLusr( reglusr, action )
struct	reg_lusrFORM	*reglusr;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

	tracelog("CmRegLusr(). start. action is %c\n", action);

	if( ll_chkinput( reglusr, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)reglusr, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildlusr( &regiv ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openlusr( &regiv ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deletelusr( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readlusr( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writelusr( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxlusr( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprlusr( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegLusr()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegLusr(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildlusr( REG_INTVAL *regiv )
#else
ll_buildlusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_getlusrpath( regiv, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "lusr" );
	if( fd < 0 )
	{
		l_errlog("CmRegLusr()", "PI_BUILD(lusr) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "lusrv" );
	if( fd < 0 )
	{
		l_errlog("CmRegLusr()", "PI_BUILD(lusrv) error\n");
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
ll_chkinput( struct reg_lusrFORM *reglusr, char action )
#else
ll_chkinput( reglusr, action )
struct	reg_lusrFORM	*reglusr;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !reglusr )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegLusr()", "reglusr is null\n");
		tracelog("CmRegLusr(). error. reglusr is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( reglusr->asid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegLusr()", "asid is space\n");
		tracelog("CmRegLusr(). error. asid is null\n");
		return( -1 );
	}

	if( ISSPACE( reglusr->usid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegLusr()", "usid is space\n");
		tracelog("CmRegLusr(). error. usid is null\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getlusrpath( REG_INTVAL *regiv, char *cfgpath, char *datapath )
#else
ll_getlusrpath( regiv, cfgpath, datapath )
REG_INTVAL	*regiv;
char	*cfgpath;
char	*datapath;
#endif
{
	struct	reg_lusrFORM	*rlusr;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;

	if( l_reggetascfg( rlusr->asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegLusr()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "USERCNTL", datapath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", datapath ) < 0 )
		{
l_errlog("CmRegLusr()","Undefind USERCNTL at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTUSERCNTL );
			return( -1 );
		}
		strcat( datapath, "/cntl/lusr" );
	}
	else
		strcat( datapath, "/lusr" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openlusr( REG_INTVAL *regiv )
#else
ll_openlusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_getlusrpath( regiv, cfgpath, datapath ) < 0 )
		return( -1 );

	ret =l_regopen( regiv, cfgpath, datapath, "lusr" );
	if( ret < 0 )
		l_errlog("CmRegLusr()", "l_regopen error\n");

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deletelusr( REG_INTVAL *regiv )
#else
ll_deletelusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	lusrFORM	lusr;
	struct	reg_lusrFORM	*rlusr;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( lusr.usid, rlusr->usid, sizeof(lusr.usid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&lusr ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&lusr ) < 0 )
		{
l_errlog("CmRegLusr()","can't delete. usid=%.8s. iserrno=%d\n",lusr.usid,iserrno);
			return( -1 );
		}
	}
	return( ll_writelusrv( regiv, rlusr->usid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readlusr( REG_INTVAL *regiv )
#else
ll_readlusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	lusrFORM	lusr;
	struct	reg_lusrFORM	*rlusr;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( lusr.usid, rlusr->usid, sizeof(lusr.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&lusr ) < 0 )
	{
l_errlog("CmRegLusr()","Not found. usid=%.8s. iserrno=%d\n",lusr.usid,iserrno);
		return( -1 );
	}
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxlusr( REG_INTVAL *regiv )
#else
ll_readnxlusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	lusrFORM	lusr;
	struct	reg_lusrFORM	*rlusr;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( lusr.usid, rlusr->usid, sizeof(lusr.usid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&lusr ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegLusr()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	memcpy( rlusr->usid, lusr.usid, sizeof(lusr.usid) );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprlusr( REG_INTVAL *regiv )
#else
ll_readprlusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	lusrFORM	lusr;
	struct	reg_lusrFORM	*rlusr;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( lusr.usid, rlusr->usid, sizeof(lusr.usid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&lusr ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegLusr()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	memcpy( rlusr->usid, lusr.usid, sizeof(lusr.usid) );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writelusr( REG_INTVAL *regiv )
#else
ll_writelusr( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	lusrFORM	lusr;
	struct	reg_lusrFORM	*rlusr;
	struct	reg_usidFORM	rusid;

	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( rusid.usid, rlusr->usid, sizeof(rusid.usid) );
	if( CmRegUsid( &rusid, REG_READ ) < 0 )
	{
l_errlog("CmRegLusr()","CmRegUsid() read error\n");
		l_sethyerrno( ECMR_NOADDUSID );
		return( -1 );
	}
	memset( (char *)&lusr, ' ', sizeof(lusr) );
	rlusr = (struct	reg_lusrFORM *)regiv->datarec;
	memcpy( lusr.usid, rlusr->usid, sizeof(lusr.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&lusr ) >= 0 )
		return( 0 );
	if( PI_ADDIT( regiv->isfd, (char *)&lusr ) < 0 )
	{
l_errlog("CmRegLusr()","can't addit. lusr=%.8s. iserrno=%d\n",lusr.usid,iserrno);
		return( -1 );
	}
	return( ll_writelusrv( regiv, rlusr->usid, OP_ADD ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writelusrv( REG_INTVAL *regiv, char *usid, char opcode )
#else
ll_writelusrv( regiv, usid, opcode )
REG_INTVAL	*regiv;
char		*usid;
char		opcode;
#endif
{
	struct	lusrvFORM	lusrv;
	int	ret;

	memset( (char *)&lusrv, ' ', sizeof(lusrv) );
	memcpy( lusrv.usid, usid, sizeof(lusrv.usid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&lusrv );
	e_getsysdate( 31, lusrv.verid, &lusrv.verid[8] );
	lusrv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&lusrv );
		if( ret < 0 )
		{
l_errlog("CmRegLusr()","can't addit. lusr=%.8s. iserrno=%d\n",lusrv.usid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&lusrv );
		if( ret < 0 )
		{
l_errlog("CmRegLusr()","can't updat. lusr=%.8s. iserrno=%d\n",lusrv.usid,iserrno);
		}
	}
	return( ret );
}

/*----------------------------------------------------------------------*/
/* end of CmRegLusr.c */
