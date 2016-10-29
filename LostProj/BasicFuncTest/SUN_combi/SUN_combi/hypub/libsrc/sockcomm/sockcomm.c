/* TCP/IP SOCKET COMMUNICATION FUNCTIONS (common) */

/* history */
/* 960618 : n_sendsock(), n_recvsock() :
	select return value check error modify */

/* 960618 : n_writestream(), n_readstream() : added
	all same with n_sendsock()/n_recvsock() without using 
	write()/read() instead of send()/recv().
	sock->fd argument name changed. */

/* 960712 : n_getportno() : added. */

/* 970310 : n_select(), n_readstream(), n_writestream() : move to gps */

/* 980424 : n_select() => sock_select() : move from gps 
            n_closesock()       => sock_close()
            n_connect()         => sock_connect()
            n_opensock()        => sock_open()
            n_sendsock()        => sock_send()
            n_recvsock()        => sock_recv()
            n_getportno()       => sock_getportno() */
/* 980506 : sock_startup(), sock_cleanup() : added for NT */

#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>

#ifndef		WIN32
#include	<sys/socket.h>
# ifndef		HYSYS_HP
# include	<sys/select.h>
# endif
#include	<netinet/in.h>
#include	<netdb.h>
#include	<unistd.h>
#else
#include	<winsock.h>
#include	<io.h>
#endif

#include	<time.h>
#include	<errno.h>

#include	"gps.h"
#include	"sockcomm.h"

extern	void	l_socksethyerrno( int sock_hyerrno );

/* sock_close() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : close socket							*/
/*----------------------------------------------------------------------*/

void CBD1
#if	defined( __CB_STDC__ )
sock_close( int sock )
#else
sock_close( sock )
int	sock;
#endif
{
#ifndef	WIN32
	close( sock );
#else
	closesocket( sock );
#endif
}

/* sock_connect() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : connect to server until timeout				*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1, -2(network error)
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_connect( int sock, char *servername, unsigned portno, int timeoutsec )
#else
sock_connect( sock, servername, portno, timeoutsec )
int		sock;		/* socket no */
char		*servername;	/* host name string to connect */
unsigned	portno; 	/* portno to connect */
int		timeoutsec;	/* connection timeout in sec */
#endif
{
#ifndef	WIN32
	struct	sockaddr_in	hostname;
	struct	hostent 	*hosthp;

	/* find host */
	if( ( hosthp = gethostbyname( servername ) ) == (struct hostent *)0 )
	{
		l_socksethyerrno( errno );
		return(-1);				/*UNKNOWN HOST*/
	}

	memcpy( &hostname.sin_addr, hosthp->h_addr, hosthp->h_length );
	hostname.sin_family = AF_INET;
	hostname.sin_port = htons( portno );

	for( ; ; )
	{
		/* connect to host */
		if( connect( sock, (struct sockaddr *)&hostname,
					sizeof( struct sockaddr ) ) == 0 )
		{
			return( 0 );
		}

		l_socksethyerrno( errno );
		switch( errno )
		{
			case EINTR	   :	/* INTERRUPTED */
				continue;	/* retry connect */
			case EISCONN	   :	/* ALREADY CONNECTED */
				return( 0 );
			case EADDRNOTAVAIL :	/* INVALID ADDR */
			case EIO	   :	/* FILE SYSTEM ERR */
				return( -1 );
			case ENETUNREACH   :	/* NETWORK UNREACHABLE */
			case ETIMEDOUT	   :	/* CONNECTION TIMEOUT */
			case ECONNREFUSED  :	/* CONNECTION REFUSED */
						/* host alive, but no service
						for that portno */
			case EHOSTDOWN	   :	/* HOST DOWN */
				return( -2 );
			case EINPROGRESS   :	/* CONNECTING INPROGRESS NOW.
						only effective in NONBLOCK mode.
						completion may obtained by
						select() ready for write */
				/* wait until connection complete or timeout */
				if( sock_select( sock, 2, timeoutsec ) == 2 )
					return( 0 );
				else	
					return( -1 );	/* CONNECTION TIMEOUT */
			default 	   :	/* OTHER ERRORS */
				return( -1 );
		}
	}
	/* 970225 by SJW for not reach ***********
	return( -2 );		 * TIMEOUT * 
	*****************************************/
#else
	struct	sockaddr_in	hostname;
	struct	hostent		*hosthp;
	long	starttime;				// in sec. from 1970.1.1
	long	passtime;				// time passed in sec.

	// find host
	if ( (hosthp = gethostbyname( servername ) ) == ( struct hostent *)0 )
	{
		l_socksethyerrno( h_errno );
		return -1;
	}

	memcpy( &hostname.sin_addr, hosthp->h_addr, hosthp->h_length );

	hostname.sin_family = AF_INET;
	hostname.sin_port = htons( (u_short)portno );
	starttime = (long)time( 0 );

	while( ( passtime = (long)time( 0 ) - starttime ) <= (long)timeoutsec )
	{
		// connect to host
		if( connect( sock, (struct sockaddr *)&hostname, 
			sizeof(struct sockaddr) ) == 0 )
			return 0; 
		l_socksethyerrno( h_errno );
		if( (*_hyerrno()) == WSAEINPROGRESS ) continue;
		return -2;
	}		

	return -2;
#endif
}

