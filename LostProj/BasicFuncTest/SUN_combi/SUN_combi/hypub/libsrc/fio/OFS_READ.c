/* OFS_READ() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read data of given record number from formatted sam file	*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fs_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFS_READ( char *retcode, int *fd, char *record, int *recsize, int *recno )
#else
OFS_READ( retcode, fd, record, recsize, recno )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd;				/* S9(8) COMP */
char	*record;			/* X(recsize) */
int	*recsize;			/* S9(8) COMP */
int	*recno; 			/* S9(8) COMP. record no starting from 0 */
#endif
{
	if( FS_READ( (int)(*fd), record, (int)(*recsize), (int)(*recno) ) < 0 )
		fs_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
