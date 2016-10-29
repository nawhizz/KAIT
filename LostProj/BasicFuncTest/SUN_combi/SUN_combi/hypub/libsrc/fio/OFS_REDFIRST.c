/* OFS_REDFIRST() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read first record						*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_REDFIRST( char *retcode, int *fd, char *record, int	*recsize )
#else
OFS_REDFIRST( retcode, fd, record, recsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*record;			/* X(recsize) */
int	*recsize;			/* S9(8) COMP */
#endif
{
	if( FS_REDFIRST( (int)(*fd), record, (int)(*recsize) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
