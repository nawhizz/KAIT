/* OD_FILLFORM() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : fill data into print buffer using form string 		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_FILLFORM( char *src, int *srclen, char *dest, char *filldata, int *fillen, char *maskchar, char *RETSTS )
#else
OD_FILLFORM( src, srclen, dest, filldata, fillen, maskchar, RETSTS )
char	*src;			/* X(srclen) */
int	*srclen;		/* S9(8) COMP. */
char	*dest;			/* X(fillen) */
char	*filldata;		/* X(fillen) */
int	*fillen;		/* S9(8) COMP. */
char	*maskchar;		/* X(1) */
char	*RETSTS;		/* X(1) */
#endif
{

	if( d_fillform( src,*srclen,dest,filldata,*fillen,*maskchar ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
