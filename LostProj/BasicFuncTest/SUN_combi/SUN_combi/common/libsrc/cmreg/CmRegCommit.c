/* CmRegCommit() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegCommit() : Commit Combi Isam Data				|
|                                                                       |
+----------------------------------------------------------------------*/
#include	"pisam.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
CmRegCommit( void )
#else
CmRegCommit()
#endif
{
	tracelog("CmRegCommit(). start. cm_transtart=%d\n",cm_transtart);
	if( cm_transtart < 2 )
	{
		tracelog("CmRegCommit(). end.\n");
		return;
	}
	PI_COMMIT();
	tracelog("CmRegCommit(). end. PI_COMMIT\n");
}
/* end of CmRegCommit */
