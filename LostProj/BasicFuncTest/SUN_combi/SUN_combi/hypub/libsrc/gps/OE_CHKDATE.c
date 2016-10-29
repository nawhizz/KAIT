/* OE_CHKDATE() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check date in various form (1990∼2089 사용가능)		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_CHKDATE( char *datestr, int *form, char *RETSTS )
#else
OE_CHKDATE( datestr, form, RETSTS )
char	*datestr;		/* X(nn) */
int	*form;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( e_chkdate( datestr, *form ) < 0 )	RETSTS[0] = 'E';
	else					RETSTS[0] = ' ';
}
