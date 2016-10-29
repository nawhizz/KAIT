/* OPI_START() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start record's index by key                                   */
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_START( char *retcode, int *fd, char *keyname, char *record, int *mode )
#else
OPI_START(retcode, fd, keyname, record, mode)
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*keyname;		/* X(2). */
char	*record;		/* X(nn) recurd buffer */
int	*mode;			/* S9(8) COMP. ISFIRST, ISEQUAL, .. in isam.h */
#endif
{
	char	l_keyname[3];

	d_mkstr( keyname, 2, l_keyname ) ;

	if( PI_START( *fd, l_keyname, record, *mode) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
