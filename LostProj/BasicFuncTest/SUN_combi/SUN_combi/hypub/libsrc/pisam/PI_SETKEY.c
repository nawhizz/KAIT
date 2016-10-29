/* PI_SETKEY() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : restart record's index by new key                             */
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_SETKEY( int fd, char *keyname )
#else
PI_SETKEY( fd, keyname )
int	fd;
char	*keyname;
#endif
{
	FILE	*tfd;
	int	isfd, recsize;
	char	buff[80];
	char	*buf;
	char	infpath[PI_PATHLEN];

	if( fd < 0 || fd >= PI_MAXOPEN ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if( keyname == (char *)0 )
	{
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] ) {
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	strcpy( infpath, pi_fileinfo[fd].infpath_sav );
	if ( ( tfd = fopen( infpath, "rb" ) ) == (FILE *)0 ) {
		l_pisamsethyerrno( EPI_NOINFFILE );
		return -1;
	}

	fscanf( tfd, "%s", buff );

	recsize = atoi( buff );
	if ( recsize <= 0 ) {
		fclose( tfd );
		l_pisamsethyerrno( EPI_INFRECSIZE );
		return -1;
	}
	fclose( tfd );

	isfd = pi_fileinfo[fd].isfd_sav;
	buf = (char *)malloc( recsize + 1);
	memset( buf, ' ', recsize );

	if ( PI_START( fd, keyname, buf, ISFIRST) < 0 ) {
		return -1;
	}
	return 0;
}
