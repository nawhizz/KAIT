/* OD_INTTODEC() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : �������� ascii decimal string���� ��ȯ ( null terminate )	*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_INTTODEC( int *num, int *nstr, char *leftchar, char *string )
#else
OD_INTTODEC( num, nstr, leftchar, string )
int	*num;		/* S9(8) COMP. */
int	*nstr;		/* S9(8) COMP. */
char	*leftchar;	/* X(1) */
char	*string;	/* X(nstr+1) */
#endif
{
	d_inttodec( *num, *nstr, *leftchar, string );
}
