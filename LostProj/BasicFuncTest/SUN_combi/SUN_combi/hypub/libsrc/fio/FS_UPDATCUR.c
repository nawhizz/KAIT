/* FS_UPDATCUR() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : update data to current postion of file			*/
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
FS_UPDATCUR( int sfd, char *record, int	recsize )
#else
FS_UPDATCUR( sfd, record, recsize )
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

	if ( fseek( fd, -( recsize ), SEEK_CUR ) != 0 ) {
		l_fiosethyerrno( EFS_FSEEK );
		return -1;
	}

	if ( ( int ) fwrite( record, recsize, 1, fd ) < 1 ) {
		l_fiosethyerrno( EFS_WRITE );
		return -1;
	}

	return 0;
}
