/* f_setenv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : set environments from CFG file				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*cfgpath	: environment configuration file path
	return	: 0/-1
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

#include "gps.h"


static	int _getactenvval();
static	int _getnameandval();

int CBD1
#if	defined( __CB_STDC__ )
f_setenv( char *cfgfpath )
#else
f_setenv( cfgfpath )
char	*cfgfpath;
#endif
{
	char		fld1[512];
	char		fld2[512];
	char		fld3[512];
	char		fld4[512];
	char		rbuf[512];
	char		envnamebuf[128];
	char		envvalbuf[512];
	char		actualval[512];
	register	nitm;		/* no of items in a line */
	FILE		*cfgfd;

	if( cfgfpath == (char *)0 )
	{
		hyerrno = EGP_INPUTERR;
		return(-1);
	}

	if( ( cfgfd = fopen( cfgfpath, "r" ) ) == (FILE *)0 )
	{
		hyerrno = errno;
		return( -1 );
	}

	for( ; !feof( cfgfd ); )
	{
		if( fgets( rbuf, sizeof rbuf, cfgfd ) == (char *)0 )
			continue;

		envnamebuf[0] = envvalbuf[0] = 0;

		nitm = sscanf( rbuf, "%s%s%s%s", fld1, fld2, fld3, fld4 );

		if( nitm == 0 || nitm == EOF ) 		/* blank line */
			continue;

		if( fld1[0] == '#' ) continue;		/* comment line */

		if( _getnameandval( nitm, fld1, fld2, fld3, fld4, envnamebuf,
							envvalbuf ) < 0 )
		{
			fclose( cfgfd );
			hyerrno = EGP_ENVVALERR;
			return(-1);
		}

		/* get actual envval from envtable, and getenv() */
		if( _getactenvval( envvalbuf, actualval ) < 0 )
		{
			fclose( cfgfd );
			hyerrno = EGP_ENVVALERR;
			return(-1);
		}
		e_setenv( envnamebuf, actualval );
	}

	fclose( cfgfd );
	return( 0 );
}


/* return 0=ok, -1=err */
static	int
_getnameandval( nitm, fld1, fld2, fld3, fld4, envnamebuf, envvalbuf)
int	nitm;
char	*fld1, *fld2, *fld3, *fld4, *envnamebuf, *envvalbuf;
{
	char	*ptr;

	/* check fld1[] */
	ptr = strchr( fld1, '=' );		/* find '=' */

	/* case  aaa=??? ???? ??? ??? */
	if( ptr )
	{					/* aaa=??? */
		*ptr = '\0';	
		strcpy( envnamebuf, fld1 );
		ptr++;

		/* case aaa=bbb ??? ??? ??? ??? */
		if( *ptr )
		{
			if( nitm > 1 && fld2[0] != '#' )
			{
				hyerrno = EGP_ENVVALERR;
				return(-1);
			}
			strcpy( envvalbuf, ptr );
			return(0);
		}

		/* case aaa= ??? ??? ??? */
		if( nitm < 2 || fld2[0] == '#' )
		{
			hyerrno = EGP_ENVVALEMPTY;
			return(-1);
		}

		/* case aaa= bbb ??? */
		if( nitm > 2 && fld3[0] != '#' )
		{
			hyerrno = EGP_ENVVALERR;
			return(-1);
		}

		/* case aaa= bbb */
		strcpy( envvalbuf, fld2 );
		return(0);
	}

	/* case  aaa ???? ??? ??? */

	strcpy( envnamebuf, fld1 );

	if( nitm < 2 || fld2[0] != '=' )
	{
		hyerrno = EGP_ENVVALEMPTY;
		return(-1);
	}

	/* case  aaa =???? ??? ??? */
	if( fld2[1] )
	{
		/* case aaaa =xxx ??? ??? */
		if( nitm > 2 && fld3[0] != '#' )
		{
			hyerrno = EGP_ENVVALERR;
			return(-1);
		}
		strcpy( envvalbuf, &fld2[1] );
		return(0);
	}

	/* case  aaa = ??? ??? */
	if( nitm < 3 || fld3[0] == '#' ) 
	{
		hyerrno = EGP_ENVVALEMPTY;
		return(-1);
	}

	/* case aaa = xxx ??? */
	if( nitm > 3 && fld4[0] != '#' )
	{
		hyerrno = EGP_ENVVALERR;
		return(-1);
	}

	/* case aaa = bbb */
	strcpy( envvalbuf, fld3 );
	return(0);
}

/* envval = $(AAA)...... => actualval = xxxxx........ */
/*        = ${AAA}...... => actualval = xxxxx........ */
/* $(AAA) : find first in envs table, if no exist then getenv() */
/* return 0, -1 */
static	int
_getactenvval( envval, actenvval )
char	*envval, *actenvval;
{

	char	*envvalptr;
	char	*ptr1, *ptr2;
	char	*tmpptr;

/*
	envval	      ptr1
	[.............$...............]
		envvalptr

	[.........]
	actenvval[]
*/

	for( envvalptr = envval, actenvval[0] = 0; ; )
	{
		ptr1 = strchr( envvalptr, '$' );	/* find '$' */

		/* no '$' any more */
		if( ptr1 == (char *)0 )
		{
			strcat( actenvval, envvalptr );
			return(0);
		}

		*ptr1 = '\0';
		strcat( actenvval, envvalptr );

		ptr1++;
		/* find opening '(' or '{' */
		if( *ptr1 != '{' && *ptr1 != '(' )
			return(-1);

		/* find closing ')' or '}' */
		ptr2 = strchr( ptr1, ( *ptr1=='(' ? ')' : '}' ) );	
		if( ptr2 == (char *)0 )
			return(-1);		/* no closing char */

		ptr1++; 			/* skip '(' */
		*ptr2 = 0;			/* replace ')' to 0  */
		ptr2++;

		/* getenv() */
		if( ( tmpptr = (char *)getenv( ptr1 ) ) == (char *)0 )
			return(-1);			/* undefined envname */

		strcat( actenvval, tmpptr );
		envvalptr = ptr2;
	}
}
