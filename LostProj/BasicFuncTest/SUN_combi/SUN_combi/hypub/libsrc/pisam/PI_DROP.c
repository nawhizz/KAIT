/* PI_DROP() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : delete file							*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_DROP( char *filepath, char *fileid )
#else
PI_DROP( filepath, fileid )
char	*filepath;
char	*fileid;
#endif
{
	char	savbuff[PI_PATHLEN];

	if( filepath == (char *)0 || fileid == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	strcpy( savbuff, filepath );
	strcat( savbuff, ".dat" );

#ifndef WIN32
	if ( access( savbuff, R_OK ) == 0 ) {	   /* if exist */
#else
	if ( access( savbuff, 6 ) == 0 ) {	   /* if exist */
#endif
		/* erase file(.dat,.idx,.lok) */
		if ( pi_erasefile( filepath ) < 0 ) {
			return -1;
		}
	}
	return 0;
}
