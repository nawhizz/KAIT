/* Kind of source is DOS, WIN32 and UNIX */
#ifndef	WIN32
#define	UNIX
/* #define	DOS	*/
#endif

/* #define	INPUT_TIMTOUTSEC */
/* History */
/*----------------------------------------------------------------------------*/
/* 2000.12.15. ksh. digital server porting 반영				      */
/*----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------*/
/*	COMMENTS							*/
/*----------------------------------------------------------------------*/

/*
	< LOGIC >

	    client, server 공히


	    suntak:
		w : showall
		h : showsts
		t : gotoSS
		n : nextSS

		o : open
		g : gethostname
		p : option
		i : ioctl
		e : select

		b : bind(서버용)
		l : listen
		a : accept(서버용)
		c : connect(클라이언트용) : gethostbyname() 이용

		r : rcvtxt
		s : sendtxt
		v : rcvfile
		f : sendfile

		k : forkap
		q : exec
		x : close
		y : closeall
		z : quit

	    do:
		selected function
*/

/*----------------------------------------------------------------------*/
/*	INCLUDE	FILES							*/
/*----------------------------------------------------------------------*/

#ifdef	UNIX
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/un.h>
#include <signal.h>
#include <sys/types.h>
# ifndef	HYSYS_HP
# include <time.h>
# include <sys/select.h>
# endif
#include <sys/wait.h>
#include <sys/socket.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/time.h>
#include <errno.h>
#endif

#ifdef	DOS
#include <ctype.h>
#include <stdio.h>
#include <process.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys\types.h>
#include <sys\stat.h>
#include <time.h>
#include <xti.h>
#include <sys\tk_types.h>
#include <sys\ioctl.h>
#include <sys\socket.h>
#include <netinet\in.h>
#include <netdb.h>
#include <sys/nfs_time.h>
#include "PCGPS.H"
#endif

#ifdef	WIN32
#include	<stdio.h>
#include	<time.h>
#include	<io.h>
#include	<process.h>
#include	<windows.h>
#endif

#include	"cbuni.h"

/*----------------------------------------------------------------------*/
/*	DEFINE VARIABLES						*/
/*----------------------------------------------------------------------*/

#define NSESSION		20
#define	CONNECT_TIMEOUTSEC	10L
#define	ACCEPT_TIMEOUTSEC	30L

/*----------------------------------------------------------------------*/
/*	DATA DECLARATION 						*/
/*----------------------------------------------------------------------*/

char		rbuf[16*1024] ={0};
char		sbuf[16*1024] ={0};

int		sock[NSESSION];
int		connected[NSESSION];
int		binded[NSESSION];
int		listened[NSESSION];	
int		accepted[NSESSION];
int		naccepted[NSESSION];
int		parentsess[NSESSION];
char		servername[NSESSION][100];
char		clientname[NSESSION][100];
char		clientaddr[NSESSION][16];	/*"999.999.999.999"*/
unsigned	portno[NSESSION];
int		listencnt[NSESSION];	/* listen() connection que count */

int		sess=0;
int		nopened = 0;
int		nconnected = 0;
int		nbinded = 0;
int		nlistened = 0;

char		myhostname[100] = "";
char		suntak[100];


void	initdata();
void	prt_suntak();
void	prt_ss();
void	gotoSS_rtn();
void	nextSS_rtn();
void	open_rtn();
void	gethostname_rtn();
void	option_rtn();
void	opt_DEBUG();
void	opt_REUSEADDR();
void	opt_KEEPALIVE();
void	opt_DONTROUTE();
void	opt_LINGER();
void	opt_BROADCAST();
void	opt_OOBINLINE();
void	opt_SNDBUF();
void	opt_RCVBUF();
void	opt_ALL();
void	getopt_DEBUG();
void	getopt_REUSEADDR();
void	getopt_KEEPALIVE();
void	getopt_DONTROUTE();
void	getopt_LINGER();
void	getopt_BROADCAST();
void	getopt_OOBINLINE();
void	getopt_SNDBUF();
void	getopt_RCVBUF();
void	getopt_TYPE();
void	getopt_ERROR();
void	select_rtn();
void	accept_rtn();
void	bind_rtn();
void	connect_rtn();
#ifdef	DOS
void	sleepsec CBD2(( int waitsec ));
#endif
void	showall_rtn();
void	showsts_rtn();
void	ioctl_rtn();
void	listen_rtn();
void	rcvtxt_rtn();
void	sendtxt_rtn();
void	rcvfile_rtn();
void	sendfile_rtn();
void	forkap_rtn();
void	exec_rtn();
void	close_rtn();
void	closeall_rtn();
void	endprog_rtn();
int	find_newsession();
int	find_nextsession();
#ifdef	UNIX
void	sighandle CBD2(( int signo ));
void	setsignal();
#endif

/*----------------------------------------------------------------------------*/
/*	Main Procedure							      */
/*----------------------------------------------------------------------------*/

