/* OD_INT2NDEC() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 정수값을 ascii decimal string으로 변환 ( not null terminate ) */
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_INT2NDEC( unsigned int *num, int *nstr, char *leftchar, char *string )
#else
OD_INT2NDEC( num, nstr, leftchar, string )
unsigned int	*num;		/* 9(8) COMP. */
int		*nstr;		/* S9(8) COMP. */
char		*leftchar;	/* X(1) */
char		*string;	/* X(nstr) */
#endif
{
	d_int2ndec( *num, *nstr, *leftchar, string );
}
