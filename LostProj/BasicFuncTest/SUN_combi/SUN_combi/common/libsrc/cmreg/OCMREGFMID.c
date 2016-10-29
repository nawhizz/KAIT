/* OCMREGFMID() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGFMID() : Handl fmid isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGFMID( char *asid, char *regfmid, char *action, char *retcode )
#else
OCMREGFMID( asid, regfmid, action, retcode )
char	*asid;		/* X(32) */
char	*regfmid;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegFmid( asid, (struct reg_fmidFORM *)regfmid, action[0] ) )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGFMID.c */
