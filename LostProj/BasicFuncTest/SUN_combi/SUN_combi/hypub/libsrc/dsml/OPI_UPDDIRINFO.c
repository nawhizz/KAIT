/* OPI_UPDDIRINFO () : LIB dsml */
/*----------------------------------------------------------------------*
|									|
|	void OPI_UPDDIRINFO( int *fd, char *olddirpath,			|
|			char *newdirpath, char *retcode )		|
|									|
|	Insert new directory to Master Volume				|
|									|
|	input	fd		- isam open file desciptor		|
|		olddirpath	- directory path to be substituted	|
|		newdirpath	- directory path to substitute		|
|	output	retcode		- Return Code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

void CBD1
#if	defined( __CB_STDC__ )
OPI_UPDDIRINFO( int *fd, char *olddirpath, char *newdirpath,  char *retcode )
#else
OPI_UPDDIRINFO( fd, olddirpath, newdirpath, retcode )
int			*fd;			/* S9(8) COMP */
char			*olddirpath;		/* X(max.128) */
char			*newdirpath;		/* X(max.128) */
char			*retcode;		/* X(5) */
#endif
{
	int	l_fd;
	char	l_olddirpath[DS_PATHLEN];
	char	l_newdirpath[DS_PATHLEN];

	memcpy( &l_fd, fd, sizeof l_fd );
	d_mkstr( olddirpath, DS_PATHLEN-1, l_olddirpath );
	d_mkstr( newdirpath, DS_PATHLEN-1, l_newdirpath );

	if( PI_UPDDIRINFO( l_fd, l_olddirpath, l_newdirpath ) < 0 )
		ds_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