void
#if	defined( __CB_STDC__ )
main( int argc, char *argv[] )
#else
main( argc, argv )
int	argc;
char	*argv[];
#endif
{

	initdata();

	printf( "+-------------------------------------------+\n" );
	printf( "|     socket function test utility          |\n" );
	printf( "|         run by P/C  and UNIX by pair      |\n" );
	printf( "|         run by UNIX and UNIX by pair      |\n" );
	printf( "|                                           |\n" );
	printf( "|                         HYSYS 1995.4.     |\n" );
	printf( "+-------------------------------------------+\n" );
	printf( "\n" );

	for( ; ; )
	{
		prt_ss();
		prt_suntak();
		printf( "====> " );
		scanf(	"%s", suntak );

		if( isalpha( suntak[0] ) && isupper( suntak[0] ) )
			suntak[0] = tolower( suntak[0] );
		switch( suntak[0] )
		{
			case 'w' : showall_rtn(); break;
			case 'h' : showsts_rtn(); break;
			case 't' : gotoSS_rtn(); break;
			case 'n' : nextSS_rtn(); break;

			case 'o' : open_rtn(); break;
			case 'g' : gethostname_rtn(); break;
			case 'p' : option_rtn(); break;
			case 'i' : ioctl_rtn(); break;
			case 'e' : select_rtn(); break;

			case 'b' : bind_rtn(); break;
			case 'l' : listen_rtn(); break;
			case 'a' : accept_rtn(); break;
			case 'c' : connect_rtn(); break;

			case 'r' : rcvtxt_rtn(); break;
			case 's' : sendtxt_rtn(); break;
			case 'v' : rcvfile_rtn(); break;
			case 'f' : sendfile_rtn(); break;

			case 'k' : forkap_rtn(); break;
			case 'q' : exec_rtn(); break;
			case 'x' : close_rtn(); break;
			case 'y' : closeall_rtn(); break;
			case 'z' : endprog_rtn(); break;
			default  : break;
		}
	}
}

void
initdata()
{
	int	i;
#ifdef	WIN32
	WORD	wVersionRequested;
	WSADATA	wsaData;
#endif

	for( i=0; i<NSESSION; i++ )
	{
		sock[i] = -1;
		connected[i] = 0;
		accepted[i] = 0;
		binded[i] = 0;
		listened[i] = 0;
		listencnt[i] = 0;
		naccepted[i] = 0;
		servername[i][0] = '\0';
		clientname[i][0] = '\0';
		clientaddr[i][0] = '\0';
		parentsess[i] = -1;
		portno[i] = 0;
	}

	sess=0;
	nopened = 0;
	nconnected = 0;
	nbinded = 0;
	nlistened = 0;
	myhostname[0] = '\0';

	for( i=0; i<sizeof sbuf; i++ )
	{
		if( i % 50 == 49 ) sbuf[i] = '\r';
		if( i && ( i % 50 == 0 ) ) sbuf[i] = '\n';
		else sbuf[i] = '0'+ i % 50;
	}

	memset( rbuf, 0, sizeof rbuf );

#ifdef	WIN32
	wVersionRequested = MAKEWORD( 2, 0 );
	if( WSAStartup ( wVersionRequested, &wsaData ) )
	{
		printf( "Winsock DLL Initialize Error ( errno=%d )\n",
						WSAGetLastError() );
		exit(1);
	}
#endif
#ifdef	UNIX
	setsignal();
#endif	/* UNIX */
}

void
prt_suntak()
{
	printf( "\n" );
	printf( "w: showall h: showsts  t: gotoSS   n: nextSS\n" );
	printf( "o: open    p: option   i: ioctl    e: select\n" );
	printf( "b: bind    l: listen   a: accept   c:connect\n" );
	printf( "r: rcvtxt  s: sendtxt  v: rcvfile  f: sendfile\n" );
	printf( "k: forkap  q: exec     x: close    y: closeall\n" );
	printf( "z: quit\n" );
	printf( "\n" );
}

void
prt_ss()
{
	printf( "\n---------------------------------------\n" );
	printf( "SS %d sock %d : ", sess, sock[ sess ] );

	if( connected[ sess ] )
		printf( "connected to %s port %u", servername[ sess ],
						portno[ sess ] );
	else if( accepted[ sess ] )
		printf( "accepted from %s", clientname[ sess ] );
	else if( binded[ sess ] )
	{
		printf( "binded to port %u", portno[ sess ] );
		if( listened[ sess ] )
			printf( " now listening with %d connection queue",
				listencnt[ sess ] );
	}
	printf( "\n---------------------------------------\n" );
}

void
gotoSS_rtn()
{
	printf( "\n<gotoSS>\n\n" );

	for( ; ; )
	{
		printf( "\nsession no => " );
		scanf( "%s", suntak );
		if( ( sess = atoi( suntak ) ) < 0 )
			continue;

		if( sess >= NSESSION )
			printf( "max. session no = %d\n", NSESSION - 1 );
		else
			break;
	}
}

void
nextSS_rtn()
{
	int	nextsess;

	printf( "\n<nextSS>\n\n" );

	nextsess = find_nextsession();

	if( nextsess < 0 )
		printf( "no next session opened !\n" );
	else
	{
		printf( "next opened session = %d\n", nextsess );
		sess = nextsess;
	}
}

