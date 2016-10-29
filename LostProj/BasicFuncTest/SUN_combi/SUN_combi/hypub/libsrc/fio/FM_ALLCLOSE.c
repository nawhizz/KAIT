/* FM_ALLCLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close all formatted form file 				*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"fm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
FM_ALLCLOSE( void )
#else
FM_ALLCLOSE()
#endif
{
	FILE		*fd;
	register	i;

	for ( i = 0; i < FM_MAXOPEN; i++ )
	{
		if ( !fm_svfinfo[i].fd_sav )
			continue;

		fd = fm_svfinfo[i].fd_sav;
		if ( fclose( fd ) != 0 )
		{
			l_fiosethyerrno( errno );
			return -1;
		}
		fm_svfinfo[i].filepath_sav[0] = 0;
		fm_svfinfo[i].fd_sav = 0;
		fm_svfinfo[i].fbuff = 0;
		fm_svfinfo[i].fsize = 0;
		if( fm_currfd < 0 ) fm_currfd = i;
	}

	fm_currfd = 0;
	return 0;
}
