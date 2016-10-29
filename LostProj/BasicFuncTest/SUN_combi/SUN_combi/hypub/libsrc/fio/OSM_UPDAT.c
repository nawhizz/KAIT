/* OSM_UPDAT() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : update data to record number's position of sam file           */
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_UPDAT( char	*retcode, FILE **fptr, char *record, int *recsize, int *recno )
#else
OSM_UPDAT( retcode, fptr, record, recsize, recno )
char	*retcode;		/* X(5) SPACE=ok */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
char	*record;
int	*recsize;		/* S9(8) COMP. */
int	*recno; 		/* S9(8) COMP. record no starting from 0 */
#endif
{
	if( SM_UPDAT( *fptr, record, *recsize, *recno ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
