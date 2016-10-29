/* f_copy() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : copy 1 file in existing directory				*/
/*		return value : ERR = -1					*/
/*			        OK = 0					*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<sys/types.h>
#include	<sys/stat.h>
#ifndef	WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	"gps.h"

extern	void	l_gpssethyerrno( int gps_hyerrno );

#ifdef		WIN32
extern	int	l_ntchmod( char *fpath, int fmode, int attrset );
#endif

int CBD1
#if	defined( __CB_STDC__ )
f_copy( char *spath, char *dpath, char writeopt )
#else
f_copy( spath, dpath, writeopt )
char	*spath;
char	*dpath;
char	writeopt;	/* 'A':append, 'W':overwrite, else:not overwrite */
#endif
{
	char	*rbuff;
	FILE	*sFD;
	FILE	*dFD;
	struct	stat	l_stat;
	register	i;
	char	tmpdir[160];
	char	opentype[5];		/* 990526 inserted by KHC */
#ifndef	WIN32
	mode_t	st_mode;			/* 990526 inserted by KHC */
#else
	unsigned short	st_mode;	/* 990526 inserted by KHC */
#endif

	if( spath == 0 )
	{
		l_gpssethyerrno( EGP_FCOPYARG1 );
		return( -1 );
	}

	if( dpath == 0 )
	{
		l_gpssethyerrno( EGP_FCOPYARG2 );
		return( -1 );
	}

	/* search file existence */
#ifndef	WIN32
	if( access( spath, F_OK ) < 0 ) 
#else
	if( access( spath, 00 ) < 0 ) 
#endif
	{
		l_gpssethyerrno( EGP_FCOPYNOTFOUND );
		return( -1 );
	}

	/* check readable */
#ifndef	WIN32
	if( access( spath, R_OK ) < 0 ) 
#else
	if( access( spath, 04 ) < 0 ) 
#endif
	{
		l_gpssethyerrno( EGP_FCOPYREADPERM );
		return( -1 );
	}

	for( i=strlen(dpath)-1 ; i>=0 ; i-- )
	{
		if( ( dpath[i] == '/' ) || ( dpath[i] == '\\' ) )
			break;
	}
	if( i<0 )
	{
		l_gpssethyerrno( EGP_FCOPYPATHWRONG );
		return( -1 );
	}
	else if( i )
	{
#ifdef	WIN32
		if( dpath[i-1] == ':' )
			i++;
#endif
		memcpy( tmpdir, dpath, i );
		tmpdir[i] = 0;
	}
	else
	{
#ifndef	WIN32
		tmpdir[0] = '/';
		tmpdir[1] = 0;
#else
		l_gpssethyerrno( EGP_FCOPYPATHERR );
		return( -1 );
#endif
	}

	if( ( toupper(writeopt) != 'W' )
	 && ( toupper(writeopt) != 'A' ) )
	{
#ifndef	WIN32
		if( access( dpath, F_OK ) >= 0 ) 
#else
		if( access( dpath, 00 ) >= 0 ) 
#endif
		{
			l_gpssethyerrno( EGP_FCOPYEXIST );
			return( -1 );
		}
	}

	/* check whether destination directory is exist */
	if( stat( tmpdir, (struct stat *)&l_stat ) < 0 ) 
	{
		l_gpssethyerrno( EGP_FCOPYWRONGDIR );
		return( -1 );
	}

	/* check whether upper path is directory */
	if( !(l_stat.st_mode & S_IFDIR) )
	{
		l_gpssethyerrno( EGP_FCOPYNOTDIR );
		return( -1 );
	}

	if( ( sFD = fopen( spath, "rb" ) ) == (FILE *)0 )
	{
		l_gpssethyerrno( EGP_FCOPYOPENERR1 );
		return( -1 );
	}

	if( stat( spath, (struct stat *)&l_stat ) < 0 ) 
	{
		fclose( sFD );
		l_gpssethyerrno( EGP_FCOPYGETSIZE );
		return( -1 );
	}

	st_mode = l_stat.st_mode;	/* 990526 inserted by KHC */

	rbuff = (char *)malloc( l_stat.st_size+1 );

	if( l_stat.st_size )
	{
		if( !fread( rbuff, l_stat.st_size, sizeof( char ), sFD ) )
		{
			free( rbuff );
			fclose( sFD );
			l_gpssethyerrno( EGP_FCOPYREADERR );
			return( -1 );
		}
	}

	memset(opentype,0,sizeof(opentype));
	if( toupper( writeopt ) == 'A' )
	{
		strcpy( opentype, "ab" );
	}
	else
	{
		strcpy( opentype, "wb" );
	}

	if( ( dFD = fopen( dpath, opentype ) ) == (FILE *)0 )
	{
		free( rbuff );
		fclose( sFD );
		l_gpssethyerrno( EGP_FCOPYOPENERR2 );
		return( -1 );
	}

	if( l_stat.st_size )
	{
		if( !fwrite( rbuff, l_stat.st_size, sizeof( char ), dFD ) )
		{
			free( rbuff );
			fclose( sFD );
			fclose( dFD );
			l_gpssethyerrno( EGP_FCOPYWRITEERR );
			return( -1 );
		}
	}

	free( rbuff );
	fclose( sFD );
	fclose( dFD );

#ifndef WIN32
        if( chmod( dpath, st_mode&0777 ) < 0 )
#else
        if( l_ntchmod( dpath, st_mode&0777, 1 ) )
#endif
        {
                l_gpssethyerrno( EGP_FCOPYCHGMODEERR );
                return -1;
        }

	return( 0 );
}
