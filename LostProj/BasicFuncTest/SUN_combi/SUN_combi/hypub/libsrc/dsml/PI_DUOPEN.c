/* PI_DUOPEN() : LIB dsml */
/************************************************************************
*	open exist file with write mode					*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		file path		*
*	return	: int	fd			open descripter		*
************************************************************************/

#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	open exist file with write mode					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DUOPEN( char *filepath )
#else
PI_DUOPEN( filepath )
char	*filepath;
#endif
{
	char	datapath[DS_PATHLEN];
	int	fd;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( filepath == (char *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_fullpath( filepath, datapath ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** check FD available
	**-------------------------------------------------------------*/
	if( ds_chkfdavail() < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** open DSML file and save DSML information
	**-------------------------------------------------------------*/
	if( ( fd = ds_fileopen( datapath, ISINOUT + ISTRANS ) ) < 0 )
		 return( -1 );

	return( fd + DS_BASE_FD );
}

/******* The end of PI_DUOPEN.c ****************************************/
