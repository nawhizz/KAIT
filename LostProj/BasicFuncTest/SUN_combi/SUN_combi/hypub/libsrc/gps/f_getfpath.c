/* f_getfpath() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get full file path of fileid according to base directory as	*/
/*	  defined in CFG file of which path defined by ENVIRONMENT	*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fileid;	file id
		  char	*fileext;	file extention
					if '.' exist then include it
		  char	*envname;	environment name (pointing CFG file)
	output	: char	filepath[];	file full path
	return	: 0/-1

	※ CFGFILE path : 환경변수로 지정(envname=/home2/cfg/cfgfile)
*/
/*-----------------------------------------------------------------------------*
| History								       |
|------------------------------------------------------------------------------|
| 2000/6/8 : ksh. NT에서의 bug 수정. / -> \				       |
*-----------------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<sys/types.h>
#include	<fcntl.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
f_getfpath( char *fileid, char *fileext, char *envname, char *filepath )
#else
f_getfpath( fileid, fileext, envname, filepath )
char	*fileid;
char	*fileext;
char	*envname;
char	*filepath;
#endif
{
	int	i;
	char	*cfgfpath;
	char	linebuf[256];
	FILE	*cfgFD;

	if ( fileid == (char *)0 || envname == (char *)0 ||
	     filepath == (char *)0 )
	{
		return -1;
	}

	if( ( cfgfpath = getenv( envname ) ) == (char *)0 )
		return -1;

	if ( ( cfgFD = fopen( cfgfpath, "r" ) ) == (FILE *)0 )
		return -1;

	for( ; ; )
	{
		fscanf( cfgFD,	"%s", linebuf );
		if ( feof( cfgFD ) )
		{
			fclose( cfgFD );
			return -1;
		}

		if (linebuf[0] == '#' )
		{
			fgets( linebuf, sizeof linebuf, cfgFD );
			continue;
		}

		for( i = 0; linebuf[i]; i++ )
		{
			if ( linebuf[i] == ':' )
			{
				linebuf[i] = 0;
				break;
			}
		}

		if ( !strcmp( fileid, linebuf ) )
		{
			strcpy( filepath, &linebuf[++i] );
			break;
		}
	}

/*2000/6/8 change start---------------------------------------------------------
	strcat( filepath, "/" );
------------------------------------------------------------------------------*/
#ifdef	WIN32
	strcat( filepath, "\\" );
#else
	strcat( filepath, "/" );
#endif
/*2000/6/8 end----------------------------------------------------------------*/
	strcat( filepath, fileid );
	if ( fileext )
		strcat( filepath, fileext );

	fclose( cfgFD );
	return 0;
}
