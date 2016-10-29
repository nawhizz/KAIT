/* FS_APPEND() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : addit one record to formatted sam file			*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  char	*record 	data
		  int	recsize 	length of data
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_APPEND( int sfd, char *record, int recsize )
#else
FS_APPEND( sfd, record, recsize )
int	sfd;
char	*record;
int	recsize;
#endif
{
	FILE	*fd;

	if ( sfd == -1 || ( fd = fs_svfinfo[sfd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	if ( fseek( fd, 0, SEEK_END ) != 0 ) {
		l_fiosethyerrno( EFS_FSEEK );
		return -1;
	}

	if ( (int)fwrite( record, recsize, 1, fd ) < 1	) {
		l_fiosethyerrno( EFS_WRITE );
		return -1;
	}
	return 0;
}
