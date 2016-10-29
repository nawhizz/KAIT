/* OFS_CLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close formatted sam file					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_CLOSE( char	*retcode, int *fd )
#else
OFS_CLOSE( retcode, fd )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
#endif
{
	if( FS_CLOSE( (int)(*fd) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
