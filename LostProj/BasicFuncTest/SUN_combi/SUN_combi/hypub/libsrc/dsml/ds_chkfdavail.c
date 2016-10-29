/* ds_chkfdavail() : LIB dsml internal function */
/************************************************************************
*	check FD avaliable						*
************************************************************************/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	struct	DS_FILEINFO	dsfi[];
extern	int	ds_currfd;

/*----------------------------------------------------------------------+
|	check FD available						|
+----------------------------------------------------------------------*/
int
ds_chkfdavail( )
{
	/*--------------------------------------------------------------+
	|	initialize TABLE if it's a first loading		|
	+--------------------------------------------------------------*/
	if( ds_currfd == -2 )
	{
		memset( &dsfi, 0, sizeof( struct DS_FILEINFO )*DS_MAX_OPEN );
		ds_currfd = 0;
		return( 0 );
	}

	/*--------------------------------------------------------------+
	|	check FD available					|
	+--------------------------------------------------------------*/
	if( ds_currfd < 0 )
	{
		l_dsmlsethyerrno( EDS_FDFULL );
		return( -1 );
	}
	
	return( 0 );
}

/******* The end of ds_chkfdavail.c *************************************/
