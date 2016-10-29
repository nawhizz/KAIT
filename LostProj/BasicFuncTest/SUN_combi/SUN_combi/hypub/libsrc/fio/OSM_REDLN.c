/* OSM_REDLN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : ???????							*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_REDLN( char	*retcode, FILE **fp, char *linebuff, int *recsize,
	int *readsize )
#else
OSM_REDLN( retcode, fp, linebuff, recsize, readsize )
char	*retcode;			/* X(5). SPACE=OK */
FILE	**fp;				/* S9(8) COMP */
char	*linebuff;			/* X(n) */
int	*recsize;			/* S9(8) COMP */
int	*readsize;			/* S9(8) COMP */
#endif
{
	*readsize = (int)SM_REDLN( *fp, linebuff, (int)(*recsize) );
	if( *readsize < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
