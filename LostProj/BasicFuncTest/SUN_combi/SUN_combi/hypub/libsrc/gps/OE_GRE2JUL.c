/* OE_GRE2JUL() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert gregorian date to julian (1990бн2089 use)		*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GRE2JUL( char *datestr, int *form, int *DATE, char *RETSTS )
#else
OE_GRE2JUL( datestr, form, DATE, RETSTS )
char	*datestr;		/* X(nn) */
int	*form;			/* S9(8) COMP. */
int	*DATE;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( (*DATE=e_gre2jul( datestr, *form )) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
