#include <stdio.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <errno.h>

#include "/home1/ieap/common/include/clmapi.h"

char	*lfifo = "/home1/ieap/kshutil/testfifo";

void sighandler( int signo )
{
printf( "rcv signal = %d\n", signo );
}

main()
{
	void	( * old_hndl ) (int);
	int	fd;

	setbuf( stdout, (char *)0 );

	signal( SIGINT, SIG_IGN );
	signal( SIGQUIT, SIG_IGN );
	signal( SIGILL, sighandler );
	signal( SIGABRT, sighandler );	/* SIGIOT */
	signal( SIGFPE, sighandler );
	signal( SIGBUS, sighandler );
	signal( SIGSEGV, sighandler );
	signal( SIGSYS, sighandler );
	signal( SIGPIPE, sighandler );
	signal( SIGTERM, sighandler );
	signal( SIGPWR, sighandler );
	signal( SIGURG, sighandler );
	signal( SIGIO, sighandler );	/* SIGPOLL */

	for( ; ; )
	{
		sleep( 1 );
		printf( "result = %d\n", lm_freefortpm( 10000, 0, "H0316   ", "T" ) ); 
	}
}
