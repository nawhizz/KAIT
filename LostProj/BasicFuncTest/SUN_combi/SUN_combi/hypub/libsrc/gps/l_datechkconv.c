/* l_datechkconv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check and convert date					*/
/*----------------------------------------------------------------------*/
/* internal function */

#include	<string.h>
#include	<stdlib.h>
#include	<ctype.h>

#include	"e_date.h"

int
#if	defined( __CB_STDC__ )
l_datechkconv( char src[], char *mask, E_DATEINFO *dateinfo )
#else
l_datechkconv( src, mask, dateinfo )
char		src[];
char		*mask;
E_DATEINFO	*dateinfo;
#endif
{
	char		*sp = "      ";
	register	i;
	int		y = 0, m = 0, d = 0;

	for( i=0; i<(int)strlen(mask); i++ )
	{
		switch( toupper( mask[i] ) )
		{
		case	'Y'	:
			dateinfo->year[y++] = src[i];
			y = ( y > 4 ? 4 : y );
			break;
		case	'M'	:
			dateinfo->month[m++] = src[i];
			m = ( m > 2 ? 2 : m );
			break;
		case	'D'	:
			dateinfo->day[d++] = src[i];
			d = ( d > 2 ? 2 : d );
			break;
		default :
			break;
		}
	}

	dateinfo->year[y] = '\0';
	dateinfo->month[m] = '\0';
	dateinfo->day[d] = '\0';

	dateinfo->iyear = atoi( dateinfo->year );
	dateinfo->imonth = atoi( dateinfo->month );
	dateinfo->iday = atoi( dateinfo->day );

	if ( dateinfo->iyear < 0 ||
	     !strlen( dateinfo->year ) ||
	     !strncmp( dateinfo->year, sp, strlen( dateinfo->year ) ) )
		return -1;

	if ( dateinfo->imonth < 1 || dateinfo->imonth > 12 )
		return -1;

	/* if day mask exist and day < 1 */
	if ( dateinfo->iday < 1 && strlen( dateinfo->day ) )
		return -1;

	/* Convert year */
	if ( dateinfo->iyear <= 50 )
		dateinfo->iyear += 2000;
	else if ( dateinfo->iyear < 100 )
		dateinfo->iyear += 1900;

	return 0;
}
