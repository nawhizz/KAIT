/* fm_savefile() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : save file							*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<stdio.h>
#include	<string.h>

#include	"fm_fun.h"

int
#if	defined( __CB_STDC__ )
fm_savefile( char *filepath, FILE *fd, char *fbuff, int fsize )
#else
fm_savefile( filepath, fd, fbuff, fsize )
char	*filepath;
FILE	*fd;
char	*fbuff;
int	fsize;
#endif
{
	int		retfd;
	register	i;

	retfd = fm_currfd;

	strcpy( fm_svfinfo[fm_currfd].filepath_sav, filepath );
	fm_svfinfo[fm_currfd].fd_sav = fd;
	fm_svfinfo[fm_currfd].fbuff = fbuff;
	fm_svfinfo[fm_currfd].fsize = fsize;

	/* find next available fd */
	if( (i=retfd+1) >= FM_MAXOPEN )
		i=0;
	for ( ; i != retfd; )
	{
		if ( !fm_svfinfo[i].filepath_sav[0] )
		{
			/* if available fd (not opened) found */
			fm_currfd = i;
			return( retfd );
		}
		if( (++i) >= FM_MAXOPEN ) i=0;
	}

	/* if no more available then set nomore */
	fm_currfd = -1;

	return( retfd );
}
