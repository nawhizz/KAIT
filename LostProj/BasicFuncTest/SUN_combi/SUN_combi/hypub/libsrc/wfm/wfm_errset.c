/* wfm_errset() : LIB wfm internal function */
/************************************************************************
*	set error number to buffer					*
*-----------------------------------------------------------------------*
*	output	: char	*retcode		return code		*
************************************************************************/

#include	<string.h>

#include	"gps.h"
#include	"wfm.h"
#include	"wfm_fun.h"

void
#if	defined( __CB_STDC__ )
wfm_errset( char *retcode )
#else
wfm_errset( retcode )
char	*retcode;
#endif
{
#ifdef	WIN32
	if( (*_hyerrno()) < 0 )
		l_wfmsethyerrno( -(*_hyerrno()) );

	if( (*_hyerrno()) == 0 )
		memset( retcode, ' ', 5 );
	else
		d_int2ndec( *_hyerrno(), 5, ' ', retcode );
#else
	if( hyerrno < 0 )
		l_wfmsethyerrno( -hyerrno );

	if( hyerrno == 0 )
		memset( retcode, ' ', 5 );
	else
		d_int2ndec( hyerrno, 5, ' ', retcode );
#endif
}

/******* The end of wfm_errset.c ***************************************/
