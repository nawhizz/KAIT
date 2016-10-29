/************************************************************************
*	GPS library testing program ( ring buffer )			*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

#include	"gps.h"

/*----------------------------------------------------------------------+
|	External variables						|
+----------------------------------------------------------------------*/
int	ring_fd = -1;
char	*ring_buffer = (char *)0;
char	*ring_data = (char *)0;

/*---------------------------------------------------------------------*/
void
D_RINGCLOSE()
{
	if( ring_fd >= 0 )
	{
		d_ringclose( ring_fd );
		ring_fd = -1;
		printf( " Result ring closed\n" );
	}

	if( ring_buffer != (char *)0 )
	{
		free( ring_buffer );
		ring_buffer = (char *)0;
	}

	if( ring_data != (char *)0 )
	{
		free( ring_data );
		ring_data = (char *)0;
	}

} /* D_RINGCLOSE */

/*---------------------------------------------------------------------*/
void
D_RINGCOPY()
{
	char	tmpstr[80];
	int	len;

	if( ring_fd < 0 )
	{
		printf( "ring not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_ringcopy( int fd(i), char *data(o),           |\n" );
	printf( "|                   int *len(i/o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_ringcopy( ring_fd, ring_data, &len ) < 0 )
	{
		printf( "d_ringcopy error .....\n" );
		return;
	}

	printf( " Result data : (%d)[%.*s]\n", len, len, ring_data );

} /* D_RINGCOPY */

/*---------------------------------------------------------------------*/
void
D_RINGOPEN()
{
	char	tmpstr[80];
	int	bufsize;

	if( ring_fd >= 0 )
	{
		d_ringclose( ring_fd );
		ring_fd = -1;
		printf( " Result ring closed\n" );
	}

	if( ring_buffer != (char *)0 )
	{
		free( ring_buffer );
		ring_buffer = (char *)0;
	}

	if( ring_data != (char *)0 )
	{
		free( ring_data );
		ring_data = (char *)0;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_ringopen( char *rbuf(i), int bufsize(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " bufsize        : " );
	scanf( "%s", tmpstr );
	if( ( bufsize = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid bufsize ......\n" );
		return;
	}

	if( ( ring_buffer = (char *)malloc( bufsize ) ) == (char *)0 )
	{
		printf( "alloc buffer error ......\n" );
		return;
	}

	if( ( ring_data = (char *)malloc( bufsize ) ) == (char *)0 )
	{
		printf( "alloc buffer error ......\n" );
		return;
	}

	if( ( ring_fd = d_ringopen( ring_buffer, bufsize ) ) < 0 )
	{
		printf( "d_ringopen error .....\n" );
		return;
	}

	printf( " Result ring fd : [%d]\n", ring_fd );

} /* D_RINGOPEN */

/*---------------------------------------------------------------------*/
void
D_RINGREAD()
{
	char	tmpstr[80];
	int	len;

	if( ring_fd < 0 )
	{
		printf( "ring not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_ringread( int fd(i), char *data(o),           |\n" );
	printf( "|                   int *len(i/o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_ringread( ring_fd, ring_data, &len ) < 0 )
	{
		printf( "d_ringread error .....\n" );
		return;
	}

	printf( " Result data : (%d)[%.*s]\n", len, len, ring_data );

} /* D_RINGREAD */

/*---------------------------------------------------------------------*/
void
D_RINGWRITE()
{
	char	tmpstr[80];
	int	len;

	if( ring_fd < 0 )
	{
		printf( "ring not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_ringread( int fd(i), char *data(i),           |\n" );
	printf( "|                   int *len(i/o) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " data                 : " );
	gets( ring_data );
	gets( ring_data );
	printf( " len                  : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_ringwrite( ring_fd, ring_data, &len ) < 0 )
	{
		printf( "d_ringwrite error .....\n" );
		return;
	}

	printf( " Result writen length : [%d]\n", len );

} /* D_RINGWRITE */

/*----------------------------------------------------------------------+
|	Display function for ring buffer				|
+----------------------------------------------------------------------*/
void
DisplayRingF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( ring buffer )        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( " 1. d_ringclose  2. d_ringcopy  3. d_ringopen\n" );
	printf( " 4. d_ringread   5. d_ringwrite\n" );
	printf( " 9. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayRingF */

/*----------------------------------------------------------------------+
|	Choose function for data maniplation				|
+----------------------------------------------------------------------*/
int
ChooseRingF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 9 && ( choosenum < 1 || choosenum > 5 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseRingF */

/*----------------------------------------------------------------------+
|	Main function for ring buffer					|
+----------------------------------------------------------------------*/
void
RingF()
{
	for( ; ; )
	{
		DisplayRingF();
		switch( ChooseRingF() )
		{
		case	1	:	D_RINGCLOSE();	break;
		case	2	:	D_RINGCOPY();	break;
		case	3	:	D_RINGOPEN();	break;
		case	4	:	D_RINGREAD();	break;
		case	5	:	D_RINGWRITE();	break;
		default		:	D_RINGCLOSE();	return;
		}
	}

} /* RingF */

/****** End of ring.c **************************************************/
