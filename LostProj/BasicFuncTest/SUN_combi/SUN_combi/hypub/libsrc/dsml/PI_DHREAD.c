/* PI_DHREAD() : LIB dsml */
/************************************************************************
*	read DSML header						*
*-----------------------------------------------------------------------*
*	input	: int	fd			open descripter		*
*	output	: struct DSMMFORM *dsmm_inf	DSML header information	*
************************************************************************/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	read DSML header						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DHREAD( int fd, struct DSMMFORM *dsmm_inf )
#else
PI_DHREAD( fd, dsmm_inf )
int			fd;
struct	DSMMFORM	*dsmm_inf;
#endif
{
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

	if( dsfi[fd].verno[0] != 2 )
	{
		l_dsmlsethyerrno( EDS_EARLY_VERSION );
		return( -1 );
	}

	if( dsmm_inf == (struct DSMMFORM *)0 )
	{
		l_dsmlsethyerrno( EDS_INVAL_ARG );
		return( -1 );
	}

	/*---------------------------------------------------------------
	** set header information
	**-------------------------------------------------------------*/
	memset( dsmm_inf, 0, sizeof( struct DSMMFORM ) );
	strcpy( dsmm_inf->version, dsfi[fd].version );
	dsmm_inf->blksz = dsfi[fd].blksz;
	dsmm_inf->volcnt = dsfi[fd].volcnt;

	return( 0 );
}

/******* The end of PI_DHREAD.c ****************************************/
