/* d_strsort() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : sorting string by key 					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	keyptr		key start offset
		  int	keyleng 	key length
		  int	noofrec 	no of rec sort
		  int	recsize 	size of rec
	inout	: char	*recbuff	recs array
	return	: 0/-1
*/

#include	<string.h>
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_strsort( int keyptr, int keyleng, int noofrec, int recsize, char *recbuff )
#else
d_strsort( keyptr, keyleng, noofrec, recsize, recbuff )
int	keyptr;
int	keyleng;
int	noofrec;
int	recsize;
char	*recbuff;
#endif
{
	register	i;
	register	j;
	register	k;
	int		ptri = 0;
	int		ptrj = 0;
	register char	temp;

	if( keyptr < 0 || keyleng <= 0 || keyptr + keyleng > recsize ||
	    noofrec <= 0 || recsize <= 0 || recbuff == (char *)0 )
		return -1;

	for( i=0; i<noofrec; i++ )
	{
		ptrj = ptri + recsize;
		for( j=i+1; j<noofrec; j++ )
		{
			if( strncmp( &recbuff[ptri+keyptr],
					&recbuff[ptrj+keyptr], keyleng ) > 0 )
			{
				for( k=0; k<recsize; k++ )
				{
					temp = recbuff[ptri+k];
					recbuff[ptri+k] = recbuff[ptrj+k];
					recbuff[ptrj+k] = temp;
				}
			}
			ptrj += recsize;
		}
		ptri += recsize;
	}
	return 0;
}
