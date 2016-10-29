/* PI_DCLOSE() : LIB dsml */
/************************************************************************
*	close opened file						*
*-----------------------------------------------------------------------*
*	input	: int	fd		open descripter			*
************************************************************************/

#include	<stdlib.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	close opened file						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DCLOSE( int fd )
#else
PI_DCLOSE( fd )
int	fd;
#endif
{
	int	volno;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( fd < DS_BASE_FD || fd >= DS_BASE_FD + DS_MAX_OPEN )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}
	fd -= DS_BASE_FD;

	if( !dsfi[fd].filepath[0] )
	{
		l_dsmlsethyerrno( EDS_FDERR );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** close isam file and free memory
	**-------------------------------------------------------------*/
	if( dsfi[fd].isfd >= 0 )
	{
		if( isclose( dsfi[fd].isfd ) < 0 )
		{
			l_dsmlsethyerrno( iserrno );
			return( -1 );
		}
	}

	for( volno = 0; volno < dsfi[fd].volcnt; volno++ )
	{
		if( dsfi[fd].vol[volno].lv != (struct DS_DIRVINFO *)0 )
			free( dsfi[fd].vol[volno].lv );

	}

	if( dsfi[fd].lm != (struct DS_DIRMINFO *)0 )
		free( dsfi[fd].lm );

	if( dsfi[fd].vol != (struct DS_VOLINFO *)0 )
		free( dsfi[fd].vol );

	dsfi[fd].filepath[0] = '\0';

	return( 0 );
}

/******* The end of PI_DCLOSE.c ****************************************/
