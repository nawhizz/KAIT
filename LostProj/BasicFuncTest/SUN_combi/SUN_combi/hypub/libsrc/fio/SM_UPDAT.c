/* SM_UPDAT() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : update data to record number's position of sam file           */
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
SM_UPDAT( FILE *fp, char *record, int recsize, int recno )
#else
SM_UPDAT( fp, record, recsize, recno )
FILE	*fp;
char	*record;
int	recsize;
int	recno;		/* record no starting from 0 */
#endif
{
	long	offset;

	if( fp == ( FILE * ) 0 ) {
		l_fiosethyerrno( ESM_NOPEN );
		return( -1 );
	}

	offset = (long)recsize * (long)recno;

	if( (fseek( fp, offset, SEEK_SET )) < 0 ) {
		l_fiosethyerrno( ESM_FSEEK );
		return( -1 ) ;
	}
	if( (int)fwrite(record, recsize, 1, fp) != 1 ) {
		l_fiosethyerrno( ESM_WRITE );
		return( -1 ) ;
	}
	return( 0 ) ;
}
