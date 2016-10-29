/* CmRegOpen() : LIBCMREG */
/*----------------------------------------------------------------------+
|	CmRegOpen() : Combi Isam Data Transaction Process Start		|
|                                                                       |
|       return	0	Passed                                          |
|               -1      Denied                                          |
|									|
+----------------------------------------------------------------------*/
#include	<errno.h>
#include	<iswrap.h>

#include	"pisam.h"
#include	"cmreg.h"
#include	"cmregdef.h"

#include	"stpapi.h"

int CBD1
#if	defined( __CB_STDC__ )
CmRegOpen( void )
#else
CmRegOpen()
#endif
{
	tracelog("CmRegOpen(). start. cm_transtart=%d\n",cm_transtart);
	if( cm_transtart >= 1 )
	{
		tracelog("CmRegOpen(). end. already cm_transtart\n");
		return( 0 );
	}

	if( PI_ISTRAN() == 2 )
	{
		cm_transtart = 1;
		tracelog("CmRegOpen(). end. already PI_TRAN. cm_transtart=1\n");
		return( 0 );
	}

	if( PI_TRAN() < 0 )
	{
l_errlog("CmRegOpen()", "PI_TRAN error. iserrno=%d, errno=%d\n",iserrno,errno);
		tracelog("CmRegOpen(). error. PI_TRAN\n");
		return( -1 );
	}

	cm_transtart = 2;
	tracelog("CmRegOpen(). end. cm_transtart=2\n");
	return( 0 );
}
/* end of CmRegOpen */
