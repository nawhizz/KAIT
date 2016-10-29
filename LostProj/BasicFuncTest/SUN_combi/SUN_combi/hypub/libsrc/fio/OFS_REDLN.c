/* OFS_REDLN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : ???????							*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_REDLN( char	*retcode, int *fd, char	*linebuff, int *buffsize,
	int *readsize )
#else
OFS_REDLN( retcode, fd, linebuff, buffsize, readsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*linebuff;			/* X(n) */
int	*buffsize;			/* S9(8) COMP */
int	*readsize;			/* S9(8) COMP */
#endif
{
	*readsize = (int)FS_REDLN( (int)(*fd), linebuff, (int)(*buffsize) );
	if( *readsize < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
