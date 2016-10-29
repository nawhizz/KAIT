/* f_mkdir() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : create directory tree if not exist and set mode		*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*fpath
		: int	mode
	return	: 0/-1
*/
/*-----------------------------------------------------------------------------*
| History								       |
|------------------------------------------------------------------------------|
| 2000/6/8 : ksh. NT에서의 bug 수정. / -> \				       |
*-----------------------------------------------------------------------------*/

#include	<string.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#ifndef		WIN32
#include	<unistd.h>
#else
#include	<direct.h>
#include	<io.h>
#endif

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
f_mkdir( char *fpath, int mode )
#else
f_mkdir( fpath, mode )
char	*fpath;
int	mode;
#endif
{
	register	i;
	char		string[512];
	char		dirpath[512];

	if( fpath == (char *)0 )
		return( -1 );

/*2000/6/8 change start---------------------------------------------------------
	if( fpath[0] != '/' )
------------------------------------------------------------------------------*/
#ifdef	WIN32
	if( fpath[0] != '\\' && ( fpath[1] != ':' || fpath[2] != '\\' ) )
#else
	if( fpath[0] != '/' )
#endif
/*2000/6/8 end----------------------------------------------------------------*/
	{
		int		len;

		if( getcwd( string, sizeof string ) == (char *)0 )
			return(-1);
		len = strlen(string);
		if( len + 2 + strlen( fpath ) > sizeof string )
			return(-1);
/*2000/6/8 change start---------------------------------------------------------
		strcat( string, "/" );
------------------------------------------------------------------------------*/
#ifdef	WIN32
		strcat( string, "\\" );
#else
		strcat( string, "/" );
#endif
/*2000/6/8 end----------------------------------------------------------------*/
		strcat( string, fpath );
	}
	else
	{
		if( strlen( fpath ) > sizeof string )
		 	return(-1);
		strcpy( string, fpath );
	}

	dirpath[0] = string[0];
	for( i=1; ; i++ )
	{
/*2000/6/8 change start---------------------------------------------------------
		if( string[i] == '/' || string[i] == 0 )
------------------------------------------------------------------------------*/
#ifdef	WIN32
		if( string[i] == '\\' || string[i] == 0 )
#else
		if( string[i] == '/' || string[i] == 0 )
#endif
/*2000/6/8 end----------------------------------------------------------------*/
		{
			dirpath[i] = 0;
#ifndef	WIN32
			if( access( dirpath, F_OK ) < 0 )
			{
				if( mkdir( dirpath, mode ) < 0 )
					return(-1);
				if( chmod( dirpath, mode ) < 0 )
					return(-1);
			}
#else
			if( access( dirpath, 0 ) < 0 )
			{
				if( mkdir( dirpath ) < 0 )
					return(-1);
			}
#endif

			if( string[i] == (char)0 )
				break;
		}
		dirpath[i] = string[i];
	}
	return(0);
}
