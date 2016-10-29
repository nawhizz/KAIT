/* OFS_REDNX() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read next record						*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_REDNX( char	*retcode, int *fd, char	*record, int *recsize )
#else
OFS_REDNX( retcode, fd, record, recsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*record;			/* X(recsize) */
int	*recsize;			/* S9(8) COMP */
#endif
{
	if( FS_REDNX( (int)(*fd), record, (int)(*recsize) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
