/* ds_erase() : LIB dsml internal function */
/************************************************************************
*	erase file							*
*-----------------------------------------------------------------------*
*	input	: char	*filepath		full file path		*
************************************************************************/

#include	<stdio.h>
#include	<string.h>
#include	<iswrap.h>
#include	<sys/types.h>
#include	<sys/stat.h>

#ifdef          WIN32
#include	<windows.h>
#include        <io.h>
#include	<direct.h>
#else
#include	<dirent.h>
#include	<unistd.h>
#endif

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	union	dsmuFORM	du;

/*----------------------------------------------------------------------+
|	remove directory						|
+----------------------------------------------------------------------*/
static	void
#if	defined( __CB_STDC__ )
ds_rmdir( char *delpath )
#else
ds_rmdir( delpath )
char	*delpath;
#endif
{
	char		l_delpath[DS_PATHLEN];

#ifdef	WIN32
	HANDLE		hFind;
	WIN32_FIND_DATA w32fd;
	char    	dirlist[255];/* "delpath\*.*" */

	sprintf( dirlist, "%s\\*.*", delpath );
        hFind = FindFirstFile( dirlist, &w32fd );
        if( hFind == INVALID_HANDLE_VALUE )
                return;

	do
	{
                strcpy( l_delpath, delpath );
                strcat( l_delpath, "\\" );
                strcat( l_delpath, w32fd.cFileName );

                if( w32fd.dwFileAttributes == FILE_ATTRIBUTE_DIRECTORY )
                        ds_rmdir( l_delpath );
		else
			remove( l_delpath );
	}
        while( FindNextFile( hFind, &w32fd ) );

	FindClose( hFind );

	rmdir( delpath );
#else
	struct	stat	statbuf;
	struct	dirent	*dirp;
	DIR		*dp;

	if( ( dp = opendir( delpath ) ) == NULL )
		return;

	while( ( dirp = readdir( dp ) ) != NULL )
	{
		if( !strcmp( dirp->d_name, "." ) ||
		    !strcmp( dirp->d_name, ".." ) )
			continue;

		strcpy( l_delpath, delpath );
		strcat( l_delpath, "/" );
		strcat( l_delpath, dirp->d_name );

		if( stat( l_delpath, &statbuf ) < 0 )
			continue;

		if( S_ISDIR( statbuf.st_mode ) )
			ds_rmdir( l_delpath );
		else
			remove( l_delpath );
	}

	closedir( dp );

	rmdir( delpath );
#endif
}

/*----------------------------------------------------------------------+
|	erase file							|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
ds_erase( char *filepath )
#else
ds_erase( filepath )
char	*filepath;
#endif
{
	register	i, j;
	int		isfd;
	int		volcnt;
	int		thisvolcnt;
	int		dircnt;
	int		thisdircnt;
	struct	keydesc	pkey;

	/*---------------------------------------------------------------
	** Open isam file
	**-------------------------------------------------------------*/
	if( ( isfd = isopen( filepath, ISINPUT + ISMANULOCK ) ) < 0 )
	{
		iserase( filepath );
		return;
	}

	/*---------------------------------------------------------------
	** Check DSML version
	**-------------------------------------------------------------*/
	if( isindexinfo( isfd, &pkey, 1 ) < 0 ||
	    pkey.k_nparts != 2 ||
	    pkey.k_part[0].kp_start != 0 ||
	    pkey.k_part[0].kp_leng != LONGSIZE ||
	    pkey.k_part[0].kp_type != LONGTYPE ||
	    pkey.k_part[1].kp_start != LONGSIZE ||
	    pkey.k_part[1].kp_leng != LONGSIZE ||
	    pkey.k_part[1].kp_type != LONGTYPE )
	{
		isclose( isfd );
		iserase( filepath );
		return;
	}
	
	/*---------------------------------------------------------------
	** Read DSML master information
	**-------------------------------------------------------------*/
	stlong( (long)-1, (char *)&du.m.id );
	stlong( (long)0, (char *)&du.m.seq );

	if( isread( isfd, (char *)&du, ISGTEQ ) < 0 ||
	    (int)ldlong( (char *)&du.m.id ) >= 0 ||
	    (int)ldlong( (char *)&du.m.seq ) > 0 ||
	    strcmp( du.m.version, DS_VERSION ) )
	{
		isclose( isfd );
		iserase( filepath );
		return;
	}

	/*---------------------------------------------------------------
	** save volume path information
	**-------------------------------------------------------------*/
	if( du.m.volsts != DS_MASTER_VOLUME )
	{
		isclose( isfd );
		iserase( filepath );
		return;
	}

	volcnt = ldint( (char *)&du.m.volcnt );
	thisvolcnt = ldint( (char *)&du.m.thisvolcnt );

	for( i=0; ; )
	{
		/* set volume informations in this page to table */
		for( j=0; j<thisvolcnt; j++ )
		{
			if( i || j )
			{
				if( du.v.vol[j].volgen != DS_NOTGEN_VOLUME )
					iserase( du.m.vol[j].volpath );
			}
		}

		if( ( i += thisvolcnt ) >= volcnt )
			break;

		/* read next master information */
		if( isread( isfd, (char *)&du, ISNEXT ) < 0 ||
		    (int)ldlong( (char *)&du.m.id ) >= 0 )
		{
			break;
		}

		thisvolcnt = ldint( (char *)&du.v.thisvolcnt );

	} /* end of for */

	stlong( (long)-2, (char *)&du.lm.id ); 
	stlong( (long)0, (char *)&du.lm.seq );

	if( isread( isfd, (char *)&du, ISEQUAL ) < 0 ||
		    (int)ldlong( (char *)&du.lm.id ) >= -1 )
	{
		isclose( isfd );
		iserase( filepath );
		return;
	}
		
	dircnt = (int)ldlong( (char *)&du.lm.totdircnt );
	thisdircnt = (int)ldlong( (char *)&du.lm.thisdircnt ); 

	for( i = 0; ; )
	{
		for( j = 0; j < thisdircnt; j++ )
			ds_rmdir( du.lm.dirent[j].dir );

		if( ( i += thisdircnt ) >= dircnt )
			break;

		/* read next lm information */
		if( isread( isfd, (char *)&du, ISNEXT ) < 0 ||
		    (int)ldlong( (char *)&du.lm.id ) >= -1 )
		{
			break;
		}
	}

	isclose( isfd );
	iserase( filepath );
}

/******* The end of ds_erase.c *****************************************/
