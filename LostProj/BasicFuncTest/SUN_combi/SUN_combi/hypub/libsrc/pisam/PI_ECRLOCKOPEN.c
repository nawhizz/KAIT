/* PI_ECRLOCKOPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : if file not exist, create and open file by exclusive lock	*/
/*	  or if file exist, open file by exclusive lock			*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<iswrap.h>

#include	"pisam.h"
#include	"pisamdef.h"
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_ECRLOCKOPEN( char *fileid, char *fileext )
#else
PI_ECRLOCKOPEN( fileid, fileext )
char	*fileid;
char	*fileext;
#endif
{
	int	isfd, fd;
	char	filepath[PI_PATHLEN];
	char	infpath[PI_PATHLEN];
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
						ISINOUT + ISEXCLLOCK ) ) < 0 ) {
			return	-1;
		}
	}
	else
	{
		if( ( isfd = isopen( filepath, ISINOUT+ISEXCLLOCK ) ) < 0 ) {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
	}

	/* save file information */
	fd = pi_savefile( filepath, isfd, infpath );
	return fd;
}
