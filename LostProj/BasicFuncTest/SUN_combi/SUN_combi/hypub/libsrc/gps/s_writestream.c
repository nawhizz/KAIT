/* s_writestream() : LIB gps */
/*----------------------------------------------------------------------+
|	FUNC : send data to stream until timeoutsec			|
|	return : >0 ( length sent within timeout )			|
|		  0 ( timeout err. no data sent )			|
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
s_writestream( int fd, char *data, int datalen, int timeoutsec )
#else
s_writestream( fd, data, datalen, timeoutsec )
int	fd;
char	*data;
int	datalen;
int	timeoutsec;
#endif
{
	int	ntosend;
	int	nsent;
	int	nremained;
	int	blocksize = 0;
#ifndef	WIN32
	int	ret;
#endif

	ntosend = nremained = datalen;

	while( ntosend > 0 )
	{
#ifndef	WIN32
		ret = s_select( fd, 2, timeoutsec );
		if( ret < 0 )
			return ( ret );		/* critical err */
		else if( ret == 0 )		/* timeout */
			return( datalen - nremained );
#endif

		nsent = write( fd, &data[datalen-nremained], ntosend );
		if( nsent < 0 )
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
			/* none sent, applicable only in NONBLOCK mode */
			case	EWOULDBLOCK	:
		 	/* send size too long */
			case	EMSGSIZE	:
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
				continue;
			default			:
				return( -1 );
			}
#endif
		}
		else if( nsent == 0 )
			return( -1 );	/* case stream closed by remote host */

		nremained -= nsent;

		ntosend = !blocksize ? nremained :
			  nremained < blocksize ? nremained : blocksize;
	}

	return( datalen - nremained );
}

/******* The end of s_wirtestream.c ************************************/
