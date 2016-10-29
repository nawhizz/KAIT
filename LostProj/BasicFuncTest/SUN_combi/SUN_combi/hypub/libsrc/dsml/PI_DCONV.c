/* PI_DCONV() : LIB dsml */
/************************************************************************
*	conversion v1 data to v2 data					*
*-----------------------------------------------------------------------*
*	input	: char	*file1path		V1 file path		*
*		: char	*file2path		V2 file path		*
*		  struct BUILDFORM *build_inf	build information	*
************************************************************************/

#include	<string.h>

#ifdef		WIN32
#include	<io.h>
#define		R_OK	04
#else
#include	<unistd.h>
#endif

#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	conversion v1 data to v2 data					|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DCONV( char *file1path, char *file2path, struct BUILDFORM *build_inf )
#else
PI_DCONV( file1path, file2path, build_inf )
char			*file1path;
char			*file2path;
struct	BUILDFORM	*build_inf;
#endif
{
	struct	BUILDFORM	l_build_inf;
	char			datapath[DS_PATHLEN];
	int			fd_v1;
	int			fd_v2;
	struct	keydesc		pkey;

	/*---------------------------------------------------------------
	** check and change arguments
	**-------------------------------------------------------------*/
	if( file1path == (char *)0 || file2path == (char *)0 ||
	    build_inf == (struct BUILDFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	if( ds_chkbuildinf( build_inf, &l_build_inf ) < 0 )
		return( -1 );

	if( ds_fullpath( file2path, datapath ) < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** check FD available
	**-------------------------------------------------------------*/
	if( ds_chkfdavail() < 0 )
		return( -1 );

	/*---------------------------------------------------------------
	** check exist DSML files
	**-------------------------------------------------------------*/
	strcat( datapath, ".idx" );

	if( !access( datapath, R_OK ) )
	{
		l_dsmlsethyerrno( EDS_EXIST_VOLUME );
		return( -1 );
	}

	datapath[ strlen( datapath ) - 4 ] = (char)0;

	/*---------------------------------------------------------------
	** open DSML file V1
	**-------------------------------------------------------------*/
	if( ( fd_v1 = isopen( file1path, ISINPUT + ISMANULOCK ) ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		return( -1 );
	}

	if( isindexinfo( fd_v1, &pkey, 1 ) < 0 )
	{
		l_dsmlsethyerrno( iserrno );
		isclose( fd_v1 );
		return( -1 );
	}

	if( pkey.k_nparts != 2 )
	{
		l_dsmlsethyerrno( EDS_NOT_DSML );
		isclose( fd_v1 );
		return( -1 );
	}

	if( pkey.k_part[0].kp_start == 0 &&
	    pkey.k_part[0].kp_leng == LONGSIZE &&
	    pkey.k_part[0].kp_type == LONGTYPE &&
	    pkey.k_part[1].kp_start == LONGSIZE &&
	    pkey.k_part[1].kp_leng == LONGSIZE &&
	    pkey.k_part[1].kp_type == LONGTYPE )
	{
		l_dsmlsethyerrno( EDS_NOTEARLY_VERSION );
		isclose( fd_v1 );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** create new DSML file V2 and save DSML information
	**-------------------------------------------------------------*/
	if( ( fd_v2 = ds_filegen( datapath, &l_build_inf, (char *)0 ) ) < 0 )
	{
		isclose( fd_v1 );
		return(	-1 );
	}

	/*---------------------------------------------------------------
	** conversion v1 data to v2 data
	**-------------------------------------------------------------*/
	if( ds_convert( fd_v1, fd_v2 ) < 0 )
	{
		isclose( fd_v1 );
		PI_DCLOSE( fd_v2 + DS_BASE_FD );
		return( -1 );
	}

	isclose( fd_v1 );
	PI_DCLOSE( fd_v2 + DS_BASE_FD );

	return( 0 );
}

/******* The end of PI_DCONV.c *****************************************/
