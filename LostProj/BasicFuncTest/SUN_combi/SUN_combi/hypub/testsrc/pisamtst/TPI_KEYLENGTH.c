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
|	External variables						|
+----------------------------------------------------------------------*/

int
TPI_COM_isspace( char *src, int len )
{
	int	i;
	for( i=0; i<len; i++ )
	{
		if( src[i] != ' ' )
			return( 0 );
	}
	return( 1 );
}

/*----------------------------------------------------------------------+
|	Function proto-types						|
+----------------------------------------------------------------------*/
void
TPI_KEYLENGTH()
{
	char	keyname[80];
	int	fd, keysize;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_KEYLENGTH( int fd, char *keyname )            |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "keyname   : " );
	scanf( "%s", keyname );

	if( (keysize=PI_KEYLENGTH( fd, keyname )) < 0 )
	{
		printf( "PI_KEYLENGTH error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_KEYLENGTH successful key length = %d\n", keysize );

} /* TPI_KEYLENGTH */

/*---------------------------------------------------------------------*/
void
TOPI_KEYLENGTH()
{
	int	fd, keysize;
	char	keyname[80], retcode[5];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      OPI_KEYLENGTH( char *retcode, int *fd,           |\n" );
	printf( "|                     char *keyname, int *keysize )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "keyname   : " );
	scanf( "%s", keyname );

	OPI_KEYLENGTH( retcode, &fd, keyname, &keysize );
	if( !TPI_COM_isspace( retcode, sizeof(retcode) ) )
	{
		printf( " OPI_KEYLENGTH error [retcode = %5.5s]", retcode );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "OPI_KEYLENGTH successful key length = %d\n", keysize );
} /* TOPI_KEYLENGTH */
