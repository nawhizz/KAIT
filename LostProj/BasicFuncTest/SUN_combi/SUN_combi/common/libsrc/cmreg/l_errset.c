/* l_errset() : LIB CMREG */
/*----------------------------------------------------------------------*/
/* FUNC : set error number to buffer					*/
/*----------------------------------------------------------------------*/
/* CMREG internal functions */
/*
	if ok( hyerrno == 0 ) then retcode[5] = "     "
	else if 53 then retcode[5] = "   53"
*/
#include	"gps.h"
#include	"cmregdef.h"

void
#if	defined( __CB_STDC__ )
l_errset( char *retcode )
#else
l_errset(retcode)
char	*retcode;
#endif
{
#ifdef	WIN32
	if( (*_hyerrno()) < 0 )
		d_int2ndec( (*_hyerrno())*(-1), 5, '0', retcode );
	else	d_int2ndec( (*_hyerrno()), 5, '0', retcode );
#else
	if( hyerrno < 0 )
		d_int2ndec( -hyerrno, 5, '0', retcode );
	else	d_int2ndec( hyerrno, 5, '0', retcode );
#endif
}
