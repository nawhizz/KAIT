/* CmRegRollback() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegRollback() : Rollback Combi Isam Data			|
+----------------------------------------------------------------------*/
#include	"pisam.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
CmRegRollback( void )
#else
CmRegRollback()
#endif
{
	tracelog("CmRegRollback(). start. cm_transtart=%d\n",cm_transtart);
	if( cm_transtart < 2 )
	{
		tracelog("CmRegRollback(). end\n");
		return;
	}
	PI_ROLLBACK();
	tracelog("CmRegRollback(). end. PI_ROLLBACK\n");
}
/* end of CmRegRollback */
