/* ds_splitpath() : LIB dsml internal function */
/************************************************************************
*	split path to directory and file
************************************************************************/

#include	<string.h>
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
*	split path to directory and file
+----------------------------------------------------------------------*/
int
#if	defined( __CB_STDC__ )
ds_splitpath( char *path, char *lpath, char *rpath, int n )
#else
ds_splitpath( path, lpath, rpath, n)
	char		*path;
	char		*lpath;
	char		*rpath;
	register	n;
#endif
{
	int	cnt, i;
	char	tmppath[DS_PATHLEN];

	/*---------------------------------------------------------------
	** check arguments
	**-------------------------------------------------------------*/
	if( path == (char *)0 )
		return( -1 );

	if( n <= 0 || n > DS_PATHLEN )
		return( -1 );

	/*---------------------------------------------------------------
	** find '/' in path
	**-------------------------------------------------------------*/
	strcpy( tmppath, path );

	cnt=0;
	for( i=strlen(tmppath)-1; i>=0; i-- )
	{
#ifdef	WIN32
		if( path[i] == '\\' || path[i] == '/' ) 
#else
		if( path[i] == '/' )
#endif
			cnt++;
		if( cnt >= n )
			break;
	}

	if( cnt < n )
		l_dsmlsethyerrno( EDS_INVAL_ARG );

	tmppath[i] = 0;
	strcpy( lpath, tmppath );
	strcpy( rpath, &tmppath[i+1] );	
	return( 0 );
}

/******* The end of ds_splitpath.c *************************************/
