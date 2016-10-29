/* OCMREGUSER() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGUSER() : Handl usid/lusr isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"stpapi.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGUSER( char *reguser, char *action, char *retcode )
#else
OCMREGUSER( reguser, action, retcode )
char	*reguser;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegUser( (struct  reg_userFORM *)reguser, action[0] ) ) 
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGUSER.c */
