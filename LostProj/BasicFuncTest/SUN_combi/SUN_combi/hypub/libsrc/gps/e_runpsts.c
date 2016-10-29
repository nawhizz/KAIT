/* e_runpsts() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork or exec other program and return status			*/
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<sys/types.h>
#ifndef		WIN32
#include	<signal.h>
#include	<sys/wait.h>
#include	<unistd.h>
#else
#include	<stdio.h>
#include	<process.h>
#endif
#include	<errno.h>

#include	"gps.h"

/********** Added 3 lines by YI, 981209 ***************************************/
#ifndef	WIN32
static	void	(*old_sig_hndl)( int signo );
#endif
/******************************************************************************/

int CBD1
#if	defined( __CB_STDC__ )
e_runpsts( char *prog, char *args[] )
#else
e_runpsts( prog, args )
char	*prog;
char	*args[];
#endif
{
#ifdef	WIN32
	int	childps;

	if( prog == (char *)0 || prog[0] == (char)0 || args == (char **)0 )
		return( -1 );

	while( ( childps = _spawnvp( _P_WAIT, prog, args ) ) == -1 )
		if( errno != ENOMEM )
			break;

	if( childps < 0 )
		return( -1 );

	return( childps );
#else
	pid_t	childps;
	int	status;

	if( prog == (char *)0 || prog[0] == (char)0 || args == (char **)0 )
		return( -1 );

/********** Added 1 line by YI, 981209 ****************************************/
	old_sig_hndl = signal( SIGCLD, SIG_DFL );
/******************************************************************************/
	/* fork / exec */
	childps = fork();

	if( childps == 0 )
	{				/* in child process */
		while( execvp( prog, args ) < 0 )
			if( errno != EAGAIN && errno != EINTR )
				break;
		exit(errno);
	}
	else if( childps < 0 )
	{
/********** Added 1 line by YI, 981209 ****************************************/
		signal( SIGCLD, old_sig_hndl );
/******************************************************************************/
		return( -1 );
	}
	else
	{
		while( waitpid( childps, &status, 0 ) < 0 )	/* wait */
			if( errno != EINTR )
			{
/********** Added 1 line by YI, 981209 ****************************************/
				signal( SIGCLD, old_sig_hndl );
/******************************************************************************/
				return( -1 );
			}

/********** Added 1 line by YI, 981209 ****************************************/
		signal( SIGCLD, old_sig_hndl );
/******************************************************************************/

		if( WIFEXITED( status ) )
			return( WEXITSTATUS( status ) );

		return( -1 );
	}
#endif
}
