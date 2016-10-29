/* PI_EOPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : open file							*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<iswrap.h>

#include	"pisam.h"
#include	"pisamdef.h"
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_EOPEN( char *fileid, char *fileext )
#else
PI_EOPEN( fileid, fileext )
char	*fileid;
char	*fileext;
#endif
{
	int	isfd, fd;
	char	filepath[PI_PATHLEN];
	char	infpath[PI_PATHLEN];

	if( fileid == (char *)0 || fileext == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	/* get file full path */
	if ( pi_getdatapath( fileid, fileext, filepath ) < 0 ) {
		l_pisamsethyerrno( EPI_NODATAFILE );
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

	if( ( isfd = isopen( filepath, ISINPUT+ISMANULOCK )  ) < 0 ) {
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	/* save file information */
	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
