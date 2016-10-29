/* PI_DVCHK() : LIB dsml */
/************************************************************************
*	check volume information					*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	volno			volume number		*
************************************************************************/

#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<iswrap.h>
#include	<errno.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	the volume convert to not genernate volume			|
+----------------------------------------------------------------------*/
static int CBD1
#if	defined( __CB_STDC__ )
lds_notgenvol( int fd, int volno )
#else
lds_notgenvol( fd, volno )
int	fd;
int	volno;
#endif
{
	int	volix;
	int	seq;

	if( volno == 0 )	/* this volume is master */
	{
		l_dsmlsethyerrno( EDS_MAST_FILE );
		return( -1 );
	}

	/* master volume open */
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );

	/* volume information update */
	seq = ds_getvolseq( fd, volno, &volix );
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)seq, (char *)&du.m.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( seq == 0 )
		du.m.vol[volix].volgen = DS_NOTGEN_VOLUME;
	else
		du.v.vol[volix].volgen = DS_NOTGEN_VOLUME;

	if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/* this volume delete */
	iserase( dsfi[fd].vol[volno].volpath );

	/* save master table */
	dsfi[fd].vol[volno].volgen = DS_NOTGEN_VOLUME;

	return( 0 );
}

/*----------------------------------------------------------------------+
|	check volume information					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DVCHK( int fd, int volno )
#else
PI_DVCHK( fd, volno )
int	fd;
int	volno;
#endif
{
	int		verno;
	int		doccnt = 0;
	int		mindocid = DS_MAX_DOC_ID + 1;
	int		maxdocid = -1;
	int		usedblkcnt = 0;
	int		reservblkcnt = 0;
	char		filepath[256];
	struct	stat	fs;

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

	if( volno < 0 || volno >= dsfi[fd].volcnt )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** invalid volume, convert to notgen volume
	**-------------------------------------------------------------*/
	if( dsfi[fd].vol[volno].volgen == DS_INVALID_VOLUME )
	{
		if( lds_notgenvol( fd, volno ) < 0 )
			return( -1 );
	}

	/*---------------------------------------------------------------
	** check volume generate status
	**-------------------------------------------------------------*/
	if( dsfi[fd].vol[volno].volgen == DS_NOTGEN_VOLUME )
		return( 0 );

	if( dsfi[fd].vol[volno].volgen != DS_GEN_VOLUME &&
	    dsfi[fd].vol[volno].volgen != DS_CGEN_VOLUME )
	{
		l_dsmlsethyerrno( EDS_CHECK_VOLUME );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** calculate volume information
	**-------------------------------------------------------------*/
	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );

	if( isread( dsfi[fd].isfd, (char *)&du, ISFIRST ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/* get statistics */
	for( ; ; )
	{
		usedblkcnt++;
		if( (int)ldlong( (char *)&du.h.seq ) == 0 &&
		    (int)ldlong( (char *)&du.h.id ) > 0 )
		{
			if( (int)ldlong( (char *)&du.h.id ) < mindocid )
				mindocid = (int)ldlong( (char *)&du.h.id );
			if( (int)ldlong( (char *)&du.h.id ) > maxdocid )
				maxdocid = (int)ldlong( (char *)&du.h.id );

			doccnt++;
		}

		if( isread( dsfi[fd].isfd, (char *)&du, ISNEXT ) < 0 )
			break;
	}

	/* get isam data size */
	strcpy( filepath, dsfi[fd].vol[volno].volpath );
	strcat( filepath, ".idx" );

	if( stat( filepath, &fs ) < 0 )
	{
		l_dsmlsethyerrno( errno );
		return( -1 );
	}

	reservblkcnt = fs.st_size / dsfi[fd].blksz / 1024 - usedblkcnt;
	if( reservblkcnt < 0 )
		reservblkcnt = 0;

	/*---------------------------------------------------------------
	** save statistics
	**-------------------------------------------------------------*/
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/* if real doccnt is zero and docid information is invalid, */
	/* the volume convert to not generate volume */
	if( doccnt == 0 &&
	    ( (int)ldlong( (char *)&du.m.mindocid ) < 0 ||
	      (int)ldlong( (char *)&du.m.mindocid ) > DS_MAX_DOC_ID ||
	      (int)ldlong( (char *)&du.m.maxdocid ) < 0 ||
	      (int)ldlong( (char *)&du.m.maxdocid ) > DS_MAX_DOC_ID ) )
	{
		return( lds_notgenvol( fd, volno ) );
	}

	if( doccnt == (int)ldlong( (char *)&du.m.doccnt ) &&
	    mindocid >= (int)ldlong( (char *)&du.m.mindocid ) &&
	    maxdocid <= (int)ldlong( (char *)&du.m.maxdocid ) &&
	    usedblkcnt != (int)ldlong( (char *)&du.m.usedblkcnt ) &&
	    reservblkcnt != (int)ldlong( (char *)&du.m.reservblkcnt ) )
	{
		return( 0 );
	}

	stlong( (long)doccnt, (char *)&du.m.doccnt );
	if( mindocid < (int)ldlong( (char *)&du.m.mindocid ) )
		stlong( (long)mindocid, (char *)&du.m.mindocid );
	if( maxdocid > (int)ldlong( (char *)&du.m.maxdocid ) )
		stlong( (long)maxdocid, (char *)&du.m.maxdocid );
	stlong( (long)usedblkcnt, (char *)&du.m.usedblkcnt );
	stlong( (long)reservblkcnt, (char *)&du.m.reservblkcnt );

	if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	dsfi[fd].vol[volno].doccnt = doccnt;
	dsfi[fd].vol[volno].mindocid = (int)ldlong( (char *)&du.m.mindocid );
	dsfi[fd].vol[volno].maxdocid = (int)ldlong( (char *)&du.m.maxdocid );
	dsfi[fd].vol[volno].usedblkcnt = doccnt;
	dsfi[fd].vol[volno].reservblkcnt = doccnt;

	return( 0 );
}

/******* The end of PI_DVCHK.c *****************************************/
