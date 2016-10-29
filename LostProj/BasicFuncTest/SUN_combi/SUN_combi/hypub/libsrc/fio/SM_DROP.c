/* SM_DROP() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : drop(remove) sam file 					*/
/*	  if nofile then ok						*/
/*----------------------------------------------------------------------*/
/*
	return : 0/-1
*/

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_DROP( char *fpath )
#else
SM_DROP( fpath )
char	*fpath;
#endif
{
#ifndef	WIN32
	if ( access( fpath, R_OK ) == 0 ) {	/* if exist */
#else
	if ( access( fpath, 4 ) == 0 ) {	/* if exist */
#endif
		if( unlink( fpath ) < 0 ) {
			l_fiosethyerrno( errno );
			return -1;
		}
	}
	return	0;
}
