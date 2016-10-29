/* FS_UPDAT() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : update data to record number's positon of file                */
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  char	*record 	read buffer
		  int	recsize 	size of record
		  int	recno		record number
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_UPDAT( int sfd, char	*record, int recsize, int recno )
#else
FS_UPDAT( sfd, record, recsize, recno )
int	sfd;
char	*record;
int	recsize;
int	recno;
#endif
{
	FILE	*fd;
	long	offset;

	if ( sfd == -1 || ( fd = fs_svfinfo[sfd].fd_sav ) == (FILE *)0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	offset = (long)recsize * (long)recno;

	if( fseek( fd, offset, SEEK_SET ) < 0 ) {
		l_fiosethyerrno( EFS_FSEEK );
		return -1;
	}

	if ( ( int ) fwrite( record, recsize, 1, fd ) < 1 ) {
		l_fiosethyerrno( EFS_WRITE );
		return -1;
	}

	return 0;
}
