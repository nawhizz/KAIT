/* OCMREGLUSR() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGLUSR() : Handle lusr Isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGLUSR( char *reglusr, char *action, char *retcode )
#else
OCMREGLUSR( reglusr, action, retcode )
char	*reglusr;
char	*action;	/* X(1)	*/
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegLusr( (struct reg_lusrFORM *)reglusr, action[0] ) ) 
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGLUSR */
