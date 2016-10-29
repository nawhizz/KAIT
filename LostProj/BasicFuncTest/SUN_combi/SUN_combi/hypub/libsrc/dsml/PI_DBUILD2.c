/* PI_DBUILD2() : LIB dsml */
/************************************************************************
*	build new file							*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		file path		*
*		  struct BUILDFORM *build_inf	build information	*
*		  char	*dirpath		directory path		*
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
PI_DBUILD2( char *filepath, struct BUILDFORM *build_inf, char *dirpath )
#else
PI_DBUILD2( filepath, build_inf, dirpath )
char			*filepath;
struct	BUILDFORM	*build_inf;

/* added by stoneshim start */
char			*dirpath;
/* added by stoneshim end */

#endif
{
	char			datapath[DS_PATHLEN];
	struct	BUILDFORM	l_build_inf;
/* added by stoneshim start */
	char			l_dirpath[DS_PATHLEN];
/* added by stoneshim end */
	int			fd;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( filepath == (char *)0 || filepath[0] == 0 ||
				 build_inf == (struct BUILDFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_chkbuildinf( build_inf, &l_build_inf ) < 0 )
		return( -1 );

	if( ds_fullpath( filepath, datapath ) < 0 )
		return( -1 );
/* added by stoneshim start */
	if( ds_fullpath( dirpath, l_dirpath ) < 0 )
		return( -1 );
/* added by stoneshim end */

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
	{
		datapath[ strlen( datapath ) - 4 ] = (char)0;
	}

	/*---------------------------------------------------------------
	** create new DSML file and save DSML information
	**-------------------------------------------------------------*/
	if( dirpath != (char *)0 && dirpath[0] != 0 )
	{
		if( ( fd = ds_filegen( datapath, &l_build_inf, l_dirpath ) < 0 ) )
			return(	-1 );
	}
	else
	{
		if( ( fd = ds_filegen( datapath, &l_build_inf, (char *)0 ) < 0 ) )
			return( -1 );
	}
	
	return( fd + DS_BASE_FD );
}

/******* The end of PI_DBUILD2.c ****************************************/
