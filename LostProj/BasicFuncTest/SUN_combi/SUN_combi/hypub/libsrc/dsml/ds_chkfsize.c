/* ds_chkfsize() : LIB dsml */
/************************************************************************
*	Check document size to insert					*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*		  int	verno	Version number				*
*		  int	fsize	size of document file			*
************************************************************************/

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
ds_chkfsize( int fd, int verno, int fsize )
#else
ds_chkfsize( fd, verno fsize )
int	fd;
int	verno;
int	fsize;
#endif
{
	int	MaxDataBlkPerDoc;
	int	MaxDataBlkSize;
	int	MaxHeadBlkSize;

	if( fsize < 0 )
		return( -1 );

	if( verno >= 2 )
		return( 0 );

	MaxDataBlkPerDoc = 0x7FFF;
	MaxDataBlkSize = sizeof du.d1.data;
	MaxHeadBlkSize = sizeof du.h1.data;

	if( fsize > MaxDataBlkPerDoc * MaxDataBlkSize + MaxHeadBlkSize )
		return( -1 );

	return( 0 );
}

/******* The end of ds_chkfsize.c **************************************/
