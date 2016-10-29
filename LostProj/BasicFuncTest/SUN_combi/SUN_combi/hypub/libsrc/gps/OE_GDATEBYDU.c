/* OE_GDATEBYDU() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : calculdate new date from given date and duration		*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OE_GDATEBYDU( int *form, char *srcdate, int *duration, int *flag, char *dstdate, int *YEAR, char *RETSTS )
#else
OE_GDATEBYDU( form, srcdate, duration, flag, dstdate, YEAR, RETSTS )
int	*form;			/* S9(8) COMP. */
char	*srcdate;		/* X(max.40) */
int	*duration;		/* S9(8) COMP. */
int	*flag;			/* S9(8) COMP. */
char	*dstdate;		/* X(max.40) */
int	*YEAR;			/* S9(8) COMP. */
char	*RETSTS;		/* X(1) */
#endif
{
	char	l_srcdate[41];
	char	l_dstdate[41];

	d_mkstr( srcdate, 40, l_srcdate );
	d_mkstr( dstdate, 40, l_dstdate );

	if( (*YEAR=e_gdatebydu(*form,l_srcdate,*duration,*flag,l_dstdate))
		   < 0 )
		RETSTS[0] = 'E';
	else	RETSTS[0] = ' ';
}
