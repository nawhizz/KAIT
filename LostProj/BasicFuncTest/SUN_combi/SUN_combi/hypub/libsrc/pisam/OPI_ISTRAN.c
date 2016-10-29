/* OPI_ISTRAN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : return transaction status					*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ISTRAN( int *transts )
#else
OPI_ISTRAN( transts )
int	*transts;
#endif
{
	int	l_transts;

	l_transts = PI_ISTRAN();
	memcpy( &transts, &l_transts, sizeof l_transts );
}
