/* ds_getver() : LIB dsml internal function */
/************************************************************************
*	get version number to table from DSML file			*
*-----------------------------------------------------------------------*
*	input	: int	fd	open descipter				*
*	output	: int	verno	version number				*
*	return	: int	fd	open descipter				*
************************************************************************/

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	get version number to table from DSML file			|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_getver( int fd, int *verno )
#else
ds_getver( fd, verno )
int	fd;
int	*verno;
#endif
{
	if( fd < DS_BASE_FD || fd >= DS_BASE_FD + DS_MAX_OPEN )
	{
		/* early version 2.0 */
		if( fd < 0 )
		{
			l_dsmlsethyerrno( EDS_FDERR );
			return( -1 );
		}
		else
			*verno = 0;		/* PISAM access version 1 */
	}
	else
	{
		fd -= DS_BASE_FD;

		if( !dsfi[fd].filepath[0] )
		{
			l_dsmlsethyerrno( EDS_FDERR );
			return( -1 );
		}

		if( dsfi[fd].verno[0] == 1 )
			*verno = 1;		/* isam access version 1 */
		else
			*verno = 2;		/* isam access version 2 */
	}

	return( fd );
}

/******* The end of ds_getver.c ****************************************/
