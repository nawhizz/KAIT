/* SM_OPEN() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : open sam file 						*/
/*	  if nofile then error						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*mode;		open mode
					  "R" = SM_RDONLY
					  "W" = SM_RDWR
					  "A" = SM_APPEND
	return	: 0/-1
*/

#include	<stdio.h>
#include	<ctype.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_OPEN( char *fpath, char *mode, FILE **fptr )
#else
SM_OPEN( fpath, mode, fptr )
char	*fpath;
char	*mode;
FILE	**fptr;
#endif
{
	*fptr = (FILE *)0;

	switch( toupper( mode[0] ) ) {
		case 'R' :
			if( ( *fptr = fopen( fpath, "rb" ) ) == (FILE *)0 ) {
				l_fiosethyerrno( errno );
				return( -1 );
			}
			break;
		case 'W' :
			if( ( *fptr = fopen( fpath, "wb" ) ) == (FILE *)0 ) {
				l_fiosethyerrno( errno );
				return( -1 );
			}
			break;
		case 'A' :
			if( ( *fptr = fopen( fpath, "ab" ) ) == (FILE *)0 ) {
				l_fiosethyerrno( errno );
				return( -1 );
			}
			if( fseek( *fptr, 0L, SEEK_END ) < 0 ) {
				l_fiosethyerrno( ESM_FSEEK );
				fclose( *fptr );
				*fptr = (FILE *)0;
				return( -1 );
			}
			break;
		default	:
			l_fiosethyerrno( ESM_INVAL );
			return( -1 );
	}
	return( 0 );
}
