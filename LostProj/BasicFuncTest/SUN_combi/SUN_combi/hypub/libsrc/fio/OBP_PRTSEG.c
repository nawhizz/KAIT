/* OBP_PRTSEG() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print segment data with segment form				*/
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
	01 ffd		PIC S9(8) COMP	VALUE -1.	: form file opened by
					by OFM_OPEN
	01 segid	PIC X(20)	VALUE SPACE.	: prtform segment id
	01 maskchar	PIC X(1)	VALUE '#'.	: output field
					descriptor in form file
*/

#include	"fio.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OBP_PRTSEG( int	*pfd, int *ffd, char *segid, char *data, int *len,
	char *maskchar, char *retcode )
#else
OBP_PRTSEG( pfd, ffd, segid, data, len, maskchar, retcode )
int	*pfd, *ffd;
char	*segid, *data;
int	*len;
char	*maskchar, *retcode;
#endif
{
	char	l_segid[21];

	d_mkstr( segid, 20, l_segid ); 
	if( bp_prtseg( *pfd, *ffd, l_segid, data, *len, *maskchar ) < 0 )
		retcode[0] = 'E';
	else	retcode[0] = ' ';
}
