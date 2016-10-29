/* FS_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of formatted sam file				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid 	file id
		  char	*fileext	file extention
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_OPEN( char *fileid, char *fileext )
#else
FS_OPEN( fileid, fileext )
char	*fileid;
char	*fileext;
#endif
{
	char	filepath[FS_PATHLEN];
	int	sfd;
	FILE	*fd;

	if( fs_currfd < 0 ) {
		l_fiosethyerrno( EFS_FDFULL );
		return -1;
	}

	if ( fs_getfpath( fileid, fileext, filepath ) < 0 ) {
		l_fiosethyerrno( EFS_FILENDEF );
		return -1;
	}

	if ( ( fd = fopen( filepath, "r+b" ) ) == (FILE *)0 ) {
		/* l_fiosethyerrno( EFS_FOPEN ); */
		l_fiosethyerrno( errno );
		return -1;
	}

	sfd = fs_savefile( filepath, fd );
	return sfd;
}
