/* e_dudate() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get duration							*/
/*----------------------------------------------------------------------*/
/*
	input	: int	dur		duration
		  char	ssrc[]		source date
		  char	dest[]		destination date
		  char	*mask		mask form
	return	: 0/-1
*/

#include	<string.h>
#include	"e_date.h"
#include	"gps.h"

extern	int	l_datechkconv CBD2(( char src[], char *mask,
						E_DATEINFO *dateinfo ));
extern	int	l_lstdaychkget CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));
extern	int	l_allday2get CBD2(( E_DATEINFO *dateinfo ));
extern	void	l_allday2date CBD2(( int allday, char *dest, char *mask ));

int CBD1
#if	defined( __CB_STDC__ )
e_dudate( int dur, char src[], char dest[], char *mask )
#else
e_dudate( dur, src, dest, mask )
int	dur;
char	src[];
char	dest[];
char	*mask;
#endif
{
	E_DATEINFO	dateinfo;
	char	buff[20];
	int	allday;

	if ( src == (char *)0 || dest == (char *)0 || mask == (char *)0 )
		return -1;

	if ( l_datechkconv( src, mask, &dateinfo ) < 0 )
		return -1;

	if ( l_lstdaychkget( &dateinfo ) < 0 )
		return -1;

	allday = l_allday2get( &dateinfo );
	allday += dur;

	l_allday2date( allday, buff, mask );

	memcpy( dest, buff, strlen(mask) );
	return 0;
}
