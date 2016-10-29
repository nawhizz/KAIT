/* PI_EDROP() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : delete isam file						*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	"pisam.h"
#include	"pisamdef.h"
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_EDROP( char *fileid, char *fileext )
#else
PI_EDROP( fileid, fileext )
char	*fileid;
char	*fileext;
#endif
{
	char	filepath[PI_PATHLEN];
	char	savbuff[PI_PATHLEN];

	if( fileid == (char *)0 || fileext == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	/* get file full path */
	if ( pi_getdatapath( fileid, fileext, filepath ) < 0 ) {
		l_pisamsethyerrno( EPI_NODATAFILE );
		return -1;
	}

	strcpy( savbuff, filepath );
	strcat( savbuff, ".dat" );

#ifndef	WIN32
	if ( access( savbuff, R_OK ) == 0  ) {	   /* if exist */
#else
	if ( access( savbuff, 6 ) == 0  ) {	   /* if exist */
#endif
		/* erase file(.dat,.idx,.lok) */
		if ( pi_erasefile( filepath ) < 0 ) {
			return -1;
		}
	}
	return 0;
}
