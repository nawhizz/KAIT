/* wfm_savefile() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : save file							*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<string.h>

#include	"wfm.h"
#include	"wfm_fun.h"

int
#if	defined( __CB_STDC__ )
wfm_savefile( char *filepath, char *fbuff, int fsize )
#else
wfm_savefile( filepath, fbuff, fsize )
char	*filepath;
char	*fbuff;
int	fsize;
#endif
{
	int		retfd;
	register	i;

	retfd = wfm_currfd;

	if( wfm_saveseginfo( fbuff, fsize, &wfm_svfinfo[wfm_currfd].hseg,
		&wfm_svfinfo[wfm_currfd].cseg,
		&wfm_svfinfo[wfm_currfd].tseg) < 0 )
	{
		l_wfmsethyerrno( EWF_NOMORE_MEM );
		return -1;
	}

	strcpy( wfm_svfinfo[wfm_currfd].filepath_sav, filepath );
	wfm_svfinfo[wfm_currfd].fbuff = fbuff;
	wfm_svfinfo[wfm_currfd].fsize = fsize;

	/* find next available fd */
	if( (i=retfd+1) >= WFM_MAXOPEN )
		i=0;
	for ( ; i != retfd; )
	{
		if ( !wfm_svfinfo[i].filepath_sav[0] )
		{
			/* if available fd (not opened) found */
			wfm_currfd = i;
			return( retfd );
		}
		if( (++i) >= WFM_MAXOPEN ) i=0;
	}

	/* if no more available then set nomore */
	wfm_currfd = -1;

	return( retfd );
}

