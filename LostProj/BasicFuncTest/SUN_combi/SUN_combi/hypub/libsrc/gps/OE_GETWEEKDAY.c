/* OE_GETWEEKDAY() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check date invalid and get weekday of srcdate			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GETWEEKDAY( char *srcdate, char *mask, char *retsts )
#else
OE_GETWEEKDAY( srcdate, mask, retsts )
char	*srcdate;		/* X(max.40) */
char	*mask;			/* X(max.40) */
char	*retsts;		/* X(1) */
#endif
{
	int	ret;
	char	l_mask[41];

	if( srcdate[0] == ' ' )
		ret = e_getweekday( (char *)0, mask );
	else {
		d_mkstr( mask, 40, l_mask );
		ret = e_getweekday( srcdate, mask );
	}

	if( ret < 0 )
		retsts[0] = 'E';
	else
		retsts[0] = (char)ret + '0';
}
