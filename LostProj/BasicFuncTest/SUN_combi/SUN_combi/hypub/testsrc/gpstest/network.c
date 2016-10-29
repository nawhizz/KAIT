/************************************************************************
*	GPS library testing program ( network interface )		*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<fcntl.h>

#ifdef	WIN32
#include	<io.h>
#endif

#include	"cbuni.h"

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
S_READSTREAM()
{
	char	tmpstr[80];
	char	filepath[128];
	int	fd;
	char	data[8192];
	int	datalen;
	int	timeoutsec;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       s_readstream( int fd(i), char *data(o),         |\n" );
	printf( "|             int datalen(i), int timeoutsec(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd : " );
	scanf( "%s", filepath );
	printf( " datelen         : " );
	scanf( "%s", tmpstr );
	if( ( datalen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid datalen ......\n" );
		return;
	}
	printf( " timeoutsec      : " );
	scanf( "%s", tmpstr );
	if( ( timeoutsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid timeoutsec ......\n" );
		return;
	}

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( s_readstream( fd, data, datalen, timeoutsec ) < 0 )
	{
		printf( "s_readstream error .....\n" );
		close( fd );
		return;
	}

	close( fd );

	printf( " Result data     : [%.*s]\n", datalen, data );

} /* S_READSTREAM */

/*---------------------------------------------------------------------*/
void
S_WRITESTREAM()
{
	char	tmpstr[80];
	char	filepath[128];
	int	fd;
	char	data[8192];
	int	datalen;
	int	timeoutsec;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       s_writestream( int fd(i), char *data(i),         |\n" );
	printf( "|             int datalen(i), int timeoutsec(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd : " );
	scanf( "%s", filepath );
	printf( " data            : " );
	gets( data );
	gets( data );
	printf( " datelen         : " );
	scanf( "%s", tmpstr );
	if( ( datalen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid datalen ......\n" );
		return;
	}
	printf( " timeoutsec      : " );
	scanf( "%s", tmpstr );
	if( ( timeoutsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid timeoutsec ......\n" );
		return;
	}

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( s_writestream( fd, data, datalen, timeoutsec ) < 0 )
	{
		printf( "s_writestream error .....\n" );
		close( fd );
		return;
	}

	close( fd );

	printf( " Result successful\n" );

} /* S_WRITESTREAM */

/*---------------------------------------------------------------------*/
void
S_SELECT()
{
#ifdef	WIN32
	printf( "Not support WIN32\n" );
#else
	char	tmpstr[80];
	char	filepath[128];
	int	fd;
	int	opt;
	int	timeoutsec;
	int	retv;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       s_writestream( int fd(i),                       |\n" );
	printf( "|             int opt(i), int timeoutsec(i) )           |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd     : " );
	scanf( "%s", filepath );
	printf( " opt                 : " );
	scanf( "%s", tmpstr );
	if( ( opt = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid opt ......\n" );
		return;
	}
	printf( " timeoutsec          : " );
	scanf( "%s", tmpstr );
	if( ( timeoutsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid timeoutsec ......\n" );
		return;
	}

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( ( retv = s_select( fd, opt, timeoutsec ) ) < 0 )
	{
		printf( "s_select error .....\n" );
		close( fd );
		return;
	}

	close( fd );

	printf( " Result return value : [%d]\n", retv );

#endif
} /* S_SELECT */

/*----------------------------------------------------------------------+
|	Display function for network interface				|
+----------------------------------------------------------------------*/
void
DisplayNetWorkF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( network interface )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. s_readstream  2. s_writestream  3. s_select\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayNetWorkF */

/*----------------------------------------------------------------------+
|	Choose function for network interface				|
+----------------------------------------------------------------------*/
int
ChooseNetWorkF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 3 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseNetWorkF */

/*----------------------------------------------------------------------+
|	Main function for network interface				|
+----------------------------------------------------------------------*/
void
NetWorkF()
{
	for( ; ; )
	{
		DisplayNetWorkF();
		switch( ChooseNetWorkF() )
		{
		case	1	:	S_READSTREAM();		break;
		case	2	:	S_WRITESTREAM();	break;
		case	3	:	S_SELECT();		break;
		default		:				return;
		}
	}

} /* NetWorkF */

/****** End of network.c ***********************************************/
