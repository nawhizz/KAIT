/* PI_CHMOD() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : change permission mode of file				*/
/*----------------------------------------------------------------------*/

#include	<string.h>

#ifndef		WIN32
#include	<unistd.h>
#else
#include	<io.h>
#endif

#include	<sys/types.h>
#include	<sys/stat.h>
#include	<errno.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_CHMOD( char *filepath, int mode )
#else
PI_CHMOD( filepath, mode )
char	*filepath;
int	mode;
#endif
{
	char	dat_path[PI_PATHLEN];
	char	idx_path[PI_PATHLEN];

	if( filepath == (char *)0 )
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
	if( access( dat_path, 0 ) < 0 || 
	    access( idx_path, 0 ) < 0 )
#endif
	{
		l_pisamsethyerrno( EPI_NODATAFILE );
		return -1;
	}

	/* change mode of '.dat' file */
	if( f_chmod( dat_path, mode ) < 0 )
	{
		l_pisamsethyerrno(  errno );
		return -1;
	}
	/* change mode of '.idx' file */
	if( f_chmod( idx_path, mode ) < 0 )
	{
		l_pisamsethyerrno(  errno );
		return -1;
	}

	return 0;
}
