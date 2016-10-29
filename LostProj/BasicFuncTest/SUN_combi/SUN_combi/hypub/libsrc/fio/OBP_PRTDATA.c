/* OBP_PRTDATA() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print data to file						*/
/*----------------------------------------------------------------------*/
/*
   RETURN VALUE
	retcode[0] = ' ' OK
		     'E' ERR

   DATA ¼±¾ð IN APPLICATION
	01 retcode	PIC X(1)	VALUE SPACE.	: return value
	01 data 	PIC X(...).			: print data
	01 len		PIC S9(8) COMP. 		: data length
	01 pfd		PIC S9(8) COMP	VALUE -1.	: printout file opened
					by OFS_OPEN,OFS_CROPEN,OFS_BUILD
*/

#include	"fio.h"

void CBD1
#if	defined( __CB_STDC__ )
OBP_PRTDATA( int *pfd, char *data, int *len, char *retcode )
#else
OBP_PRTDATA( pfd, data, len, retcode )
int	*pfd;
char	*data;
int	*len;
char	*retcode;
#endif
{
	if( bp_prtdata( *pfd, data, *len ) < 0 ) retcode[0] = 'E';
	else	retcode[0] = ' ';
}

