/* OFS_DROP() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : delete formatted sam file					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fs_fun.h"
#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_DROP( char *retcode, char *fileid, char *fileext )
#else
OFS_DROP( retcode, fileid, fileext )
char	*retcode;			/* X(5). SPACE=OK */
char	*fileid;			/* X(FS_IDLEN, fileid) */
char	*fileext;			/* X(n) */
#endif
{
	char	l_fileid[FS_IDLEN + 1];
	char	l_fileext[FS_EXTLEN + 1];

	d_mkstr( fileid, FS_IDLEN, l_fileid );
	d_mkstr( fileext, FS_EXTLEN, l_fileext );
	if( FS_DROP( l_fileid, l_fileext ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
