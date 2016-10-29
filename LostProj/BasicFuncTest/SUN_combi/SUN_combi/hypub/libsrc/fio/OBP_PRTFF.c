/* OBP_PRTFF() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print formfeed to file					*/
/*----------------------------------------------------------------------*/
/*
   RETURN VALUE
	retcode[0] = ' ' OK
		     'E' ERR

   DATA ���� IN APPLICATION
	01 retcode	PIC X(1)	VALUE SPACE.	: return value
	01 pfd		PIC S9(8) COMP	VALUE -1.	: printout file opened
					by OFS_OPEN,OFS_CROPEN,OFS_BUILD
*/

#include	"fio.h"

void CBD1
#if	defined( __CB_STDC__ )
OBP_PRTFF( int *pfd, char *retcode )
#else
OBP_PRTFF( pfd, retcode )
int	*pfd;
char	*retcode;
#endif
{
	if( bp_prtff( *pfd ) < 0 ) retcode[0] = 'E';
	else	retcode[0] = ' ';
}

