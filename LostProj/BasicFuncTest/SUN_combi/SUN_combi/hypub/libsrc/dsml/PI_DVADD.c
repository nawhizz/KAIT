/* PI_DVADD() : LIB dsml */
/************************************************************************
*	add new volume							*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  struct VOLFORM *vol_inf	volume information	*
************************************************************************/

#include	<string.h>
#include	<stdlib.h>
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
PI_DVADD( int fd, struct VOLFORM *vol_inf )
#else
PI_DVADD( fd, vol_inf )
int		fd;
struct	VOLFORM	*vol_inf;
#endif
{
	struct	VOLFORM	l_vol_inf;
	int		verno;
	int		seq;
	int		volix;
	char		*tmpaddr;

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

	if( vol_inf == (struct VOLFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_chkvolinf( vol_inf, &l_vol_inf ) < 0 )
		return( -1 );

	for( volix=0; volix<dsfi[fd].volcnt; volix++ )
	{
		if( !strcmp( l_vol_inf.volpath, dsfi[fd].vol[volix].volpath ) )
		{
			l_dsmlsethyerrno( EDS_EXIST_VOLUME );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** reallocate volume information table
	**-------------------------------------------------------------*/
	tmpaddr = (char *)realloc( dsfi[fd].vol,
			( dsfi[fd].volcnt + 1 ) * sizeof( struct DS_VOLINFO ) );
	if( tmpaddr == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		return( -1 );
	}
	dsfi[fd].vol = (struct DS_VOLINFO *)tmpaddr;
	memset( &dsfi[fd].vol[dsfi[fd].volcnt], 0, sizeof( struct DS_VOLINFO ));

	/*---------------------------------------------------------------
	** storing new volume information to isam file
	**-------------------------------------------------------------*/
	seq = ds_getvolseq( fd, dsfi[fd].volcnt, &volix );
	if( seq > DS_MAX_VOL_SEQ )
	{
		l_dsmlsethyerrno( EDS_TOOMANY_VOLUME );
		return( -1 );
	}

	/* open volume */
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );

	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)seq, (char *)&du.m.seq );

	if( volix )	/* volume page exist */
	{
		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}
	}
	else		/* need new volume page */
	{
		memset( &du, 0, sizeof du );
		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)seq, (char *)&du.m.seq );
	}

	if( seq == 0 )	/* new volume insert to first volume page */
	{
		stint( ldint( (char *)&du.m.volcnt ) + 1,
							(char *)&du.m.volcnt );

		stint( ldint( (char *)&du.m.thisvolcnt ) + 1,
						(char *)&du.m.thisvolcnt );

		memset( du.m.vol[volix].volpath, 0, DS_PATHLEN );
		strcpy( du.m.vol[volix].volpath, l_vol_inf.volpath );
		stlong( (long)( l_vol_inf.maxvolsz * 1024 / dsfi[fd].blksz ),
					(char *)&du.m.vol[volix].maxblkcnt );
		du.m.vol[volix].volgen = DS_NOTGEN_VOLUME;
	}
	else	/* new volume insert to second volume page */
	{
		stint( ldint( (char *)&du.v.thisvolcnt ) + 1,
						(char *)&du.v.thisvolcnt );

		memset( du.v.vol[volix].volpath, 0, DS_PATHLEN );
		strcpy( du.v.vol[volix].volpath, l_vol_inf.volpath );
		stlong( (long)( l_vol_inf.maxvolsz * 1024 / dsfi[fd].blksz ),
				(char *)&du.v.vol[volix].maxblkcnt );
		du.v.vol[volix].volgen = DS_NOTGEN_VOLUME;
	}

	if( volix )
	{
		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}
	else
	{
		if( iswrite( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}

		if( ds_usedblkcnt( fd, 1, 0 ) < 0 )
			return( -1 );
	}

	/* if volume inserted to second volume page, */
	/* increase count of all volume in first volume page. */
	/* if volume inserted to first volume page, increased it already */
	if( seq != 0 )
	{
		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)0, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}

		stint( ldint( (char *)&du.m.volcnt ) + 1,
							(char *)&du.m.volcnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** storing new volume information to master table
	**-------------------------------------------------------------*/
	dsfi[fd].vol[dsfi[fd].volcnt].doccnt = 0;
	dsfi[fd].vol[dsfi[fd].volcnt].mindocid = -1;
	dsfi[fd].vol[dsfi[fd].volcnt].maxdocid = -1;
	dsfi[fd].vol[dsfi[fd].volcnt].usedblkcnt = 0;
	dsfi[fd].vol[dsfi[fd].volcnt].reservblkcnt = 0;

	strcpy( dsfi[fd].vol[dsfi[fd].volcnt].volpath, l_vol_inf.volpath );
	dsfi[fd].vol[dsfi[fd].volcnt].maxblkcnt =
				l_vol_inf.maxvolsz * 1024 / dsfi[fd].blksz;
	dsfi[fd].vol[dsfi[fd].volcnt].volgen = DS_NOTGEN_VOLUME;

	dsfi[fd].volcnt ++;
	
	return( 0 );
}

/******* The end of PI_DVADD.c *****************************************/
