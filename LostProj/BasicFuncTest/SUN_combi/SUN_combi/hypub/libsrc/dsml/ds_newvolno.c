/* ds_newvolno() : LIB dsml internal function */
/************************************************************************
*	Search volume to insert new document				*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	fsize	size of document file			*
*	return	: int	volno	volume number to insert new document	*
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
ds_newvolno( int fd, int fsize )
#else
ds_newvolno( fd, fsize )
int	fd;
int	fsize;
#endif
{
	register		volno;
	int			reqblkcnt;
	struct	DS_VOLINFO	*tvol;

	/*---------------------------------------------------------------
	** calculate require block count for new document
	**-------------------------------------------------------------*/
	fsize -= dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;

	for( reqblkcnt=1; fsize>0; reqblkcnt++ )
		fsize -= dsfi[fd].blksz * 1024 - DS_DAT_HEADSZ - 1;

	/*---------------------------------------------------------------
	** search volume that new document can insert
	**-------------------------------------------------------------*/
	for( volno=0; volno<dsfi[fd].volcnt; volno++ )
	{
		tvol = &dsfi[fd].vol[volno];

		if( tvol->volgen != DS_GEN_VOLUME &&
		    tvol->volgen != DS_CGEN_VOLUME )
		{
			continue;
		}

		if( tvol->doccnt < tvol->maxdocid - tvol->mindocid + 1 )
		{
			if( tvol->maxblkcnt * ( 100 - DS_VOL_FREE ) / 100 >=
						tvol->usedblkcnt + reqblkcnt )
				return( volno );
		}
	}

	/*---------------------------------------------------------------
	** search new volume that is not generated, and generate it
	**-------------------------------------------------------------*/
	for( volno=0; volno<dsfi[fd].volcnt; volno++ )
	{
		if( dsfi[fd].vol[volno].volgen != DS_NOTGEN_VOLUME )
			continue;

		if( dsfi[fd].vol[volno].maxblkcnt * ( 100 - DS_VOL_FREE ) / 100
								< reqblkcnt )
			continue;

		if( ds_volgen( fd, volno, DS_SECOND_VOLUME ) < 0 )
			return( -1 );

		return( volno );
	}

	l_dsmlsethyerrno( EDS_NOMORE_SPACE );
	return( -1 );
}

/******* The end of ds_newvolno.c **************************************/
