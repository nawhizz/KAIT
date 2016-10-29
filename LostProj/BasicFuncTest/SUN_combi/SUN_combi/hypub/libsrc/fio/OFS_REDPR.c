/* FS_REDPR() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read previous record						*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_REDPR( char	*retcode, int *fd, char	*record, int *recsize )
#else
OFS_REDPR( retcode, fd, record, recsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*record;			/* X(recsize) */
int	*recsize;			/* S9(8) COMP */
#endif
{
	if( FS_REDPR( (int)(*fd), record, (int)(*recsize) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
