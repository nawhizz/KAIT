/* CmRegUsid() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegUsid() : Handle usid isam					|
|									|
|	return	 0	OK						|
|		-1	error						|
|									|
| 2001.5.21  ksh. build 기능 추가					|
|									|
+----------------------------------------------------------------------*/
#define	_BUILD		/*2001.5.21*/

#include	<string.h>    /*memcpy,memset,strcat*/
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"usid.h"
#include	"usidv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildusid	CBD2(( void ));
static	int	ll_getusidpath	CBD2(( char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_usidFORM *, char ));
static	int	ll_openusid	CBD2(( REG_INTVAL * ));
static	int	ll_deleteusid	CBD2(( REG_INTVAL * ));
static	int	ll_readusid	CBD2(( REG_INTVAL * ));
static	int	ll_readnxusid	CBD2(( REG_INTVAL * ));
static	int	ll_readprusid	CBD2(( REG_INTVAL * ));
static	int	ll_writeusid	CBD2(( REG_INTVAL * ));
static	int	ll_writeusidv	CBD2(( REG_INTVAL *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegUsid( struct reg_usidFORM *regusid, char action )
#else
CmRegUsid( regusid, action )
struct	reg_usidFORM	*regusid;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

	tracelog("CmRegUsid(). start. action is %c\n", action);

	if( ll_chkinput( regusid, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regusid, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildusid() );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openusid( &regiv ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deleteusid( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readusid( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writeusid( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxusid( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprusid( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegUsid()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegUsid(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildusid( void )
#else
ll_buildusid()
#endif
{
	int	fd;
	char	datapath[128];

	if( ll_getusidpath( datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "usid" );
	if( fd < 0 )
	{
		l_errlog("CmRegUsid()", "PI_BUILD(usid) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "usidv" );
	if( fd < 0 )
	{
		l_errlog("CmRegUsid()", "PI_BUILD(usidv) error\n");
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
ll_chkinput( struct reg_usidFORM *regusid, char action )
#else
ll_chkinput( regusid, action )
struct	reg_usidFORM	*regusid;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regusid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegUsid()", "regusid is null\n");
		tracelog("CmRegUsid(). error. regusid is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( regusid->usid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegUsid()", "usid is space\n");
		tracelog("CmRegUsid(). error. usid is space\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getusidpath( char *datapath )
#else
ll_getusidpath( datapath )
char	*datapath;
#endif
{
	if( e_getenv( "USERINFO", datapath ) < 0 )
	{
		if( e_getenv( "IEAPHOME", datapath ) < 0 )
		{
			l_errlog("CmRegUsid()", "Undefined USERINFO\n");
			l_sethyerrno( ECMR_NOTUSERINFO );
			return( -1 );
		}
		strcat( datapath, "/syscntl/usid" );
	}
	else
		strcat( datapath, "/usid" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openusid( REG_INTVAL *regiv )
#else
ll_openusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	char	datapath[128];
	int	ret;

	if( ll_getusidpath( datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, (char *)0, datapath, "usid" );
	if( ret < 0 )
		l_errlog("CmRegUsid()", "l_regopen error\n");

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deleteusid( REG_INTVAL *regiv )
#else
ll_deleteusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	usidFORM	usid;
	struct	reg_usidFORM	*rusid;

	rusid = (struct	reg_usidFORM *)regiv->datarec;
	memcpy( usid.usid, rusid->usid, sizeof(usid.usid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&usid ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUsid()","can't delete. usid=%.8s, iserrno=%d\n",usid.usid,iserrno);
			return( -1 );
		}
	}
	return( ll_writeusidv( regiv, rusid->usid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readusid( REG_INTVAL *regiv )
#else
ll_readusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	usidFORM	usid;
	struct	reg_usidFORM	*rusid;

	rusid = (struct	reg_usidFORM *)regiv->datarec;
	memcpy( usid.usid, rusid->usid, sizeof(usid.usid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
l_errlog("CmRegUsid()","Not found. usid=%.8s, iserrno=%d\n",usid.usid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)rusid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxusid( REG_INTVAL *regiv )
#else
ll_readnxusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	usidFORM	usid;
	struct	reg_usidFORM	*rusid;

	rusid = (struct	reg_usidFORM *)regiv->datarec;
	memcpy( usid.usid, rusid->usid, sizeof(usid.usid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
		l_errlog("CmRegUsid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)rusid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprusid( REG_INTVAL *regiv )
#else
ll_readprusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	usidFORM	usid;
	struct	reg_usidFORM	*rusid;

	rusid = (struct	reg_usidFORM *)regiv->datarec;
	memcpy( usid.usid, rusid->usid, sizeof(usid.usid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&usid ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
		l_errlog("CmRegUsid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&usid, (char *)rusid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeusid( REG_INTVAL *regiv )
#else
ll_writeusid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	usidFORM	usid;
	struct	reg_usidFORM	*rusid;
	int	ret;

	memset( (char *)&usid, ' ', sizeof(usid) );
	rusid = (struct	reg_usidFORM *)regiv->datarec;
	memcpy( usid.usid, rusid->usid, sizeof(usid.usid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&usid );
	memcpy( usid.usnm, rusid->usnm, sizeof(usid.usnm) );
	memcpy( usid.ugrp, rusid->ugrp, sizeof(usid.ugrp) );
	memcpy( usid.ulev, rusid->ulev, sizeof(usid.ulev) );
	memcpy( usid.upwd, rusid->upwd, sizeof(usid.upwd) );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUsid()","can't addit. usid=%.8s, iserrno=%d\n",usid.usid,iserrno);
			return( -1 );
		}
		return( ll_writeusidv( regiv, rusid->usid, OP_ADD ) );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&usid ) < 0 )
		{
l_errlog("CmRegUsid()","can't updat. usid=%.8s, iserrno=%d\n",usid.usid,iserrno);
			return( -1 );
		}
		return( ll_writeusidv( regiv, rusid->usid, OP_CHANGE ) );
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeusidv( REG_INTVAL *regiv, char *usid, char opcode )
#else
ll_writeusidv( regiv, usid, opcode )
REG_INTVAL	*regiv;
char		*usid;
char		opcode;
#endif
{
	struct	usidvFORM	usidv;
	int	ret;

	memset( (char *)&usidv, ' ', sizeof(usidv) );
	memcpy( usidv.usid, usid, sizeof(usidv.usid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&usidv );
	e_getsysdate( 31, usidv.verid, &usidv.verid[8] );
	usidv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&usidv );
		if( ret < 0 )
		{
l_errlog("CmRegUsid()","can't addit. usid=%.8s, iserrno=%d\n",usidv.usid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&usidv );
		if( ret < 0 )
		{
l_errlog("CmRegUsid()","can't updat. usid=%.8s, iserrno=%d\n",usidv.usid,iserrno);
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
	struct	reg_usidFORM	*rusid;

	usid  = (struct usidFORM *)src;
	rusid = (struct reg_usidFORM *)dest;

	memcpy( rusid->usid, usid->usid, sizeof(usid->usid) );
	memcpy( rusid->usnm, usid->usnm, sizeof(usid->usnm) );
	memcpy( rusid->ugrp, usid->ugrp, sizeof(usid->ugrp) );
	memcpy( rusid->ulev, usid->ulev, sizeof(usid->ulev) );
	memcpy( rusid->upwd, usid->upwd, sizeof(usid->upwd) );
}
/*----------------------------------------------------------------------*/
/* end of CmRegUsid.c */
