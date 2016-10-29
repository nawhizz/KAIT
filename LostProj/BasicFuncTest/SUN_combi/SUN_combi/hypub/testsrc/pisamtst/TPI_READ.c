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
#define	ISSPACE(s)	d_isspacenstr( s, sizeof(s) )
char	record[2048];

/*----------------------------------------------------------------------+
|	Function proto-types						|
+----------------------------------------------------------------------*/
void
TPI_REDGE()
{
	int	fd, displen, keypos;
	char	keyname[16], keydata[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_REDGE( int fd, char *keyname, char *record )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "keyname : " );
	scanf( "%s", keyname );
	printf( "key 의 위치 : " );
	scanf( "%d", &keypos );
	printf( "초기 키 값 : " );
	gets( record );
	gets( keydata );
	printf( "출력하고자 하는 데이타 길이 : " );
	scanf( "%d", &displen );

	memset( record, ' ', sizeof(record) );
	memcpy( record+keypos, keydata, strlen(keydata) );
	if( PI_REDGE( fd, keyname, record ) < 0 )
	{
		printf( "PI_REDGE error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}
		
	printf( "PI_REDGE successful. data is " );
	printf( "%*.*s", displen, displen, record );
	printf( "\n" );

} /* TOPI_READGE */

/*---------------------------------------------------------------------*/
void
TPI_REDNX()
{
	int	fd;
	int	displen;
	char	record[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      PI_REDNX( int fd, char *record )                 |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "출력하고자 하는 데이타 길이 : " );
	scanf( "%d", &displen );

	if( PI_REDNX( fd, record ) < 0 )
	{
		printf( "PI_REDNX error" );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}
		
	printf( "PI_REDNX successful. data is " );
	printf( "%*.*s", displen, displen, record );
	printf( "\n" );

} /* TPI_REDNX */

/*---------------------------------------------------------------------*/
void
TOPI_REDGE()
{
	int	fd, displen, keypos;
	char	keyname[16], retcode[5], keydata[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      OPI_REDGE( char *retcode, int *fd, char *keyname, char *record ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "keyname : " );
	scanf( "%s", keyname );
	printf( "key 의 위치 : " );
	scanf( "%d", &keypos );
	printf( "초기 키 값 : " );
	gets( record );
	gets( keydata );
	printf( "출력하고자 하는 데이타 길이 : " );
	scanf( "%d", &displen );

	memset( record, ' ', sizeof(record) );
	memcpy( record+keypos, keydata, strlen(keydata) );
	OPI_REDGE( retcode, &fd, keyname, record );
	if( !ISSPACE( retcode ) )
	{
		printf( "OPI_REDGE error" );
		printf( " [retcode = %.5s]", retcode );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}
		
	printf( "PI_REDGE successful. data is " );
	printf( "%*.*s", displen, displen, record );
	printf( "\n" );

} /* TOPI_READGE */

/*---------------------------------------------------------------------*/
void
TOPI_REDNX()
{
	int	fd;
	int	displen;
	char	retcode[5], record[1024];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|      OPI_REDNX( char *retcode, int *fd, char *record )|\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "fd : " );
	scanf( "%d", &fd );
	printf( "출력하고자 하는 데이타 길이 : " );
	scanf( "%d", &displen );

	OPI_REDNX( retcode, &fd, record );
	if( !ISSPACE( retcode ) )
	{
		printf( "OPI_REDNX error" );
		printf( " [retcode = %.5s]", retcode );
		if( hyerrno )
			printf( " [hyerrno = %d]", hyerrno );
		if( iserrno )
			printf( " [iserrno = %d]", iserrno );
		if( errno )
			printf( " [errno = %d]", errno );
		printf( "\n" );
		return;
	}
		
	printf( "PI_REDNX successful. data is " );
	printf( "%*.*s", displen, displen, record );
	printf( "\n" );

} /* TOPI_REDNX */
