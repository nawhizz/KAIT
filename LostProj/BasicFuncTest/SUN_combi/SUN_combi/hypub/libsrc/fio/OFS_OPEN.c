/* OFS_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of formatted sam file				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fs_fun.h"
#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_OPEN( char *retcode, int *fd, char *fileid, char *fileext )
#else
OFS_OPEN( retcode, fd, fileid, fileext )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*fileid;			/* X(8) */
char	*fileext;			/* X(n) */
#endif
{
	char	l_fileid[FS_IDLEN + 1];
	char	l_fileext[FS_EXTLEN + 1];

	d_mkstr( fileid, FS_IDLEN, l_fileid );
	d_mkstr( fileext, FS_EXTLEN, l_fileext );
	if( ( *fd = (int)FS_OPEN( l_fileid, l_fileext ) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
