/* OF_TEMPNAM() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : generate temporary file in directory				*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_TEMPNAM( char *tmpdir,  char *tmpfpath, char *retcode )
#else
OF_TEMPNAM( tmpdir, tmpfpath, retcode )
char	*tmpdir;		/* X(100) */
char	*tmpfpath;		/* X(100) */
char	*retcode;		/* X(1) */
#endif
{
	char	l_tmpdir[128];
	char	*tmpfile;
#ifdef	WIN32
	int	retv;
#endif

	d_mkstr( tmpdir, 100, l_tmpdir );

	if( l_tmpdir[0] != 0 )
	{
#ifdef	WIN32
		if( access( l_tmpdir, 6 ) )
#else
		if( access( l_tmpdir, F_OK | R_OK | W_OK | X_OK ) )
#endif
		{
			retcode[0] = 'E';
			return;
		}
	}
	else
	{
#ifdef	WIN32
		retv = GetTempPath( sizeof( l_tmpdir ) - 1, l_tmpdir );
		if( !retv || retv > sizeof( l_tmpdir ) - 1 )
		{
			retcode[0] = 'E';
			return;
		}
#else
		strcpy( l_tmpdir, "/tmp" );
#endif
	}

	if( ( tmpfile = tempnam( l_tmpdir, (char *)0 ) ) == (char *)0 )
	{
		retcode[0] = 'E';
		return;
	}

	strcpy( tmpfpath, tmpfile );
	free( tmpfile );

	retcode[0] = ' ';
}
