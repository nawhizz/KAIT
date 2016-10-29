/************************************************************************
*	PISAM library testing program					*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
-----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>
#include	<iswrap.h>
#include	<errno.h>

#include	"cbuni.h"
#include	"gps.h"
#include	"pisam.h"

/*----------------------------------------------------------------------+
|	External Function						|
+----------------------------------------------------------------------*/
extern	int	TPI_COM_isspace( char *src, int len );

/*---------------------------------------------------------------------*/
void
TPI_ADDIT()
{
	char	record[1025];
	int	fd;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_ADDIT( int fd, char *record )                 |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "record (<=1K) : " );
	scanf( "%s", record );

	if( PI_ADDIT( fd, record ) < 0 )
	{
		printf( "PI_ADDIT error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_ADDIT successful\n" );

} /* TPI_ADDIT */
