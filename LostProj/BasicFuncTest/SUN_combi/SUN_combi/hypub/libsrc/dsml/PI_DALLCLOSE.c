/* PI_DALLCLOSE() : LIB dsml */
/************************************************************************
*	close all opened file						*
************************************************************************/

#include	<stdlib.h>
#include	<iswrap.h>

#include	"gps.h"
#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	int			ds_currfd;
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	close all opened file						|
+----------------------------------------------------------------------*/
int CBD1
#if	defined( __CB_STDC__ )
PI_DALLCLOSE( void )
#else
PI_DALLCLOSE()
#endif
{
	register	i;
	int		ret = 0;
	int		volno;

	for( i=0; i<DS_MAX_OPEN; i++ )
	{
		if( dsfi[i].filepath[0] == '\0' )
			continue;

		if( dsfi[i].isfd >= 0 )
			if( isclose( dsfi[i].isfd ) < 0 )
				ret = iserrno;

		for( volno = 0; volno < dsfi[i].volcnt; volno++ )
		{
			if( dsfi[i].vol[volno].lv != (struct DS_DIRVINFO *)0 )
				free( dsfi[i].vol[volno].lv );

		}

		if( dsfi[i].lm != (struct DS_DIRMINFO *)0 )
			free( dsfi[i].lm );

		if( dsfi[i].vol != (struct DS_VOLINFO *)0 )
			free( dsfi[i].vol );

		dsfi[i].filepath[0] = '\0';

	}

	ds_currfd = 0;

	if( ret )
	{
		l_dsmlsethyerrno( ret );
		return( -1 );
	}

	return 0;
}

/******* The end of PI_DALLCLOSE.c *************************************/
