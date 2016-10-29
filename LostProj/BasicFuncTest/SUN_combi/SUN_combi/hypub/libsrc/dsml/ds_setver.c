/* ds_setver() : LIB dsml internal function */
/************************************************************************
*	set version number to table from DSML file			*
*-----------------------------------------------------------------------*
*	input	: char	version			version	in DSML file	*
*	output	: char	verno			version number in table	*
************************************************************************/

#include	<stdlib.h>
#include	<ctype.h>

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	set version number to table from DSML file			|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
ds_setver( char *version, char *verno )
#else
ds_setver( version, verno )
char	*version;
char	*verno;
#endif
{
	register	i, j;

	for( i=0, j=0; i<4; i++ )
	{
		verno[i] = (char)0;

		for( ; j<31 && !isdigit( version[j] ); j++ ) ;

		if( j < 31 )
		{
			verno[i] = atoi( &version[j] );
			for( ; j<31 && isdigit( version[j] ); j++ ) ;
			if( j >= 31 || version[j] == (char)0 )
				j = 32;
		}
	}
}

/******* The end of ds_setver.c ****************************************/
