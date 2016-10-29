/* r_execprg() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : execute program and exit ( chainning program )		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*pname		program name to run
	output	: short *retval 	return value
					control not returned case o.k.
					-1 err.
*/

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<process.h>
#endif

#include	<errno.h>

#include	"gps.h"

#define 	R_PROGNAMESIZE	128		/* program name string size */

void CBD1
#if	defined( __CB_STDC__ )
r_execprg( char *pname, short *retval )
#else
r_execprg( pname, retval )
char	*pname;
short	*retval;
#endif
{
	char	progname[R_PROGNAMESIZE+1];

	if( pname == (char *)0 )
	{
		if( retval != (short *)0 )
			*retval = -1 ;
		return;
	}

	d_mkstr( pname, R_PROGNAMESIZE, progname );

	while( execl( progname, progname, (char *)0 ) < 0 )
	{
#ifndef	WIN32
		if( errno != EAGAIN && errno != EINTR )
			break;
#else
		if( errno != ENOMEM )
			break;
#endif
	}
	if( retval != (short *)0 )
		*retval = -1;
	return;
}
