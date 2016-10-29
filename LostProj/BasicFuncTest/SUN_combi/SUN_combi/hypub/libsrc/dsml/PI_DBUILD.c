/* PI_DBUILD() : LIB dsml */
/************************************************************************
*	build new file							*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		file path		*
*		  struct BUILDFORM *build_inf	build information	*
*	return	: int	fd			open descripter		*
************************************************************************/

#include	<string.h>

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
|	build new file							|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DBUILD( char *filepath, struct BUILDFORM *build_inf )
#else
PI_DBUILD( filepath, build_inf )
char			*filepath;
struct	BUILDFORM	*build_inf;
#endif
{
	char			datapath[DS_PATHLEN];
	struct	BUILDFORM	l_build_inf;
	int			fd;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( filepath == (char *)0 || build_inf == (struct BUILDFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_chkbuildinf( build_inf, &l_build_inf ) < 0 )
		return( -1 );

	if( ds_fullpath( filepath, datapath ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** check FD available
	**-------------------------------------------------------------*/
	if( ds_chkfdavail() < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** erase DSML files
	**-------------------------------------------------------------*/
	strcat( datapath, ".idx" );

	if( !access( datapath, R_OK ) )
	{
		datapath[ strlen( datapath ) - 4 ] = (char)0;
		ds_erase( datapath );
	}
	else
	{
		datapath[ strlen( datapath ) - 4 ] = (char)0;
	}

	/*---------------------------------------------------------------
	** create new DSML file and save DSML information
	**-------------------------------------------------------------*/
	if( ( fd = ds_filegen( datapath, &l_build_inf, (char *)0 ) ) < 0 )
	{
		return(	-1 );
	}


	return( fd + DS_BASE_FD );
}

/******* The end of PI_DBUILD.c ****************************************/
