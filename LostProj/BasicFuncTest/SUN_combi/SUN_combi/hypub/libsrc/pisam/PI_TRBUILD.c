/* PI_TRBUILD() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : build file by exclusive lock and trans			*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_TRBUILD( char *filepath, char *fileid )
#else
PI_TRBUILD( filepath, fileid )
char	*filepath;
char	*fileid;
#endif
{
	char	infpath[PI_PATHLEN];
	char	savbuff[PI_PATHLEN];
	int	isfd, fd;

	if( filepath == (char *)0 || fileid == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( pi_transtart < 2 ) {
		l_pisamsethyerrno( EPI_TRANNSTART );
		return -1;
	}

	/* get info file path */
	if ( pi_getinfpath( fileid, infpath ) < 0 ) {
		return -1;
	}

	strcpy( savbuff, filepath );
	strcat( savbuff, ".dat" );

#ifndef	WIN32
	if ( access( savbuff, R_OK ) == 0 ) {	   /* if exist */
#else
	if ( access( savbuff, 6 ) == 0 ) {	   /* if exist */
#endif
		/* erase file(.dat,.idx,.lok) */
		if ( pi_erasefile( filepath ) < 0 ) {
			return -1;
		}
	}

	/* Generate isam file */
	if ( ( isfd = pi_filegen( filepath, infpath,
				ISINOUT + ISEXCLLOCK + ISTRANS ) ) < 0 ) {
		return	-1;
	}

	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
