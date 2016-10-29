/* CmRegAscl() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegAscl() : Handle ascl isam					|
|									|
|	return	 0	OK						|
|		-1	error						|
|									|
| 2001.5.21  ksh. build 기능 추가					|
|									|
+----------------------------------------------------------------------*/
#define	_BUILD		/*2001.5.21*/

#include	<stdio.h>	/*sprintf,unlink*/
#include	<string.h>	/*memcpy,memset,strcat*/
#include	<iswrap.h>
#ifdef	WIN32
#include	<io.h>		/*access,unlink*/
#include	<direct.h>	/*mkdir*/
#else
#include	<unistd.h>	/*unlink*/
#endif
#include	<sys/types.h>	/*mkdir,stat*/
#include	<sys/stat.h>	/*mkdir,stat*/
#include	<errno.h>	/*errno*/

#include	"gps.h"
#include	"pisam.h"
#include	"stpapi.h"
#include	"stpmacro.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"ascl.h"
#include	"asclv.h"
/*----------------------------------------------------------------------+
|	Declare Internal Function					|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int	ll_buildascl	CBD2(( char *, char *, char * ));
static	int	ll_getasclpath	CBD2(( char *, char *, char *, char *, char *));
/*end of 2001.5.21------------------------------------------------------------*/
#endif
static	int	ll_chkinput	CBD2(( struct reg_asclFORM *, char *, char ));
static	int	ll_openascl	CBD2(( REG_INTVAL *, char *, char *, char * ));
static	int	ll_deleteascl	CBD2(( REG_INTVAL *, char * ));
static	int	ll_readascl	CBD2(( REG_INTVAL * ));
static	int	ll_readnxascl	CBD2(( REG_INTVAL * ));
static	int	ll_readprascl	CBD2(( REG_INTVAL * ));
static	int	ll_writeascl	CBD2(( REG_INTVAL *, char *, char *, char * ));
static	int	ll_writeasclv	CBD2((REG_INTVAL *,struct reg_asclFORM *,char));
static	void	ll_movedata	CBD2(( char *, char * ));
static	int	ll_chkdir	CBD2(( char *, char * ));
static	void	ll_getfpath	CBD2(( char *, char *, char * ));

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined(__CB_STDC__)
CmRegAscl( char *asid, struct reg_asclFORM *regascl, char *srcpath, char action)
#else
CmRegAscl( asid, regascl, srcpath, action )
char			*asid;
struct	reg_asclFORM	*regascl;
char			*srcpath;
char			action;
#endif
{
	int		ret;
	char		clivpath[256], fowner[20];
	REG_INTVAL	regiv;

	if( !asid )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegAscl()", "asid is null\n");
		return( -1 );
	}

	if( ll_chkinput( regascl, srcpath, action ) < 0 )
		return( -1 );

	l_reginit( &regiv, (char *)regascl, action );

#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
	{
		return( ll_buildascl( asid, clivpath, fowner ) );
	}
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( ll_openascl( &regiv, asid, clivpath, fowner ) < 0 )
	{
		l_regclose( &regiv );
		return( -1 );
	}

	switch( action )
	{
	case	REG_DELETE :
		ret = ll_deleteascl( &regiv, clivpath );
		break;

	case	REG_READ   :
		ret = ll_readascl( &regiv );
		break;

	case	REG_WRITE  :
		ret = ll_writeascl( &regiv, clivpath, srcpath, fowner );
		break;

	case	REG_READNX :
		ret = ll_readnxascl( &regiv );
		break;

	case	REG_READPR :
		ret = ll_readprascl( &regiv );
		break;

	default 	   :
		l_sethyerrno( ECMR_UNDEFACTION );
		l_errlog("CmRegAscl()", "action is wrong [%c]\n", action);
		ret = -1;
	}

	l_regclose( &regiv );

	return( ret );
}

