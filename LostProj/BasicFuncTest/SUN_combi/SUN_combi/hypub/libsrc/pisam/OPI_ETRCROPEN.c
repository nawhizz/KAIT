/* OPI_ETRCROPEN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : if file not exist, create and open file by manual lock & trans*/
/*	  or if file exist, open file by manual lock & trans		*/
/*----------------------------------------------------------------------*/
/* PISAM COBOL function */

#include	<string.h>

#include	"pisamdef.h"
#include	"pisam.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_ETRCROPEN( char *retcode, int *fd, char *fileid, char *fileext )
#else
OPI_ETRCROPEN( retcode, fd, fileid, fileext )
char	*retcode;		/* X(5) VALUE SPACE. SPACE=OK */
int	*fd ;			/* S9(8) COMP VALUE -1. */
char	*fileid;		/* X(8) */
char	*fileext;		/* X(max.40) followed by LOWVALUE */
#endif
{
	char	l_fileid[PI_IDLEN + 1];
	char	l_fileext[PI_EXTLEN + 1];

	d_mkstr( fileid, PI_IDLEN, l_fileid ) ;
	d_mkstr( fileext, PI_EXTLEN, l_fileext ) ;

	if( ( *fd = PI_ETRCROPEN( l_fileid, l_fileext ) ) < 0 ) 
		pi_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
