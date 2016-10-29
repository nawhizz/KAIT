/* OD_FILLDATA() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into print buffer using form string 		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_FILLDATA( char *src, int *srclen, char *dest, char *filldata, char *maskchar, char *RETSTS )
#else
OD_FILLDATA( src, srclen, dest, filldata, maskchar, RETSTS )
char	*src;			/* X(srclen) */
int	*srclen;		/* S9(8) COMP. */
char	*dest;			/* X(fillen) */
char	*filldata;		/* X(fillen) */
char	*maskchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{

	if( d_filldata(src,*srclen,dest,filldata,*maskchar) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
