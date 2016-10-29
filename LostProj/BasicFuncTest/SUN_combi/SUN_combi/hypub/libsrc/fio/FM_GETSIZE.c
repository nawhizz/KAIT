/* FM_GETSIZE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get size of formatted file					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	ffd		file descriptor
	return	: >0 (file size)
		  -1
*/

#include	<stdio.h>

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_GETSIZE( int	ffd )
#else
FM_GETSIZE( ffd )
int	ffd;
#endif
{
	FILE	*fd;

	if ( ffd == -1 || ( fd = fm_svfinfo[ffd].fd_sav ) == 0 ) {
		l_fiosethyerrno( EFM_NOPEN );
		return -1;
	}

	return fm_svfinfo[ffd].fsize;
}
