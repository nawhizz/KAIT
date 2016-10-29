/* OR_RUNWAIT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork() & exex() & wait()					*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OR_RUNWAIT(char *pname,short *retval)
#else
OR_RUNWAIT(pname,retval)
char	*pname; 		/* X(max.40) */
short	*retval;		/* S9(4) COMP. */
#endif
{
	char	l_pname[41];

	d_mkstr( pname, 40, l_pname );
	r_runwait( l_pname, retval );
}
