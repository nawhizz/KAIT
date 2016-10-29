/* e_getweekday() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check date invalid and get weekday of srcdate			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	srcdate[]		date
		  char	*mask			date mask form
	return	: >=0/-1
		  0~6 (0 is sunday)
*/

#include	<sys/types.h>
#include	<time.h>

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
							E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));

int	 CBD1
#if	defined( __CB_STDC__ )
e_getweekday( char *srcdate, char *mask )
#else
e_getweekday( srcdate, mask )
char	*srcdate;
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;
	struct	tm	*tm;
	time_t	clock;
	int	i;

	/* weekday of system date */
	if( !srcdate ) {
		time( &clock );
		tm = localtime( &clock );
		return( tm->tm_wday );
	}

	if( !mask )	return( -1 );
	else if( l_datechkconv( srcdate, mask, &dateinfo ) < 0 )
		return( -1 );
	else if( l_lstdaychkget( &dateinfo ) < 0 )
		return( -1 );

	i = l_allday2get( &dateinfo );

	return( i % 7 );
}
