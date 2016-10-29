/* ds_fullpath() : LIB dsml internal function */
/************************************************************************
*	get full file path						*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		file path		*
*	output	: char	*filefull		full file path		*
************************************************************************/

#include	<string.h>
#include	<errno.h>

#ifdef	WIN32
#include	<windows.h>
#else
#include	<unistd.h>
#endif

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	get full file path						|
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_fullpath( char *filepath, char *fullpath )
#else
ds_fullpath( filepath, fullpath )
char	*filepath;
char	*fullpath;
#endif
{
#ifdef	WIN32
	char		*filename;
#endif
	register	spos, dpos;
	char		cwd[256];

#ifdef	WIN32
	if( !GetFullPathName( filepath, sizeof cwd, cwd, &filename ) )
	{
		if( filepath[0] == '\\' || filepath[0] == '/' )
		{
			if( !GetCurrentDirectory( sizeof cwd, cwd ) )
			{
				l_dsmlsethyerrno( GetLastError() );
				return( -1 );
			}

			if( strlen( filepath ) >= DS_PATHLEN - 2 )
			{
				l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
				return( -1 );
			}

			memcpy( fullpath, cwd, 2 );	/* C: */
			strcpy( &fullpath[2], filepath );
		}
		else if( filepath[1] == ':' )
		{
			if( filepath[2] == '\\' || filepath[2] == '/' )
			{
				if( strlen( filepath ) >= DS_PATHLEN )
				{
					l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
					return( -1 );
				}

				strcpy( fullpath, filepath );
			}
			else
			{
				l_dsmlsethyerrno( EDS_INVAL_ARG );
				return( -1 );
			}
		}
		else
		{
			if( !GetCurrentDirectory( sizeof cwd, cwd ) )
			{
				l_dsmlsethyerrno( GetLastError() );
				return( -1 );
			}

			dpos=strlen( cwd );
			for( spos=0; !memcmp( &filepath[spos], "..", 2 ); spos+=3 )
			{
				for( ; dpos>=2 && cwd[dpos]!='/' && cwd[dpos]!='\\'; dpos-- )
					cwd[dpos] = (char)0;
				if( dpos >= 2 )
				{
					cwd[dpos] = (char)0;
					dpos--;
				}
			}

			strcat( cwd, "\\" );
			strcat( cwd, &filepath[spos] );

			if( strlen( cwd ) >= DS_PATHLEN )
			{
				l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
				return( -1 );
			}

			strcpy( fullpath, cwd );
		}
	}
	else
	{
		if( strlen( cwd ) >= DS_PATHLEN )
		{
			l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
			return( -1 );
		}

		strcpy( fullpath, cwd );
	}
#else
	if( filepath[0] != '/' )
	{
		if( getcwd( cwd, sizeof cwd ) == (char *)0 )
		{
			l_dsmlsethyerrno( errno );
			return( -1 );
		}

		dpos=strlen( cwd );
		for( spos=0; !memcmp( &filepath[spos], "../", 3 ); spos+=3 )
		{
			for( ; dpos>=0 && cwd[dpos]!='/'; dpos-- )
				cwd[dpos] = (char)0;
			if( dpos >= 0 )
			{
				cwd[dpos] = (char)0;
				dpos--;
			}
		}

		strcat( cwd, "/" );
		strcat( cwd, &filepath[spos] );

		if( (int)strlen( cwd ) >= DS_PATHLEN )
		{
			l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
			return( -1 );
		}

		strcpy( fullpath, cwd );
	}
	else
	{
		if( (int)strlen( filepath ) >= DS_PATHLEN )
		{
			l_dsmlsethyerrno( EDS_TOOLONG_FILEPATH );
			return( -1 );
		}

		strcpy( fullpath, filepath );
	}
#endif

	return( 0 );
}
/******* The end of ds_fullpath.c **************************************/
