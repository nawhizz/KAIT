/************************************************************************
*	GPS library testing program ( rotational FIFO )				*
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
int	rf_fd = -1;

/*---------------------------------------------------------------------*/
void
RF_BUILD()
{
	char	tmpstr[80];
	char	fpath[256];
	int	fmode = 0;
	int	recsize;
	int	maxrecno;
	int	i;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_build( char *fpath(i), int fmode(i),         |\n" );
	printf( "|                 int recsize(i), int maxrecno(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fpath    : " );
	scanf( "%s", fpath );
	printf( " fmode    : " );
	scanf( "%s", tmpstr );
	for( i=0; tmpstr[i]; i++ )
	{
		if( tmpstr[i] < '0' || tmpstr[i] > '7' )
		{
			printf( "invalid fmode ......\n" );
			return;
		}
		fmode = fmode * 8 + tmpstr[i] - '0';
	}
	printf( " recsize  : " );
	scanf( "%s", tmpstr );
	if( ( recsize = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid recsize ......\n" );
		return;
	}
	printf( " maxrecno : " );
	scanf( "%s", tmpstr );
	if( ( maxrecno = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid maxrecno ......\n" );
		return;
	}

	if( rf_build( fpath, fmode, recsize, maxrecno ) < 0 )
	{
		printf( "rf_build error .....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* RF_BUILD */

/*---------------------------------------------------------------------*/
void
RF_OPEN()
{
	char	fpath[256];

	if( rf_fd >= 0 )
	{
		rf_close( rf_fd );
		rf_fd = -1;
		printf( " Result fifo closed\n" );
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_open( char *fpath(i) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fpath          : " );
	scanf( "%s", fpath );

	if( ( rf_fd = rf_open( fpath ) ) < 0 )
	{
		printf( "rf_open error .....\n" );
		return;
	}

	printf( " Result fifo fd : [%d]\n", rf_fd );

} /* RF_OPEN */

/*---------------------------------------------------------------------*/
void
RF_CLOSE()
{
	if( rf_fd >= 0 )
	{
		rf_close( rf_fd );
		rf_fd = -1;
		printf( " Result fifo closed\n" );
	}

} /* RF_CLOSE */

/*---------------------------------------------------------------------*/
void
RF_DELETE()
{
	char	tmpstr[80];
	int	waitmsec;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_delete( int fd(i), int waitmsec(i) )         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " waitmsec : " );
	scanf( "%s", tmpstr );
	if( ( waitmsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid waitmsec ......\n" );
		return;
	}

	if( rf_delete( rf_fd, waitmsec ) < 0 )
	{
		printf( "rf_delete error .....\n" );
		return;
	}

	printf( " Result success\n" );

} /* RF_DELETE */

/*---------------------------------------------------------------------*/
void
RF_GET()
{
	char	recdata[1024];
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_get( int fd(i), char *recdata(o) )           |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( ( datalen = rf_get( rf_fd, recdata ) ) < 0 )
	{
		printf( "rf_get error .....\n" );
		return;
	}

	printf( " Result recdata : (%d)[%.*s]\n", datalen, datalen, recdata );

} /* RF_GET */

/*---------------------------------------------------------------------*/
void
RF_GETD()
{
	char	tmpstr[80];
	char	recdata[1024];
	int	recno;
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_get( int fd(i), int recno(i),                |\n" );
	printf( "|               char *recdata(o) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " recno          : " );
	scanf( "%s", tmpstr );
	if( ( recno = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid recno ......\n" );
		return;
	}

	if( ( datalen = rf_getd( rf_fd, recno, recdata ) ) < 0 )
	{
		printf( "rf_getd error .....\n" );
		return;
	}

	printf( " Result recdata : (%d)[%.*s]\n", datalen, datalen, recdata );

} /* RF_GETD */

/*---------------------------------------------------------------------*/
void
RF_GETINFO()
{
	int	recsize;
	int	maxrecno;
	int	quelen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_getinfo( int fd(i), int *recsize(o),         |\n" );
	printf( "|               int *maxrecno(o), int *quelen(o) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );

	if( rf_getinfo( rf_fd, &recsize, &maxrecno, &quelen ) < 0 )
	{
		printf( "rf_getinfo error .....\n" );
		return;
	}

	printf( " Result recsize  : [%d]\n", recsize );
	printf( " Result maxrecno : [%d]\n", maxrecno );
	printf( " Result quelen   : [%d]\n", quelen );

} /* RF_GETINFO */

/*---------------------------------------------------------------------*/
void
RF_GETNEW()
{
	char	tmpstr[80];
	char	recdata[1024];
	int	recno;
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_getnew( int fd(i), int recno(i),             |\n" );
	printf( "|               char *recdata(o) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " recno          : " );
	scanf( "%s", tmpstr );
	if( ( recno = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid recno ......\n" );
		return;
	}

	if( ( datalen = rf_getnew( rf_fd, recno, recdata ) ) < 0 )
	{
		printf( "rf_getnew error .....\n" );
		return;
	}

	printf( " Result recdata : (%d)[%.*s]\n", datalen, datalen, recdata );

} /* RF_GETNEW */

/*---------------------------------------------------------------------*/
void
RF_GETOLD()
{
	char	tmpstr[80];
	char	recdata[1024];
	int	recno;
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_getold( int fd(i), int recno(i),             |\n" );
	printf( "|               char *recdata(o) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " recno          : " );
	scanf( "%s", tmpstr );
	if( ( recno = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid recno ......\n" );
		return;
	}

	if( ( datalen = rf_getold( rf_fd, recno, recdata ) ) < 0 )
	{
		printf( "rf_getold error .....\n" );
		return;
	}

	printf( " Result recdata : (%d)[%.*s]\n", datalen, datalen, recdata );

} /* RF_GETOLD */

/*---------------------------------------------------------------------*/
void
RF_READ()
{
	char	tmpstr[80];
	char	recdata[1024];
	int	waitmsec;
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_read( int fd(i), char *recdata(o),           |\n" );
	printf( "|                int waitmsec(i) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " waitmsec       : " );
	scanf( "%s", tmpstr );
	if( ( waitmsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid waitmsec ......\n" );
		return;
	}

	if( ( datalen = rf_read( rf_fd, recdata, waitmsec ) ) < 0 )
	{
		printf( "rf_read error .....\n" );
		return;
	}

	printf( " Result recdata : (%d)[%.*s]\n", datalen, datalen, recdata );

} /* RF_READ */

/*---------------------------------------------------------------------*/
void
RF_WRITE()
{
	char	tmpstr[80];
	char	recdata[1024];
	int	waitmsec;
	int	datalen;

	if( rf_fd < 0 )
	{
		printf( "fifo not opened ... \n" );
		return;
	}

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       rf_write( int fd(i), char *recdata(i),          |\n" );
	printf( "|                int datalen(i), int waitmsec(i) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " recdata  : " );
	gets( recdata );
	gets( recdata );
	printf( " datalen  : " );
	scanf( "%s", tmpstr );
	if( ( datalen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid datalen ......\n" );
		return;
	}
	printf( " waitmsec : " );
	scanf( "%s", tmpstr );
	if( ( waitmsec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid waitmsec ......\n" );
		return;
	}

	if( rf_write( rf_fd, recdata, datalen, waitmsec ) < 0 )
	{
		printf( "rf_write error .....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* RF_WRITE */

/*----------------------------------------------------------------------+
|	Display function for rotational FIFO				|
+----------------------------------------------------------------------*/
void
DisplayFIFOF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( rotational FIFO )    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( "  1. rf_build   2. rf_open  3. rf_close    4. rf_delete\n" );
	printf( "  5. rf_get     6. rf_getd  7. rf_getinfo  8. rf_getnew\n" );
	printf( "  9. rf_getold 10. rf_read 11. rf_write\n" );
	printf( " 99. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayFIFOF */

/*----------------------------------------------------------------------+
|	Choose function for rotational FIFO				|
+----------------------------------------------------------------------*/
int
ChooseFIFOF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 && ( choosenum < 1 || choosenum > 11 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseFIFOF */

/*----------------------------------------------------------------------+
|	Main function for rotational FIFO				|
+----------------------------------------------------------------------*/
void
FIFOF()
{
	for( ; ; )
	{
		DisplayFIFOF();
		switch( ChooseFIFOF() )
		{
		case	 1	:	RF_BUILD();	break;
		case	 2	:	RF_OPEN();	break;
		case	 3	:	RF_CLOSE();	break;
		case	 4	:	RF_DELETE();	break;
		case	 5	:	RF_GET();	break;
		case	 6	:	RF_GETD();	break;
		case	 7	:	RF_GETINFO();	break;
		case	 8	:	RF_GETNEW();	break;
		case	 9	:	RF_GETOLD();	break;
		case	10	:	RF_READ();	break;
		case	11	:	RF_WRITE();	break;
		default		:	RF_CLOSE();	return;
		}
	}

} /* FIFOF */

/****** End of fifo.c **************************************************/
