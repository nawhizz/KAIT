/* OFS_UPDAT() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : update data to record number's positon of file                */
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_UPDAT( char	*retcode, int *fd, char	*record, int *recsize, int *recno )
#else
OFS_UPDAT( retcode, fd, record, recsize, recno )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*record;			/* X(recsize) */
int	*recsize;			/* S9(8) COMP */
int	*recno; 		/* S9(8) COMP. record no starting from 0 */
#endif
{
	if( FS_UPDAT( (int)(*fd), record, (int)(*recsize), (int)(*recno) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
