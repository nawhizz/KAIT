/* OBP_PRTFORM() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print formatted data to file					*/
/*----------------------------------------------------------------------*/
/*
   RETURN VALUE
	retcode[0] = ' ' OK
		     'E' ERR

   DATA ���� IN APPLICATION
	01 retcode	PIC X(1)	VALUE SPACE.	: return value
	01 data 	PIC X(...).			: print data
	01 len		PIC S9(8) COMP. 		: data length
	01 pfd		PIC S9(8) COMP	VALUE -1.	: printout file opened
					by OFS_OPEN,OFS_CROPEN,OFS_BUILD
	01 ffd		PIC S9(8) COMP	VALUE -1.	: form file opened by
					by OFM_OPEN
	01 MASKCHAR	PIC X(1)	VALUE '#'.	: output field
					descriptor in form file
*/

#include	"fio.h"

void CBD1
#if	defined( __CB_STDC__ )
OBP_PRTFORM( int *pfd, int *ffd, char *data, int *len, char *maskchar,
	char *retcode )
#else
OBP_PRTFORM( pfd, ffd, data, len, maskchar, retcode )
int	*pfd, *ffd;
char	*data;
int	*len;
char	*maskchar, *retcode;
#endif
{
	if( bp_prtform( *pfd, *ffd, data, *len, *maskchar ) < 0 )
		retcode[0] = 'E';
	else	retcode[0] = ' ';
}
