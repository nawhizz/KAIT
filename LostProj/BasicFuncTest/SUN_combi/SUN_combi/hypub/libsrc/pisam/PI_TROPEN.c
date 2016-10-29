/* PI_TROPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open file by manual lock & trans				*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_TROPEN( char *filepath, char *fileid )
#else
PI_TROPEN( filepath, fileid )
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

	if ( pi_transtart < 2 ) {
		l_pisamsethyerrno( EPI_TRANNSTART );
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

	if( ( isfd = isopen( filepath,ISINOUT+ISMANULOCK+ISTRANS) ) < 0 ) {
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	/* save file information */
	fd = pi_savefile( filepath, isfd, infpath );

	return fd;
}
