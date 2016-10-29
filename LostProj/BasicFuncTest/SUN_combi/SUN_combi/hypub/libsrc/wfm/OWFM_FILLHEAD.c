/* OWFM_FILLHEAD () : LIB wfm */
/*----------------------------------------------------------------------*
|									|
|	void OWFM_FILLHEAD( char *retcode, int *ffd,  char *data	|
|			int *maxdatalen, char *mdata, int *mdatalen )	|
|									|
|	Fill Data into fields of head segment. (merge)			|
|									|
|	input	ffd		- form file descriptor			|
|		data		- data to fill				|
|		maxdatalen	- maxlength of merged data buffer	|
|	output	mdata		- merged data buffer			|
|		mdatalen	- length of merged data buffer		|
|		retcode		- return code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"gps.h"
#include	"wfm.h"
#include	"wfm_fun.h"

void CBD1
#if	defined( __CB_STDC__ )
OWFM_FILLHEAD( char *retcode, int *ffd, char *data, int *maxdatalen,
						 char *mdata, int *mdatalen )
#else
OWFM_FILLHEAD( retcode, ffd, data, maxdatalen, mdata, mdatalen )
char	*retcode;		/* X(5) */
int	*ffd;			/* S9(8) COMP */
char	*data;			/* X(len) */
int	*maxdatalen;		/* S9(8) COMP */
char	*mdata;			/* X(len) */
int	*mdatalen;		/* S9(8) COMP */
#endif
{
	int	l_ffd;
	char	*l_data[1024];
	int	l_maxdatalen;
	char	*l_mdata;
	int	l_copylen;

	memcpy( &l_ffd, ffd, sizeof l_ffd );
	memcpy( &l_maxdatalen, maxdatalen, sizeof l_maxdatalen );

	if( wfm_str2strarr( data, l_data ) < 0 )
	{
		wfm_errset( retcode );
		return;
	}

	if( ( l_mdata = WFmFillHead( l_ffd, l_data ) ) == (char *)0 )
	{
		wfm_errset( retcode );
		return;
	}

	if((int)strlen(l_mdata) < l_maxdatalen)	l_copylen = strlen(l_mdata);
	else					l_copylen = l_maxdatalen;

	memcpy( mdata, l_mdata, l_copylen );
	memset( retcode, ' ', 5 );
	*mdatalen = l_copylen;
}
