/* FS_RECNUM() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get record number						*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
		  int	recsize 	size of record
	return	: 0/-1
*/

#include	<stdio.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_RECNUM( int sfd, int	recsize )
#else
FS_RECNUM( sfd, recsize )
int	sfd;
int	recsize;
#endif
{
	FILE	*fd;
	int	fsize, recnum;

	if ( sfd == -1 || ( fd = fs_svfinfo[sfd].fd_sav ) == (FILE *)0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	if ( fseek( fd, 0L, SEEK_END ) != 0 ) {
		l_fiosethyerrno( EFS_FSEEK );
		return -1;
	}

	if( ( fsize = ftell( fd ) ) == -1 ) {
		l_fiosethyerrno( ferror( fd ) );
		return -1;
	}

	if( fsize%recsize != 0 )
		recnum=fsize/recsize+1;
	else
		recnum=fsize/recsize;

	return (recnum);
}
