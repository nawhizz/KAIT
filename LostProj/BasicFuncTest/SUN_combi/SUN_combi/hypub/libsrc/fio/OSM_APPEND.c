/* OSM_APPEND() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : append data to sam file					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_APPEND( char *retcode, FILE	**fptr, char *record, int *recsize )
#else
OSM_APPEND( retcode, fptr, record, recsize )
char	*retcode;		/* X(5) SPACE=ok */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
char	*record;
int	*recsize;		/* S9(8) COMP. */
#endif
{
	if( SM_APPEND( *fptr, record, *recsize ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
