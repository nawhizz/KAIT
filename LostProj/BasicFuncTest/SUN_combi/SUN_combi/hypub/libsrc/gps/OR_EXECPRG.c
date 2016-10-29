/* OR_EXECPRG() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : execute program and exit ( chainning program )		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OR_EXECPRG(char *pname,short *retval)
#else
OR_EXECPRG(pname,retval)
char	*pname; 		/* X(max.40) */
short	*retval;		/* S9(4) COMP. */
#endif
{
	char	l_pname[41];

	d_mkstr( pname, 40, l_pname );
	r_execprg( l_pname, retval );
}
