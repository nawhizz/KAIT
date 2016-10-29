/* OCMREGASCL() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGASCL() : Handl ascl isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"gps.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGASCL( char *asid, char *regascl, char *fpath, char *action, char *retcode)
#else
OCMREGASCL( asid, regascl, fpath, action, retcode )
char	*asid;		/* X(32) */
char	*regascl;
char	*fpath;		/* X(256) */
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	char	l_fpath[257];

	d_mkstr( fpath, sizeof(l_fpath)-1, l_fpath );
	if( CmRegAscl( asid, (struct reg_asclFORM *)regascl, fpath, action[0] ))
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGASCL.c */
