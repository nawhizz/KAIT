/* s_readstream() : LIB gps */
/*----------------------------------------------------------------------+
|	FUNC : receive data to stream until timeoutsec			|
|	return : >0 ( length received within timeout )			|
|		  0 ( timeout err. no data received )			|
|		 <0 ( other system error )				|
+----------------------------------------------------------------------*/

#ifdef		WIN32
#include	<io.h>
#else
#include	<unistd.h>
#endif

#include	<errno.h>

#include	"gps.h"

/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
extern	void	l_gpssethyerrno( int gps_hyerrno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

int CBD1
#if	defined( __CB_STDC__ )
s_readstream( int fd, char *data, int datalen, int timeoutsec )
#else
s_readstream( fd, data, datalen, timeoutsec )
int	fd;
char	*data;
int	datalen;
int	timeoutsec;
#endif
{
	int	ntorcv;
	int	nrcved;
#ifndef	WIN32
	int	ret;
#endif

	ntorcv = datalen;

	while( ntorcv > 0 )
	{
#ifndef	WIN32
		ret = s_select( fd, 1, timeoutsec );	/* wait for read ready*/
		if( ret < 0 )
			return( ret );			/* critical err */
		else if( ret == 0 )
			return( datalen - ntorcv );	/* timeout */
#endif

		nrcved = read( fd, &data[datalen - ntorcv], ntorcv );
		if( nrcved < 0 )
		{
#ifdef	WIN32
/*	98.09.16 for MultiThread by JJH ( Delete )
			hyerrno = errno;
*/
/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
			l_gpssethyerrno( errno );
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/
			return( -1 );
#else
			switch( errno )
			{
			/* interrupted without send any */
			case	EINTR		:
				continue;
			/* none rcved, applicable only in NONBLOCK mode */
			case	EWOULDBLOCK	:
				continue;
			default			:
				return( -1 );
			}
#endif
		}
		else if( nrcved == 0 )
			return( -1 );	/* case stream closed by remote host */

		ntorcv -= nrcved;
	}

	return( datalen - ntorcv );
}

/******* The end of s_readstream.c *************************************/