/* sock_open() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : open socket							*/
/*----------------------------------------------------------------------*/
/*
	return	: >=0 (socket id)
		  -1 (error)
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_open( void )
#else
sock_open()
#endif
{
#ifndef	WIN32
	int	sid;

	if( ( sid = socket( AF_INET, SOCK_STREAM, 0 ) ) < 0 )
	{
		l_socksethyerrno( errno );
		return( -1 );
	}
	else	return( sid );
#else
	int	sid;

	for( ; ; )
	{
		sid = socket( AF_INET, SOCK_STREAM, 0 );
		if( sid == (int)INVALID_SOCKET )
		{       
			l_socksethyerrno( h_errno );
			if ( (*_hyerrno()) == WSAEINPROGRESS)	continue;
			return -1;
		}
		return sid;
	}
#endif
}

/* sock_send() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : send data to socket until timeoutsec				*/
/*----------------------------------------------------------------------*/
/*
	return	: >0 (length sent within timeout)
		   0 (timeout err. no data sent)
		  <0 (other system error)
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_send( int sock, char *data, int datalen, int timeoutsec )
#else
sock_send( sock, data, datalen, timeoutsec )
int	sock;
char	*data;
int	datalen;
int	timeoutsec;
#endif
{
#ifndef	WIN32
	int	ntosend;
	int	nsent;
	int	nremained;
	int	blocksize = 0;
	int	ret;

	ntosend = nremained = datalen;

	while( ntosend > 0 )
	{
		ret = sock_select( sock, 2, timeoutsec );

		if( ret < 0 )
			return ( ret );	/* critical err */
		else if( ret == 0 )	 /* timeout */
			return( datalen - nremained );

		nsent = send( sock, &data[datalen-nremained], ntosend, 0 );
		if( nsent < 0 )
		{
			l_socksethyerrno( errno );
			switch( errno )
			{
				case EINTR : /* interrupted without send any */
					continue;
				case EWOULDBLOCK :	/* none sent */
							/* applicable only in
							   NONBLOCK mode */
				case EMSGSIZE : 	/* send size too long */
					if( !blocksize )
					{
						for( blocksize=4096;
							blocksize > ntosend;
							blocksize /= 2 );
					}
					else
						blocksize /= 2;

					if( blocksize < 128 )
						return( datalen-nremained );
					else
						continue;
				default    :
					return( -1 );
			}
		}
		else if( nsent == 0 ) return( -1 );	/* case socket closed
							by remote host */
		nremained -= nsent;

		ntosend = ( blocksize ?
			( nremained < blocksize ? nremained : blocksize )
			: nremained );
	}
	return( datalen - nremained );
#else
	int	ntosend;
	int	nsent;
	int	nremained;
	int	ret;

	ntosend = nremained = datalen;

	for ( ; nremained > 0; )
	{
		ret = sock_select( sock, 2, (long)timeoutsec );

		if( ret < 0 ) return (ret);			// critical err 
		else if( ret == 0 )	 			// timeout 
			return( datalen - nremained );

		nsent = send( sock, &data[datalen-nremained], ntosend, 0 );
		if( nsent<0 ) 
		{
			l_socksethyerrno( h_errno );
			switch( (*_hyerrno()) )
			{
			case WSAEINTR : /* interrupted without send any */
			case WSAEWOULDBLOCK :	/* none sent */
						/* applicable only in
						   NONBLOCK mode */     
			case WSAEINPROGRESS :
				continue;
			default    :
				return( -1 );
			}
		}
		else if( nsent == 0 )
			return(-1);	// case socket closed
					// by remote host 
		nremained -= nsent;
		ntosend = nremained;
	}
	return( datalen - nremained );
