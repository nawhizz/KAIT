/* OD_MKSTRADD() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 두개의 string을 붙임 						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_MKSTRADD( char *presrc, char *postsrc, char *dest, int *destlen, char *RETSTS )
#else
OD_MKSTRADD( presrc, postsrc, dest, destlen, RETSTS )
char	*presrc;		/* X(200) */
char	*postsrc;		/* X(200) */
char	*dest;			/* X(400) */
int	*destlen;		/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	if( d_mkstradd( presrc, postsrc, dest, destlen ) < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
