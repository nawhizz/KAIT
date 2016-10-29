/* e_datechk() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check valid date						*/
/*----------------------------------------------------------------------*/
/*
	input	: char	src[]		source data
		  char	*mask		data mask form
	return	: 0/-1
*/

#include	<string.h>
#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));

int CBD1
#if	defined( __CB_STDC__ )
e_datechk( char src[], char *mask )
#else
e_datechk( src, mask )
char	src[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;

	if ( src == (char *)0 || mask == (char *)0 )
		return(-1);

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return(-1);

	if ( strlen( dateinfo.day ) )
		if ( l_lstdaychkget( &dateinfo ) < 0 )
			return(-1);

	return(0);
}
