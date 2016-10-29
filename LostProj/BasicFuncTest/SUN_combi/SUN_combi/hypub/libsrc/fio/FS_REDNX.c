/* FS_REDNX() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read next record						*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  int	recsize 	size of record
	output	: char	*record 	read buffer
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_REDNX( int sfd, char	*record, int recsize )
#else
FS_REDNX( sfd, record, recsize )
int	sfd;
char	*record;
int	recsize;
#endif
{
	FILE	*fd;

	if ( sfd == -1 || ( fd = fs_svfinfo[sfd].fd_sav ) == (FILE *)0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	if ( (int)fread( record, recsize, 1, fd ) < 1 ) {
		l_fiosethyerrno( EFS_READ );
		return -1;
	}
	return 0;
}
