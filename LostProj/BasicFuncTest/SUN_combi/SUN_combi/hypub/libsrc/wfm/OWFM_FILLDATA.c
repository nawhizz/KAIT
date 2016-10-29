/* OWFM_FILLDATA () : LIB wfm */
/*----------------------------------------------------------------------*
|									|
|	void OWFM_FILLDATA( char *retcode, int *ffd, char *segid	|
|		char *data, int *maxdatalen, char *mdata, int *mdatalen)|
|									|
|	Fill Data into fields of specified segment. (merge)		|
|									|
|	input	ffd		- form file descriptor			|
|		segid		- segmentname in formfile		|
|		data		- data to fill				|
|		maxdatalen	- maxlength of merged data buffer	|
|	output	mdata		- merged data buffer			|
|		mdatalen	- length of merged data			|
|		retcode		- return code				|
|									|
*----------------------------------------------------------------------*/

#include	<string.h>

#include	"wfm.h"
#include	"wfm_fun.h"
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
OWFM_FILLDATA( char *retcode, int *ffd, char *segid, char *data,
		int *maxdatalen, char *mdata, int *mdatalen )
#else
OWFM_FILLDATA( retcode, ffd, segid, data, maxdatalen, mdata, mdatalen )
char	*retcode;		/* X(5) */
int	*ffd;			/* S9(8) COMP */
char	*segid;			/* X(64) */
char	*data;			/* X(len) */
int	*maxdatalen;		/* S9(8) COMP */
char	*mdata;			/* X(len) */
int	*mdatalen;		/* S9(8) COMP */
#endif
{
	int	l_ffd;
	char	l_segid[64];
	char	*l_data[1024];
	int	l_maxdatalen;
	char	*l_mdata;
	int	l_copylen;

	memcpy( &l_ffd, ffd, sizeof l_ffd );
	d_mkstr( segid, 64-1, l_segid );
	memcpy( &l_maxdatalen, maxdatalen, sizeof l_maxdatalen );

	if( wfm_str2strarr( data, l_data ) < 0 )
	{
		wfm_errset( retcode );
		return;
	}

	if( ( l_mdata = WFmFillData( l_ffd, l_segid, l_data ) ) == (char *)0 )
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
