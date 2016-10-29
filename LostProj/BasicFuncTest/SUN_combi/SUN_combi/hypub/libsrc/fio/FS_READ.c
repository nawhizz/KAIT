/* FS_READ() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read data of given record number from formatted sam file	*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  char	*record 	read buffer
		  int	recno		record number to read
	output	: int	recsize 	length of read buffer
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_READ( int sfd, char *record, int recsize, int recno )
#else
FS_READ( sfd, record, recsize, recno )
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

	if( fseek( fd, offset, SEEK_SET  ) < 0 ) {
		l_fiosethyerrno( EFS_FSEEK );
		return( -1 ) ;
	}

	if ( (int)fread( record, recsize, 1, fd ) < 1 ) {
		l_fiosethyerrno( EFS_READ );
		return -1;
	}
	return 0;
}
