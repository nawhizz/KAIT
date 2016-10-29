/* PI_OPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open file to read						*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_OPEN( char *filepath, char *fileid )
#else
PI_OPEN( filepath, fileid )
char	*filepath;
char	*fileid;
#endif
{
	int	isfd, fd;
	char	infpath[PI_PATHLEN];

	if( filepath == (char *)0 || fileid == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	/* get info file path */
	if ( pi_getinfpath( fileid, infpath ) < 0 ) {
		return -2;
	}

	/* chk FD available */
	if( pi_currfd < 0 ) {
		l_pisamsethyerrno( EPI_FDFULL );
		return -3;
	}

	if( (isfd=isopen( filepath, ISINPUT+ISMANULOCK)) < 0 ) {
		l_pisamsethyerrno( iserrno );
		return -4;
	}

	/* save file information */
	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
