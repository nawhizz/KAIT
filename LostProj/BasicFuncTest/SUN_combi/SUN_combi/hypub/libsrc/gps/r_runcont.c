/* r_runcont() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork() & exex() & continue					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*pname		program name to run
	output	: short *retval 	return value
*/

#include	<sys/types.h>
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
r_runcont( char *pname, short *retval )
#else
r_runcont( pname, retval )
char	*pname;
short	*retval;
#endif
{
#ifndef	WIN32
	char	progname[R_PROGNAMESIZE+1];
	pid_t	childpid;

	if( pname == (char *)0 )
	{
		if( retval != (short *)0 )
			*retval = -1 ;
		return;
	}

	d_mkstr( pname, R_PROGNAMESIZE, progname );

	childpid = fork();
	if( childpid == -1 )
	{ 						/* if fork() err */
		if( retval != (short *)0 )
			*retval = -1;
		return;
	}
	if(childpid == 0)
	{					/* if child process */
		while( execl( progname, progname, (char *)0 ) < 0 )
			 if( errno != EAGAIN && errno != EINTR )
				break;
		exit( errno );
	}
	else
	{				/* case parent process */
		if( retval != (short *)0 )
			*retval = 0;
		return;
	}
#else
	char	progname[R_PROGNAMESIZE+1];
	int	childpid;

	if( pname == (char *)0 )
	{
		if( retval != (short *)0 )
			*retval = -1 ;
		return;
	}

	d_mkstr( pname, R_PROGNAMESIZE, progname );

	while( ( childpid = _spawnl( _P_NOWAIT, progname, (char *)0 ) ) == -1 )
		 if( errno != ENOMEM )
			break;
	if( childpid == -1 )		/* if _spawnl() err */
	{
		if( retval != (short *)0 )
			*retval = -1;
	}
	else
	{
		if( retval != (short *)0 )
			*retval = 0;
	}
#endif
}
