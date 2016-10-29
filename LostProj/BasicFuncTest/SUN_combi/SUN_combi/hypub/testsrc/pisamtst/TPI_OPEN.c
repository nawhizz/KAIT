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
int	_isopen = 0;

/*----------------------------------------------------------------------+
|	Function proto-types						|
+----------------------------------------------------------------------*/
void
TPI_TRAN()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_TRAN()                                        |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( PI_TRAN() < 0 )
	{
		printf( "PI_TRAN error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_TRAN successful\n" );
} /* TPI_TRAN */

/*---------------------------------------------------------------------*/
void
TPI_ENDTRAN()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_ENDTRAN()                                     |\n" );
	printf( "+-------------------------------------------------------+\n" );

	PI_ENDTRAN();

	printf( "PI_ENDTRAN successful\n" );
} /* TPI_ENDTRAN */

/*---------------------------------------------------------------------*/
void
TPI_COMMIT()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_COMMIT()                                      |\n" );
	printf( "+-------------------------------------------------------+\n" );

	PI_COMMIT();

	printf( "PI_COMMIT successful\n" );
} /* TPI_COMMIT */

/*---------------------------------------------------------------------*/
void
TPI_ROLLBACK()
{
	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_ROLLBACK()                                      |\n" );
	printf( "+-------------------------------------------------------+\n" );

	PI_ROLLBACK();

	printf( "PI_ROLLBACK successful\n" );
} /* TPI_ROLLBACK */

/*---------------------------------------------------------------------*/
void
TPI_OPEN()
{
	char	filepath[256], fileid[80];
	int	fd;

	if( _isopen )
	{
		if( PI_ALLCLOSE() < 0 )
		{
			printf( "PI_ALLCLOSE error" );
			if( hyerrno )
				printf( "[hyerrno = %d]", hyerrno );
			if( iserrno )
				printf( "[iserrno = %d]", iserrno );
			if( errno )
				printf( "[errno = %d]", errno );
			printf( "\n" );
		}
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_OPEN( char *filepath, char *fildid )          |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath : " );
	scanf( "%s", filepath );
	printf( "fileid   : " );
	scanf( "%s", fileid );

	if( ( fd = PI_OPEN( filepath, fileid ) ) < 0 )
	{
		printf( "PI_OPEN error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_OPEN successful return fd (%d)\n", fd );

} /* TPI_OPEN */

/*---------------------------------------------------------------------*/
void
TPI_CLOSE()
{
	int	fd;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_CLOSE( int fd )                               |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );

	if( PI_CLOSE( fd ) < 0 )
	{
		printf( " PI_CLOSE error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_CLOSE successful\n" );
} /* TPI_CLOSE */

/*---------------------------------------------------------------------*/
void
TPI_BUILD()
{
	char	filepath[256], fileid[80];
	int	fd;

	if( _isopen )
	{
		if( PI_ALLCLOSE() < 0 )
		{
			printf( "PI_ALLCLOSE error" );
			if( hyerrno )
				printf( "[hyerrno = %d]", hyerrno );
			if( iserrno )
				printf( "[iserrno = %d]", iserrno );
			if( errno )
				printf( "[errno = %d]", errno );
			printf( "\n" );
		}
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_BUILD( char *filepath, char *fildid )         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "filepath : " );
	scanf( "%s", filepath );
	printf( "fileid   : " );
	scanf( "%s", fileid );

	if( ( fd = PI_BUILD( filepath, fileid ) ) < 0 )
	{
		printf( "PI_BUILD error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}

	printf( "PI_BUILD successful return fd (%d)\n", fd );
} /* TPI_BUILD */
