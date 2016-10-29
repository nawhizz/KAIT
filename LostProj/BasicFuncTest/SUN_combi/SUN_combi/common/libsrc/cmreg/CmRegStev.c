/* CmRegStev() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegStev() : Handle stev isam					|
|									|
|	return	 0	OK						|
|		-1	error						|
|									|
+----------------------------------------------------------------------*/
#include	<string.h>    /*memcpy,memset,strcat*/
#include	<errno.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"stpapi.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"stev.h"
#include	"stevv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
static	int	ll_buildstev	CBD2(( char * ));
static	int	ll_getstevpath	CBD2(( char *, char *, char * ));
static	int	ll_chkinput	CBD2(( struct reg_stevFORM *, char ));
static	int	ll_openstev	CBD2(( REG_INTVAL *, char * ));
static	int	ll_deletestev	CBD2(( REG_INTVAL * ));
static	int	ll_readstev	CBD2(( REG_INTVAL * ));
static	int	ll_readnxstev	CBD2(( REG_INTVAL * ));
static	int	ll_readprstev	CBD2(( REG_INTVAL * ));
static	int	ll_writestev	CBD2(( REG_INTVAL * ));
static	int	ll_writestevv	CBD2(( REG_INTVAL *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegStev( char *asid, struct reg_stevFORM *regstev, char action )
#else
CmRegStev( asid, regstev, action )
char			*asid;
struct	reg_stevFORM	*regstev;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

tracelog( "CmRegStev(). start. asid is %.4s, action is %c\n", asid, action );

	if( !asid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog( "CmRegStev()", "asid is NULL pointer\n" );
		tracelog( "CmRegStev(). error. asid is NULL pointer\n" );
		return( -1 );
	}

	if( ll_chkinput( regstev, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regstev, action );

	if( action == REG_BUILD )
	{
		return( ll_buildstev( asid ) );
	}

	if( ll_openstev( &regiv, asid ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deletestev( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readstev( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writestev( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxstev( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprstev( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegStev()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegStev(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildstev( char *asid )
#else
ll_buildstev( asid )
char		*asid;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_getstevpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "stev" );
	if( fd < 0 )
	{
		l_errlog("CmRegStev()", "PI_BUILD(stev) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "stevv" );
	if( fd < 0 )
	{
		l_errlog("CmRegStev()", "PI_BUILD(stevv) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_chkinput( struct reg_stevFORM *regstev, char action )
#else
ll_chkinput( regstev, action )
struct	reg_stevFORM	*regstev;
char			action;
#endif
{
	if( action == REG_BUILD )
		return( 0 );

	if( !regstev )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegStev()", "regstev is null\n");
		tracelog("CmRegStev(). error. regstev is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );

	if( ISSPACE( regstev->evid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegStev()", "evid is space\n");
		tracelog("CmRegStev(). error. evid is space\n");
		return( -1 );
	}

	if( action != REG_WRITE )
		return( 0 );

	if( ISSPACE( regstev->fcode ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegStev()", "fcode is space\n");
		tracelog("CmRegStev(). error. fcode is space\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getstevpath( char *asid, char *cfgpath, char *datapath )
#else
ll_getstevpath( asid, cfgpath, datapath )
char	*asid;
char	*cfgpath;
char	*datapath;
#endif
{
	if( l_reggetascfg( asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegStev()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "PSCNTL", datapath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", datapath ) < 0 )
		{
l_errlog("CmRegStev()","Undefined PSCNTL at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTUSERINFO );
			return( -1 );
		}
		strcat( datapath, "/cntl/stev" );
	}
	else
		strcat( datapath, "/stev" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openstev( REG_INTVAL *regiv, char *asid )
#else
ll_openstev( regiv, asid )
REG_INTVAL	*regiv;
char		*asid;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_getstevpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, cfgpath, datapath, "stev" );
	if( ret < 0 )
		l_errlog("CmRegStev()", "l_regopen error\n");
	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deletestev( REG_INTVAL *regiv )
#else
ll_deletestev( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	stevFORM	stev;
	struct	reg_stevFORM	*rstev;

	rstev = (struct	reg_stevFORM *)regiv->datarec;
	memcpy( stev.evid, rstev->evid, sizeof(stev.evid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&stev ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&stev ) < 0 )
		{
l_errlog( "CmRegStev()",
	  "can't delete. evid=%.8s. iserrno=%d\n", stev.evid, iserrno );
			return( -1 );
		}
	}
	return( ll_writestevv( regiv, rstev->evid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readstev( REG_INTVAL *regiv )
#else
ll_readstev( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	stevFORM	stev;
	struct	reg_stevFORM	*rstev;

	rstev = (struct	reg_stevFORM *)regiv->datarec;
	memcpy( stev.evid, rstev->evid, sizeof(stev.evid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&stev ) < 0 )
	{
l_errlog("CmRegStev()","Not found. evid=%.8s. iserrno=%d\n",stev.evid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&stev, (char *)rstev );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxstev( REG_INTVAL *regiv )
#else
ll_readnxstev( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	stevFORM	stev;
	struct	reg_stevFORM	*rstev;

	rstev = (struct	reg_stevFORM *)regiv->datarec;
	memcpy( stev.evid, rstev->evid, sizeof(stev.evid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&stev ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegStev()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&stev, (char *)rstev );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprstev( REG_INTVAL *regiv )
#else
ll_readprstev( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	stevFORM	stev;
	struct	reg_stevFORM	*rstev;

	rstev = (struct	reg_stevFORM *)regiv->datarec;
	memcpy( stev.evid, rstev->evid, sizeof(stev.evid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&stev ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegStev()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&stev, (char *)rstev );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writestev( REG_INTVAL *regiv )
#else
ll_writestev( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	stevFORM	stev;
	struct	reg_stevFORM	*rstev;
	int	ret;

	memset( (char *)&stev, ' ', sizeof(stev) );
	rstev = (struct	reg_stevFORM *)regiv->datarec;
	memcpy( stev.evid, rstev->evid, sizeof(stev.evid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&stev );
	memcpy( stev.fcode  , rstev->fcode  , sizeof(stev.fcode)   );
	memcpy( stev.evnm   , rstev->evnm   , sizeof(stev.evnm)    );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&stev ) < 0 )
		{
l_errlog("CmRegStev()","can't add. evid=%.8s. iserrno=%d\n",stev.evid,iserrno);
			return( -1 );
		}
		return( ll_writestevv( regiv, rstev->evid, OP_ADD ) );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&stev ) < 0 )
		{
l_errlog("CmRegStev()","can't updat. evid=%.8s iserrno=%d\n",stev.evid,iserrno);
			return( -1 );
		}
		return( ll_writestevv( regiv, rstev->evid, OP_CHANGE ) );
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writestevv( REG_INTVAL *regiv, char *evid, char opcode )
#else
ll_writestevv( regiv, evid, opcode )
REG_INTVAL	*regiv;
char		*evid;
char		opcode;
#endif
{
	struct	stevvFORM	stevv;
	int	ret;

	memset( (char *)&stevv, ' ', sizeof(stevv) );
	memcpy( stevv.evid, evid, sizeof(stevv.evid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&stevv );
	e_getsysdate( 31, stevv.verid, &stevv.verid[8] );
	stevv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&stevv );
		if( ret < 0 )
		{
l_errlog("CmRegStev()","can't add. evid=%.8s. iserrno=%d\n",stevv.evid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&stevv );
		if( ret < 0 )
		{
l_errlog("CmRegStev()","can't updat. evid=%.8s iserrno=%d\n",stevv.evid,iserrno);
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
	struct	stevFORM	*stev;
	struct	reg_stevFORM	*rstev;

	stev = (struct stevFORM *)src;
	rstev = (struct reg_stevFORM *)dest;

	memcpy( rstev->evid   , stev->evid   , sizeof(stev->evid)    );
	memcpy( rstev->fcode  , stev->fcode  , sizeof(stev->fcode)   );
	memcpy( rstev->evnm   , stev->evnm   , sizeof(stev->evnm)    );
}
/*----------------------------------------------------------------------*/
/* end of CmRegStev.c */
