/* OSM_BUILD() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : truncate open sam file					*/
/*	  if fileexist then truncate else create			*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_BUILD( char	*retcode, char *fpath, FILE **fptr )
#else
OSM_BUILD( retcode, fpath, fptr )
char	*retcode;		/* X(5) SPACE=ok */
char	*fpath; 		/* X(80) filepath */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
#endif
{
	char	l_fpath[81];

	d_mkstr( fpath, 80, l_fpath );
	if( SM_BUILD( l_fpath, fptr ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
