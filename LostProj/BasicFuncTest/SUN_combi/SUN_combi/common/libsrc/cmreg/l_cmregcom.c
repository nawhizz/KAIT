/* l_cmregcom.c */
/*----------------------------------------------------------------------*/
/* FUNC : generate file							*/
/*----------------------------------------------------------------------*/
/* cmreg internal function */
#include	<stdio.h>	/*sprintf*/
#include	<string.h>	/*strcat,strcpy,strlen*/
#include	<stdlib.h>	/*getenv*/

#ifdef	WIN32
#include	<io.h>		/*access*/
#define		F_OK	0
#else
#include	<unistd.h>	/*access*/
#endif

#include	<errno.h>	/*errno*/
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"cmreg.h"
#include	"cmregdef.h"

/*----------------------------------------------------------------------*/
/* FUNC : Internal							*/
/*----------------------------------------------------------------------*/
int
#if	defined(__CB_STDC__)
l_chownmod( char *cfgpath, char *dpath )
#else
l_chownmod( cfgpath, dpath )
char	*cfgpath;
char	*dpath;
#endif
{
	char	datapath[128], owner[9];

	tracelog("l_chownmod(). start\n");
	if( cfg_getenv( cfgpath, "", "FILEOWNER", owner ) < 0 )
	{
		if( cfg_getenv( cfgpath, "", "MYOWNER", owner ) < 0 )
		{
l_errlog("l_chownmod()","Not found myowner. errno(%d). cfg is %s\n",cfgpath,errno);
			l_sethyerrno( ECMR_NOTMYOWNER );
			tracelog("l_chownmod(). error. FILEOWNER\n");
			return( -1 );
		}
	}

	strcpy( datapath, dpath );
	strcat( datapath, ".dat" );
	/* change owner, group of '.dat' file */
	if( f_chown( datapath, owner ) < 0 )
	{
l_errlog("l_chownmod()","f_chown() error. errno(%d). file is %s\n",errno,datapath);
		tracelog("l_chownmod(). error. f_chown(.dat)\n");
		return -1;
	}
	/* change mode of '.dat' file */
	if( f_chmod( datapath, 0664 ) < 0 )
	{
l_errlog("l_chownmod()","f_chmod() error. errno(%d). file is %s\n",errno,datapath);
		tracelog("l_chownmod(). error. f_chmod(.dat)\n");
		return -1;
	}

	datapath[strlen(datapath)-4] = '\0';
	strcat( datapath, ".idx" );
	/* change owner, group of '.idx' file */
	if( f_chown( datapath, owner ) < 0 )
	{
l_errlog("l_chownmod()","f_chown() error. errno(%d). file is %s\n",errno,datapath);
		tracelog("l_chownmod(). error. f_chown(.idx)\n");
		return -1;
	}
	/* change mode of '.idx' file */
	if( f_chmod( datapath, 0664 ) < 0 )
	{
l_errlog("l_chownmod()","f_chmod() error. errno(%d). file is %s\n",errno,datapath);
		tracelog("l_chownmod(). error. f_chmod(.idx)\n");
		return -1;
	}
	tracelog("l_chownmod(). end\n");
	return 0;
}

/*----------------------------------------------------------------------*/
/* FUNC : External							*/
/*----------------------------------------------------------------------*/
void
#if	defined(__CB_STDC__)
l_reginit( REG_INTVAL *regiv, char *regdata, char action )
#else
l_reginit( regiv, regdata, action )
REG_INTVAL	*regiv;
char		*regdata;
char		action;
#endif
{
	tracelog("l_reginit(). start\n");
	regiv->isfd	 = -1;
	regiv->isvfd	 = -1;
	regiv->action	 = action;
	regiv->datarec	 = regdata;
	tracelog("l_reginit(). end\n");
}

