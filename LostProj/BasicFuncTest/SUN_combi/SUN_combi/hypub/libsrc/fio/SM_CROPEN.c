/* SM_CROPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open or create sam file for append				*/
/*	  if nofile then create 					*/
/*----------------------------------------------------------------------*/
/*
	return : 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_CROPEN( char	*fpath, FILE **fptr )
#else
SM_CROPEN( fpath, fptr )
char	*fpath;
FILE	**fptr;
#endif
{
	*fptr = (FILE *)0;

	if( ( *fptr = fopen( fpath, "r+b" ) ) == (FILE *)0 ) {
		if( ( *fptr = fopen( fpath, "w+b" ) ) == (FILE *)0 ) {
			l_fiosethyerrno( errno );
			return( -1 );
		}
	}

	return( 0 );
}
