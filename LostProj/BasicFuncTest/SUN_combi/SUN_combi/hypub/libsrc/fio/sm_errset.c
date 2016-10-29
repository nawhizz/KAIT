/* sm_errset() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : set errno number to return code				*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<string.h>

#include	"gps.h"
#include	"sm_fun.h"

void
#if	defined( __CB_STDC__ )
sm_errset( char *retcode )
#else
sm_errset( retcode )
char	*retcode;		/* X(5). SPACE=OK */
#endif
{
#ifdef	WIN32
	if( (*_hyerrno()) < 0 )
#else
	if( hyerrno < 0 )
#endif
		memcpy( retcode, "99999", 5 );
#ifdef	WIN32
	else if( (*_hyerrno()) == 0 )
#else
	else if( hyerrno == 0 )
#endif
		memset( retcode, ' ', 5 );
	else
#ifdef	WIN32
		d_int2ndec( (*_hyerrno()), 5, '0', retcode );
#else
		d_int2ndec( hyerrno, 5, '0', retcode );
#endif
}
