/* PI_START() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : start record's index by key                                   */
/*----------------------------------------------------------------------*/

#include	<string.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_START( int fd, char *keyname, char *record, int mode )
#else
PI_START(fd, keyname, record, mode)
int	fd;
char	*keyname;
char	*record;
int	mode;		/* iswrap.h: ISFIRST, ISGREAT, ISEQUAL, ... */
#endif
{
	register	i, j;
	char		key_sav[3];
	struct	keydesc	ckey;
	int		isfd;

	if( fd < 0 || fd >= PI_MAXOPEN ) {
		l_pisamsethyerrno( EPI_FDERR );
		return -1;
	}

	if( keyname == (char *)0 || record == (char *)0 )
	{
		l_pisamsethyerrno( EPI_INPUTERR );
		return -1;
	}

	if ( !pi_fileinfo[fd].filepath_sav[0] ) {
		l_pisamsethyerrno( EPI_NOPEN );
		return -1;
	}

	strncpy( key_sav, keyname, 2);
	key_sav[2] = 0;

	for (i=0; i<pi_fileinfo[fd].pi_nkeys; i++)
	{
		if (!pi_fileinfo[fd].pi_keyinfo[i].kname[0])
		{
			l_pisamsethyerrno( EPI_NOTUSEKEY );
			return -1;
		}
		if (!memcmp(pi_fileinfo[fd].pi_keyinfo[i].kname, key_sav, 2))
			break;
	}
	if (i>=pi_fileinfo[fd].pi_nkeys)
	{
		l_pisamsethyerrno( EPI_NOTUSEKEY );
		return -1;
	}

	ckey.k_flags = pi_fileinfo[fd].pi_keyinfo[i].imode;

	for (j=0; j<pi_fileinfo[fd].pi_keyinfo[i].pi_nkeyparts;j++)
	{
		ckey.k_part[j].kp_start = pi_fileinfo[fd].pi_keyinfo[i].pi_keypart[j].pi_kpstart;
		ckey.k_part[j].kp_leng = pi_fileinfo[fd].pi_keyinfo[i].pi_keypart[j].pi_kpleng;
		ckey.k_part[j].kp_type = pi_fileinfo[fd].pi_keyinfo[i].pi_keypart[j].pi_kptype;
/*
		ckey.k_part[j].kp_type = CHARTYPE;
*/
	}
	ckey.k_nparts = pi_fileinfo[fd].pi_keyinfo[i].pi_nkeyparts;

	isfd = pi_fileinfo[fd].isfd_sav;	/* get saved isfd */

	if ( isstart( isfd, &ckey, 0, record, mode ) < 0 )
	{
		pi_fileinfo[fd].keyname_sav[0] = 0;
		l_pisamsethyerrno( iserrno );
		return -1;
	}

	/* Save keyname */
	strcpy( pi_fileinfo[fd].keyname_sav, key_sav );

	return 0;
}
