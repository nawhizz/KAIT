/* PI_LOCKOPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open file by exclusive lock					*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_LOCKOPEN( char *filepath, char *fileid )
#else
PI_LOCKOPEN( filepath, fileid )
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
		return -1;
	}

	/* chk FD available */
	if( pi_currfd < 0 ) {
		l_pisamsethyerrno( EPI_FDFULL );
		return -1;
	}

	if( ( isfd = isopen( filepath, ISINOUT+ISEXCLLOCK )  ) < 0 ) {
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	/* save file information */
	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
