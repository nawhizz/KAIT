/* CmRegUser() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegUser() : Handle usid/lusr isam				|
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

#include	"usid.h"
#include	"usidv.h"
#include	"lusr.h"
#include	"lusrv.h"

#include	"stpapi.h"

/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_builduser	CBD2(( REG_INTVAL * ));
static	int	ll_getuserpath	CBD2(( REG_INTVAL *, char *, char *, char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_userFORM *, char ));
static	int	ll_openuser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_deleteuser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_readuser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_readnxuser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_readpruser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_writeuser	CBD2(( REG_INTVAL *, REG_INTVAL * ));
static	int	ll_writeuserv	CBD2(( REG_INTVAL *,REG_INTVAL *,char *,char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegUser( struct reg_userFORM *reguser, char action )
#else
CmRegUser( reguser, action )
struct	reg_userFORM	*reguser;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;
	REG_INTVAL	lusrfm;

	tracelog("CmRegUser(). start. usid=%.8s, asid=%.4s, action=%c\n",
			reguser->usid, reguser->asid, action);

	if( ll_chkinput( reguser, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)reguser, action );
	l_reginit( &lusrfm, (char *)reguser, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_builduser( &regiv ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openuser( &regiv, &lusrfm ) < 0 )
	{
		l_regclose( &regiv );
		l_regclose( &lusrfm );
		tracelog("CmRegUser(). error. openuser\n");
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deleteuser( &regiv, &lusrfm );
		break;

	case	REG_READ   :
		ret = ll_readuser( &regiv, &lusrfm );
		break;

	case	REG_WRITE  :
		ret = ll_writeuser( &regiv, &lusrfm );
		break;

	case	REG_READNX :
		ret = ll_readnxuser( &regiv, &lusrfm );
		break;

	case	REG_READPR :
		ret = ll_readpruser( &regiv, &lusrfm );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegUser()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );
	l_regclose( &lusrfm );

	tracelog("CmRegUser(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_builduser( REG_INTVAL *regiv )
#else
ll_builduser( regiv )
REG_INTVAL	*regiv;
#endif
{
	char	cfgpath[128], usidpath[128], lusrpath[128];
	int	fd;

	tracelog( "ll_builduser(). start\n" );

	if( ll_getuserpath( regiv, cfgpath, usidpath, lusrpath ) < 0 )
		return( -1 );

	fd = PI_BUILD( usidpath, "usid" );
	if( fd < 0 )
	{
		l_errlog( "CmRegUser()", "PI_BUILD (usid) error\n" );
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( usidpath, "v" );
	fd = PI_BUILD( usidpath, "usidv" );
	if( fd < 0 )
	{
		l_errlog( "CmRegUser()", "PI_BUILD (usidv) error\n" );
		return( -1 );
	}

	PI_CLOSE( fd );

	fd = PI_BUILD( lusrpath, "lusr" );
	if( fd < 0 )
	{
		l_errlog( "CmRegUser()", "PI_BUILD (lusr) error\n" );
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( lusrpath, "v" );
	fd = PI_BUILD( lusrpath, "lusrv" );
	if( fd < 0 )
	{
		l_errlog( "CmRegUser()", "PI_BUILD (lusrv) error\n" );
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
ll_chkinput( struct reg_userFORM *reguser, char action )
#else
ll_chkinput( reguser, action )
struct	reg_userFORM	*reguser;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !reguser )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegUser()", "reguser is null\n");
		tracelog("CmRegUser(). error. reguser is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( reguser->asid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegUser()", "asid is space\n");
		tracelog("CmRegUser(). error. asid is space\n");
		return( -1 );
	}

	if( ISSPACE( reguser->usid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegUser()", "usid is space\n");
		tracelog("CmRegUser(). error. usid is space\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getuserpath( REG_INTVAL *regiv,char *cfgpath,char *usidpath,char *lusrpath )
#else
ll_getuserpath( regiv, cfgpath, usidpath, lusrpath )
REG_INTVAL	*regiv;
char		*cfgpath;
char		*usidpath;
char		*lusrpath;
#endif
{
	struct	reg_userFORM	*ruser;

	if( e_getenv( "USERINFO", usidpath ) < 0 )
	{
		if( e_getenv( "IEAPHOME", usidpath ) < 0 )
		{
			l_errlog( "CmRegUser()",
				  "Undefind USERINFO. errno=%d\n", errno );
			l_sethyerrno( ECMR_NOTUSERINFO );
			tracelog( "ll_getuserpath(). error. IEAPHOME\n" );
			return( -1 );
		}
		strcat( usidpath, "/syscntl/usid" );
	}
	else
		strcat( usidpath, "/usid" );

	ruser = (struct reg_userFORM *)regiv->datarec;

	if( l_reggetascfg( ruser->asid, cfgpath ) < 0 )
	{
		l_errlog( "CmRegUser()", "l_reggetascfg error\n" );
		tracelog( "ll_getuserpath(). error. reggetascfg\n" );
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "USERCNTL", lusrpath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", lusrpath ) < 0 )
		{
			l_errlog( "CmRegUser()",
				  "Undefined USERCNTL at %s. errno=%d\n",
				  cfgpath, hyerrno );
			l_sethyerrno( ECMR_NOTUSERCNTL );
			tracelog("ll_getuserpath(). error. USERCNTL\n");
			return( -1 );
		}
		strcat( lusrpath, "/cntl/lusr" );
	}
	else
		strcat( lusrpath, "/lusr" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openuser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_openuser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	char	cfgpath[128], usidpath[128], lusrpath[128];
	int	ret;

	tracelog("ll_openuser(). start\n");

	if( ll_getuserpath( regiv, cfgpath, usidpath, lusrpath ) < 0 )
		return( -1 );

	if( l_regopen( regiv, (char *)0, usidpath, "usid" ) < 0 )
	{
		l_errlog("CmRegUser()","l_regopen error\n");
		tracelog("ll_openuser(). error. regopen\n");
		return( -1 );
	}

	tracelog("ll_openuser(). end.\n");

	ret = l_regopen( lusrfm, cfgpath, lusrpath, "lusr" );
	if( ret < 0 )
		l_errlog("CmRegUser()","l_regopen error\n");

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deleteuser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_deleteuser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	struct	usidFORM	usid;
	struct	lusrFORM	lusr;
	struct	reg_userFORM	*ruser;

	tracelog("ll_deleteuser(). start.\n");
	ruser = (struct	reg_userFORM *)regiv->datarec;
	memcpy( lusr.usid, ruser->usid, sizeof(lusr.usid) );
	if( PI_RDUEQ( lusrfm->isfd, "KA", (char *)&lusr ) >= 0 )
	{
		if( PI_DELET( lusrfm->isfd, (char *)&lusr ) < 0 )
		{
l_errlog("CmRegUser()","lusr can't delete. usid=%.8s. iserrno=%d\n",
lusr.usid,iserrno);
			tracelog("ll_deleteuser(). error. PI_DELET(lusr).\n");
			return( -1 );
		}
	}

	memcpy( usid.usid, ruser->usid, sizeof(usid.usid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&usid ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUser()","user can't delete. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
			tracelog("ll_deleteuser(). error. PI_DELET(usid).\n");
			return( -1 );
		}
	}
	tracelog("ll_deleteuser(). end.\n");
	return( ll_writeuserv( regiv, lusrfm, ruser->usid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readuser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_readuser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	struct	usidFORM	usid;
	struct	lusrFORM	lusr;
	struct	reg_userFORM	*ruser;

	tracelog("ll_readuser(). start.\n");
	ruser = (struct	reg_userFORM *)regiv->datarec;
	memcpy( lusr.usid, ruser->usid, sizeof(lusr.usid) );
	if( PI_REDEQ( lusrfm->isfd, "KA", (char *)&lusr ) < 0 )
	{
l_errlog("CmRegUser()","lusr Not found. usid=%.8s. iserrno=%d\n",
lusr.usid,iserrno);
		tracelog("ll_readuser(). error. PI_REDEQ(lusr)\n");
		return( -1 );
	}

	memcpy( usid.usid, ruser->usid, sizeof(usid.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
l_errlog("CmRegUser()","user Not found. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
		tracelog("ll_readuser(). error. PI_REDEQ(usid)\n");
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)ruser );
	tracelog("ll_readuser(). end\n");
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxuser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_readnxuser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	struct	usidFORM	usid;
	struct	lusrFORM	lusr;
	struct	reg_userFORM	*ruser;

	ruser = (struct	reg_userFORM *)regiv->datarec;
	memcpy( lusr.usid, ruser->usid, sizeof(lusr.usid) );
	if( PI_REDGT( lusrfm->isfd, "KA", (char *)&lusr ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegUser()","lusr Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}

	memcpy( usid.usid, lusr.usid, sizeof(usid.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
l_errlog("CmRegUser()","user Not found. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)ruser );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readpruser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_readpruser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	struct	usidFORM	usid;
	struct	lusrFORM	lusr;
	struct	reg_userFORM	*ruser;

	ruser = (struct	reg_userFORM *)regiv->datarec;
	memcpy( lusr.usid, ruser->usid, sizeof(lusr.usid) );
	if( PI_REDLT( lusrfm->isfd, "KA", (char *)&lusr ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegUser()","lusr Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}

	memcpy( usid.usid, lusr.usid, sizeof(usid.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
l_errlog("CmRegUser()","user Not found. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)ruser );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeuser( REG_INTVAL *regiv, REG_INTVAL *lusrfm )
#else
ll_writeuser( regiv, lusrfm )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
#endif
{
	struct	usidFORM	usid;
	struct	lusrFORM	lusr;
	struct	reg_userFORM	*ruser;
	int	ret;
	char	opcd;

	tracelog("ll_writeuser(). start\n");
	memset( (char *)&usid, ' ', sizeof(usid) );
	ruser = (struct	reg_userFORM *)regiv->datarec;
	memcpy( usid.usid, ruser->usid, sizeof(usid.usid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&usid );
	memcpy( usid.usnm, ruser->usnm, sizeof(usid.usnm) );
	memcpy( usid.ugrp, ruser->ugrp, sizeof(usid.ugrp) );
	memcpy( usid.ulev, ruser->ulev, sizeof(usid.ulev) );
	memcpy( usid.upwd, ruser->upwd, sizeof(usid.upwd) );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUser()","user can't addit. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
			tracelog("ll_writeuser(). error. PI_ADDIT(usid)\n");
			return( -1 );
		}
		opcd = OP_ADD;
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUser()","user can't updat. usid=%.8s. iserrno=%d\n",
usid.usid,iserrno);
			tracelog("ll_writeuser(). error. PI_UPDAT(usid)\n");
			return( -1 );
		}
		opcd = OP_CHANGE;
	}

	memset( (char *)&lusr, ' ', sizeof(lusr) );
	memcpy( lusr.usid, ruser->usid, sizeof(lusr.usid) );
	if( PI_REDEQ( lusrfm->isfd, "KA", (char *)&lusr ) >= 0 )
	{
		tracelog("ll_writeuser(). end. PI_REDEQ(lusr)\n");
		return( ll_writeuserv( regiv, 0, ruser->usid, opcd ) );
	}
	if( PI_ADDIT( lusrfm->isfd, (char *)&lusr ) < 0 )
	{
l_errlog("CmRegUser()","lusr can't addit. usid=%.8s. iserrno=%d\n",
lusr.usid,iserrno);
		tracelog("ll_writeuser(). error. PI_ADDIT(lusr)\n");
		return( -1 );
	}
	tracelog("ll_writeuser(). end.\n");
	return( ll_writeuserv( regiv, lusrfm, ruser->usid, opcd ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeuserv( REG_INTVAL *regiv, REG_INTVAL *lusrfm, char *usid, char opcode )
#else
ll_writeuserv( regiv, lusrfm, usid, opcode )
REG_INTVAL	*regiv;
REG_INTVAL	*lusrfm;
char		*usid;
char		opcode;
#endif
{
	struct	usidvFORM	usidv;
	struct	lusrvFORM	lusrv;
	int	ret;

	tracelog("ll_writeuserv(). start.\n");
	memset( (char *)&usidv, ' ', sizeof(usidv) );
	memcpy( usidv.usid, usid, sizeof(usidv.usid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&usidv );
	e_getsysdate( 31, usidv.verid, &usidv.verid[8] );
	usidv.opcode[0] = opcode;
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isvfd, (char *)&usidv ) < 0 )
		{
l_errlog("CmRegUser()","user can't addit. usid=%.8s. iserrno=%d\n",
usidv.usid,iserrno);
			tracelog("ll_writeuserv(). error. PI_ADDIT(usidv)\n");
			return( -1 );
		}
	}
	else
	{
		if( PI_UPDAT( regiv->isvfd, (char *)&usidv ) < 0 )
		{
l_errlog("CmRegUser()","user can't updat. usid=%.8s. iserrno=%d\n",
usidv.usid,iserrno);
			tracelog("ll_writeuserv(). error. PI_UPDAT(usidv)\n");
			return( -1 );
		}
	}

	/* login user 는 update 하지 않는다 */
	if( lusrfm == (REG_INTVAL *)0 )
	{
		tracelog("ll_writeuserv(). end.\n");
		return( 0 );
	}

	memset( (char *)&lusrv, ' ', sizeof(lusrv) );
	memcpy( lusrv.usid, usid, sizeof(lusrv.usid) );
	ret = PI_RDUEQ( lusrfm->isvfd, "KA", (char *)&lusrv );
	memcpy( lusrv.verid, usidv.verid, sizeof(lusrv.verid) );
	lusrv.opcode[0] = opcode;
	tracelog("ll_writeuserv(). end. PI_ADDIT(UPDAT).lusrv. ret=%d\n",ret);
	if( ret < 0 )
	{
		ret = PI_ADDIT( lusrfm->isvfd, (char *)&lusrv );
		if( ret < 0 )
		{
l_errlog("CmRegUser()","lusr can't addit. usid=%.8s. iserrno=%d\n",
lusrv.usid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( lusrfm->isvfd, (char *)&lusrv );
		if( ret < 0 )
		{
l_errlog("CmRegUser()","lusr can't addit. usid=%.8s. iserrno=%d\n",
lusrv.usid,iserrno);
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
	struct	usidFORM	*usid;
	struct	reg_userFORM	*ruser;

	usid = (struct usidFORM *)src;
	ruser = (struct reg_userFORM *)dest;
	
	memcpy( ruser->usid, usid->usid, sizeof(usid->usid) );
	memcpy( ruser->usnm, usid->usnm, sizeof(usid->usnm) );
	memcpy( ruser->ugrp, usid->ugrp, sizeof(usid->ugrp) );
	memcpy( ruser->ulev, usid->ulev, sizeof(usid->ulev) );
	memcpy( ruser->upwd, usid->upwd, sizeof(usid->upwd) );
}

/*----------------------------------------------------------------------*/
/* end of CmRegUser.c */
