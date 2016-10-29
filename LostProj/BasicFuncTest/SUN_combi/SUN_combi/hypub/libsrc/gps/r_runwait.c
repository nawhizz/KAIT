/* r_runwait() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork() & exex() & wait()					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*pname		program name to run
	output	: short *retval 	return value
*/

#include	<sys/types.h>
#ifndef		WIN32
#include	<sys/wait.h>
#include	<unistd.h>
#else
#include	<process.h>
#endif

#include	<errno.h>

#include	"gps.h"

#define 	R_PROGNAMESIZE	128		/* program name string size */

void CBD1
#if	defined( __CB_STDC__ )
r_runwait(char *pname,short *retval)
#else
r_runwait(pname,retval)
char	*pname;
short	*retval;
#endif
{
#ifndef	WIN32
	char	progname[R_PROGNAMESIZE+1];
	pid_t	chpid;

	if( pname == (char *)0 )
	{
		if( retval != (short *)0 )
			*retval = -1 ;
		return;
	}

	d_mkstr( pname, R_PROGNAMESIZE, progname );

	chpid = fork();
	if( chpid == -1 )
	{			 			/* if fork err */
		if( retval != (short *)0 )
			*retval = -2;
		return;
	}
	if( chpid == 0 )
	{						/* if child */
		while( execl( progname, progname, (char *)0 ) < 0 )
			 if( errno != EAGAIN && errno != EINTR )
				break;
		exit( 0 );
	}

	while( waitpid(chpid, (int *)0, 0)<0 && errno==EINTR ) ;

	if( retval != (short *)0 )
		*retval = 0;
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

	while( ( childpid = _spawnl( _P_WAIT, progname, (char *)0 ) ) == -1 )
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

	return;
}
