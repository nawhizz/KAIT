/* OSM_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close sam file						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_CLOSE( char	*retcode, FILE **fptr )
#else
OSM_CLOSE( retcode, fptr )
char	*retcode;		/* X(5) SPACE=ok */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
#endif
{
	if( SM_CLOSE( *fptr ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
