/* PI_DCROPEN() : LIB dsml */
/************************************************************************
*	open exist file or build new file				*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		file path		*
*		  struct BUILDFORM *build_inf	build information	*
*	return	: int	fd			open descripter		*
************************************************************************/

#include	<string.h>
#include	<iswrap.h>

#ifdef		WIN32
#include	<io.h>
#define		R_OK	04
#else
#include	<unistd.h>
#endif

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	open exist file or build new file				|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DCROPEN( char *filepath, struct BUILDFORM *build_inf )
#else
PI_DCROPEN( filepath, build_inf )
char			*filepath;
struct	BUILDFORM	*build_inf;
#endif
{
	char	datapath[DS_PATHLEN];
	int	fd;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( filepath == (char *)0 || filepath[0] == 0 || 
			build_inf == (struct BUILDFORM *)0 )
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
	** build or open DSML file and save DSML information
	**-------------------------------------------------------------*/
	strcat( datapath, ".idx" );

	if( access( datapath, R_OK ) )
	{
		struct	BUILDFORM	l_build_inf;

		datapath[ strlen( datapath ) - 4 ] = (char)0;

		if( ds_chkbuildinf( build_inf, &l_build_inf ) < 0 )
			return( -1 );

		if( ( fd = ds_filegen( datapath, &l_build_inf, (char *)0 ) ) < 0 )
			return(	-1 );
	}
	else
	{
		datapath[ strlen( datapath ) - 4 ] = (char)0;

		if( ( fd = ds_fileopen( datapath, ISINOUT + ISTRANS ) ) < 0 )
			return(	-1 );
	}

	return( fd + DS_BASE_FD );
}

/******* The end of PI_DCROPEN.c ***************************************/
