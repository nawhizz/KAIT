/* PI_KEYLENGTH() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : get length of key						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<stdlib.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_KEYLENGTH( int fd, char *keyname )
#else
PI_KEYLENGTH( fd, keyname )
int	fd;
char	*keyname;
#endif
{
	int	isfd, nkeys, keylen, i;
	struct	keydesc  key;

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

	nkeys = keyname[1] - 64;		/* 'A'=65 */

	if( isindexinfo( isfd, &key, nkeys ) != 0 )
	{
		l_pisamsethyerrno( iserrno  );
		return -1;
	}

	keylen = 0;
	for( i=0; i<key.k_nparts; i++ )
		keylen += key.k_part[i].kp_leng;

	return keylen;
}
