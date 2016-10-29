/* OBP_PRTSEGF() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print segment form without data				*/
/*----------------------------------------------------------------------*/
/*
   RETURN VALUE
	retcode[0] = ' ' OK
		     'E' ERR

   data ¼±¾ð IN APPLICATION
	01 retcode	PIC X(1)	VALUE SPACE.	: return value
	01 pfd		PIC S9(8) COMP	VALUE -1.	: printout file opened
					by OFS_OPEN,OFS_CROPEN,OFS_BUILD
	01 ffd		PIC S9(8) COMP	VALUE -1.	: form file opened by
					by OFM_OPEN
	01 segid	PIC X(20)	VALUE SPACE.	: prtform segment id
*/

#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OBP_PRTSEGF( int *pfd, int *ffd, char *segid, char *retcode )
#else
OBP_PRTSEGF( pfd, ffd, segid, retcode )
int	*pfd, *ffd;
char	*segid, *retcode;
#endif
{
	char	l_segid[21];

	d_mkstr( segid, 20, l_segid );
	if( bp_prtsegf( *pfd, *ffd, l_segid ) < 0 )
		retcode[0] = 'E';
	else	retcode[0] = ' ';
}
