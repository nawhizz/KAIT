/* CmRegFmid() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegFmid() : Handle fmid isam					|
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
#include	<errno.h>

#include	"gps.h"
#include	"pisam.h"
#include	"stpapi.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"fmid.h"
#include	"fmidv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildfmid	CBD2(( char * ));
static	int	ll_getfmidpath	CBD2(( char *, char *, char * ));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_fmidFORM *, char ));
static	int	ll_openfmid	CBD2(( REG_INTVAL *, char * ));
static	int	ll_deletefmid	CBD2(( REG_INTVAL * ));
static	int	ll_readfmid	CBD2(( REG_INTVAL * ));
static	int	ll_readnxfmid	CBD2(( REG_INTVAL * ));
static	int	ll_readprfmid	CBD2(( REG_INTVAL * ));
static	int	ll_writefmid	CBD2(( REG_INTVAL * ));
static	int	ll_writefmidv	CBD2(( REG_INTVAL *, char *, char ));
static	void	ll_movedata	CBD2(( char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegFmid( char *asid, struct reg_fmidFORM *regfmid, char action )
#else
CmRegFmid( asid, regfmid, action )
char			*asid;
struct	reg_fmidFORM	*regfmid;
char			action;
#endif
{
	int		ret;
	REG_INTVAL	regiv;

tracelog("CmRegFmid(). start. asid is %.4s, action is %c\n",asid,action);

	if( !asid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegFmid()", "asid is null\n");
		tracelog("CmRegFmid(). error. asid is null\n");
		return( -1 );
	}

	if( ll_chkinput( regfmid, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regfmid, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildfmid( asid ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openfmid( &regiv, asid ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deletefmid( &regiv );
		break;

	case	REG_READ   :
		ret = ll_readfmid( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writefmid( &regiv );
		break;

	case	REG_READNX :
		ret = ll_readnxfmid( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprfmid( &regiv );
		break;

	default		   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegFmid()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	tracelog("CmRegFmid(). end. ret is %d\n", ret);
	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildfmid( char *asid )
#else
ll_buildfmid( asid )
char		*asid;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_getfmidpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "fmid" );
	if( fd < 0 )
	{
		l_errlog("CmRegFmid()", "PI_BUILD(fmid) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "fmidv" );
	if( fd < 0 )
	{
		l_errlog("CmRegFmid()", "PI_BUILD(fmidv) error\n");
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
ll_chkinput( struct reg_fmidFORM *regfmid, char action )
#else
ll_chkinput( regfmid, action )
struct	reg_fmidFORM	*regfmid;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regfmid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegFmid()", "regfmid is null\n");
		tracelog("CmRegFmid(). error. regfmid is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( regfmid->fmid ) )
	{
		l_errlog("CmRegFmid()", "fmid is space\n");
		tracelog("CmRegFmid(). error. fmid is space\n");
		return( -1 );
	}

	if( (action == REG_WRITE) && ISSPACE( regfmid->cpgid ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegFmid()", "cpgid is space\n");
		tracelog("CmRegFmid(). error. cpgid is space\n");
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getfmidpath( char *asid, char *cfgpath, char *datapath )
#else
ll_getfmidpath( asid, cfgpath, datapath )
char	*asid;
char	*cfgpath;
char	*datapath;
#endif
{
	if( l_reggetascfg( asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegFmid()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "PSCNTL", datapath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", datapath ) < 0 )
		{
l_errlog("CmRegFmid()","Undefind PSCNTL at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTPSCNTL );
			return( -1 );
		}
		strcat( datapath, "/cntl/fmid" );
	}
	else
		strcat( datapath, "/fmid" );


	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openfmid( REG_INTVAL *regiv, char *asid )
#else
ll_openfmid( regiv, asid )
REG_INTVAL	*regiv;
char		*asid;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_getfmidpath( asid, cfgpath, datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, cfgpath, datapath, "fmid" );
	if( ret < 0 )
	{
		l_errlog("CmRegFmid()", "l_regopen error\n");
		tracelog("ll_openfmid(). Error. hyerr=%d, errno=%d, iserr=%d\n",
			hyerrno, errno, iserrno);
	}

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deletefmid( REG_INTVAL *regiv )
#else
ll_deletefmid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	fmidFORM	fmid;
	struct	reg_fmidFORM	*rfmid;

	rfmid = (struct	reg_fmidFORM *)regiv->datarec;
	memcpy( fmid.fmid, rfmid->fmid, sizeof(fmid.fmid) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&fmid ) >= 0 )
	{
		if( PI_DELET( regiv->isfd, (char *)&fmid ) < 0 )
		{
l_errlog("CmRegFmid()","can't delet. fmid=%.8s. iserrno=%d\n",fmid.fmid,iserrno);
			return( -1 );
		}
	}
	return( ll_writefmidv( regiv, rfmid->fmid, OP_DELETE ) );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readfmid( REG_INTVAL *regiv )
#else
ll_readfmid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	fmidFORM	fmid;
	struct	reg_fmidFORM	*rfmid;

	rfmid = (struct	reg_fmidFORM *)regiv->datarec;
	memcpy( fmid.fmid, rfmid->fmid, sizeof(fmid.fmid) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&fmid ) < 0 )
	{
l_errlog("CmRegFmid()","Not found. fmid=%.8s. iserrno=%d\n",fmid.fmid,iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&fmid, (char *)rfmid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxfmid( REG_INTVAL *regiv )
#else
ll_readnxfmid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	fmidFORM	fmid;
	struct	reg_fmidFORM	*rfmid;

	rfmid = (struct	reg_fmidFORM *)regiv->datarec;
	memcpy( fmid.fmid, rfmid->fmid, sizeof(fmid.fmid) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&fmid ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegFmid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&fmid, (char *)rfmid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprfmid( REG_INTVAL *regiv )
#else
ll_readprfmid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	fmidFORM	fmid;
	struct	reg_fmidFORM	*rfmid;

	rfmid = (struct	reg_fmidFORM *)regiv->datarec;
	memcpy( fmid.fmid, rfmid->fmid, sizeof(fmid.fmid) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&fmid ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegFmid()","Not found. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&fmid, (char *)rfmid );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writefmid( REG_INTVAL *regiv )
#else
ll_writefmid( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	fmidFORM	fmid;
	struct	reg_fmidFORM	*rfmid;
	int	ret;

	memset( (char *)&fmid, ' ', sizeof(fmid) );
	rfmid = (struct	reg_fmidFORM *)regiv->datarec;
	memcpy( fmid.fmid, rfmid->fmid, sizeof(fmid.fmid) );
	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&fmid );
	memcpy( fmid.formnm	,rfmid->formnm	, sizeof(fmid.formnm)	);
	memcpy( fmid.fmgrp	,rfmid->fmgrp	, sizeof(fmid.fmgrp)	);
	memcpy( fmid.cpgid	,rfmid->cpgid	, sizeof(fmid.cpgid)	);
	memcpy( fmid.txid	,rfmid->txid	, sizeof(fmid.txid)	);
	memcpy( fmid.ulev	,rfmid->ulev	, sizeof(fmid.ulev)	);
	memcpy( fmid.runkind	,rfmid->runkind	, sizeof(fmid.runkind)	);
	memcpy( fmid.formkind	,rfmid->formkind, sizeof(fmid.formkind) );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&fmid ) < 0 )
		{
l_errlog("CmRegFmid()","can't addit. fmid=%.8s. iserrno=%d\n",fmid.fmid,iserrno);
			return( -1 );
		}
		return( ll_writefmidv( regiv, rfmid->fmid, OP_ADD ) );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&fmid ) < 0 )
		{
l_errlog("CmRegFmid()","can't updat. fmid=%.8s. iserrno=%d\n",fmid.fmid,iserrno);
			return( -1 );
		}
		return( ll_writefmidv( regiv, rfmid->fmid, OP_CHANGE ) );
	}
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writefmidv( REG_INTVAL *regiv, char *fmid, char opcode )
#else
ll_writefmidv( regiv, fmid, opcode )
REG_INTVAL	*regiv;
char		*fmid;
char		opcode;
#endif
{
	struct	fmidvFORM	fmidv;
	int	ret;

	memset( (char *)&fmidv, ' ', sizeof(fmidv) );
	memcpy( fmidv.fmid, fmid, sizeof(fmidv.fmid) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&fmidv );
	e_getsysdate( 31, fmidv.verid, &fmidv.verid[8] );
	fmidv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&fmidv );
		if( ret )
		{
l_errlog("CmRegFmid()","can't addit. fmid=%.8s. iserrno=%d\n",fmidv.fmid,iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&fmidv );
		if( ret )
		{
l_errlog("CmRegFmid()","can't updat. fmid=%.8s. iserrno=%d\n",fmidv.fmid,iserrno);
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
	struct	fmidFORM	*fmid;
	struct	reg_fmidFORM	*rfmid;

	fmid  = (struct fmidFORM *)src;
	rfmid = (struct reg_fmidFORM *)dest;

	memcpy( rfmid->fmid	, fmid->fmid	, sizeof(fmid->fmid)	);
	memcpy( rfmid->formnm	, fmid->formnm	, sizeof(fmid->formnm)	);
	memcpy( rfmid->fmgrp	, fmid->fmgrp	, sizeof(fmid->fmgrp)	);
	memcpy( rfmid->cpgid	, fmid->cpgid	, sizeof(fmid->cpgid)	);
	memcpy( rfmid->txid	, fmid->txid	, sizeof(fmid->txid)	);
	memcpy( rfmid->ulev	, fmid->ulev	, sizeof(fmid->ulev)	);
	memcpy( rfmid->runkind	, fmid->runkind	, sizeof(fmid->runkind)	);
	memcpy( rfmid->formkind	, fmid->formkind, sizeof(fmid->formkind));
}

/*----------------------------------------------------------------------*/
/* end of CmRegFmid.c */
