/* OWFM_OPEN () : LIB wfm */
/*----------------------------------------------------------------------*
|									|
|	void OWFM_OPEN( int *ffd, char *ffpath )			|
|									|
|	open form file							|
|									|
|	input	ffpath		- full path of form file		|
|	output	retcode		- return code				|
|		ffd	>=0	- form file descriptor			|
|			< 0	- error					|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"wfm.h"
#include	"wfm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OWFM_OPEN( char *retcode, int *ffd, char *ffpath )
#else
OWFM_OPEN( retcode, ffd, ffpath )
char		*retcode;		/* X(5) */
int		*ffd;			/* S9(8) COMP */
char		*ffpath;		/* X(max.128) */
#endif
{
	int	l_ffd;
	char	l_ffpath[128];

	d_mkstr( ffpath, 128-1, l_ffpath );

	if( (l_ffd = WFmOpen( l_ffpath )) < 0 )
		wfm_errset( retcode );
	else
	{
		memcpy( ffd, &l_ffd, sizeof l_ffd );
		memset( retcode, ' ', 5 );
	}
}
