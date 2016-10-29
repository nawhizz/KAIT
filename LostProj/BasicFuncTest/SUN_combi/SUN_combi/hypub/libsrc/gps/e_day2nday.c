/* e_day2nday() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get day from inputed n's month				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*src1		form day
		  int	nmonth		number of month
		: char	*src2		to day
	return	: 0/-1
*/

#include	<string.h>
#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_day2nday( char *src1, int nmonth, char *src2 )
#else
e_day2nday( src1, nmonth, src2 )
char	*src1;
int	nmonth;
char	*src2;
#endif
{
	E_DATEINFO 	fdate,tdate;
	int  		k;

	if( src1 == (char *)0 || src2 == (char *)0 || nmonth < 0 )
		return -1;

	if( nmonth == 0 )
	{
		memcpy( src2, src1, 6 );
		return 0;
	}

	if( l_datechkconv( src1, "YYMMDD", &fdate ) < 0 )
		return -1;

	if( l_lstdaychkget( &fdate ) < 0 )
		return -1;

	k = fdate.imonth + nmonth - 1;
	tdate.iyear = fdate.iyear + k / 12;
	tdate.imonth = k % 12 + 1;
	tdate.iday = 1;
	if( l_lstdaychkget( &tdate ) < 0 )
		return -1;

	tdate.iday = fdate.iday > tdate.lastday[tdate.imonth-1]
		     ? tdate.lastday[tdate.imonth-1] : fdate.iday;

	d_int2ndec( tdate.iyear % 100, 2, '0', src2 );
	d_int2ndec( tdate.imonth, 2, '0', src2 + 2 );
	d_int2ndec( tdate.iday, 2, '0', src2 + 4 );

	return 0;
}
