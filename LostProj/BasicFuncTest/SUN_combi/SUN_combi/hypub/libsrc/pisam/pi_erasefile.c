/* pi_erasefile() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : erase file (data, index, lock)				*/
/*----------------------------------------------------------------------*/
/* PISAM internal functions */

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<errno.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int
#if	defined( __CB_STDC__ )
pi_erasefile( char *filepath )
#else
pi_erasefile( filepath )
char	*filepath;
#endif
{
	char	savbuff[PI_PATHLEN];
	int	retval=0;

	strcpy( savbuff, filepath );
	strcat( savbuff, ".dat" );
	if( unlink( savbuff ) < 0 && errno != ENOENT ) {
		l_pisamsethyerrno( errno );
		retval = -1;
	}

	strcpy( savbuff, filepath );
	strcat( savbuff, ".idx" );
	if( unlink( savbuff ) < 0 && errno != ENOENT ) {
		l_pisamsethyerrno( errno );
		retval = -1;
	}

	strcpy( savbuff, filepath );
	strcat( savbuff, ".lok" );
	if( unlink( savbuff ) < 0 && errno != ENOENT ) {
		l_pisamsethyerrno( errno );
		retval = -1;
	}

	return( retval );
}
