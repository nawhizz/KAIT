/* fm_getfpath() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : get full path of file 					*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<stdlib.h>
#include	<string.h>

#include	"fm_fun.h"

int
#if	defined( __CB_STDC__ )
fm_getfpath( char *fileid, char *fileext, char *filepath )
#else
fm_getfpath( fileid, fileext, filepath )
char	*fileid;
char	*fileext;
char	*filepath;
#endif
{
	register	i;
	char		c_fileid[81];
	char		*c_filepath;

	if( ( c_filepath = getenv( "PFORMDIR" ) ) == (char *)0 )
		return -1;

	strcpy( filepath, c_filepath );

	memcpy( c_fileid, fileid, strlen(fileid) );
	for( i=strlen(fileid)-1; i>=0; i-- )
		if( fileid[i] != ' ' )
			break;

	c_fileid[i+1]=0;

	strcat( filepath, "/" );
	strcat( filepath, c_fileid );
	strcat( filepath, fileext );

	return 0;
}
