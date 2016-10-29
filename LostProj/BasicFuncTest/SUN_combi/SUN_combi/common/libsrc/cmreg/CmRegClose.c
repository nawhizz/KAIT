/* CmRegClose() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegClose() : Handle lusr Isam for COBOL			|
|                                                                       |
+----------------------------------------------------------------------*/
#include	"pisam.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
CmRegClose( void )
#else
CmRegClose()
#endif
{
	tracelog("CmRegClose(). start. cm_transtart=%d\n", cm_transtart);
	if( cm_transtart < 2 )
	{
		tracelog("CmRegClose(). End.\n");
		return;
	}
	cm_transtart = 0;
	PI_ENDTRAN();
	tracelog("CmRegClose(). end. PI_ENDTRAN\n");
}
/* end of CmRegClose */
