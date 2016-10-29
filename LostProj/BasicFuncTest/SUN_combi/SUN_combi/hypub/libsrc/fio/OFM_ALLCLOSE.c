/* OFM_ALLCLOSE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : close all formatted form file 				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#include	"fio.h"
#include	"fm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OFM_ALLCLOSE( char *retcode )
#else
OFM_ALLCLOSE( retcode )
char	*retcode;			/* X(5). SPACE=OK */
#endif
{
	if( FM_ALLCLOSE() < 0 )
		fm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
