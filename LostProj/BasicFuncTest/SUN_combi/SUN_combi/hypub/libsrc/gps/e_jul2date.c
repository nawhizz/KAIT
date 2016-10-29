/* e_jul2date() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert julian date into normal date				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	jul		julian date
		  char	src[]		year
		  char	dest[]		destination data
		  char	*mask		data mask form
	return	: 0/-1
*/

#include	<stdlib.h>
#include	<ctype.h>

#include	"e_date.h"
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_jul2date( int jul, char src[], char dest[], char *mask )
#else
e_jul2date( jul, src, dest, mask )
int	jul;
char	src[];
char	dest[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;
	register	i;
	int		y, m, d;
	int		maxday = 365;
	static	int	lastday[12] = { 	/* the last days of month */
			31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
		};

	if ( jul < 1 ||
	     src == (char *)0 || dest == (char *)0 || mask == (char *)0 )
	{
		return -1;
	}

	for ( i=0; mask[i]!=(char)0; i++ )
	{
		if ( toupper( mask[i] ) != 'Y' )
			break;
		dateinfo.year[i] = src[i];
	}
	dateinfo.year[++i] = '\0';
	dateinfo.iyear = atoi( dateinfo.year );

	if ( dateinfo.iyear >= 0 && dateinfo.iyear <= 50 )
		dateinfo.iyear += 2000;
	else if ( dateinfo.iyear < 100 && dateinfo.iyear > 50 )
		dateinfo.iyear += 1900;

	for ( i=0; i<12; i++ )
		dateinfo.lastday[i] = lastday[i];

	/* check leap year */
	if ( jul >= dateinfo.lastday[0] + dateinfo.lastday[1] &&
	    !( dateinfo.iyear % 4 ) )
	{
		if ( !( dateinfo.iyear % 100 ) )
		{
			if ( !( dateinfo.iyear % 400 ) )
			{
				dateinfo.lastday[1]++; /*last dayof Febrary+1 */
				maxday++;	   /* total days of year */
			}
		}
		else
		{
			dateinfo.lastday[1]++;	   /* last day of Febrary + 1 */
			maxday++;		   /* total days of year */
		}
	}

	/* over current year */
	if ( jul > maxday )
		return -1;

	for ( dateinfo.imonth = 1; dateinfo.imonth < 12; dateinfo.imonth++ )
	{
		if ( jul <= dateinfo.lastday[dateinfo.imonth - 1] )
			break;
		jul -= dateinfo.lastday[dateinfo.imonth - 1];
	}

	dateinfo.iday = jul;

	d_inttodec( dateinfo.imonth, 2, '0', dateinfo.month );
	d_inttodec( dateinfo.iday, 2, '0', dateinfo.day );

	y = 0;
	m = 0;
	d = 0;
	for ( i=0; mask[i] != (char)0 ; i++ )
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
