/* PI_DVDEL() : LIB dsml */
/************************************************************************
*	delete volume							*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		  char	*volpath		volume path		*
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
PI_DVDEL( int fd, char *volpath )
#else
PI_DVDEL( fd, volpath )
int	fd;
char	*volpath;
#endif
{
	register	i;
	register	seqno;
	int		verno;
	char		l_volpath[DS_PATHLEN];
	int		delvolno;
	int		maxseq;
	int		seq;
	int		volix;
	int		tvolix;
	int		thisvolcnt;
	struct	volFORM	l_vol;

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

	if( volpath == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_fullpath( volpath, l_volpath ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** find volume index in master table
	**-------------------------------------------------------------*/
	for( delvolno=0; strcmp( dsfi[fd].vol[delvolno].volpath, l_volpath ); )
	{
		if( ++delvolno >= dsfi[fd].volcnt )
		{
			l_dsmlsethyerrno( EDS_INVAL_ARG );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** check whether the volume can delete
	**-------------------------------------------------------------*/
	/* if the volume is master volume, error */
	if( delvolno == 0 )
	{
		l_dsmlsethyerrno( EDS_MAST_FILE );
		return( -1 );
	}

	/* if the volume created already, error */
	if( dsfi[fd].vol[delvolno].volgen != DS_NOTGEN_VOLUME )
	{
		l_dsmlsethyerrno( EDS_USED_FILE );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** storing changed volume information to isam file
	**-------------------------------------------------------------*/
	/* last volume page no */
	maxseq = ds_getvolseq( fd, dsfi[fd].volcnt - 1, &volix );
	/* current volume page no */
	seq = ds_getvolseq( fd, delvolno, &volix );

	/* open volume */
	if( ds_volopen( fd, 0 ) < 0 )
		return( -1 );

	/* delete volno volume */
	/* Move first volume of next volume page */
	/* to last volume of current volume page. */
	for( seqno=seq, tvolix=volix; seqno<=maxseq; seqno++, tvolix=0 )
	{
		/* copy first volume informatin of next volume page */
		if( seqno != maxseq )
		{
			stlong( (long)-1, (char *)&du.v.id );
			stlong( (long)( seqno + 1 ), (char *)&du.v.seq );

			if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
			{
				l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
				return( -1 );
			}

			memcpy( &l_vol, &du.v.vol[0], sizeof l_vol );
		}
		else
			memset( &l_vol, 0, sizeof l_vol );

		/* read current volume page */
		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)seqno, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}

		/* delete volume information from current volume page */
		if( seqno == 0 )
		{	/* the volume exist in first volume page */
			stint( ldint( (char *)&du.m.volcnt ) - 1,
							(char *)&du.m.volcnt );

			thisvolcnt = ldint( (char *)&du.m.thisvolcnt );

			for( i=tvolix; i<thisvolcnt-1; i++ )
				memcpy( &du.m.vol[i], &du.m.vol[i+1],
						sizeof du.m.vol[i] );

			memcpy( &du.m.vol[i], &l_vol, sizeof l_vol );

			if( seqno == maxseq )
			{
				thisvolcnt--;
				stint( (short)thisvolcnt,
						(char *)&du.m.thisvolcnt );
			}
		}
		else	/* the volume exist in second volume page */
		{
			thisvolcnt = ldint( (char *)&du.v.thisvolcnt );

			for( i=tvolix; i<thisvolcnt-1; i++ )
				memcpy( &du.v.vol[i], &du.v.vol[i+1],
							sizeof du.v.vol[i] );

			memcpy( &du.v.vol[i], &l_vol, sizeof l_vol );

			if( seqno == maxseq )
			{
				thisvolcnt--;
				stint( (short)thisvolcnt,
						(char *)&du.v.thisvolcnt );
			}
		}

		if( thisvolcnt == 0 ) /* last volume page */
		{
			if( isdelcurr( dsfi[fd].isfd ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}

			if( ds_usedblkcnt( fd, -1, 0 ) < 0 )
				return( -1 );
		}
		else
		{
			if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
			{
				l_dsmlsethyerrno( iserrno );
				return( -1 );
			}
		}
	} /* end of for ( delete volume information ) */

	/* if volume deleted to second volume page, */
	/* decrease count of all volume in first volume page. */
	/* if volume deleted to first volume page, decreased it already */
	if( seq != 0 )
	{
		stlong( (long)-1, (char *)&du.m.id );
		stlong( (long)0, (char *)&du.m.seq );

		if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
		{
			l_dsmlsethyerrno( EDS_INVAL_MAST_INFO );
			return( -1 );
		}

		stint( ldint( (char *)&du.m.volcnt ) - 1,
							(char *)&du.m.volcnt );

		if( isrewcurr( dsfi[fd].isfd, (char *)&du ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** deleting volume information to delete from master table
	**-------------------------------------------------------------*/
	dsfi[fd].volcnt--;
	for( i=delvolno; i<dsfi[fd].volcnt; i++ )
	{
		memcpy( &dsfi[fd].vol[i], &dsfi[fd].vol[i+1],
						sizeof dsfi[fd].vol[i] );
	}

	/* not free useless memory */
	memset( &dsfi[fd].vol[i], 0, sizeof dsfi[fd].vol[i] );

	return( 0 );
}

/******* The end of PI_DVDEL.c *****************************************/
