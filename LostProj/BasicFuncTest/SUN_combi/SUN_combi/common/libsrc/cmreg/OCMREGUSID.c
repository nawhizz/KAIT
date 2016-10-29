/* OCMREGUSID() : LIBCMREG */
/*----------------------------------------------------------------------+
|	OCMREGUSID() : Handl usid isam for COBOL			|
+----------------------------------------------------------------------*/
#include	<string.h> /*memset*/

#include        "cbuni.h"
#include	"cmreg.h"
#include	"cmregdef.h"

void CBD1
#if	defined( __CB_STDC__ )
OCMREGUSID( char *regusid, char *action, char *retcode )
#else
OCMREGUSID( regusid, action, retcode )
char	*regusid;
char	*action;	/* X(1) */
char	*retcode;	/* X(5)	*/
#endif
{
	if( CmRegUsid( (struct reg_usidFORM *)regusid, action[0] ) )
		l_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
/* end of OCMREGUSID.c */
