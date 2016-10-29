/* ds_nextfd() : LIB dsml internal function */
/************************************************************************
*	get next valid fd						*
************************************************************************/

#include	"dsml.h"
#include	"dsmldef.h"

/*----------------------------------------------------------------------+
|	external variables						|
+----------------------------------------------------------------------*/
extern	int			ds_currfd;
extern	struct	DS_FILEINFO	dsfi[];

/*----------------------------------------------------------------------+
|	get next valid fd						|
+----------------------------------------------------------------------*/
void
#if	defined( __CB_STDC__ )
ds_nextfd( void )
#else
ds_nextfd()
#endif
{
	register	i;

	/*---------------------------------------------------------------
	** find next available fd
	**-------------------------------------------------------------*/
	if( ( i = ds_currfd + 1 ) >= DS_MAX_OPEN )
		i = 0;

	for ( ; i != ds_currfd; )
	{
		if ( !dsfi[i].filepath[0] )
		{
			/* if available fd (not opened) found */
			ds_currfd = i;
			return;
		}

		if( ++i >= DS_MAX_OPEN )
			i = 0;
	}

	/* if no more available then set nomore */
	ds_currfd = -1;

	return;
}

/******* The end of ds_nextfd.c ****************************************/
