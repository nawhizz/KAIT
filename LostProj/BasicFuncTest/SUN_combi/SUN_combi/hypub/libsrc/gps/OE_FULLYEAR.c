/* OE_FULLYEAR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert 2 length year to 4 length year			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_FULLYEAR( char *src, char *dest, int *YEAR, char *RETSTS )
#else
OE_FULLYEAR( src, dest, YEAR, RETSTS )
char	*src;			/* X(2) */
char	*dest;			/* X(5) */
int	*YEAR;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( ( *YEAR = e_fullyear( src, dest ) ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
