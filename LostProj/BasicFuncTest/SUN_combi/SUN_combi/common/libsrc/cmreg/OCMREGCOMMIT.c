/* OCMREGCOMMIT() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGCOMMIT() : COMMIT for COBOL				|
+----------------------------------------------------------------------*/
#include        "cbuni.h"
#include	"cmreg.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGCOMMIT( void )
#else
OCMREGCOMMIT()
#endif
{
	CmRegCommit();
}
/* end of OCMREGCOMMIT */
