/* PI_DLFREAD() : LIB dsml */
/************************************************************************
*	read filepath of document in internal directory			*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*		: int	docid			document id		*
*	output	: char  *filebuf		buffer for filepath	*
*		: char	*filename		buffer for filename	*
************************************************************************/

#include	<string.h>

#include	"iswrap.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	read information of master directory				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DLFREAD( int fd, int docid, char *filebuf, char *filename )
#else
PI_DLFREAD( fd, lmidx, filebuf, filename )
int		fd;
int		docid;
char		*filebuf;
char		*filename;
#endif
{
	int	verno;
	int	volno;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( ( fd = ds_getver( fd, &verno ) ) < 0 )
		return( -1 );

	if( verno != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( filebuf == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** search file path information 
	**-------------------------------------------------------------*/
	if( ( volno = ds_getvolno( fd, docid ) ) < 0 )
		return( -1 );

	if( ds_volopen( fd, volno ) < 0 )
		return( -1 );

	stlong( (long)docid, (char *)&du.h.id );
	stlong( (long)0, (char *)&du.h.seq );

	if( isread( dsfi[fd].isfd, (char *)&du, ISEQUAL ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( du.h.dst[0] != 'I' )
		return -1;

	strcpy( filebuf, du.h.data );
	strcpy( filename, du.h.fname );

	return( 0 );
}

/******* The end of PI_DLFREAD.c ****************************************/
