/* ds_splitvol() : LIB dsml internal function */
/************************************************************************
*	Search volume to insert new document				*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	volno	volume number to split			*
************************************************************************/

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	Search volume to insert new document				|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_splitvol( int fd, int volno )
#else
ds_splitvol( fd, volno )
int	fd;
int	volno;
#endif
{
	register	volix;
	char		volsts;

	if( dsfi[fd].vol[volno].maxdocid == DS_MAX_DOC_ID )
		volsts = DS_SECOND_VOLUME;
	else
		volsts = DS_CHILD_VOLUME;

	/*---------------------------------------------------------------
	** search new volume that is not generated, and generate it
	**-------------------------------------------------------------*/
	for( volix=0; volix<dsfi[fd].volcnt; volix++ )
	{
		if( dsfi[fd].vol[volix].volgen != DS_NOTGEN_VOLUME )
			continue;

		if( dsfi[fd].vol[volix].maxblkcnt <
			dsfi[fd].vol[volno].maxblkcnt / 2 )
		{
			continue;
		}

		if( ds_volgen( fd, volix, volsts ) < 0 )
			return( -1 );

		break;
	}

	if( volix >= dsfi[fd].volcnt )
	{
		l_dsmlsethyerrno( EDS_NOMORE_SPACE );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** move documents
	**-------------------------------------------------------------*/
	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );

	if( ds_movedoc( fd, volno, volix ) < 0 )
		return( -1 );

	return( 0 );
}

/******* The end of ds_splitvol.c **************************************/
