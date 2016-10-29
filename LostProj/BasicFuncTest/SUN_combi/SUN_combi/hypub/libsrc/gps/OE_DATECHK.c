/* OE_DATECHK() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : check valid date						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_DATECHK( char *src, char *mask, char *RETSTS )
#else
OE_DATECHK( src, mask, RETSTS )
char	*src;			/* X(max.40) */
char	*mask;			/* X(max.40) */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	if( e_datechk( src, l_mask ) < 0 )	RETSTS[0] = 'E';
	else					RETSTS[0] = ' ';
}
