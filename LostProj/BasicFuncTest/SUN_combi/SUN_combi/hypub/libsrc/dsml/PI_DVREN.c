/* PI_DVREN() : LIB dsml */
/************************************************************************
*	rename volume path	 					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	*svolpath		volume path		*
*		  char	*dvolpath		volume path		*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	add new volume							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DVREN( int fd, char *svolpath, char *dvolpath )
#else
PI_DVREN( fd, svolpath, dvolpath )
int	fd;
char	*svolpath;
char	*dvolpath;
#endif
{
	char	l_svolpath[DS_PATHLEN];
	char	l_dvolpath[DS_PATHLEN];
	int	verno;
	int	seq;
	int	chgvolno;
	int	volno;
	int	volix;
	int	i;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return -1;

	if( !dsfi[fd].filepath[0] )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}

	if( dsfi[fd].verno[0] != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( dsfi[fd].volsts != DS_MASTER_VOLUME )
	{
		l_dsmlsethyerrno( EDS_MUST_OPEN_MASTER );
		return( -1 );
	}

	if( svolpath == (char *)0 || dvolpath == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}
#ifdef	WIN32
	if( svolpath[0] != '/' )
#else
	if( svolpath[1] != ':' || svolpath[2] != '\\' )
#endif
	{
		if( ds_fullpath( svolpath, l_svolpath ) < 0 )
			return( -1 );
	}
	else
	{
		strcpy( l_svolpath, svolpath );
	}
		if( ds_fullpath( dvolpath, l_dvolpath ) < 0 )
			return( -1 );

	if( !strcmp( l_svolpath, l_dvolpath ) )
	{
		l_dsmlsethyerrno( EDS_SAME_PATH );
		return( -1 );
	}

	for( i = 0; i < dsfi[fd].volcnt; i++ )
	{
		if( !strcmp( dsfi[fd].vol[i].volpath, l_dvolpath ) )
		{
			l_dsmlsethyerrno( EDS_EXIST_VOLUME );
			return -1;
		}
	}
	/*---------------------------------------------------------------
	** find volume index in master table
	**-------------------------------------------------------------*/
	for( chgvolno=0; strcmp( dsfi[fd].vol[chgvolno].volpath, l_svolpath ); )
	{
		if( ++chgvolno >= dsfi[fd].volcnt )
		{
			l_dsmlsethyerrno( EDS_INVAL_ARG );
			return( -1 );
		}
	}

	/* if the volume is master volume, error */
	if( chgvolno == 0 )
	{
		l_dsmlsethyerrno( EDS_MAST_FILE );
		return( -1 );
	}

	if( dsfi[fd].vol[chgvolno].volgen != DS_GEN_VOLUME &&
	    dsfi[fd].vol[chgvolno].volgen != DS_CGEN_VOLUME &&
	    dsfi[fd].vol[chgvolno].volgen != DS_INVALID_VOLUME &&
	    dsfi[fd].vol[chgvolno].volgen != DS_NOTGEN_VOLUME )
	{
		l_dsmlsethyerrno( EDS_INVAL_VOLUME );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** storing changed volume information to master table
	**-------------------------------------------------------------*/
	memset( dsfi[fd].vol[chgvolno].volpath, 0, DS_PATHLEN );
	strcpy( dsfi[fd].vol[chgvolno].volpath, l_dvolpath );

	/*---------------------------------------------------------------
	** storing changed volume information to isam file
	**-------------------------------------------------------------*/
	seq = ds_getvolseq( fd, chgvolno, &volix );

	for( volno=0; ; volno=chgvolno, seq=0, volix=1 )
	{
		/* open volume */
		if( ds_volopen( fd, volno ) < 0 )
		{
			memset( dsfi[fd].vol[chgvolno].volpath, 0, DS_PATHLEN );
			strcpy( dsfi[fd].vol[chgvolno].volpath, l_svolpath );
			return( -1 );
		}

		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)seq, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			memset( dsfi[fd].vol[chgvolno].volpath, 0, DS_PATHLEN );
			strcpy( dsfi[fd].vol[chgvolno].volpath, l_svolpath );
			return( -1 );
		}

		if( seq == 0 )	/* the volume exist in first volume page */
		{
			memset( du.m.vol[volix].volpath, 0, DS_PATHLEN );
			strcpy( du.m.vol[volix].volpath, l_dvolpath );
		}
		else	/* the volume exist in second volume page */
		{
			memset( du.v.vol[volix].volpath, 0, DS_PATHLEN );
			strcpy( du.v.vol[volix].volpath, l_dvolpath );
		}

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			memset( dsfi[fd].vol[chgvolno].volpath, 0, DS_PATHLEN );
			strcpy( dsfi[fd].vol[chgvolno].volpath, l_svolpath );
			return( -1 );
		}

		if( volno == chgvolno )
			break;

		if( dsfi[fd].vol[chgvolno].volgen == DS_NOTGEN_VOLUME )
			break;
		else if( dsfi[fd].vol[chgvolno].volgen == DS_INVALID_VOLUME )
			dsfi[fd].vol[chgvolno].volgen = DS_GEN_VOLUME;
	} /* end of for ( for generated volume ) */

	return( 0 );
}

/******* The end of PI_DVREN.c *****************************************/
