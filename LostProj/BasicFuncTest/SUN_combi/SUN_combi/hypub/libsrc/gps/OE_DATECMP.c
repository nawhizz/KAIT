/* OE_DATECMP() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : compare two date						*/
/*	  ( if date is error then date is 01/01/01 )			*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_DATECMP( char *src1, char *src2, char *mask, int *DIFF )
#else
OE_DATECMP( src1, src2, mask, DIFF )
char	*src1;			/* X(max.40) */
char	*src2;			/* X(max.40) */
char	*mask;			/* X(max.40) */
int	*DIFF;			/* S9(8) COMP. */
#endif
{
	char	l_mask[41];

	d_mkstr( mask, 40, l_mask );

	*DIFF = e_datecmp( src1, src2, l_mask );
}
