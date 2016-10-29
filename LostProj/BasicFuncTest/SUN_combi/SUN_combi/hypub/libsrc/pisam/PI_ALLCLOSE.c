/* PI_ALLCLOSE() : LIB pisam */
/*----------------------------------------------------------------------*/
/* FUNC : close all opened file						*/
/*	  if no file opened then return ok				*/
/*----------------------------------------------------------------------*/

#include	<iswrap.h>

#include	"gps.h"
#include	"pisam.h"
#include	"pisamdef.h"

int CBD1
#if	defined( __CB_STDC__ )
PI_ALLCLOSE( void )
#else
PI_ALLCLOSE()
#endif
{
	register	i, j;
	int		isfd;

	for (i=0;i< PI_MAXOPEN;i++) {
		if ( !pi_fileinfo[i].filepath_sav[0] )	/* if not exist */
			continue;

		isfd = pi_fileinfo[i].isfd_sav;

		if( isclose( isfd ) < 0 )  {
			l_pisamsethyerrno( iserrno );
			return -1;
		}
		pi_fileinfo[i].filepath_sav[0] = '\0';
		pi_fileinfo[i].infpath_sav[0] = '\0';
		pi_fileinfo[i].isfd_sav = -1;
		pi_fileinfo[i].keyname_sav[0] = '\0';
		for (j=0; j<PI_MAXKEY; j++)
			pi_fileinfo[i].pi_keyinfo[j].kname[0]='\0';
	}

	pi_currfd = 0;
	return 0;
}
