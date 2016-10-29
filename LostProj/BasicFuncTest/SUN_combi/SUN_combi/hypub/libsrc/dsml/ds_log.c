/* ds_log() : LIB dsml internal function */
/************************************************************************
*	add history to logfile
************************************************************************/
/*-------------------------------------------------------------------
add : |nsize(2)|aleng(1)|code(1)|afname(aleng)|psize(2)|
upd : |nsize(2)|bleng(1)|code(1)|aleng(1)|bfname(bleng)|afname(aleng)|psize(2)|
del : |nsize(2)|bleng(1)|code(1)|bfname(bleng)|psize(2)|
-------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#include	<fcntl.h>
#include	<errno.h>

#ifdef		WIN32
#include	<io.h>
#else
#include	<unistd.h>
#endif

#include	"dsml.h"
#include	"dsmldef.h"

char	dsml_logpath[DS_PATHLEN] = "";
/*----------------------------------------------------------------------+
*	add history to logfile
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_log( char code, char *bfname, char *afname )
#else
ds_log( code, bfname, afname)
char	code;
char	*bfname;
char	*afname;
#endif
{
	char	*logbuf;
	char	*bufaddr;
	unsigned char	aleng;
	unsigned char	bleng;
	short	nsize;
	int	logFD;
	char	tmppath[DS_PATHLEN];

	/*---------------------------------------------------------------
	** check arguments & init some variables
	**-------------------------------------------------------------*/
	switch( code )
	{
	case	DS_ADD_CODE	:
		aleng = (unsigned char)( strlen( afname ) + 1 );
		nsize = 6 + aleng;
		break;
	case	DS_DEL_CODE	:
		bleng = (unsigned char)( strlen( bfname ) + 1 );
		nsize = 6 + bleng;
		break;
	case	DS_UPD_CODE	:
		aleng = (unsigned char)( strlen( afname ) + 1 );
		bleng = (unsigned char)( strlen( bfname ) + 1 );
		nsize = 7 + bleng + aleng;
		break;
	}

	/*---------------------------------------------------------------
	** create or open logfile
	**-------------------------------------------------------------*/
	if( dsml_logpath[0] == 0 )
	{
		char	*env;
		int	psize = 0;	/* psize(2byte) & nsize(2byte) */

		if( ( env = getenv( "ISLOGDIR" ) ) == (char *)0 )
		{
			l_dsmlsethyerrno( EDS_NOT_DEF_ISLOGDIR );
			return( -1 );
		}

#ifdef	WIN32
		sprintf( tmppath, "%s/dslog.%d", env, GetCurrentProcessId() );
#else
		sprintf( tmppath, "%s/dslog.%d", env, getpid() );
#endif
		ds_fullpath( tmppath, dsml_logpath );

#ifdef	WIN32
		logFD = open( dsml_logpath, O_CREAT | O_WRONLY | O_BINARY,
									0666 );
#else
		logFD = open( dsml_logpath, O_CREAT | O_WRONLY, 0666 );
#endif
		if( logFD < 0 )
		{
			l_dsmlsethyerrno( EDS_OPENLOG_FAIL );
			return( -1 );
		}

		if( write( logFD, &psize, sizeof psize ) != sizeof psize )
		{
			l_dsmlsethyerrno( errno );
			close( logFD );
			return( -1 );
		}
	}
	else
	{
#ifdef	WIN32
		if( ( logFD = open( dsml_logpath, O_WRONLY | O_BINARY ) ) < 0 )
#else
		if( ( logFD = open( dsml_logpath, O_WRONLY ) ) < 0 )
#endif
		{
			l_dsmlsethyerrno( EDS_OPENLOG_FAIL );
			return( -1 );
		}
	}

	/*---------------------------------------------------------------
	** data set on logbuf
	**-------------------------------------------------------------*/
	if( ( logbuf = (char *)malloc( nsize + sizeof( short ) ) ) == (char *)0  )
	{
		l_dsmlsethyerrno( EDS_NOMORE_MEM );
		close( logFD );
		return( -1 );
	}

	bufaddr = logbuf;
	
	/* nsize */
	memcpy( bufaddr, &nsize, sizeof( nsize ) );
	bufaddr += sizeof( nsize );

	/* bleng */
	if( code == DS_DEL_CODE || code == DS_UPD_CODE )
	{
		memcpy( bufaddr, &bleng, sizeof( bleng ) );
		bufaddr += sizeof( bleng );
	}
	else
	{
		memcpy( bufaddr, &aleng, sizeof( aleng ) );
		bufaddr += sizeof( aleng );
	}

	/* code */
	*bufaddr = code;
	bufaddr += 1;

	/* aleng */
	if( code == DS_UPD_CODE )
	{
		memcpy( bufaddr, &aleng, sizeof( aleng ) );
		bufaddr += sizeof( aleng );
	}

	/* bfname */
	if( code == DS_UPD_CODE || code == DS_DEL_CODE )
	{
		strcpy( bufaddr, bfname );
		bufaddr += bleng;
	}

	/* afname */
	if( code == DS_ADD_CODE || code == DS_UPD_CODE )
	{
		strcpy( bufaddr, afname );
		bufaddr += aleng;
	}

	/* psize */
	memcpy( bufaddr, &nsize, sizeof( nsize ) );
	bufaddr += sizeof nsize;

	/* nsize */
	memset( bufaddr, 0, sizeof( short ) );
	/*---------------------------------------------------------------
	** change offset and write logbuf to logfile
	**-------------------------------------------------------------*/
	if( lseek( logFD, -2, SEEK_END ) < 0 )
	{
		l_dsmlsethyerrno( errno );
		free( logbuf );
		close( logFD );
		return( -1 );
	}

	if( (short)write( logFD, logbuf,
			nsize + sizeof( short ) ) != (short)(nsize + sizeof( short )) )
	{
		l_dsmlsethyerrno( errno );
		free( logbuf );
		close( logFD );
		return( -1 );
	}

	free( logbuf );
	close( logFD );
	return 0;
}
