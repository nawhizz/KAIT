/* SM_BUILD() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : truncate open sam file					*/
/*	  if fileexist then truncate else create			*/
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
SM_BUILD( char *fpath, FILE **fptr )
#else
SM_BUILD( fpath, fptr )
char	*fpath;
FILE	**fptr;
#endif
{
	*fptr = (FILE *)0;

	if( (*fptr=fopen( fpath, "w+b" )) == NULL ) {
		l_fiosethyerrno( errno );
		return( -1 );
	}
	else	return( 0 );
}
