/* PI_BUILD() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : build new file						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*filepath	full file path
		  char	*fileid		file layout id
*/

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
PI_BUILD( char *filepath, char *fileid )
#else
PI_BUILD( filepath, fileid )
char	*filepath;
char	*fileid;
#endif
{
	char	infpath[PI_PATHLEN];
	char	datapath[PI_PATHLEN];
	int	isfd, fd;

	if( filepath == (char *)0 || fileid == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	/* get info file path */
	if( pi_getinfpath( fileid, infpath ) < 0 ) {
		return -1;
	}

	/* chk FD available */
	if( pi_currfd < 0 ) {
		l_pisamsethyerrno( EPI_FDFULL );
		return -1;
	}

	strcpy( datapath, filepath );
	strcat( datapath, ".dat" );

#ifndef	WIN32
	if( access( datapath, R_OK ) == 0 ) {	   /* if exist */
#else
	if( access( datapath, 6 ) == 0 ) {	   /* if exist */
#endif
		/* erase file(.dat,.idx,.lok) */
		if ( pi_erasefile( filepath ) < 0 ) {
			return -1;
		}
	}

	/* Generate isam file */
	if( ( isfd = pi_filegen( filepath, infpath,
						ISINOUT + ISEXCLLOCK ) ) < 0 ) {
		return	-1;
	}

	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
