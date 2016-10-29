/* e_nextday() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get next day							*/
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<ctype.h>

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_nextday( char src[], char dest[], char *mask )
#else
e_nextday( src, dest, mask )
char	src[];
char	dest[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;
	register	i;
	int		y, m, d;

	if ( src == (char *)0 || dest == (char *)0 || mask == (char *)0 )
		return -1;

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return -1;

	if ( strlen( dateinfo.day ) )
	{
		if ( l_lstdaychkget( &dateinfo ) < 0 )
			return -1;
	}
	else
		return -1;

	if ( dateinfo.imonth == 12 && dateinfo.iday == 31 )
	{
		dateinfo.iyear++;
		dateinfo.imonth = 1;
		dateinfo.iday = 1;
	}
	else if ( dateinfo.iday == dateinfo.lastday[dateinfo.imonth - 1] )
	{
		dateinfo.imonth++;
		dateinfo.iday = 1;
	}
	else
		dateinfo.iday++;

	if ( (int)strlen( dateinfo.year ) > 2 )
		d_inttodec( dateinfo.iyear, 4, '0', dateinfo.year );
	else
		d_inttodec( dateinfo.iyear, 2, '0', dateinfo.year );

	d_inttodec( dateinfo.imonth, 2, '0', dateinfo.month );
	d_inttodec( dateinfo.iday, 2, '0', dateinfo.day );

	y = 0;
	m = 0;
	d = 0;
	for ( i=0; mask[i]!=(char)0; i++ )
	{
		switch ( toupper( mask[i] ) )
		{
			case	'Y'	:
				dest[i] = dateinfo.year[y++];
				break;
			case	'M'	:
				dest[i] = dateinfo.month[m++];
				break;
			case	'D'	:
				dest[i] = dateinfo.day[d++];
				break;
			default :
				dest[i] = mask[i];
				break;
		}
	}
	return 0;
}
