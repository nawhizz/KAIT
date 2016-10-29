/* FS_ALLCLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close all fomatted sam file					*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"fio.h"
#include	"fs_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FS_ALLCLOSE( void )
#else
FS_ALLCLOSE()
#endif
{
	register	i;
	FILE		*fd;

	for ( i = 0; i < FS_MAXOPEN; i++ ) {
		if ( !fs_svfinfo[i].fd_sav )
			continue;

		fd = fs_svfinfo[i].fd_sav;
		if ( fclose( fd ) != 0 ) {
			/* l_fiosethyerrno( EFS_FCLOSE ); */
			l_fiosethyerrno( errno );
			return -1;
		}
		fs_svfinfo[i].filepath_sav[0] = 0;
		fs_svfinfo[i].fd_sav = 0;
		if( fs_currfd < 0 ) fs_currfd = i;
	}

	fs_currfd = 0;
	return 0;
}
