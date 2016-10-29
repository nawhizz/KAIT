/* OD_ISSPACENSTR() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : test if len's string is all space character                   */
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_ISSPACENSTR( char *string, int *len, char *RETSTS )
#else
OD_ISSPACENSTR( string, len, RETSTS )
char	*string;		/* X(len) */
int	*len ;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_isspacenstr( string, *len ) == 0 )	RETSTS[0] = 'E';
	else						RETSTS[0] = ' ';
}
