/* OWFM_CLOSE () : LIB wfm */
/*----------------------------------------------------------------------*
|									|
|	void OWFM_CLOSE( char *retcode, int *ffd )			|
|									|
|	close opened form file						|
|									|
|	input	ffd		- form file open descriptor		|
|	output	retcode		- Return code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"wfm.h"
#include	"wfm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OWFM_CLOSE( char *retcode, int *ffd )
#else
OWFM_CLOSE( retcode, ffd )
char			*retcode;		/* X(5) */
int			*ffd;			/* S9(8) COMP */
#endif
{
	int	l_ffd;
	int	l_ret;

	memcpy( &l_ffd, ffd, sizeof l_ffd );

	if( (l_ret = WFmClose( l_ffd )) < 0 )
		wfm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
