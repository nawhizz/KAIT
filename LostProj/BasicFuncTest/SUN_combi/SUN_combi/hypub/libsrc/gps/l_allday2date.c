/* l_allday2date() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : adjust integer date to masked string date			*/
/*----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------*
| History								       |
|------------------------------------------------------------------------------|
| 2000.10.11 : ksh. 2000.10.2 + 90 = 2000.12.31 ÀÎµ¥ 2001.1.0 ·Î ³ª¿È	       |
*-----------------------------------------------------------------------------*/

#include	<string.h>
#include	<ctype.h>

#include	"e_date.h"
#include	"gps.h"

void
#if	defined( __CB_STDC__ )
l_allday2date( int allday, char *dest, char *mask )
#else
l_allday2date( allday, dest, mask )
int	allday;
char	*dest;
char	*mask;
#endif
{
	register	i;
	char		year[5], month[3], day[3];
	double		d_preyear;
	int		preyear, preallday, iyear, imonth, iday;
	int		y, m, d;
	static	int	lastday[12] = { 	/* the last days of month */
			31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
		};

/*2000.10.11 change ------------------------------------------------------------
	d_preyear = (double)400/(double)146097*(double)allday;
------------------------------------------------------------------------------*/
	d_preyear = (double)400/(double)146097*(double)(allday - 1);
/*2000.10.11 end -------------------------------------------------------------*/
	preyear = (int)d_preyear;
	preallday = preyear * 365 + preyear / 4 - preyear / 100 + preyear / 400;
	allday -= preallday;
	iyear = preyear + 1;

	if ( !( iyear % 4 ) ) {
		if ( !( iyear % 100 ) ) {
			if ( !( iyear % 400 ) )
				lastday[1] = 29;
			else
				lastday[1] = 28;
		}
		else		/* last day of Febrary + 1 */
			lastday[1] = 29;
	}
	else
		lastday[1] = 28;

	for ( imonth = 0; imonth < 12; imonth++ ) {
		if ( allday <= lastday[imonth] )
			break;
		allday -= lastday[imonth];
	}
	imonth++;
	iday = allday;


	for ( i = 0, y = 0; i < (int)strlen(mask); i++ ) {
		if ( mask[i] == 'Y' || mask[i] == 'y' )
			y++;
	}

	if ( y == 2 )
		iyear %= 100;

	d_inttodec( iyear, y, '0', year );
	d_inttodec( imonth, 2, '0', month );
	d_inttodec( iday, 2, '0', day );

	y = m = d = 0;
	for ( i = 0; i < (int)strlen(mask); i++ ) {
		switch ( toupper( mask[i] ) ) {
			case	'Y'	:
				dest[i] = year[y++];
				y = y > 4 ? 4 : y;
				break;
			case	'M'	:
				dest[i] = month[m++];
				m = m > 2 ? 2 : m;
				break;
			case	'D'	:
				dest[i] = day[d++];
				d = d > 2 ? 2 : d;
				break;
			default :
				dest[i] = mask[i];
				break;
		}
	}
	dest[i] = 0;
}
