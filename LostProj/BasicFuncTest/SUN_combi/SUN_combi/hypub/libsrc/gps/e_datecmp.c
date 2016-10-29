/* e_datecmp() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : compare two date						*/
/*	  ( if date is error then date is 01/01/01 )			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src1[]		first date string
		  char	src2[]		second date string
		  char	*mask		mask form
	return	: src1-src2
*/

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_datecmp( char src1[], char src2[], char *mask )
#else
e_datecmp( src1, src2, mask )
char	src1[];
char	src2[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo1;
	E_DATEINFO	dateinfo2;

	if ( l_datechkconv( src1, mask, &dateinfo1 )  < 0 )
	{
		dateinfo1.iyear = 0;
		dateinfo1.imonth = 0;
		dateinfo1.iday = 0;
	}
	else if ( l_lstdaychkget( &dateinfo1 ) < 0 )
	{
		dateinfo1.iyear = 0;
		dateinfo1.imonth = 0;
		dateinfo1.iday = 0;
	}

	if ( l_datechkconv( src2, mask, &dateinfo2 )  < 0 )
	{
		dateinfo2.iyear = 0;
		dateinfo2.imonth = 0;
		dateinfo2.iday = 0;
	}
	else if ( l_lstdaychkget( &dateinfo2 ) < 0 )
	{
		dateinfo2.iyear = 0;
		dateinfo2.imonth = 0;
		dateinfo2.iday = 0;
	}

	return( l_allday2get( &dateinfo1 ) - l_allday2get( &dateinfo2 ) );
}
