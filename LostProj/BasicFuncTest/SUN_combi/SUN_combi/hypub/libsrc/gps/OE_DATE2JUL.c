/* OE_DATE2JUL() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert normal date into julian date				*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_DATE2JUL( char *src, char *mask, int *RESULT, char *RETSTS )
#else
OE_DATE2JUL( src, mask, RESULT, RETSTS )
char	*src;			/* X(max.40) */
char	*mask;			/* X(max.40) */
int	*RESULT;		/* S9(8) COMP */
char	*RETSTS;		/* X(1) */
#endif
{
	int	res;
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( ( res=e_date2jul( src, l_mask ) ) < 0 )
		RETSTS[0] = 'E';
	else
	{
		RETSTS[0] = ' ';
		*RESULT = res;
	}
}
