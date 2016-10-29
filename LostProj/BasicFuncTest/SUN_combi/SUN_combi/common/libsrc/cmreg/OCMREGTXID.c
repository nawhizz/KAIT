/* OCMREGTXID() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGTXID() : Handl txid isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGTXID( char *asid, char *regtxid, char *action, char *retcode )
#else
OCMREGTXID( asid, regtxid, action, retcode )
char	*asid;		/* X(32) */
char	*regtxid;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegTxid( asid, (struct reg_txidFORM *)regtxid, action[0] ) )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGTXID.c */