/*----------------------------------------------------------------------*/
int
#if	defined(__CB_STDC__)
l_regopen( REG_INTVAL *regiv, char *cfgpath, char *datapath, char *fileid )
#else
l_regopen( regiv, cfgpath, datapath, fileid )
REG_INTVAL	*regiv;
char		*cfgpath;
char		*datapath;
char		*fileid;
#endif
{
	char	vfileid[8];
	int	retval;

	tracelog("l_regopen(). start\n");
	if( regiv->action == REG_READ )
	{
		regiv->isfd = PI_OPEN( datapath, fileid );
		if( regiv->isfd < 0 )
		{
l_errlog("l_regopen()","%s open error. iserrno(%d)\n",datapath,iserrno);
tracelog("l_regopen(). error. PI_OPEN. fileid=%s\n",fileid);
			return( -1 );
		}
		tracelog("l_regopen(). end\n");
		return( 0 );
	}

	/* version file id. ie. fileid is usid then vfileid is usidv */
	strcpy( vfileid, fileid );
	strcat( vfileid, "v" );

	/* file open */
	strcat( datapath, ".dat" );
	retval = access( datapath, F_OK );
	datapath[strlen(datapath)-4]='\0';
	if( cm_transtart )
	{
		if( retval < 0 )
		{
			regiv->isfd = PI_TRCROPEN( datapath, fileid );
			if( regiv->isfd < 0 )
			{
l_errlog("l_regopen()","%s TRCR open error. iserrno(%d)\n",datapath,iserrno);
				tracelog("l_regopen(). error. PI_OPEN\n");
				return( -1 );
			}
		}
		else
		{
			regiv->isfd = PI_TROPEN( datapath, fileid );
			if( regiv->isfd < 0 )
			{
l_errlog("l_regopen()","%s TR open error. iserrno(%d)\n",datapath,iserrno);
				tracelog("l_regopen(). error. PI_OPEN\n");
				return( -1 );
			}
		}
	}
	else
	{
		regiv->isfd = PI_CROPEN( datapath, fileid );
		if( regiv->isfd < 0 )
		{
l_errlog("l_regopen()","%s CR open error. iserrno(%d)\n",datapath,iserrno);
			tracelog("l_regopen(). error. PI_OPEN\n");
			return( -1 );
		}
	}
	if( (retval < 0) && cfgpath[0] )
	{
		if( l_chownmod( cfgpath, datapath ) < 0 )
		{
			tracelog("l_regopen(). error. l_chownmod\n");
			return( -1 );
		}
	}

	/* version file open */
	strcat( datapath, "v.dat" );
	retval = access( datapath, F_OK );
	datapath[strlen(datapath)-4]='\0';
	if( cm_transtart )
	{
		if( retval < 0 )
		{
			regiv->isvfd = PI_TRCROPEN( datapath, vfileid );
			if( regiv->isvfd < 0 )
			{
l_errlog("l_regopen()","%s TRCR open error. iserrno(%d)\n",datapath,iserrno);
				tracelog("l_regopen(). error. PI_OPEN(v)\n");
				return( -1 );
			}
		}
		else
		{
			regiv->isvfd = PI_TROPEN( datapath, vfileid );
			if( regiv->isvfd < 0 )
			{
l_errlog("l_regopen()","%s TR open error. iserrno(%d)\n",datapath,iserrno);
				tracelog("l_regopen(). error. PI_OPEN(v)\n");
				return( -1 );
			}
		}
	}
	else
	{
		regiv->isvfd = PI_CROPEN( datapath, vfileid );
		if( regiv->isvfd < 0 )
		{
l_errlog("l_regopen()","%s CR open error. iserrno(%d)\n",datapath,iserrno);
			tracelog("l_regopen(). error. PI_OPEN(v)\n");
			return( -1 );
		}
	}
	if( (retval < 0) && cfgpath[0] )
	{
		if( l_chownmod( cfgpath, datapath ) < 0 )
		{
			tracelog("l_regopen(). error. l_chownmod(v)\n");
			return( -1 );
		}
	}

	tracelog("l_regopen(). end\n");
	return( 0 );
}

/*----------------------------------------------------------------------*/
void
#if	defined(__CB_STDC__)
l_regclose( REG_INTVAL *regiv )
#else
l_regclose( regiv )
REG_INTVAL	*regiv;
#endif
{
	tracelog("l_regclose(). start\n");
	if( regiv->isfd >= 0 )
		PI_CLOSE( regiv->isfd );
	if( regiv->isvfd >= 0 )
		PI_CLOSE( regiv->isvfd );
	tracelog("l_regclose(). end\n");
}

/*----------------------------------------------------------------------*/
int
#if	defined(__CB_STDC__)
l_reggetascfg( char *asid, char *ascfgpath )
#else
l_reggetascfg( asid, ascfgpath )
char	*asid;
char	*ascfgpath;
#endif
{
	int	i;
	char	*tphome, *tpid, asini[20], ascfgnm[20], tpcfg[128];

	tphome = (char *)getenv( "TPHOME" );
	if( tphome == NULL )
	{
		l_sethyerrno( ECMR_UNDEFTPHOME );
l_errlog("l_reggetascfg()","Undefind TPHOME. errno(%d)\n",errno);
		tracelog("l_reggetascfg(). error. UNDEFINE TPHOME\n");
		return( -1 );
	}

	tpid = (char *)getenv( "TPID" );
	if( tpid == NULL )
	{
		l_sethyerrno( ECMR_UNDEFTPID );
l_errlog("l_reggetascfg()","Undefind TPID. errno(%d)\n",errno);
		tracelog("l_reggetascfg(). error. UNDEFINE TPID\n");
		return( -1 );
	}

	sprintf( tpcfg, "%s/startup/tp%s.cfg", tphome, tpid );

	for( i=0; i<LEN_ASID; i++ )
	{
		if( asid[i] == ' ' )
			break;
		ascfgnm[i] = asid[i];
	}
	ascfgnm[i] = '\0';
	strcat( ascfgnm, "CFG" );

	if( cfg_getenv( tpcfg, "ASCFG", ascfgnm, asini ) < 0 )
	{
l_errlog("l_reggetascfg()","Not found ASCFG(%s) at %s. errno(%d)\n",ascfgnm,tpcfg,errno);
		l_sethyerrno( ECMR_ASIDNOTFOUND );
		tracelog("l_reggetascfg(). error. asid not found\n");
		return( -1 );
	}

	sprintf( ascfgpath, "%s/startup/%s.cfg", tphome, asini );
	return( 0 );
}
/* end of l_cmregcom.c */
