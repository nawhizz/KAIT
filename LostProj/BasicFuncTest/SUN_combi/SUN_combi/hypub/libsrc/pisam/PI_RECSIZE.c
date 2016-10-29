/* PI_RECSIZE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get size of record						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_RECSIZE( char *fileid )
#else
PI_RECSIZE( fileid )
char	*fileid;
#endif
{
	FILE	*fd;
	char	buff[81];
	char	infpath[PI_PATHLEN];
	int	recsize;

	if( fileid == (char *)0 ) {
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( pi_getinfpath( fileid, infpath ) < 0 ) {
		return -1;
	}

	if ( ( fd = fopen( infpath, "rb" ) ) == (FILE *)0 ) {
		l_pisamsethyerrno( EPI_NOINFFILE );
		return -1;
	}

	fscanf( fd, "%s", buff );

	recsize = atoi( buff );
	if ( recsize <= 0 ) {
		fclose( fd );
		l_pisamsethyerrno( EPI_INFRECSIZE );
		return -1;
	}

	fclose( fd );
	return recsize;
}
