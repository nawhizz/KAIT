/* OE_GETYEAR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert 2 or 3 length string to 4 length string		*/
/*	  ( 1990бн2089 use )						*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GETYEAR( int *year, int *RETYEAR, char *RETSTS )
#else
OE_GETYEAR( year, RETYEAR, RETSTS )
int	*year;			/* S9(8) COMP. */
int	*RETYEAR;		/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( (*RETYEAR=e_getyear( *year )) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
