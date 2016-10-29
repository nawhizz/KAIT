/* OR_RUNCONT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fork() & exex() & continue					*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OR_RUNCONT(char *pname,short *retval)
#else
OR_RUNCONT(pname,retval)
char	*pname; 		/* X(max.40) */
short	*retval;		/* S9(4) COMP. */
#endif
{
	char	l_pname[41];

	d_mkstr( pname, 40, l_pname );
	r_runcont( l_pname, retval );
}