#endif
}

/* sock_recv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : receive data to socket until timeoutsec			*/
/*----------------------------------------------------------------------*/
/*
	return	: >0 (length received within timeout)
		   0 (timeout err. no data received)
		  <0 (other system error)
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_recv( int sock, char *data, int datalen, int timeoutsec )
#else
sock_recv( sock, data, datalen, timeoutsec )
int	sock;
char	*data;
int	datalen;
int	timeoutsec;
#endif
{
#ifndef	WIN32
	int	ntorcv;
	int	nrcved;
	int	ret;

	ntorcv = datalen;

	while( ntorcv > 0 )
	{
		ret = sock_select( sock, 1, timeoutsec );
					/* wait for read ready */

		if( ret < 0 )
			return ( ret );	/* critical err */
		else if( ret == 0 )	/* timeout */
			return( datalen - ntorcv );

		nrcved = recv( sock, &data[datalen - ntorcv], ntorcv, 0 );
		if( nrcved < 0 )
		{
			l_socksethyerrno( errno );
			switch( errno )
			{
				case EINTR : /* interrupted without send any */
					continue;
				case EWOULDBLOCK :	/* none rcved */
					continue;	/* applicable only in
							   NONBLOCK mode */
				default    :
					return( -1 );
			}
		}
		else if( nrcved == 0 )
			return( -1 );	/* case socket closed by remote host */

		ntorcv -= nrcved;
	}
	return( datalen - ntorcv );
#else
	int	ntorcv;
	int	nrcved;
	int	ret;

	ntorcv = datalen;

	for ( ; ntorcv > 0; )
	{
		// wait for read ready
		ret = sock_select( sock, 1, (long)timeoutsec );
		if( ret < 0 )	return (ret);		// critical err 
		else if( ret == 0 )			// timeout 
			return( datalen - ntorcv );

		nrcved = recv( sock, &data[datalen-ntorcv], ntorcv, 0 );
		if ( nrcved < 0 ) 
		{
			l_socksethyerrno( h_errno );
			switch( (*_hyerrno()) )
			{
			case WSAEINTR : /* interrupted without send any */
			case WSAEWOULDBLOCK :	/* none rcved */
				 		/* applicable only in
						   NONBLOCK mode */
			case WSAEINPROGRESS : 
				continue;
			default    :
				return( -1 );
			}
			return -1;
		}
		else if( nrcved == 0 )
			return(-1);	// case socket
					// closed by remote host

		ntorcv -= nrcved;
	}
	return( datalen - ntorcv );
#endif
}

int CBD1
#if	defined( __CB_STDC__ )
sock_getportno( char *service, char *protocol )
#else
sock_getportno( service, protocol )
char	*service;	/* the name of service in /etc/services file */
char	*protocol;	/* protocol name. tcp or udp */
#endif
{
#ifndef	WIN32
	struct	servent	*sp;

	if( ( sp = getservbyname( service, protocol ) ) == (struct servent *)0 )
	{
		l_socksethyerrno( errno );
		return( -1 );		/* ERROR */
	}

	return( (int)ntohs((unsigned short)sp->s_port) );
#else
	struct	servent	*sp;

	if( ( sp = getservbyname( service, protocol ) ) == NULL )
	{
		l_socksethyerrno( h_errno );
		return( -1 );
	}

	return( sp->s_port );
#endif
}

