/* e_alldayget() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get all days from 01/01/01					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*src1		source data
		  char	*mask		data mask form
	return	: >0(all days)
		  -1
*/

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
							E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_alldayget( char *src, char *mask )
#else
e_alldayget( src, mask )
char	*src;
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;

	if ( l_datechkconv( src, mask, &dateinfo )  < 0 )
	{
		dateinfo.iyear = 0;
		dateinfo.imonth = 0;
		dateinfo.iday = 0;
	}
	else if ( l_lstdaychkget( &dateinfo ) < 0 )
	{
		dateinfo.iyear = 0;
		dateinfo.imonth = 0;
		dateinfo.iday = 0;
	}

	return( l_allday2get( &dateinfo ) );
}
