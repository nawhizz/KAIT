/* e_lstdayget() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get last day of each month					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source date
		  char	lastday[]	last day string
		  char	*mask		mask form
	return	: >0 (last day)
		  -1
*/

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask, E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_lstdayget( char src[], char lstday[], char *mask )
#else
e_lstdayget( src, lstday, mask )
char	src[];
char	lstday[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;

	if ( src == (char *)0 || lstday == (char *)0 || mask == (char *)0 )
		return -1;

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return -1;

	if ( l_lstdaychkget( &dateinfo ) < 0 )
		return -1;

	d_int2ndec( dateinfo.lastday[dateinfo.imonth - 1], 2, '0', lstday);
	return dateinfo.lastday[dateinfo.imonth - 1];
}
