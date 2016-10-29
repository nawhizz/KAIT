/* OFS_ALLCLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close all fomatted sam file					*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_ALLCLOSE( char *retcode )
#else
OFS_ALLCLOSE( retcode )
char	*retcode;			/* X(5). SPACE=OK */
#endif
{
	if( FS_ALLCLOSE() < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
