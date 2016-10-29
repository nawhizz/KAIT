/* ds_getvolno() : LIB dsml internal function */
/************************************************************************
*	Search volume that document exist				*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	docid	ID of document				*
*	return	: int	volno	volume number				*
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
ds_getvolno( int fd, int docid )
#else
ds_getvolno( fd, docid )
int	fd;
int	docid;
#endif
{
	register	volno;

	/*---------------------------------------------------------------
	** search volume that new document can insert
	**-------------------------------------------------------------*/
	for( volno=0; volno<dsfi[fd].volcnt; volno++ )
	{
		if( dsfi[fd].vol[volno].volgen != DS_GEN_VOLUME &&
		    dsfi[fd].vol[volno].volgen != DS_CGEN_VOLUME )
		{
			continue;
		}

		if( docid >= dsfi[fd].vol[volno].mindocid &&
		    docid <= dsfi[fd].vol[volno].maxdocid )
		{
			return( volno );
		}
	}

	l_dsmlsethyerrno( EDS_INVAL_DOCID );
	return( -1 );

}

/******* The end of ds_getvolno.c **************************************/
