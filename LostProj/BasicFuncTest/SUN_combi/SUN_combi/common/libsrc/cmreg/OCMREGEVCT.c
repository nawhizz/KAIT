/* OCMREGEVCT() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGEVCT() : Handl evct isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGEVCT( char *asid, char *regevct, char *action, char *retcode )
#else
OCMREGEVCT( asid, regevct, action, retcode )
char	*asid;		/* X(32) */
char	*regevct;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegEvct( asid, (struct reg_evctFORM *)regevct, action[0] ) )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGEVCT.c */
