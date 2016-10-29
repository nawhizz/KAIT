/* e_runp() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork or exec other program					*/
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<sys/types.h>
#ifndef		WIN32
#include	<sys/wait.h>
#include	<unistd.h>
#else
#include	<stdio.h>
#include	<process.h>
#endif
#include	<errno.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_runp( char *prog, char *args[] )
#else
e_runp( prog, args )
char	*prog;
char	*args[];
#endif
{
#ifndef	WIN32
	pid_t	childps;

	if( prog == (char *)0 || prog[0] == (char)0 || args == (char **)0 )
		return( -1 );

	/* fork / exec */
	childps = fork();

	if( childps == 0 )
	{				/* in child process */
		while( execvp( prog, args ) < 0 )
			if( errno != EAGAIN && errno != EINTR )
				break;
		exit(1);
	}
	else if( childps < 0 )
	{
		return( -1 );
	}
	else
	{
		waitpid( childps, (int *)0, 0 ); 	/* wait */
		return( 0 );
	}
#else
	int	childps;

	if( prog == (char *)0 || prog[0] == (char)0 || args == (char **)0 )
		return( -1 );

	while( ( childps = _spawnvp( _P_WAIT, prog, args ) ) == -1 )
		if( errno != ENOMEM )
			break;

	if( childps == -1 )
		return( -1 );

	return( 0 );
#endif
}