void
open_rtn()
{
	int	newsess;
	int	newsock;

	printf( "\n<open new socket>\n\n" );

	if( ( newsess = find_newsession() ) < 0 )
	{
		printf( "no more session to open socket !\n" );
		return;
	}

	newsock = socket(AF_INET,SOCK_STREAM, 0);

	if( newsock < 0 )
		printf( "socket open error ( return = %d errno = %d) !\n",
						newsock,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	else
	{
		sess = newsess;
		sock[ sess ] = newsock;
		printf( "new socket ( %d ) opened\n", sock[ sess ] );
		printf( "new session no = %d\n", sess );
		nopened++;
	}
}

void
gethostname_rtn()
{
	printf( "\n<gethostname>\n\n" );

	if( gethostname( myhostname, sizeof myhostname ) < 0 )
		printf( "gethostname() error ( errno = %d ) !\n",
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	else
		printf( "myhostname = %s\n", myhostname );
}

void
option_rtn()
{
	printf( "\n<option> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	for( ; ; )
	{
		printf( "a: ALL      g: DEBUG    u:REUSEADDR  k:KEEPALIVE\n" );
		printf( "d:DONTROUTE l: LINGER   b:BROADCAST  o:OOBINLINE\n" );
		printf( "s:SNDBUFsz  r: RCVBUFsz t:TYPE       e:ERROR     z:end\n" );
		printf( "======> " );
		scanf( "%s", suntak );

		if( isalpha( suntak[0] ) && isupper( suntak[0] ) )
			suntak[0] = tolower( suntak[0] );
		switch( suntak[0] )
		{
			case 'a' : opt_ALL(); break;
			case 'g' : opt_DEBUG(); break;
			case 'u' : opt_REUSEADDR(); break;
			case 'k' : opt_KEEPALIVE(); break;
			case 'd' : opt_DONTROUTE(); break;
			case 'l' : opt_LINGER(); break;
			case 'b' : opt_BROADCAST(); break;
			case 'o' : opt_OOBINLINE(); break;
			case 's' : opt_SNDBUF(); break;
			case 'r' : opt_RCVBUF(); break;
			case 't' : getopt_TYPE(); break;
			case 'e' : getopt_ERROR(); break;
			case 'z' : return;
			default  : break;
		}
		printf( "\n" );
	}
}

void
opt_DEBUG()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_DEBUG();

	for( ; ; )
	{
		printf( "SOL_DEBUG => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_DEBUG,
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_DEBUG ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "DEBUG = %d\n", iopt );
}

void
opt_REUSEADDR()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_REUSEADDR();

	for( ; ; )
	{
		printf( "SOL_REUSEADDR => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_REUSEADDR, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_REUSEADDR ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "REUSEADDR = %d\n", iopt );
}

void
opt_KEEPALIVE()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_KEEPALIVE();

	for( ; ; )
	{
		printf( "SOL_KEEPALIVE => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_KEEPALIVE, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_KEEPALIVE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "KEEPALIVE = %d\n", iopt );
}

void
opt_DONTROUTE()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_DONTROUTE();

	for( ; ; )
	{
		printf( "SOL_DONTROUTE => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_DONTROUTE, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_DONTROUTE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "DONTROUTE = %d\n", iopt );
}

void
opt_LINGER()
{
	struct	linger	lopt ;
	int	ret;
	int	len;

	getopt_LINGER();

	for( ; ; )
	{
		printf( "SOL_LINGER => " );
		scanf( "%s", suntak );
		if( ( lopt.l_onoff = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	
	for( ; ; )
	{
		printf( "    LINGER TIME SEC => " );
		scanf( "%s", suntak );
		if( ( lopt.l_linger = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( lopt );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_LINGER, 
		(char *)&lopt, len ) ) < 0 ) {
		printf( "setsockopt( SO_LINGER ) ERR ! ( ret = %d )\n", ret );
	}
	else
	{
		printf( "LINGER = %d, LINGER TIME = %d sec\n",
			lopt.l_onoff, lopt.l_linger );
	}
}

void
opt_BROADCAST()
{
#ifdef	DOS
	printf( "BROADCAST option not applicable in PC\n" );
	return;
#else	/* DOS */
	int	iopt;
	int	ret;
	int	len;

	getopt_BROADCAST();

	for( ; ; )
	{
		printf( "SOL_BROADCAST => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_BROADCAST, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_DONTROUTE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "BROADCAST = %d\n", iopt );
#endif	/* DOS */
}

void
opt_OOBINLINE()
{
#ifdef	DOS
	printf( "OOBINLINE option not applicable in PC\n" );
	return;
#else	/* DOS */
	int	iopt;
	int	ret;
	int	len;

	getopt_OOBINLINE();

	for( ; ; )
	{
		printf( "SOL_OOBINLINE => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_OOBINLINE, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_OOBINLINE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "OOBINLINE = %d\n", iopt );
#endif	/* DOS */
}

void
opt_SNDBUF()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_SNDBUF();

	for( ; ; )
	{
		printf( "SOL_SNDBUF size in bytes => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_SNDBUF, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_SNDBUF ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "SNDBUF = %d bytes.\n", iopt );
}

void
opt_RCVBUF()
{
	int	iopt;
	int	ret;
	int	len;

	getopt_RCVBUF();

	for( ; ; )
	{
		printf( "SOL_RCVBUF size in bytes => " );
		scanf( "%s", suntak );
		if( ( iopt = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	len = sizeof( int );
	if( ( ret = setsockopt( sock[ sess ], SOL_SOCKET, SO_RCVBUF, 
		(char *)&iopt,len ) ) < 0 )
	{
		printf( "setsockopt( SO_RCVBUF ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "RCVBUF = %d bytes\n", iopt );
}

void
opt_ALL()
{
	getopt_DEBUG();
	getopt_REUSEADDR();
	getopt_KEEPALIVE();
	getopt_DONTROUTE();
	getopt_LINGER();
	getopt_BROADCAST();
	getopt_OOBINLINE();
	getopt_SNDBUF();
	getopt_RCVBUF();
	getopt_TYPE();
	getopt_ERROR();
}

void
getopt_DEBUG()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_DEBUG,
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_DEBUG ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "DEBUG = %d\n", ( iopt ? 1 : 0 ) );
}

void
getopt_REUSEADDR()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_REUSEADDR, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_REUSEADDR ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "REUSEADDR = %d\n", ( iopt ? 1 : 0 ) );
}

void
getopt_KEEPALIVE()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_KEEPALIVE, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_KEEPALIVE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "KEEPALIVE = %d\n", ( iopt ? 1 : 0 ) );
}

void
getopt_DONTROUTE()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_DONTROUTE, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_DONTROUTE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "DONTROUTE = %d\n", ( iopt ? 1 : 0 ) );
}

void
getopt_LINGER()
{
	struct	linger	lopt ;
	int	ret;
	int	len;

	len = sizeof( lopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_LINGER, 
		(char *)&lopt, &len ) ) < 0 )
	{
		printf( "getsockopt( SO_LINGER ) ERR ! ( ret = %d )\n", ret );
	}
	else
	{
		printf( "LINGER = %d, LINGER TIME = %d sec\n",
			lopt.l_onoff, lopt.l_linger );
	}
}

void
getopt_BROADCAST()
{
#ifdef	DOS
	printf( "BROADCAST option not applicable in PC\n" );
	return;
#else	/* DOS */
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_BROADCAST, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_BROADCAST ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "BROADCAST = %d\n", ( iopt ? 1 : 0 ) );
#endif	/* DOS */
}

void
getopt_OOBINLINE()
{
#ifdef	DOS
	printf( "OOBINLINE option not applicable in PC\n" );
	return;
#else	/* DOS */
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_OOBINLINE, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_OOBIBLINE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "OOBINLINE = %d\n", ( iopt ? 1 : 0 ) );
#endif	/* DOS */
}

void
getopt_SNDBUF()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_SNDBUF, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_SNDBUF ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "SNDBUF = %d bytes.\n", iopt );
}

void
getopt_RCVBUF()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_RCVBUF, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_RCVBUF ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "RCVBUF = %d bytes\n", iopt );
}

void
getopt_TYPE()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_TYPE, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_TYPE ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "TYPE = %d\n", iopt );
}

void
getopt_ERROR()
{
	int	iopt;
	int	ret;
	int	len;

	len = sizeof( iopt );
	if( ( ret = getsockopt( sock[ sess ], SOL_SOCKET, SO_ERROR, 
		(char *)&iopt,&len ) ) < 0 )
	{
		printf( "getsockopt( SO_ERROR ) ERR ( ret = %d errno = %d )!\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
	}
	else
		printf( "ERROR = %d\n", iopt );
}

void
select_rtn()
{
	fd_set	readfds;
	fd_set	writefds;
	fd_set	exceptfds;
	struct	timeval	timeout;
	int	nfds, nfds_ready;
	int	timeoutsec;

	printf( "\n<select> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

#ifdef	INPUT_TIMTOUTSEC
	for( ; ; )
	{
		printf( "timeout sec => " );
		scanf( "%s", suntak );
		if( ( timeoutsec = atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	printf( "\n" );
#else
	timeoutsec = 10;
	printf( "timeout sec = %d", timeoutsec );
	printf( "\n" );
#endif

        timeout.tv_sec = (long)timeoutsec;
        timeout.tv_usec = 0;

	nfds = sock[ sess ] + 1;

	FD_ZERO( &readfds );
	FD_ZERO( &writefds );
	FD_ZERO( &exceptfds );

	FD_SET( sock[ sess ], &readfds );
	FD_SET( sock[ sess ], &writefds );
	FD_SET( sock[ sess ], &exceptfds );

	printf( "select() ing....... (timeout=%d sec)\n", timeoutsec );

	nfds_ready = select( nfds, &readfds, &writefds, &exceptfds, &timeout );
	
	printf( "select() returned %d ( = no of socks ready )\n", nfds_ready );
	if( nfds_ready <= 0 )
		return;

	if( FD_ISSET( sock[ sess ], &readfds ) )
		printf( "-> ready for read\n" );
	if( FD_ISSET( sock[ sess ], &writefds ) )
		printf( "-> ready for write\n" );
	if( FD_ISSET( sock[ sess ], &exceptfds ) )
		printf( "-> exception condition occurred !\n" );
}

void
accept_rtn()
{
	struct	sockaddr	cli_addr;
	struct	hostent		*clientinfo;
	int	subsock;
	int	info_len = sizeof( struct sockaddr );
	int	parentsessno, newsess;
	time_t	startTime, currTime;
    
	printf( "\n<accept> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( connected[ sess ] )
	{
		printf( "connected to  server %s %u\n",
			servername[ sess ], portno[ sess ] );
		return;
	}

	if( accepted[ sess ] )
	{
		printf( "already accepted with %s ( %s )\n",
			clientname[ sess ], clientaddr[ sess ] );
		return;
	}

	if( !binded[ sess ] )
	{
		printf( "not binded yet !\n" );
		return;
	}

	if( !listened[ sess ] )
	{
		printf( "not listened yet !\n" );
		printf( "Do you want to accept really ? (y/n) -> " );
		scanf( "%s", suntak );
		if( suntak[0] != 'Y' && suntak[0] != 'y' )
			return;
	}

	if( ( newsess = find_newsession() ) < 0 )
	{
		printf( "no more session to open sub socket !\n" );
		return;
	}

	time( &startTime ) ;
	currTime = startTime;

	printf( "accepting connection from client ....\n" );

	for( ; ; )
	{
		cli_addr.sa_family = AF_INET;
		memset( cli_addr.sa_data, 0, sizeof cli_addr.sa_data );

		subsock = accept( sock[ sess ], &cli_addr, &info_len );
		if( subsock > 0 )
		{
			naccepted[ sess ]++;

			parentsessno = sess;
			sess = newsess;
			nopened ++;
			sock[ sess ] = subsock;
			portno[ sess ] = portno[ parentsessno ];
			accepted[ sess ] = 1;
			parentsess[ sess ] = parentsessno;

			sprintf( clientaddr[ sess ], "%d.%d.%d.%d",
				(unsigned char) cli_addr.sa_data[2],
				(unsigned char) cli_addr.sa_data[3],
				(unsigned char) cli_addr.sa_data[4],
				(unsigned char) cli_addr.sa_data[5] );

			clientinfo = gethostbyaddr( &cli_addr.sa_data[2], 4,
				AF_INET );

			if( clientinfo )
				strcpy( clientname[sess], clientinfo->h_name );
			else
				strcpy( clientname[ sess ], "unknown host" );

			printf( "accepted connection from client %s ( %s ).\n",
				clientname[ sess ], clientaddr[ sess ] );

			return;
		}
		else
		{
			printf( "accept() error ( return = %d errno = %d )\n",
							subsock,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);

			time( &currTime ) ;
			if( ( currTime - startTime ) > ACCEPT_TIMEOUTSEC )
			{
				printf( " => no connection request !\n" );
				return;
			}
			printf( " retrying ....\n" );
		}
	}
}

void
bind_rtn()
{
	struct	sockaddr_in	hostname;
	int	ret;

	printf( "\n<bind> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( connected[ sess ] )
	{
		printf( "already connected to server %s %u\n",
			servername[ sess ], portno[ sess ] );
		return;
	}
	else if( accepted[ sess ] )
	{
		printf( "already accepted from  client %s\n",
			clientname[ sess ] );
		return;
	}
	else if( binded[ sess ] )
	{
		printf( "already binded to port %u !\n", portno[ sess ] );
		return;
	}

	for( ; ; )
	{
		printf( "portno => " );
		scanf( "%s", suntak );
		if( ( portno[sess] = (unsigned)atoi( suntak ) ) < 0 )
			continue;
		break;
	}

	hostname.sin_family = AF_INET;
	hostname.sin_addr.s_addr = htonl(INADDR_ANY);
	hostname.sin_port = htons( (unsigned short )portno[ sess ] );
    
	printf( "\nbinding to port %u ....\n", portno[ sess ] );

	if( ( ret = bind( sock[ sess ], (struct sockaddr *) &hostname,
		sizeof(hostname) ) ) < 0)
	{
		printf( "bind() error ( return = %d errno = %d ) !\n",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
		return;
	}

	binded[ sess ] = 1;
	nbinded++;
	printf( "binded.\n" );

	return;
}

void
connect_rtn()
{
	time_t	startTime, currTime;
	struct	sockaddr_in	hostname;
	struct	hostent 	*hosthp;
	int	ret;

	printf( "\n<connect> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( connected[ sess ] )
	{
		printf( "already connected to  server %s %u\n",
			servername[ sess ], portno[ sess ] );
		return;
	}
	else if( accepted[ sess ] )
	{
		printf( "already accepted from  client %s\n",
			clientname[ sess ] );
		return;
	}
	else if( binded[ sess ] )
	{
		printf( "already binded as port %u !\n", 
			portno[ sess ] );
		return;
	}

	printf( "servername => " );
	scanf( "%s", servername[ sess ] );
	for( ; ; )
	{
		printf( "portno => " );
		scanf( "%s", suntak );
		if( ( portno[sess] = (unsigned)atoi( suntak ) ) < 0 )
			continue;
		break;
	}
	printf( "\n" );

	/* find host */
	hosthp = gethostbyname( servername[ sess ] );
	if(hosthp == 0)
	{
		printf( "unknown host( %s )", servername[ sess ] );
		return;
	}

	memcpy( &hostname.sin_addr, hosthp->h_addr, hosthp->h_length );
	hostname.sin_family = AF_INET;
	hostname.sin_port = htons( (unsigned short )portno[ sess ] );

	/* connect to host */
	time( &startTime ) ;
	currTime = startTime;

	printf("connecting to host %s port %u ......\n",
	       servername[ sess ], portno[ sess ] );

	for( ; ; )
	{
		if( ( ret = connect( sock[ sess ],(struct sockaddr *)&hostname,
					sizeof (struct sockaddr ) ) ) == 0)
		     break;
		time( &currTime ) ;
		printf( "connect() error ( return = %d errno = %d )",
								ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
		if( ( currTime - startTime ) > CONNECT_TIMEOUTSEC )
		{
			printf( " => connect Timeout." );
			return;
		}
#ifdef	DOS
		sleepsec(1);
#endif
#ifdef	WIN32
		Sleep( 1000 );
#endif
#ifdef	UNIX
		sleep(1);
#endif
		printf( ", retrying....\n" );
	}

	printf( "connected.\n" );
	connected[ sess ] = 1;
	nconnected++;

	return;
}

#ifdef	DOS
void
#if	defined( __CB_STDC__ )
sleepsec( int waitsec )
#else
sleepsec( waitsec )
int	waitsec;
#endif
{
	time_t	startTime, currTime;

	time( &startTime ) ;
	for( ; ; )
	{
		time( &currTime ) ;
		if( ( currTime - startTime ) >= waitsec )
			return;
	}
}
#endif

void
showall_rtn()
{
	int	i;

	printf( "\n<showall> for all sessions\n\n", sess );

	if( nopened <= 0 )
	{
		printf( "no socket opened !\n" );
		return;
	}

	printf( "nopened = %d  nconnected = %d  nbinded = %d  nlistened = %d\n",
		nopened, nconnected, nbinded, nlistened );

	printf( "\ncurrent SS = %d\n", sess );

	for( i=0; i<NSESSION; i++ )
	{
		if( sock[i] < 0 )
			continue;

		printf( "\nSS %2d : ", i );
		printf( "sock %d ", sock[i] );
		if( connected[i] )
		{
			printf( "connected to %s %u\n", servername[i],
				portno[i] );
			continue;
		}
		else if( accepted[i] )
		{
			printf( "accepted ( client = %s ) \n",
				clientname[ sess ] );
			continue;
		}
		else if( binded[i] )
		{
			printf( "binded ( port %u ) ", portno[i] );
			if( listened[i] )
			{
				printf( "%d accepted ", naccepted );
				printf( "now listening with %d connect. que.\n",
					listencnt[ i ] );
			}
		}
		else
			printf( "\n" );
	}
}

void
showsts_rtn()
{
	printf( "\n<showsts> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( connected[ sess ] )
	{
		printf( "connected to %s port %u\n",
		servername[ sess ], portno[ sess ] );
		return;
	}
	else if( accepted[ sess ] )
	{
		printf( "accepted from client %s ( %s )\n",
		clientname[ sess ], clientaddr[ sess ] );
		return;
	}
	else if( binded[ sess ] )
	{
		printf( "binded to port %u ", portno[ sess ] );
		if( listened[ sess ] )
		{
			printf( "listening now with %d connect. que.\n",
				listencnt[ sess ] );
			printf( "naccepted = %d ", naccepted );
		}
		else
			printf( "not listening.\n" );
	}
	else
		printf( "not binded /or/ connected.\n" );
}

void
ioctl_rtn()
{
	int	blocking = 1 ;
	int	ret;

	printf( "\n<ioctl> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

#ifdef	DOS
	if( ( ret = ioctl( sock[ sess ], FIONBIO , &blocking ) ) != 0 )
	{
		printf( "ioctl( FIONBIO ) ERR ( return = %d ) !\n", ret );
		return;
	}
#endif
#ifdef	WIN32
	if( ( ret = ioctlsocket( sock[ sess ], FIONBIO , &blocking ) ) != 0 )
	{
		printf( "ioctl( FIONBIO ) ERR ( return = %d ) !\n", ret );
		return;
	}
#endif
	return;
}

void
listen_rtn()
{
	int	ret;
	int	listencnttmp;

	printf( "\n<listen> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( connected[ sess ] )
	{
		printf( "connected to server %s %u !\n",
			servername[ sess ], portno[ sess ] );
		return;
	}
	else if( accepted[ sess ] )
	{
		printf( "accepted from %s !\n", clientname[ sess ] );
		return;
	}
	else if( !binded[ sess ] )
	{
		printf( "socket not binded !\n" );
		return;
	}
	else if( listened[ sess ] )
	{
		printf( "already listening with %d connection que !\n",
			listencnt[ sess ] );
		return;
	}

	for( ; ; )
	{
		printf( "connection que to listen -> listen( %d, nque ) ",
			sock[ sess ] );
		scanf( "%s", suntak );
		if( ( listencnttmp = atoi( suntak ) ) < 0 )
			continue;
		break;
	}

	if( ( ret = listen( sock[ sess ], listencnttmp ) ) < 0 )
	{
		printf( "listen() ERR ( return = %d errno = %d) !\n", ret,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
		return;
	}
	else
		printf( "now listening with %d connect que.\n", listencnttmp );

	listencnt[ sess ] = listencnttmp;
	listened[ sess ] = 1;
	nlistened++;

	return;
}

void
rcvtxt_rtn()
{
	int	nrcvd;
	int	ntorcv;

	printf( "\n<rcvtxt> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( !accepted[ sess ] && !connected[ sess ] )
	{
		printf( "not connected/or/accepted !\n" );
		printf( "Do you want to recv really ? (y/n) -> " );
		scanf( "%s", suntak );
		if( suntak[0] != 'Y' && suntak[0] != 'y' )
			return;
	}

	for( ; ; )
	{
		for( ; ; )
		{
			printf( "bytes to rcv => " );
			scanf( "%s", suntak );
			if( ( ntorcv = atoi( suntak ) ) < 0 )
				continue;
			break;
		}
		if( ntorcv == 0 ) break;
		nrcvd = recv( sock[ sess ], rbuf, ntorcv, 0 );
		printf( "nrcvd = %d\n", nrcvd );
		if( nrcvd > 0 )
			printf( "data = %.*s\n", nrcvd, rbuf );
		else
			printf( "recv() ERR ( return = %d errno = %d )\n",
								nrcvd,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
		printf( "\n" );
	}
}

void
sendtxt_rtn()
{
	int	nsent;
	int	ntosend;

	printf( "\n<sendtxt> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

	if( !accepted[ sess ] && !connected[ sess ] )
	{
		printf( "not connected/or/accepted !\n" );
		printf( "Do you want to send really ? (y/n) -> " );
		scanf( "%s", suntak );
		if( suntak[0] != 'Y' && suntak[0] != 'y' )
			return;
	}

	for( ; ; )
	{
		for( ; ; )
		{
			printf( "bytes to send => " );
			scanf( "%s", suntak );
			if( ( ntosend = atoi( suntak ) ) < 0 )
				continue;
			break;
		}
		if( ntosend == 0 )
			break;
		nsent = send( sock[ sess ], sbuf, ntosend, 0 );
/*
		nsent = write( sock[ sess ], sbuf, ntosend );
*/
		if( nsent == ntosend )
			printf( "nsent = %d\n", nsent );
		else if( nsent > 0 )
			printf( "send() ERR ( nsent = %d )\n", nsent );
		else
			printf( "send() ERRor ( return = %d errno = %d )\n",
								nsent,
#ifdef	WIN32
						WSAGetLastError()
#else
						errno
#endif
						);
		printf( "\n" );
	}
}

void
rcvfile_rtn()
{
	printf( "\n<rcvfile> for SS %d sock %d\n\n", sess, sock[ sess ] );
	printf( "this function not supported yet !\n" );
}

void
sendfile_rtn()
{
	printf( "\n<sendfile> for SS %d sock %d\n\n", sess, sock[ sess ] );
	printf( "this function not supported yet !\n" );
}

void
forkap_rtn()
{
	char	progpath[256];
#ifdef	UNIX
	int	pid;
#endif
	
	printf( "\n<forkap> for SS %d sock %d\n\n", sess, sock[ sess ] );
	
	for( ; ; )
	{
		printf( "program path to fork => " );
		scanf( "%s", progpath );
#ifdef	UNIX
		if( access( progpath, R_OK ) < 0 )
		{
			printf( "no such program ( %s ) !\n", progpath );
			printf( "\n" );
			continue;
		}
		if( access( progpath, X_OK ) < 0 )
		{
			printf( "cannot execute program ( %s )!\n", progpath );
			printf( "\n" );
			continue;
		}
		pid = fork();
		if( pid )
		{
			wait( (int *)0 );
			return;
		}
		else
		{
			execl( progpath, progpath, (char *)0 );
			printf( "exec program( %s ) ERR !\n", progpath );
			exit( 1 );
		}
#else
		if( access( progpath, 0 ) < 0 )
		{
			printf( "no such program ( %s ) !\n", progpath );
			printf( "\n" );
			continue;
		}
		if( spawnl( P_WAIT, progpath, progpath, (char *)0 ) < 0 )
			printf( "spawn program( %s ) ERR !\n", progpath );
		else
			return;
#endif
	}
}

void
exec_rtn()
{
	char	progpath[256];
	
	printf( "\n<exec> for SS %d sock %d\n\n", sess, sock[ sess ] );
#ifdef	UNIX
	strcpy( progpath, "socktst" );
#else
	strcpy( progpath, "socktst.exe" );
#endif
	execl( progpath, progpath, (char *)0 );
	printf( "exec program( %s ) ERR !\n", progpath );
	return;
}

void
close_rtn()
{
	int	ret;

	printf( "\n<close> for SS %d sock %d\n\n", sess, sock[ sess ] );

	if( sock[ sess ] < 0 )
	{
		printf( "socket not opened !\n" );
		return;
	}

#ifdef	WIN32
	if( ( ret = closesocket( sock[ sess ] ) ) < 0 )
#else
	if( ( ret = close( sock[ sess ] ) ) < 0 )
#endif
	{
		printf( "close() ERR ( ret = %d ) !\n", ret );
		return;
	}
	else
	{
		printf( "closed. \n", sock[ sess ] );

		sock[ sess ] = -1;
		nopened --;

		/* case client socket */
		if( connected[ sess ] )
		{
			connected[ sess ] = 0;
			nconnected --;
		}
		/* case sub socket */
		else if( accepted[ sess ] )
		{
			accepted[ sess ] = 0;
			naccepted[ parentsess[ sess ] ]--;
			parentsess[ sess ] = -1;
		}
		/* case master socket */
		else if( binded[ sess ] )
		{
			binded[ sess ] = 0;
			nbinded --;
			if( listened[ sess ] )
			{
				listened[ sess ] = 0;
				listencnt[ sess ] = 0;
				nlistened --;
			}
		}
	}
}

void
closeall_rtn()
{
	int	i;
	int	nopened_org;

	printf( "\n<closeall>\n\n" );

	nopened_org = nopened;
	for( i=0; i<NSESSION; i++ )
	{
		if( sock[ i ] < 0 )
			continue;
		sess = i;
		close_rtn();
	}
	sess = 0;
	printf( "all opened sockets ( %d ) closed.\n", nopened_org );
}

void
endprog_rtn()
{
	closeall_rtn();
#ifdef	WIN32
	WSACleanup();
#endif
	printf( "\n" );
	exit(0);
}

int
find_newsession()
{
	int	i;

	if( sock[ sess ] < 0 )
		return( sess );

	for( i=sess+1; i != sess; i++ )
	{
		if( i == NSESSION )
			i = 0;
		if( sock[ i ] < 0 )
			return( i );
	}
	return( -1 );
}

int
find_nextsession()
{
	int	i;

	for( i=sess+1; i != sess; i++ )
	{
		if( i == NSESSION )
			i = -1;
		if( sock[ i ] >= 0 )
			return( i );
	}
	return( -1 );
}

#ifdef	UNIX
void
#if	defined( __CB_STDC__ )
sighandle( int signo )
#else
sighandle( signo )
int	signo;
#endif
{
	if( signo != SIGCLD )
		signal( signo,sighandle );
	printf( "Signal(%d) Recieved !!\n", signo );
	if( signo == SIGCLD )
		signal( signo,sighandle );
	return;
}

void
setsignal()
{
	signal( SIGHUP, sighandle );
	signal( SIGINT, sighandle );
	signal( SIGQUIT, sighandle );
	signal( SIGILL, sighandle );
	signal( SIGTRAP, sighandle );
	signal( SIGIOT, sighandle );
	signal( SIGEMT, sighandle );
	signal( SIGFPE, sighandle );
	signal( SIGBUS, sighandle );
	signal( SIGSEGV, sighandle );
	signal( SIGSYS, sighandle );
	signal( SIGPIPE, sighandle );
	signal( SIGALRM, sighandle );
	signal( SIGTERM, sighandle );
	signal( SIGUSR1, sighandle );
	signal( SIGUSR2, sighandle );
	signal( SIGCLD, sighandle );
	signal( SIGPWR, sighandle );
	signal( SIGWINCH, sighandle );
	signal( SIGURG, sighandle );
	signal( SIGPOLL, sighandle );
	signal( SIGCONT, sighandle );
	signal( SIGTTIN, sighandle );
	signal( SIGTTOU, sighandle );
	signal( SIGVTALRM, sighandle );
	signal( SIGPROF, sighandle );
	signal( SIGXCPU, sighandle );
	signal( SIGXFSZ, sighandle );
/*2000.12.15. digital 추가*/
#if	!defined( HYSYS_HP ) && !defined( __digital__ )
	signal( SIGWAITING, sighandle );
	signal( SIGWAITING, sighandle );
	signal( SIGLWP, sighandle );
	signal( SIGFREEZE, sighandle );
	signal( SIGTHAW, sighandle );
#ifdef	SIGCANCEL	/* Added by YI, 990623 */
	signal( SIGCANCEL, sighandle );
#endif			/* Added by YI, 990623 */
#endif
	signal( SIGRTMIN, sighandle );
	signal( SIGRTMAX, sighandle );
}
#endif	/* UNIX */

/*---------------------------------------------------------------------------*/
/*  END OF PROGRAM							     */
/*---------------------------------------------------------------------------*/

