/* OPI_ALLCLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close all opened file 					*/
/*	  if no file opened then return ok				*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ALLCLOSE( char *retcode )
#else
OPI_ALLCLOSE( retcode )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=ok */
#endif
{
	if( PI_ALLCLOSE() < 0 )
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
