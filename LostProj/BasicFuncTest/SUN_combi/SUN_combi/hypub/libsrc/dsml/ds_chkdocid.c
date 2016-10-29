/* ds_chkdocid() : LIB dsml */
/************************************************************************
*	Get new document ID						*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	docid	ID of document				*
*		  int	fsize	size of document file			*
************************************************************************/

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
|	Get new document ID						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_chkdocid( int fd, int docid, int fsize )
#else
ds_chkdocid( fd, docid fsize )
int	fd;
int	docid;
int	fsize;
#endif
{
	int		volno;
	int		reqblkcnt;
	int		useblkcnt;

	if( fsize < 0 )
		return( 0 );

	/*---------------------------------------------------------------
	** search volume that document exist
	**-------------------------------------------------------------*/
	if( ( volno = ds_getvolno( fd, docid ) ) < 0 )
		return( -1 );

	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** check whether new document update at this volume
	**-------------------------------------------------------------*/
	stlong( (long)docid, (char *)&du.h.id );
	stlong( (long)0, (char *)&du.h.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL + ISLCKW ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	fsize -= dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
	for( reqblkcnt=1; fsize>0; reqblkcnt++ )
		fsize -= dsfi[fd].blksz * 1024 - DS_DAT_HEADSZ - 1;

	fsize = (int)ldlong( (char *)&du.h.size );
	fsize -= dsfi[fd].blksz * 1024 - DS_DOC_HEADSZ - 1;
	for( useblkcnt=1; fsize>0; useblkcnt++ )
		fsize -= dsfi[fd].blksz * 1024 - DS_DAT_HEADSZ - 1;

	if( reqblkcnt <= useblkcnt )
		return( 0 );

	if( dsfi[fd].vol[volno].maxblkcnt - dsfi[fd].vol[volno].usedblkcnt >=
							reqblkcnt - useblkcnt )
	{
		return( 0 );
	}

	/*---------------------------------------------------------------
	** split volume
	**-------------------------------------------------------------*/
	if( ds_splitvol( fd, volno ) < 0 )
		return( -1 );

	return( 0 );
}

/******* The end of ds_chkdocid.c **************************************/
