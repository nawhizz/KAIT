/* OPI_DCONV () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_DCONV( char *file1path, char *file2path,		|
|		struct BUILDFORM *build_inf, char *retcode )		|
|									|
|	Build new file							|
|									|
|	input	file1path	- full file path of V1			|
|		file2path	- full file path of V2			|
|		build_inf	- information of file			|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_DCONV( char *file1path, char *file2path, struct BUILDFORM *build_inf,
							char *retcode )
#else
OPI_DCONV( file1path, file2path, build_inf, retcode )
char			*file1path;		/* X(max.128) */
char			*file2path;		/* X(max.128) */
struct	BUILDFORM	*build_inf;
char			*retcode;		/* X(5) */
#endif
{
	char	l_file1path[DS_PATHLEN];
	char	l_file2path[DS_PATHLEN];

	d_mkstr( file1path, DS_PATHLEN-1, l_file1path );
	d_mkstr( file2path, DS_PATHLEN-1, l_file2path );

	if( PI_DCONV( l_file1path, l_file2path, build_inf ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
