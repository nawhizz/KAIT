/* PI_RECLENGTH() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get length of record						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_RECLENGTH( int fd )
#else
PI_RECLENGTH( fd )
int	fd;
#endif
{
	int	isfd;
	struct	dictinfo buffer;

	if( ( fd < 0 ) || ( fd >= PI_MAXOPEN ) ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] )
	{
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	isfd = pi_fileinfo[fd].isfd_sav;	/* get saved isfd */

	if( isindexinfo( isfd, (struct keydesc *)&buffer, 0 ) != 0 )
	{
		l_pisamsethyerrno( iserrno  );
		return -1;
	}

	return buffer.di_recsize;
}
