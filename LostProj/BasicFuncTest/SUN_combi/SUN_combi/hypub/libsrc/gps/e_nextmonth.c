/* e_nextmonth() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get next month						*/
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<ctype.h>

#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
							E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_nextmonth( char src[], char dest[], char *mask )
#else
e_nextmonth( src, dest, mask )
char	src[];
char	dest[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;
	register	i;
	int		y, m;

	if ( src == (char *)0 || dest == (char *)0 || mask == (char *)0 )
		return -1;

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return -1;

	if ( dateinfo.imonth == 12 )
	{
		dateinfo.iyear++;
		dateinfo.imonth = 1;
		if ( (int)strlen( dateinfo.year ) > 2 )
			d_inttodec( dateinfo.iyear, 4, '0', dateinfo.year );
		else
			d_inttodec( dateinfo.iyear%100, 2, '0', dateinfo.year );

		d_inttodec( dateinfo.imonth, 2, '0', dateinfo.month );
	}
	else
	{
		dateinfo.imonth++;
		d_inttodec( dateinfo.imonth, 2, '0', dateinfo.month );
	}

	y = 0;
	m = 0;
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
			default :
				dest[i] = mask[i];
				break;
		}
	}

	return 0;
}
