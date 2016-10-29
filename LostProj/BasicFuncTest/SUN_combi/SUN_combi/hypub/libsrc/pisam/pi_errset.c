/* pi_errset() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : set error number to buffer					*/
/*----------------------------------------------------------------------*/
/* PISAM internal functions */
/*
	if ok( hyerrno == 0 ) then retcode[5] = "     "
	else if 53 then retcode[5] = "   53"
*/

#include	<string.h>

#include	"pisam.h"
#include	"pisamdef.h"
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
pi_errset( char *retcode )
#else
pi_errset(retcode)
char	*retcode;
#endif
{
#ifdef	WIN32
	if( (*_hyerrno()) < 0 )
		memcpy( retcode, "99999", 5 );
	else	d_int2ndec( (*_hyerrno()), 5, '0', retcode );
#else
	if( hyerrno < 0 )
		memcpy( retcode, "99999", 5 );
	else	d_int2ndec( hyerrno, 5, '0', retcode );
#endif
}
