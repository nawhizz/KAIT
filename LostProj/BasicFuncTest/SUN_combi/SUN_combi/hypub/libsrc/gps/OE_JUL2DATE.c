/* OE_JUL2DATE() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert julian date into normal date				*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_JUL2DATE( int *jul, char *src, char *dest, char *mask, char *RETSTS )
#else
OE_JUL2DATE( jul, src, dest, mask, RETSTS )
int	*jul;			/* S9(8) COMP. */
char	*src;			/* X(max.40) */
char	*dest;			/* X(40) */
char	*mask;			/* X(max.40) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( e_jul2date( *jul, src, dest, l_mask ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
