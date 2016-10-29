/* PI_TRCROPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : if file not exist, create and open file by manual lock & trans*/
/*	  or if file exist, open file by manual lock & trans		*/
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
PI_TRCROPEN( char *filepath, char *fileid )
#else
PI_TRCROPEN( filepath, fileid )
char	*filepath;
char	*fileid;
#endif
{
	int	isfd, fd;
	char	infpath[PI_PATHLEN];
	char	savbuff[PI_PATHLEN];

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

	strcpy( savbuff, filepath );
	strcat( savbuff, ".dat" );

#ifndef	WIN32
	if ( access( savbuff, R_OK ) < 0  ) {	   /* if not exist */
#else
	if ( access( savbuff, 6 ) < 0  ) {	   /* if not exist */
#endif
		if ( ( isfd = pi_filegen( filepath, infpath,
				ISINOUT + ISEXCLLOCK + ISTRANS ) ) < 0 ) {
			return	-1;
		}
	}
	else
	{
		if( ( isfd = isopen( filepath,
				ISINOUT + ISMANULOCK + ISTRANS ) ) < 0 ) {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
	}

	/* save file information */

	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
