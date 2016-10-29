/* OD_ADJNDECIMAL() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : adjust numeric string with format (with len, left fill char)	*/
/*	  Not Null Terminated						*/
/*----------------------------------------------------------------------*/

#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_ADJNDECIMAL( char *str, char *leftchar, int *len, char *RETSTS )
#else
OD_ADJNDECIMAL( str, leftchar, len, RETSTS )
char	*str;			/* X(len) */
char	*leftchar;		/* X(1) */
int	*len;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{

	if( d_adjndecimal( str, *leftchar, *len ) < 0 ) RETSTS[0] = 'E';
	else						RETSTS[0] = ' ';
}
