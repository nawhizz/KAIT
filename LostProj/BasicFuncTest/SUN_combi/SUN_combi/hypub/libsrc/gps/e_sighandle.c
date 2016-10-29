/* e_sighandle() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : handle signal 						*/
/*----------------------------------------------------------------------*/

#ifdef		WIN32
#include	<stdlib.h>
#endif

#include	<signal.h>
#include	"e_sigact.h"

#include	"gps.h"

int	(*e_sigaction[MAX_signal][MAX_action])	() = {0};

void
#if	defined( __CB_STDC__ )
e_sighandle( int sig )
#else
e_sighandle( sig )
int	sig;
#endif
{
	register	i;
	int		ret;

	signal( sig, e_sighandle );

	for( i=(MAX_action-1); i>=0; i--)
		if( e_sigaction[sig][i] )
			ret = e_sigaction[sig][i]( sig );

	if (ret < 0)
		exit( 0 );
}
