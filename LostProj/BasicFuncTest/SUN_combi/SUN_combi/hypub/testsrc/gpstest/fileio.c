/************************************************************************
*	GPS library testing program ( file I/O )			*
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
F_CHMOD()
{
	char	tmpstr[80];
	char	fpath[256];
	int	mode = 0;
	int	i;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_chmod( char *fpath(i), int mode(i) )          |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fpath : " );
	scanf( "%s", fpath );
	printf( " mode  : " );
	scanf( "%s", tmpstr );
	for( i=0; tmpstr[i]; i++ )
	{
		if( tmpstr[i] < '0' || tmpstr[i] > '7' )
		{
			printf( "invalid mode ......\n" );
			return;
		}
		mode = mode * 8 + tmpstr[i] - '0';
	}

	if( f_chmod( fpath, mode ) < 0 )
	{
		printf( "f_chmod error .....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* F_CHMOD */

/*---------------------------------------------------------------------*/
void
F_CHOWN()
{
	char	owner[80];
	char	fpath[256];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_chown( char *fpath(i), char *owner(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fpath : " );
	scanf( "%s", fpath );
	printf( " owner : " );
	scanf( "%s", owner );

	if( f_chown( fpath, owner ) < 0 )
	{
		printf( "f_chown error .....(%d)\n", hyerrno );
		return;
	}

	printf( " Result successful\n" );

} /* F_CHOWN */

#ifndef	WIN32
/*---------------------------------------------------------------------*/
void
F_GETENV()
{
	char	cfgfpath[80];
	char	envname[80];
	char	envvalue[512];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_getenv( char *cfgfpath(i), char *envname(i),  |\n" );
	printf( "|                 char *envvalue(o) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cfgfpath        : " );
	scanf( "%s", cfgfpath );
	printf( " envname         : " );
	scanf( "%s", envname );

	if( f_getenv( cfgfpath, envname, envvalue ) < 0 )
	{
		printf( "f_getenv error .....\n" );
		return;
	}

	printf( " Result envvalue : [%s]\n", envvalue );

} /* F_GETENV */
#endif

/*---------------------------------------------------------------------*/
void
F_GETFPATH()
{
	char	fileid[80];
	char	fileext[80];
	char	envname[80];
	char	filepath[512];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_getfpath( char *fileid(i), char *fileext(i),  |\n" );
	printf( "|                char *envname(i), char *filepath(o) )  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fileid          : " );
	scanf( "%s", fileid );
	printf( " fileext         : " );
	gets( fileext );
	gets( fileext );
	printf( " envname         : " );
	scanf( "%s", envname );

	if( f_getfpath( fileid, fileext, envname, filepath ) < 0 )
	{
		printf( "f_getfpath error .....\n" );
		return;
	}

	printf( " Result filepath : [%s]\n", filepath );

} /* F_GETFPATH */

/*---------------------------------------------------------------------*/
void
F_LOCK()
{
	char	filepath[128];
	int	fd;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_lock( int fd(i) )                             |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd : " );
	scanf( "%s", filepath );

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( f_lock( fd ) < 0 )
	{
		printf( "f_lock error .....\n" );
		close( fd );
		return;
	}

	printf( " Pause .....\n" );
	gets( filepath );
	gets( filepath );

	close( fd );

	printf( " Result successful\n" );

} /* F_LOCK */

/*---------------------------------------------------------------------*/
void
F_LOCKWAIT()
{
	char	filepath[128];
	int	fd;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_lockwait( int fd(i) )                         |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd : " );
	scanf( "%s", filepath );

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( f_lockwait( fd ) < 0 )
	{
		printf( "f_lockwait error .....\n" );
		close( fd );
		return;
	}

	printf( " Pause .....\n" );
	gets( filepath );
	gets( filepath );

	close( fd );

	printf( " Result successful\n" );

} /* F_LOCKWAIT */

/*---------------------------------------------------------------------*/
void
F_MKDIR()
{
	char	tmpstr[80];
	char	fpath[256];
	int	mode = 0;
	int	i;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_mkdir( char *fpath(i), int mode(i) )          |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " fpath : " );
	scanf( "%s", fpath );
	printf( " mode  : " );
	scanf( "%s", tmpstr );
	for( i=0; tmpstr[i]; i++ )
	{
		if( tmpstr[i] < '0' || tmpstr[i] > '7' )
		{
			printf( "invalid mode ......\n" );
			return;
		}
		mode = mode * 8 + tmpstr[i] - '0';
	}

	if( f_mkdir( fpath, mode ) < 0 )
	{
		printf( "f_mkdir error .....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* F_MKDIR */

#ifndef	WIN32
/*---------------------------------------------------------------------*/
void
F_SETENV()
{
	char	cfgfpath[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_setenv( char *cfgfpath(i) )                   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " cfgfpath : " );
	scanf( "%s", cfgfpath );

	if( f_setenv( cfgfpath ) < 0 )
	{
		printf( "f_setenv error .....\n" );
		return;
	}

	printf( " Result successful\n" );

} /* F_SETENV */
#endif

/*---------------------------------------------------------------------*/
void
F_UNLOCK()
{
	char	filepath[128];
	int	fd;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       f_unlock( int fd(i) )                           |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " filepath for fd : " );
	scanf( "%s", filepath );

#ifdef	WIN32
	if( ( fd = open( filepath, O_BINARY | O_RDWR ) ) < 0 )
#else
	if( ( fd = open( filepath, O_RDWR ) ) < 0 )
#endif
	{
		printf( "open error .....\n" );
		return;
	}

	if( f_unlock( fd ) < 0 )
	{
		printf( "f_unlock error .....\n" );
		close( fd );
		return;
	}

	close( fd );

	printf( " Result successful\n" );

} /* F_UNLOCK */

/*----------------------------------------------------------------------+
|	Display function for file I/O					|
+----------------------------------------------------------------------*/
void
DisplayFIOF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( file I/O )           |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( "  1. f_chmod  2. f_chown     3. f_getfpath\n" );
	printf( "  4. f_lock   5. f_lockwait  6. f_mkdir    7. f_unlock\n" );
#ifndef	WIN32
	printf( "  8. f_getenv 9. f_setenv\n" );
#endif
	printf( " 99. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayFIOF */

/*----------------------------------------------------------------------+
|	Choose function for file I/O					|
+----------------------------------------------------------------------*/
int
ChooseFIOF()
{
	int	choosenum = 0;
	char	choosestr[80];

#ifdef	WIN32
	while( choosenum != 99 && ( choosenum < 1 || choosenum > 9 ) )
#else
	while( choosenum != 99 && ( choosenum < 1 || choosenum > 7 ) )
#endif
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseFIOF */

/*----------------------------------------------------------------------+
|	Main function for file I/O					|
+----------------------------------------------------------------------*/
void
FIOF()
{
	for( ; ; )
	{
		DisplayFIOF();
		switch( ChooseFIOF() )
		{
		case	1	:	F_CHMOD();	break;
		case	2	:	F_CHOWN();	break;
		case	3	:	F_GETFPATH();	break;
		case	4	:	F_LOCK();	break;
		case	5	:	F_LOCKWAIT();	break;
		case	6	:	F_MKDIR();	break;
		case	7	:	F_UNLOCK();	break;
#ifndef	WIN32
		case	8	:	F_GETENV();	break;
		case	9	:	F_SETENV();	break;
#endif
		default		:			return;
		}
	}

} /* FIOF */

/****** End of fileio.c ************************************************/
