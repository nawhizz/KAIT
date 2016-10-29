/* OCMREGROLLBACK() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGROLLBACK() : ROLLBACK for COBOL				|
+----------------------------------------------------------------------*/
#include        "cbuni.h"
#include	"cmreg.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGROLLBACK( void )
#else
OCMREGROLLBACK()
#endif
{
	CmRegRollback();
}
/* end of OCMREGROLLBACK */
