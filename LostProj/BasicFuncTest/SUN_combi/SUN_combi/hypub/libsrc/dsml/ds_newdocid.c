/* ds_newdocid() : LIB dsml */
/************************************************************************
*	Get new document ID						*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	verno	version number				*
*		  int	fsize	size of document file			*
*	return	: int	docid	ID for new document			*
************************************************************************/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	Get new document ID						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_newdocid( int fd, int verno, int fsize )
#else
ds_newdocid( fd, verno, fsize )
int	fd;
int	verno;
int	fsize;
#endif
{
	register	i, j;
	int		volno;
	int		datasize;
	int		id;
	int		seq;
	int		outcnt;
	unsigned char	*dfl;

	/*---------------------------------------------------------------
	** if version is 2, search volume and open it
	**-------------------------------------------------------------*/
	if( verno == 2 )
	{
		if( ( volno = ds_newvolno( fd, fsize ) ) < 0 )
			return( -1 );

		if( ds_volopen( fd, volno ) < 0 )
			return( -1 );
	}

	/*---------------------------------------------------------------
	** search last delete page
	** if not exist delete page, get last document id
	**-------------------------------------------------------------*/
	if( verno < 2 )
	{
		stint( 1, (char *)&du.o1.id );
		stint( 0, (char *)&du.o1.seq );
	}
	else
	{
		stlong( (long)1, (char *)&du.o.id );
		stlong( (long)0, (char *)&du.o.seq );
	}

	if( DP_REDLT( fd, verno, du ) < 0 ||
	    ( verno == 2 && (int)ldlong( (char *)&du.o.id ) < 0 ) )
	{
		if( verno < 2 )
		{
			/* search last document ID in use */
			if( DP_REDLAST( fd, verno, du ) < 0 )
				return( 1 );

			id = ldint( (char *)&du.h1.id );
			if( id == 0x7fff )
			{
				l_dsmlsethyerrno( EDS_FULLID );
				return( -1 );
			}

			/* return new document ID is last document ID plus 1 */
			return( id + 1 );
		}
		else
		{
			if( isread( dsfi[fd].isfd, (char *)&du, ISLAST ) < 0 ||
			    (int)ldlong( (char *)&du.h.id ) < 1 )
			{
				return( dsfi[fd].vol[volno].mindocid );
			}

			id = (int)ldlong( (char *)&du.h.id );
			if( id == dsfi[fd].vol[volno].maxdocid )
			{
				l_dsmlsethyerrno( EDS_FULLID );
				return( -1 );
			}

			/* return new document ID is last document ID plus 1 */
			return( id + 1 );
		}
	}

	/*---------------------------------------------------------------
	** searched last delete page.  update read for change this page
	**-------------------------------------------------------------*/
	if( DP_RDUEQ( fd, verno, du ) < 0 )
	{
		if( verno )
			l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** search a deleted ID
	**-------------------------------------------------------------*/
	if( verno < 2 )
	{
		seq = ldint( (char *)&du.o1.seq );
		datasize = sizeof du.o1.dfl;
		outcnt = ldint( (char *)&du.o1.outcnt );
	}
	else
	{
		seq = (int)ldlong( (char *)&du.o.seq );
		datasize = dsfi[fd].blksz * 1024 - DS_DEL_HEADSZ - 1;
		outcnt = (int)ldlong( (char *)&du.o.outcnt );
	}

	for( i=datasize-1; i>=0; i-- )
	{
		dfl = verno == 2 ? &du.o.dfl[i] : &du.o1.dfl[i];

		if( !*dfl )
			continue;

		for( j=7; j>=0; j-- )
		{
			if( !( *dfl & ( 1 << j ) ) )
				continue;

			if( outcnt > 1 )
			{
				*dfl &= (unsigned char) ~( 1 << j );
				outcnt--;
				if( verno < 2 )
				{
					stint( (short)outcnt,
							(char *)&du.o1.outcnt );
				}
				else
				{
					stlong( (long)outcnt,
							(char *)&du.o.outcnt );
				}

				if( DP_UPDATE( fd, verno, du ) < 0 )
				{
					if( verno )
						l_dsmlsethyerrno( iserrno );
					return( -1 );
				}
			}
			else
			{
				if( DP_DELETE( fd, verno, du ) < 0 )
				{
					if( verno )
						l_dsmlsethyerrno( iserrno );
					return( -1 );
				}

				if( verno == 2 )
					if( ds_usedblkcnt( fd, -1, 0 ) < 0 )
						return( -1 );
			}

			return( ( seq * datasize + i ) * 8 + j );

		} /* end of for one byte */

	} /* end of for dfl */

	l_dsmlsethyerrno( EDS_BADDELPAGE );
	return( -1 );

}

/******* The end of ds_newdocid.c **************************************/
