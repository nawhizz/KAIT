/* pi_savefile() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : save file information						*/
/*----------------------------------------------------------------------*/
/* PISAM internal function */

#include	<stdio.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int
#if	defined( __CB_STDC__ )
pi_savefile( char *filepath, int isfd, char *infpath )
#else
pi_savefile( filepath, isfd, infpath )
char	*filepath;
int	isfd;
char	*infpath;
#endif
{
	int	retfd;
	int	i, j;
	int	nkeys=0, nkeyparts=0;
	FILE	*inffd;
	char	input[80];

	retfd = pi_currfd;

	/* save file info into table */
	strcpy( pi_fileinfo[pi_currfd].filepath_sav, filepath );
	pi_fileinfo[pi_currfd].isfd_sav = isfd;
	strcpy( pi_fileinfo[pi_currfd].infpath_sav, infpath );

	/* Open key info. file */
	if ((inffd = fopen(infpath, "rb")) == (FILE *)0 ) {
		l_pisamsethyerrno( EPI_NOINFFILE );
		return -1;
	}

	fscanf(inffd, "%s", input);	/* recsize. 1st line of inf file */
	nkeys=0;
	for (i=0; i<PI_MAXKEY; i++)
	{
		fscanf(inffd, "%s", input);
		if ( feof(inffd) )
			break;
		strcpy(pi_fileinfo[pi_currfd].pi_keyinfo[i].kname, input );
		nkeys++;
		fscanf(inffd, "%s", input);
		if (!memcmp(input, "K:", 2)) {
			pi_setkeymode(&input[2],
				&pi_fileinfo[pi_currfd].pi_keyinfo[i].imode);
			if (!pi_fileinfo[pi_currfd].pi_keyinfo[i].imode)
			    pi_fileinfo[pi_currfd].pi_keyinfo[i].imode=ISNODUPS;
		}
		else {
			pi_fileinfo[pi_currfd].pi_keyinfo[i].imode=ISNODUPS;
			fseek( inffd, -(int)strlen(input), SEEK_CUR );
		}
		nkeyparts=0;
		for (j=0; ; j++) {
			fscanf(inffd, "%s", input);
			if ( !strcmp(input,"end") )
			{
				break;
			}
			if( j > PI_MAXKEYPART )
			{
				l_pisamsethyerrno( EPI_INFKEYPART );
				return -1;
			}
			nkeyparts++;
			pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kpstart = 0;
			pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kpleng = 0;
			pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kptype = 0;
			sscanf( input, "%hd,%hd,%hd",
				&pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kpstart,
				&pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kpleng,
				&pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_keypart[j].pi_kptype );
		}
		pi_fileinfo[pi_currfd].pi_keyinfo[i].pi_nkeyparts = nkeyparts;
	}
	pi_fileinfo[pi_currfd].pi_nkeys = nkeys;
	fclose(inffd);

	/* find next available fd */
	if( ( i = retfd + 1 ) >= PI_MAXOPEN )
		i = 0;
	for ( ; i != retfd; ) {
		if ( !pi_fileinfo[i].filepath_sav[0] ) {
			/* if available fd (not opened) found */
			pi_currfd = i;
			return( retfd );
		}
		if( ++i >= PI_MAXOPEN )
			i = 0;
	}

	/* if no more available then set nomore */
	pi_currfd = -1;
	return( retfd );
}
