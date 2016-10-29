/* OE_JUL2GRE() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert julian to gregorian date (1990бн2089 use)		*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_JUL2GRE( int *jul, int *form, char *srcdate, char *dstdate, char *RETSTS )
#else
OE_JUL2GRE( jul, form, srcdate, dstdate, RETSTS )
int	*jul;			/* S9(8) COMP. */
int	*form;			/* S9(8) COMP. */
char	*srcdate;		/* X(nn) */
char	*dstdate;		/* X(nn) */
char	*RETSTS;		/* X(1) */
#endif
{
	if( e_jul2gre( *jul, *form, srcdate, dstdate ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