/*----------------------------------------------------------------------+
|	Internal Function						|
+----------------------------------------------------------------------*/
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_buildascl( char *asid, char *clivpath, char *fowner )
#else
ll_buildascl( asid, clivpath, fowner )
char		*asid;
char		*clivpath;
char		*fowner;
#endif
{
	int	fd;
	char	cfgpath[128], datapath[128];

	if( ll_getasclpath( asid, clivpath, fowner, cfgpath, datapath ) < 0 )
		return( -1 );

	fd = PI_BUILD( datapath, "ascl" );
	if( fd < 0 )
	{
		l_errlog("CmRegAscl()", "PI_BUILD(ascl) error\n");
		return( -1 );
	}

	PI_CLOSE( fd );

	strcat( datapath, "v" );
	fd = PI_BUILD( datapath, "asclv" );
	if( fd < 0 )
	{
		l_errlog("CmRegAscl()", "PI_BUILD(asclv) error\n");
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
ll_chkinput( struct reg_asclFORM *regascl, char *srcpath, char action )
#else
ll_chkinput( regascl, srcpath, action )
struct	reg_asclFORM	*regascl;
char			*srcpath;
char			action;
#endif
{
#ifdef	_BUILD
/*2001.5.21. add--------------------------------------------------------------*/
	if( action == REG_BUILD )
		return( 0 );
/*end of 2001.5.21------------------------------------------------------------*/
#endif

	if( !regascl )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegAscl()", "regascl is null\n");
		return( -1 );
	}

	if( (action == REG_READNX) || (action == REG_READPR) )
		return( 0 );
		
	if( ISSPACE( regascl->fname ) )
	{
		l_sethyerrno( ECMR_ARGERR );
		l_errlog("CmRegAscl()", "fname is space\n");
		return( -1 );
	}

	if( regascl->clios[0] != ' ' )
	{
		if( (regascl->clios[0] < '0') || (regascl->clios[0] > '2') )
		{
			l_sethyerrno( ECMR_ARGERR );
l_errlog("CmRegAscl()","clios(0-2) is wrong [%c]\n",regascl->clios[0]);
			return( -1 );
		}
	}

	if( action == REG_WRITE )
	{
		if( !srcpath )
		{
			l_sethyerrno( ECMR_ARGERR );
			l_errlog("CmRegAscl()", "source file path is null\n");
			return( -1 );
		}
		if( regascl->group[0] != ' ')
		{
			if( (regascl->group[0] < '0') ||
			    (regascl->group[0] > '3') )
			{
				l_sethyerrno( ECMR_ARGERR );
l_errlog("CmRegAscl()","group(0-3) is wrong [%c]\n",regascl->group[0]);
				return( -1 );
			}
		}
		else if( ISSPACE( regascl->dnpath ) )
		{
			l_sethyerrno( ECMR_ARGERR );
			l_errlog("CmRegAscl()", "down path is space\n");
			return( -1 );
		}
	}
	
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_getasclpath( char *asid,
		char *clivpath, char *fowner, char *cfgpath, char *datapath )
#else
ll_getasclpath( asid, clivpath, fowner, cfgpath, datapath )
char		*asid;
char		*clivpath;
char		*fowner;
char		*cfgpath;
char		*datapath;
#endif
{
	if( l_reggetascfg( asid, cfgpath ) < 0 )
	{
		l_errlog("CmRegAscl()", "l_reggetascfg error\n");
		return( -1 );
	}

	if( cfg_getenv( cfgpath, "", "CLIVER", clivpath ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "ASHOME", clivpath ) < 0 )
		{
l_errlog("CmRegAscl()","Undefind CLIVER at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTTXCNTL );
			return( -1 );
		}
		strcat( clivpath, "/cliver" );
	}

	if( cfg_getenv( cfgpath, "", "FILEOWNER", fowner ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "MYOWNER", fowner ) < 0 )
		{
l_errlog("CmRegAscl()","Undefind FILEOWNER at %s. errno=%d\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTMYOWNER );
			return( -1 );
		}
	}

	strcpy( datapath, clivpath );
	strcat( datapath, "/ascl" );

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_openascl( REG_INTVAL *regiv, char *asid, char *clivpath, char *fowner )
#else
ll_openascl( regiv, asid, clivpath, fowner )
REG_INTVAL	*regiv;
char		*asid;
char		*clivpath;
char		*fowner;
#endif
{
	char	cfgpath[128], datapath[128];
	int	ret;

	if( ll_getasclpath( asid, clivpath, fowner, cfgpath, datapath ) < 0 )
		return( -1 );

	ret = l_regopen( regiv, cfgpath, datapath, "ascl" );
	if( ret < 0 )
		l_errlog("CmRegAscl()", "l_regopen error\n");

	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_deleteascl( REG_INTVAL *regiv, char *clivpath )
#else
ll_deleteascl( regiv, clivpath )
REG_INTVAL	*regiv;
char		*clivpath;
#endif
{
	struct	asclFORM	ascl;
	struct	reg_asclFORM	*rascl;
	char	fpath[128];

	rascl = (struct reg_asclFORM *)regiv->datarec;
	memcpy( ascl.fname, rascl->fname, sizeof(ascl.fname) );
	memcpy( ascl.clios, rascl->clios, sizeof(ascl.clios) );
	if( PI_RDUEQ( regiv->isfd, "KA", (char *)&ascl ) < 0 )
	{
l_errlog("CmRegAscl()","Not found. fname=%.20s, clios=%c. iserrno=%d\n",
ascl.fname,ascl.clios[0],iserrno);
		return( -1 );
	}

	if( PI_DELET( regiv->isfd, (char *)&ascl ) < 0 )
	{
l_errlog("CmRegAscl()","can't delete. fname=%.20s, clios=%c. iserrno=%d\n",
ascl.fname,ascl.clios[0],iserrno);
		return( -1 );
	}

	if( ll_writeasclv( regiv, rascl, OP_DELETE ) < 0 )
		return( -1 );

	ll_getfpath( ascl.clios, clivpath, fpath );

	d_mkstr( ascl.fname, sizeof(ascl.fname), &fpath[strlen(fpath)] );

	if( unlink( fpath ) < 0 )
	{
		l_sethyerrno( errno );
l_errlog("CmRegAscl()","%s can't unlink. errno=%d\n",fpath,errno);
		return( -1 );
	}

	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readascl( REG_INTVAL *regiv )
#else
ll_readascl( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	asclFORM	ascl;
	struct	reg_asclFORM	*rascl;

	rascl = (struct reg_asclFORM *)regiv->datarec;
	memcpy( ascl.fname, rascl->fname, sizeof(ascl.fname) );
	memcpy( ascl.clios, rascl->clios, sizeof(ascl.clios) );
	if( PI_REDEQ( regiv->isfd, "KA", (char *)&ascl ) < 0 )
	{
l_errlog("CmRegAscl()","Not found. fname=%.20s, clios=%c. iserrno=%d\n",
ascl.fname,ascl.clios[0],iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&ascl, (char *)rascl );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readnxascl( REG_INTVAL *regiv )
#else
ll_readnxascl( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	asclFORM	ascl;
	struct	reg_asclFORM	*rascl;

	rascl = (struct reg_asclFORM *)regiv->datarec;
	memcpy( ascl.fname, rascl->fname, sizeof(ascl.fname) );
	memcpy( ascl.clios, rascl->clios, sizeof(ascl.clios) );
	if( PI_REDGT( regiv->isfd, "KA", (char *)&ascl ) < 0 )
	{
		if( iserrno == 111 )
			return( -1 );
l_errlog("CmRegAscl()","can't read. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&ascl, (char *)rascl );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_readprascl( REG_INTVAL *regiv )
#else
ll_readprascl( regiv )
REG_INTVAL	*regiv;
#endif
{
	struct	asclFORM	ascl;
	struct	reg_asclFORM	*rascl;

	rascl = (struct reg_asclFORM *)regiv->datarec;
	memcpy( ascl.fname, rascl->fname, sizeof(ascl.fname) );
	memcpy( ascl.clios, rascl->clios, sizeof(ascl.clios) );
	if( PI_REDLT( regiv->isfd, "KA", (char *)&ascl ) < 0 )
	{
		if( iserrno == 110 )
			return( -1 );
l_errlog("CmRegAscl()","can't read. iserrno=%d\n",iserrno);
		return( -1 );
	}
	ll_movedata( (char *)&ascl, (char *)rascl );
	return( 0 );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeascl( REG_INTVAL *regiv, char *clivpath, char *srcpath, char *fowner )
#else
ll_writeascl( regiv, clivpath, srcpath, fowner )
REG_INTVAL	*regiv;
char		*clivpath;
char		*srcpath;
char		*fowner;
#endif
{
	struct	asclFORM	ascl;
	struct	reg_asclFORM	*rascl;
	struct	stat		srcstat;
	char			destpath[256], tmpbuf[30];
	int			ret;

	rascl = (struct reg_asclFORM *)regiv->datarec;

	if( stat( srcpath, &srcstat ) < 0 )
	{
		l_sethyerrno( ECMR_ARGERR );
l_errlog("CmRegAscl()","%s can't get status. errno=%d\n",srcpath,errno);
		return( -1 );
	}

	ll_getfpath( rascl->clios, clivpath, destpath );

	if( ll_chkdir( destpath, fowner ) < 0 )
		return( -1 );

	d_mkstr(rascl->fname,sizeof(rascl->fname),&destpath[strlen(destpath)]);

	if( f_copy( srcpath, destpath, 'W' ) < 0 )
	{
l_errlog("CmRegAscl()","f_copy(%s, %s, 'w') error. errno=%d\n",
srcpath,destpath,errno);
		return( -1 );
	}
	if( f_chown(destpath, fowner) < 0 )
	{
l_errlog("CmRegAscl()","f_chown(%s) error. errno=%d\n",destpath,errno);
		return( -1 );
	}

	memset( (char *)&ascl, ' ', sizeof(ascl) );
	memcpy( ascl.fname, rascl->fname, sizeof(ascl.fname) );
	memcpy( ascl.clios, rascl->clios, sizeof(ascl.clios) );

	ret = PI_RDUEQ( regiv->isfd, "KA", (char *)&ascl );

	memcpy( ascl.group	,rascl->group	 , sizeof(ascl.group)	 );
	memcpy( ascl.dnpath	,rascl->dnpath	 , sizeof(ascl.dnpath)	 );
	sprintf( tmpbuf, "%*d"	,sizeof(ascl.fsize), srcstat.st_size	 );
	memcpy( ascl.fsize	,tmpbuf 	 , strlen(tmpbuf)	 );
	memcpy( ascl.compress	,rascl->compress , sizeof(ascl.compress) );
	memcpy( ascl.usid	,rascl->usid	 , sizeof(ascl.usid)	 );
	if( ret < 0 )
	{
		if( PI_ADDIT( regiv->isfd, (char *)&ascl ) < 0 )
		{
l_errlog("CmRegAscl()","can't addit. fname=%.20s, clios=%c. iserrno=%d\n",
ascl.fname,ascl.clios[0],iserrno);
			return( -1 );
		}
		ret = ll_writeasclv( regiv, rascl, OP_ADD );
	}
	else
	{
		if( PI_UPDAT( regiv->isfd, (char *)&ascl ) < 0 )
		{
l_errlog("CmRegAscl()","can't updat. fname=%.20s, clios=%c. iserrno=%d\n",
ascl.fname,ascl.clios[0],iserrno);
			return( -1 );
		}
		ret = ll_writeasclv( regiv, rascl, OP_CHANGE );
	}
	return( ret );
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_writeasclv( REG_INTVAL *regiv, struct reg_asclFORM *rascl, char opcode )
#else
ll_writeasclv( regiv, rascl, opcode )
REG_INTVAL	*regiv;
struct	reg_asclFORM	*rascl;
char		opcode;
#endif
{
	struct	asclvFORM	asclv;
	int	ret;

	memset( (char *)&asclv, ' ', sizeof(asclv) );
	memcpy( asclv.fname, rascl->fname, sizeof(asclv.fname) );
	memcpy( asclv.clios, rascl->clios, sizeof(asclv.clios) );
	ret = PI_RDUEQ( regiv->isvfd, "KA", (char *)&asclv );
	memcpy( asclv.group, rascl->group, sizeof(asclv.group) ); 
	e_getsysdate( 31, asclv.verid, &asclv.verid[8] );
	asclv.opcode[0] = opcode;
	if( ret < 0 )
	{
		ret = PI_ADDIT( regiv->isvfd, (char *)&asclv );
		if( ret < 0 )
		{
l_errlog("CmRegAscl()","can't addit. fname=%.20s, clios=%c. iserrno=%d\n",
asclv.fname,asclv.clios[0],iserrno);
		}
	}
	else
	{
		ret = PI_UPDAT( regiv->isvfd, (char *)&asclv );
		if( ret < 0 )
		{
l_errlog("CmRegAscl()","can't updat. fname=%.20s, clios=%c. iserrno=%d\n",
asclv.fname,asclv.clios[0],iserrno);
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
	struct	asclFORM	*ascl;
	struct	reg_asclFORM	*rascl;

	ascl  = (struct asclFORM *)src;
	rascl = (struct reg_asclFORM *)dest;

	memcpy( rascl->fname	, ascl->fname	, sizeof(ascl->fname)	);
	memcpy( rascl->clios	, ascl->clios	, sizeof(ascl->clios)	);
	memcpy( rascl->group	, ascl->group	, sizeof(ascl->group)	);
	memcpy( rascl->dnpath	, ascl->dnpath	, sizeof(ascl->dnpath)	);
	memcpy( rascl->fsize	, ascl->fsize	, sizeof(ascl->fsize)	);
	memcpy( rascl->compress , ascl->compress, sizeof(ascl->compress));
	memcpy( rascl->csize	, ascl->csize	, sizeof(ascl->csize)	);
	memcpy( rascl->usid	, ascl->usid	, sizeof(ascl->usid)	);
}

/*----------------------------------------------------------------------*/
static	int
#if	defined(__CB_STDC__)
ll_chkdir( char *pszDir, char *fowner )
#else
ll_chkdir( pszDir, fowner )
char	*pszDir;
char	*fowner;
#endif
{
	int	nIdx;
	char	szTmpDir[60 + 1];

	if( access (pszDir, 00) == 0 )
		return( 0 );

	if( errno == ENOENT )
	{
		for(nIdx=strlen(pszDir)-2; nIdx>=0; nIdx--)
		{
#ifdef	WIN32
			if (pszDir[nIdx] == '\\')
				break;
			if (pszDir[nIdx] == ':')
			{
l_errlog("CmRegAscl()","%s is wrong\n",pszDir);
				return( -1 );
			}
#else
			if (pszDir[nIdx] == '/')
				break;
#endif
		}

		memcpy (szTmpDir, pszDir, nIdx);
		szTmpDir[nIdx] = '\0';

		if (ll_chkdir (szTmpDir, fowner) < 0)
			return( -1 );

#ifdef	WIN32
		if (mkdir (pszDir) == 0)
#else
		if (mkdir (pszDir, 0775) == 0)
#endif
		{
			f_chown(pszDir, fowner);
			return( 0 );
		}
	}
l_errlog("CmRegAscl()","%s error. errno=%d\n",pszDir,errno);
	return( -1 );
}

/*----------------------------------------------------------------------*/
static	void
#if	defined(__CB_STDC__)
ll_getfpath( char *clios, char *clivpath, char *fpath )
#else
ll_getfpath( clios, clivpath, fpath )
char	*clios;
char	*clivpath;
char	*fpath;
#endif
{
	strcpy( fpath, clivpath );
	switch( clios[0] )
	{
	case	'0' :
		strcat( fpath, "/dos/" );
		break;
	case	'1' :
		strcat( fpath, "/win31/" );
		break;
	case	'2' :
		strcat( fpath, "/win95/" );
		break;
	default :
		strcat( fpath, "/all/" );
		break;
	}
}
/*----------------------------------------------------------------------*/
/* end of CmRegAscl.c */
