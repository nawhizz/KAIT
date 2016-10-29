/* e_addsigact() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : insert signal routine 					*/
/*----------------------------------------------------------------------*/

#include	<signal.h>
#include	"e_sigact.h"
#include	"gps.h"

void	e_sighandle CBD2(( int signo ));

int CBD1
#if	defined( __CB_STDC__ )
e_addsigact( int sig, int (*sig_func)( int ) )
#else
e_addsigact( sig, sig_func )
int	sig;
int	(*sig_func)( int );
#endif
{
	register	i;

	for( i=0; e_sigaction[sig][i]; )
		if( ++i > MAX_action )
			return( -1 );

	if( i == 0 )
		signal( sig, e_sighandle );

	e_sigaction[sig][i] = sig_func;

	return 0;
}
