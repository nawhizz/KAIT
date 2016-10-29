/* e_getsysdate() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get system date & time in form of options followed		*/
/*----------------------------------------------------------------------*/
/*
	input	: int	  choice	option number
					  01 (	         HHMMSS  )
					  02 (	         HH:MM:SS)
					  10 (YYMMDD  	         )
					  20 (YY/MM/DD	         )
					  11 (YYMMDD     HHMMSS  )
					  12 (YYMMDD     HH:MM:SS)
					  21 (YY/MM/DD   HHMMSS  )
					  22 (YY/MM/DD   HH:MM:SS)
					  31 (YYYYMMDD   HHMMSS  )
					  32 (YYYYMMDD   HH:MM:SS)
	output	: char	  *datestr	date string (not null terminated)
		  char	  *timestr	time string (not null terminated)
	return	: 0/-1
*/

#include	<sys/types.h>
#include	<time.h>
#include	<string.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_getsysdate( int choice, char *datestr, char *timestr )
#else
e_getsysdate( choice, datestr, timestr )
int	choice;
char	*datestr;
char	*timestr;
#endif
{
	return( e_getdatestr( time((time_t *)0), choice, datestr, timestr ) );
}
