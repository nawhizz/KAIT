/* OCMREGCLNT() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGCLNT() : Handl clnt isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGCLNT( char *regclnt, char *action, char *retcode )
#else
OCMREGCLNT( regclnt, action, retcode )
char	*regclnt;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegClnt( (struct reg_clntFORM *)regclnt, action[0] ) )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGCLNT.c */
