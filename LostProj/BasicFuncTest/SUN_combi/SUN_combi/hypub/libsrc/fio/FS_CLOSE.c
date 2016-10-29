/* FS_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close formatted sam file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	sfd		file descriptor
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_CLOSE( int sfd )
#else
FS_CLOSE( sfd )
int	sfd;
#endif
{
	FILE	*fd;

	if ( sfd < 0 || sfd >= FS_MAXOPEN ) {
		l_fiosethyerrno( EFS_FDERR );
		return -1;
	}

	if ( ( fd = fs_svfinfo[sfd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFS_NOPEN );
		return -1;
	}

	if ( fclose( fd ) != 0 ) {
		/* l_fiosethyerrno( EFS_FCLOSE ); */
		l_fiosethyerrno( errno );
		return -1;
	}

	fs_svfinfo[sfd].filepath_sav[0] = 0;
	fs_svfinfo[sfd].fd_sav = 0;
	if( fs_currfd < 0 ) fs_currfd = sfd;

	return 0;
}
