/* OD_STRNCAT() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : 두개의 string을 붙임 						*/
/*----------------------------------------------------------------------*/
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OD_STRNCAT( char *src, char *add, int *addsize, char *dest )
#else
OD_STRNCAT( src, add, addsize, dest )
char	*src;			/* X(???) : null termiated string */
char	*add;			/* X(addsize) */
int	*addsize;		/* S9(8) COMP. */
char	*dest;			/* X(???) */
#endif
{
	char	l_add[132];
	int	l_addsize;

	memcpy( (char *)&l_addsize, addsize, sizeof( int ) );
	d_mkstr( add, l_addsize, l_add );
	strcpy( dest, src );
	strcat( dest, l_add );
}
