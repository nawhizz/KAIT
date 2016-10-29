/* OE_ALLDAYGET() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get all days from 01/01/01					*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_ALLDAYGET( char *src, char *mask, int *RESDAYS, char *RETSTS )
#else
OE_ALLDAYGET( src, mask, RESDAYS, RETSTS )
char	*src;			/* X(max.40) */
char	*mask;			/* X(max.40) */
int	*RESDAYS;		/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( ( *RESDAYS = e_alldayget( src, l_mask ) ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
