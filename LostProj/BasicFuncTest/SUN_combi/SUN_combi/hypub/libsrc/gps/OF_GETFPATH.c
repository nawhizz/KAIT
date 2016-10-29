/* OF_GETFPATH() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get full file path of fileid according to base directory as	*/
/*	  defined in CFG file of which path defined by ENVIRONMENT	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OF_GETFPATH( char *fileid, char *fileext, char *envname, char *filepath, char *RETSTS )
#else
OF_GETFPATH( fileid, fileext, envname, filepath, RETSTS )
char	*fileid;		/* X(10) */
char	*fileext;		/* X(10) */
char	*envname;		/* X(20) */
char	*filepath;		/* X(100) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_fileid[11];
	char	l_fileext[11];
	char	l_envname[21];

	d_mkstr( fileid, 10, l_fileid );
	d_mkstr( fileext, 10, l_fileext );
	d_mkstr( envname, 20, l_envname );

	if( f_getfpath( l_fileid, l_fileext, l_envname, filepath ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
