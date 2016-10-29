/* OSM_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open sam file 						*/
/*	  if nofile then error						*/
/*----------------------------------------------------------------------*/

#include	<stdio.h>
#include	<string.h>

#include	"fio.h"
#include	"sm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OSM_OPEN( char *retcode, char *fpath, char *mode, FILE **fptr )
#else
OSM_OPEN( retcode, fpath, mode, fptr )
char	*retcode;		/* X(5) SPACE=ok */
char	*fpath; 		/* X(80) file path */
char	*mode;			/* X(1)  OPEN mode */
					/* "R" = SM_RDONLY */
					/* "W" = SM_RDWR   */
					/* "A" = SM_APPEND */
FILE	**fptr; 		/* S9(8) COMP. file descriptor pointer */
#endif
{
	char	l_fpath[81];

	d_mkstr( fpath, 80, l_fpath );
	if( SM_OPEN( l_fpath, mode, fptr ) < 0 )
		sm_errset( retcode );
	else
		memset( retcode, ' ', 5 );
}
