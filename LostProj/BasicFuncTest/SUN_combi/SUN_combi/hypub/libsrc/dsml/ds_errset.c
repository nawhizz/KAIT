/* ds_errset() : LIB dsml internal function */
/************************************************************************
*	set error number to buffer					*
*-----------------------------------------------------------------------*
*	output	: char	*retcode		return code		*
************************************************************************/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void
#if	defined( __CB_STDC__ )
ds_errset( char *retcode )
#else
ds_errset( retcode )
char	*retcode;
#endif
{
#ifdef	WIN32
	if( (*_hyerrno()) < 0 )
		l_dsmlsethyerrno( -(*_hyerrno()) );

	if( (*_hyerrno()) == 0 )
		memset( retcode, ' ', 5 );
	else
		d_int2ndec( *_hyerrno(), 5, ' ', retcode );
#else
	if( hyerrno < 0 )
		l_dsmlsethyerrno( -hyerrno );

	if( hyerrno == 0 )
		memset( retcode, ' ', 5 );
	else
		d_int2ndec( hyerrno, 5, ' ', retcode );
#endif
}

/******* The end of ds_errset.c ****************************************/
