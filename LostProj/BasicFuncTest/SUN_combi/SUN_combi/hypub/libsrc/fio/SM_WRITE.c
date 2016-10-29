/* SM_WRITE() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : write new data to sam file					*/
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
SM_WRITE( FILE *fp, char *record, int recsize )
#else
SM_WRITE( fp, record, recsize )
FILE	*fp;
char	*record;
int	recsize;
#endif
{
	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}
	if( (int)fwrite( record, recsize, 1, fp ) != 1 ) {
		l_fiosethyerrno( ESM_WRITE );
		return( -1 ) ;
	}
	return( 0 ) ;
}
