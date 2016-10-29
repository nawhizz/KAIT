/* OCMREGOPEN() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGOPEN() : TRAN START for COBOL				|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"stpapi.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGOPEN( char *retcode )
#else
OCMREGOPEN( retcode )
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegOpen() )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGOPEN */
