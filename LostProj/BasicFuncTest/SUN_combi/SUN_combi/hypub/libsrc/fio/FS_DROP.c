/* FS_DROP() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : delete formatted sam file					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
		  char	*fileext	file extention
	return	: 0/-1
*/

#include	<stdio.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<errno.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_DROP( char *fileid, char *fileext )
#else
FS_DROP( fileid, fileext )
char	*fileid;
char	*fileext;
#endif
{
	char	filepath[FS_PATHLEN];

	if ( fs_getfpath( fileid, fileext, filepath ) < 0 ) {
		l_fiosethyerrno( EFS_FILENDEF );
		return -1;
	}

#ifndef	WIN32
	if ( access( filepath, R_OK ) == 0 ) {	/* if exist */
#else
	if ( access( filepath, 4 ) == 0 ) {	/* if exist */
#endif
		if( unlink( filepath ) < 0 ) {
			/* l_fiosethyerrno( EFS_FDEL ); */
			l_fiosethyerrno( errno );
			return -1;
		}
	}
	return 0;
}
