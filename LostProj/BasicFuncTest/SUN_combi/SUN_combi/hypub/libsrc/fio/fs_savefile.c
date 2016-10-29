/* fs_savefile() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : save file							*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<stdio.h>
#include	<string.h>

#include	"fs_fun.h"

int
#if	defined( __CB_STDC__ )
fs_savefile( char *filepath, FILE *fd )
#else
fs_savefile( filepath, fd )
char	*filepath;
FILE	*fd;
#endif
{
	int		retfd;
	register	i;

	retfd = fs_currfd;

	strcpy( fs_svfinfo[fs_currfd].filepath_sav, filepath );
	fs_svfinfo[fs_currfd].fd_sav = fd;

	/* find next available fd */
	if( (i=retfd+1) >= FS_MAXOPEN )
		i=0;
	for ( ; i != retfd; )
	{
		if ( !fs_svfinfo[i].filepath_sav[0] )
		{
			/* if available fd (not opened) found */
			fs_currfd = i;
			return( retfd );
		}
		if( (++i) >= FS_MAXOPEN ) i=0;
	}

	/* if no more available then set nomore */
	fs_currfd = -1;

	return( retfd );
}
