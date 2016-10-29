/* OFM_FILLFRM() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : fill data in formatted form file				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_FILLFRM( char *retcode, int *fd, char *data, int *datalen, char *dest,
	int *destlen, char *maskchar, int *fillsize )
#else
OFM_FILLFRM( retcode, fd, data, datalen, dest, destlen, maskchar, fillsize )
char	*retcode;			/* X(5). SPACE=OK */
int	*fd, *datalen, *destlen;	/* S9(8) COMP */
char	*data, *dest;			/* X(n) */
char	*maskchar;			/* X(1) */
int	*fillsize;			/* S9(8) COMP */
#endif
{
	*fillsize=FM_FILLFRM( *fd, data, *datalen, dest, *destlen, *maskchar );
	if( *fillsize < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
