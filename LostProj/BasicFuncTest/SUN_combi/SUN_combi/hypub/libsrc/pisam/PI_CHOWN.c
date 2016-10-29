/* PI_CHOWN() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : change owner and group of file				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#include	<pwd.h>
#else
#include	<io.h>
#endif

#include	<sys/types.h>
#include	<errno.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_CHOWN( char *filepath, char *owner )
#else
PI_CHOWN( filepath, owner )
char	*filepath;
char	*owner;
#endif
{
	char	dat_path[PI_PATHLEN];
	char	idx_path[PI_PATHLEN];

	if( filepath == (char *)0 || owner == (char *)0 )
	{
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	strcpy( dat_path, filepath );
	strcpy( idx_path, filepath );
	strcat( dat_path, ".dat" );
	strcat( idx_path, ".idx" );

	/* search file existence */
#ifndef	WIN32
	if( access( dat_path, F_OK ) < 0 || 
	    access( idx_path, F_OK ) < 0 )
#else
	if( access( dat_path, 6 ) < 0 || 
	    access( idx_path, 6 ) < 0 )
#endif
	{
		l_pisamsethyerrno( EPI_NODATAFILE );
		return -1;
	}

	/* change owner, group of '.dat' file */
	if( f_chown( dat_path, owner ) < 0 )
	{
		l_pisamsethyerrno(  errno );
		return -1;
	}
	/* change owner, group of '.idx' file */
	if( f_chown( idx_path, owner ) < 0 )
	{
		l_pisamsethyerrno(  errno );
		return -1;
	}

	return 0;
}

