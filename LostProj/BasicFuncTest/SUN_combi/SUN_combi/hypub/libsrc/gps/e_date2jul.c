/* e_date2jul() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert normal date into julian date				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  char	*mask		data mask form
	return	: >0 (julian date)
		  -1
*/

#include	<string.h>
#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_date2jul( char src[], char *mask )
#else
e_date2jul( src, mask )
char	src[];
char	*mask;
#endif
{
	register	i;
	int		jul = 0;
	E_DATEINFO	dateinfo;

	if ( src == (char *)0 || mask == (char *)0 )
		return(-1);

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return(-1);

	if ( !strlen( dateinfo.day ) )
		return(-1);

	if ( l_lstdaychkget( &dateinfo ) < 0 )
		return(-1);

	for ( i = 0; i < dateinfo.imonth - 1; i++ )
		jul += dateinfo.lastday[i];

	jul += dateinfo.iday;

	return( jul );
}
