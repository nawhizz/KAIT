/* OSM_CROPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open or create sam file for append				*/
/*	  if nofile then create 					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_CROPEN( char *retcode, char	*fpath, FILE **fptr )
#else
OSM_CROPEN( retcode, fpath, fptr )
char	*retcode;		/* X(5) SPACE=ok */
char	*fpath; 		/* X(80) file path */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
#endif
{
	char	l_fpath[81];

	d_mkstr( fpath, 80, l_fpath );
	if( SM_CROPEN( l_fpath, fptr ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
