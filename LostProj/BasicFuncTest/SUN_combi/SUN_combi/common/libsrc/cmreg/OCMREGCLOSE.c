/* OCMREGCLOSE() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGCLOSE() : TRAN END for COBOL				|
+----------------------------------------------------------------------*/
#include        "cbuni.h"
#include	"cmreg.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGCLOSE( void )
#else
OCMREGCLOSE()
#endif
{
	CmRegClose();
}
/* end of OCMREGCLOSE */
