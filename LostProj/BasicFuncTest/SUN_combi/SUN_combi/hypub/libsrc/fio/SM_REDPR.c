/* SM_REDPR() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : read previous data						*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/

#include	<stdio.h>
#include	<errno.h>

#include	"gps.h"
#include	"fio.h"
#include	"sm_fun.h"

int CBD1
#if	defined( __CB_STDC__ )
SM_REDPR( FILE *fp, char *record, int recsize )
#else
SM_REDPR( fp, record, recsize )
FILE	*fp;
char	*record;
int	recsize;
#endif
{
	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	if( fseek( fp, -(long)(recsize*2), SEEK_CUR  ) < 0 ) {
		l_fiosethyerrno( ESM_FSEEK );
		return( -1 ) ;
	}

	if( (int)fread( record, recsize, 1, fp ) != 1 ) {
		l_fiosethyerrno( ESM_READ );
		return( -1 ) ;
	}
	return( 0 );
}
