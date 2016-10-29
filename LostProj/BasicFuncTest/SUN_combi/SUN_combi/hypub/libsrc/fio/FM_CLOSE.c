/* FM_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close formatted form file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	ffd		file descriptor
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_CLOSE( int ffd )
#else
FM_CLOSE( ffd )
int	ffd;
#endif
{
	FILE	*fd;

	if ( ffd < 0 || ffd >= FM_MAXOPEN ) {
		l_fiosethyerrno( EFM_FDERR );
		return -1;
	}

	if ( ( fd = fm_svfinfo[ffd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFM_NOPEN );
		return -1;
	}

	if ( fclose( fd ) != 0 ) {
		l_fiosethyerrno( errno );
		return -1;
	}

	fm_svfinfo[ffd].filepath_sav[0] = 0;
	fm_svfinfo[ffd].fd_sav = 0;
	fm_svfinfo[ffd].fbuff = 0;
	fm_svfinfo[ffd].fsize = 0;
	if( fm_currfd < 0 ) fm_currfd = ffd;

	return 0;
}
