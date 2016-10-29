/* s_select() : LIB gps */
/*----------------------------------------------------------------------+
|	FUNC : select read/write/exception event until timeoutsec	|
|	option	: 1(read/accept) 2(write) 4(except) bitwise OR		|
|	return	: >0 ( read/write/except readies bitwise OR )		|
|		   0 ( timeout )					|
|		  <0 ( error )						|
+----------------------------------------------------------------------*/

#include	<sys/types.h>
# ifndef	HYSYS_HP
# include	<sys/select.h>
# endif
#include	<sys/time.h>
#include	<time.h>
#include	<errno.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
s_select( int fd, int opt, int timeoutsec )
#else
s_select( fd, opt, timeoutsec )
int	fd;		/* stream fd */
int	opt;
int	timeoutsec;
#endif
{
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
		return( nfds_ready );

	if( FD_ISSET( fd, &readfds ) )		ret |= 1;
	if( FD_ISSET( fd, &writefds ) ) 	ret |= 2;
	if( FD_ISSET( fd, &exceptfds ) )	ret |= 4;

	return( ret );
}

/******* The end of s_select.c *****************************************/
