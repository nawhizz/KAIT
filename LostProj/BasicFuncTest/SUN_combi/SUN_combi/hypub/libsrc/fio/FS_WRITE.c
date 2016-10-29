/* FS_WRITE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : write data to file						*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  char	*record 	read buffer
		  int	recsize 	size of record
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_WRITE( int sfd, char	*record, int recsize )
#else
FS_WRITE( sfd, record, recsize )
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

	if ( (int)fwrite( record, recsize, 1, fd ) < 1	) {
		l_fiosethyerrno( EFS_WRITE );
		return -1;
	}

	return 0;
}