/* sock_select() : LIB gps */
/*----------------------------------------------------------------------*/
/*	FUNC : select read/write/exception event until timeoutsec	*/
/*----------------------------------------------------------------------*/
/*	option	: 1(read/accept) 2(write) 4(except) bitwise OR		
	return	: >0 ( read/write/except readies bitwise OR )		
		   0 ( timeout )					
		  <0 ( error )						
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_select( int fd, int opt, int timeoutsec )
#else
sock_select( fd, opt, timeoutsec )
int	fd;		
int	opt;
int	timeoutsec;
#endif
{
#ifndef	WIN32
	fd_set		readfds;
	fd_set		writefds;
	fd_set		exceptfds;
	struct	timeval timeout;
	int		nfds, nfds_ready;
	int		ret = 0;

	nfds = fd + 1;

	timeout.tv_sec = (long)timeoutsec;
	timeout.tv_usec = 0L;

	FD_ZERO( &readfds );
	FD_ZERO( &writefds );
	FD_ZERO( &exceptfds );

	if( opt & 1 ) FD_SET( fd, &readfds );
	if( opt & 2 ) FD_SET( fd, &writefds );
	if( opt & 4 ) FD_SET( fd, &exceptfds );

	for( ; ; )
	{
		nfds_ready = select( nfds, &readfds, &writefds,
			&exceptfds, &timeout );

		if( nfds_ready < 0  && errno == EINTR )
			continue;
		break;
	}

	if( nfds_ready <= 0 )
	{
		l_socksethyerrno( errno );
		return( nfds_ready );
	}

	if( FD_ISSET( fd, &readfds ) )		ret |= 1;
	if( FD_ISSET( fd, &writefds ) ) 	ret |= 2;
	if( FD_ISSET( fd, &exceptfds ) )	ret |= 4;

	return( ret );
#else
	fd_set	readfds;
	fd_set	writefds;
	fd_set	exceptfds;
	struct	timeval timeout;
	int	nfds, nfds_ready;
	int	ret = 0;

	nfds = fd + 1;
         
	FD_ZERO( &readfds );
	FD_ZERO( &writefds );
	FD_ZERO( &exceptfds );

	if( opt & 1 ) FD_SET( (unsigned int)fd, &readfds );
	if( opt & 2 ) FD_SET( (unsigned int)fd, &writefds );
	if( opt & 4 ) FD_SET( (unsigned int)fd, &exceptfds );

	timeout.tv_sec = (long)timeoutsec;
	timeout.tv_usec = (long)( timeoutsec % 1000 * 1000 );

	for( ; ; )
	{
		nfds_ready = select( nfds, &readfds, &writefds, &exceptfds,
			&timeout );
		if( nfds_ready < 0 ) {
			l_socksethyerrno( h_errno );
			if( (*_hyerrno()) == WSAEINTR 
			 || (*_hyerrno()) == WSAEINPROGRESS )
				continue;
			else	break;
		}
		else	break;
	}

	if( nfds_ready <= 0 )	return( nfds_ready );

	if( FD_ISSET( fd, &readfds ) )		ret |= 1;
	if( FD_ISSET( fd, &writefds ) ) 	ret |= 2;
	if( FD_ISSET( fd, &exceptfds ) )	ret |= 4;

	return( ret );
#endif
}

/* sock_startup() : LIB gps */
/*----------------------------------------------------------------------*/
/*	FUNC : Initializing wsock32.dll ( NT only )			*/
/*	       dummy for UNIX						*/
/*----------------------------------------------------------------------*/
/*	return	:  0 ( OK )					
		  -1 ( error )						
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_startup( int wMinorVersion, int wMajorVersion )
#else
sock_startup( wMinorVersion, wMajorVersion )
int	wMinorVersion;
int	wMajorVersion;
#endif
{
#ifdef	WIN32
	WORD	wVersionReqd;
	WSADATA wsaData;

	wVersionReqd = MAKEWORD( wMinorVersion, wMajorVersion );
	if( WSAStartup( wVersionReqd, &wsaData ) )
	{
		l_socksethyerrno( h_errno );
		return -1;
	}
#endif
	return 0;
}

/* sock_cleanup() : LIB gps */
/*----------------------------------------------------------------------*/
/*	FUNC : Terminating wsock32.dll ( NT only )			*/
/*	       dummy for UNIX						*/
/*----------------------------------------------------------------------*/
/*	return	: 0 ( OK )					
*/
int CBD1
#if	defined( __CB_STDC__ )
sock_cleanup( void )
#else
sock_cleanup()
#endif
{
#ifdef	WIN32
	for (;;)
	{
		if ( WSACleanup() < 0 )
		{
			l_socksethyerrno( h_errno );
			if ( (*_hyerrno()) == WSANOTINITIALISED )
				break;
		}
		
	}
#endif
	return 0;
}
