/* e_getdatestr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : formmat time & date by choice    				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	  timeval	time value (using 'time' function)
		  int	  choice	option number
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

#include	<time.h>
#include	<string.h>

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_getdatestr( long timeval, int choice, char *datestr, char *timestr )
#else
e_getdatestr( timeval, choice, datestr, timestr )
long 	timeval;
int 	choice;
char 	*datestr;
char 	*timestr;
#endif
{
	struct	tm	*tmtime;
	int		f_year;

	choice %= 100;
	if( ( choice / 10 && datestr == (char *)0 ) ||
	    ( choice % 10 && timestr == (char *)0 ) )
	{
		return( -1 );
	}

	tmtime = localtime((time_t *)&timeval);
	tmtime->tm_mon ++;

	switch( choice / 10 )
	{
		case	1	:
			d_int2ndec((unsigned)tmtime->tm_year,2,'0',&datestr[0]);
			d_int2ndec((unsigned)tmtime->tm_mon,2,'0',&datestr[2]);
			d_int2ndec((unsigned)tmtime->tm_mday,2,'0',&datestr[4]);
			break;

		case	2	:
			d_int2ndec((unsigned)tmtime->tm_year,2,'0',&datestr[0]);
			d_int2ndec((unsigned)tmtime->tm_mon,2,'0',&datestr[3]);
			d_int2ndec((unsigned)tmtime->tm_mday,2,'0',&datestr[6]);
			datestr[2] = '/';
			datestr[5] = '/';
			break;

		case	3	:
			f_year = tmtime->tm_year + 1900;
			d_int2ndec((unsigned)f_year,4,'0',&datestr[0]);
			d_int2ndec((unsigned)tmtime->tm_mon,2,'0',&datestr[4]);
			d_int2ndec((unsigned)tmtime->tm_mday,2,'0',&datestr[6]);
			break;

		case	0	:
			break;
		default		:
			return( -1 );
	}

	switch( choice % 10 )
	{
		case	1	:
			d_int2ndec((unsigned)tmtime->tm_hour,2,'0',&timestr[0]);
			d_int2ndec((unsigned)tmtime->tm_min, 2,'0',&timestr[2]);
			d_int2ndec((unsigned)tmtime->tm_sec, 2,'0',&timestr[4]);
			break;

		case	2	:
			d_int2ndec((unsigned)tmtime->tm_hour,2,'0',&timestr[0]);
			d_int2ndec((unsigned)tmtime->tm_min, 2,'0',&timestr[3]);
			d_int2ndec((unsigned)tmtime->tm_sec, 2,'0',&timestr[6]);
			timestr[2] = ':';
			timestr[5] = ':';
			break;

		case	0	:
			if( choice / 10 == 0 )
				return( -1 );
			break;

		default		:
			return( -1 );
	}

	return( 0 );
}
