/* ds_volgen() : LIB dsml internal function */
/************************************************************************
*	generate new volume						*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  int	volno			volume number		*
*		  char	volsts			volume flag		*
************************************************************************/

#include	<stdlib.h>
#include	<string.h>
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
|	generate new volume						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_volgen( int fd, int volno, char volsts )
#else
ds_volgen( fd, volno, volsts )
int	fd;
int	volno;
char	volsts;
#endif
{
	int		isfd;
	struct	keydesc ckey;
	int		maxdocid;
	int		volix;
	int		seq;

	/*---------------------------------------------------------------
	** open last volume in use, write new maxdocid
	**-------------------------------------------------------------*/
	if( volsts == DS_SECOND_VOLUME )
	{
		for( volix=0; volix<dsfi[fd].volcnt; volix++ )
		{
			if( dsfi[fd].vol[volix].volgen != DS_GEN_VOLUME )
				continue;

			if( dsfi[fd].vol[volix].maxdocid == DS_MAX_DOC_ID )
				break;
		}

		if( volix >= dsfi[fd].volcnt )
		{
			l_dsmlsethyerrno( EDS_NOMORE_SPACE );
			return( -1 );
		}

		if( ds_volopen( fd, volix ) < 0 )
			return( -1 );

		if( isread( dsfi[fd].isfd, (char *)&du, ISLAST ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		if( ( maxdocid = (int)ldlong( (char *)&du.h.id ) ) < 1 )
		{
			l_dsmlsethyerrno( EDS_FATAL_DSML );
			return( -1 );
		}

		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)0, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}

		stlong( (long)maxdocid, (char *)&du.m.maxdocid );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		dsfi[fd].vol[volix].maxdocid = maxdocid;

	} /* end of if( volume is second ) */

	/*---------------------------------------------------------------
	** Build isam file with primary key
	**-------------------------------------------------------------*/
	ckey.k_flags = ISNODUPS;
	ckey.k_nparts = 2;
	ckey.k_len = 2 * LONGSIZE;
	ckey.k_rootnode = 0;
	ckey.k_part[0].kp_start = 0;
	ckey.k_part[0].kp_leng	= LONGSIZE;
	ckey.k_part[0].kp_type = LONGTYPE;
	ckey.k_part[1].kp_start = LONGSIZE;
	ckey.k_part[1].kp_leng	= LONGSIZE;
	ckey.k_part[1].kp_type = LONGTYPE;

	if( ( isfd = isbuild( dsfi[fd].vol[volno].volpath,
		dsfi[fd].blksz * 1024 - 1, &ckey, ISINOUT + ISMANULOCK ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		if( volsts == DS_SECOND_VOLUME )
			dsfi[fd].vol[volix].maxdocid = DS_MAX_DOC_ID;
		return( -1 );
	}

	/*---------------------------------------------------------------
	** Write DSML master information
	**-------------------------------------------------------------*/
	memset( &du, 0, sizeof du );
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	strcpy( du.m.version, DS_VERSION );
	du.m.volsts = volsts;
	stlong( (long)0, (char *)&du.m.doccnt );
	if( volsts == DS_SECOND_VOLUME )
	{
		stlong( (long)( maxdocid + 1 ), (char *)&du.m.mindocid );
		stlong( (long)DS_MAX_DOC_ID, (char *)&du.m.maxdocid );
	}
	else
	{
		stlong( (long)-1, (char *)&du.m.mindocid );
		stlong( (long)-1, (char *)&du.m.maxdocid );
	}
	stlong( (long)1, (char *)&du.m.usedblkcnt );
	stlong( (long)0, (char *)&du.m.reservblkcnt );
	stint( dsfi[fd].blksz, (char *)&du.m.blksz );
	stint( 2, (char *)&du.m.volcnt );
	stint( 2, (char *)&du.m.thisvolcnt );

	strcpy( du.m.vol[0].volpath, dsfi[fd].vol[0].volpath );
	stlong( (long)dsfi[fd].vol[0].maxblkcnt,
					(char *)&du.m.vol[0].maxblkcnt );
	du.m.vol[0].volgen = DS_GEN_VOLUME;

	strcpy( du.m.vol[1].volpath, dsfi[fd].vol[volno].volpath );
	stlong( (long)dsfi[fd].vol[volno].maxblkcnt,
					(char *)&du.m.vol[1].maxblkcnt );
	du.m.vol[1].volgen = DS_GEN_VOLUME;

	if( iswrite( isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		if( volsts == DS_SECOND_VOLUME )
			dsfi[fd].vol[volix].maxdocid = DS_MAX_DOC_ID;
		isclose( isfd );
		iserase( dsfi[fd].vol[volno].volpath );
		return( -1 );
	}

	isclose( isfd );

	/*---------------------------------------------------------------
	** save DSML master information to table
	**-------------------------------------------------------------*/
	/* head information */
	dsfi[fd].vol[volno].doccnt = 0;
	if( volsts == DS_SECOND_VOLUME )
	{
		dsfi[fd].vol[volno].mindocid = maxdocid + 1;
		dsfi[fd].vol[volno].maxdocid = DS_MAX_DOC_ID;
		dsfi[fd].vol[volno].volgen = DS_GEN_VOLUME;
	}
	else
	{
		dsfi[fd].vol[volno].mindocid = -1;
		dsfi[fd].vol[volno].maxdocid = -1;
		dsfi[fd].vol[volno].volgen = DS_CGEN_VOLUME;
	}
	dsfi[fd].vol[volno].usedblkcnt = 1;
	dsfi[fd].vol[volno].reservblkcnt = 0;

	/*---------------------------------------------------------------
	** save DSML master information to table
	**-------------------------------------------------------------*/
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );

	seq = ds_getvolseq( fd, volno, &volix );

	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)seq, (char *)&du.m.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( seq == 0 )
		du.m.vol[volix].volgen = DS_GEN_VOLUME;
	else
		du.v.vol[volix].volgen = DS_GEN_VOLUME;

	if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}
		
	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );

	return( 0 );
}

/******* The end of ds_volgen.c ****************************************/
