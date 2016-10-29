/* f_getenv() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get environment value(directory) of group_id within		*/
/*		configuration file					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*cfgfpath	confiuration file full path
		  char	*envname	convironment varable
	output	: char	*envval	environment value
	return	: 0/-1

	ex>
		f_getenv( "/CASE1/hycase96/startup/demo.cfg",
			   "MYCNTL", envval );
*/

#include	<stdio.h>
#include	<string.h>
#include	<stdlib.h>
#include	<fcntl.h>
#include	<errno.h>

#include	"gps.h"


static	int	_getnameandval();
static	int	_putenvintotable();
static	char	*_getenvfromtable();
static	int	_getactenvval();
static	int	_freeenvtable();

struct	envs_form	{
	int	no;
	char	envname[128];
	char	envval[512];
	struct	envs_form	*next;
};

static	struct	envs_form	*startenvs= 0;
static	struct	envs_form	*currenvs = 0;

int CBD1
#if	defined( __CB_STDC__ )
f_getenv( char *cfgfpath, char *envname, char *envval )
#else
f_getenv( cfgfpath, envname, envval )
char	*cfgfpath;
char	*envname;
char	*envval;
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

#ifdef	DBG
/*DBG**/printf("cfgfpath=%s, envname=%s\n", cfgfpath, envname );
#endif

	if( cfgfpath == (char *)0 || envname == (char *)0 )
	{
		hyerrno = EGP_INPUTERR;
		return(-1);
	}

	if( ( cfgfd = fopen( cfgfpath, "r" ) ) == (FILE *)0 )
	{
		hyerrno = errno;
		return( -1 );
	}

	startenvs = currenvs = (struct envs_form *)0;

	for( ; !feof( cfgfd ); )
	{
		if( fgets( rbuf, sizeof rbuf - 1, cfgfd ) == (char *)0 )
			continue;

		envnamebuf[0] = envvalbuf[0] = 0;

		nitm = sscanf( rbuf, "%s%s%s%s", fld1, fld2, fld3, fld4 );

		if( nitm == 0 || nitm == EOF )		/* blank line */
			continue;

		if( fld1[0] == '#' ) continue;		/* comment line */

#ifdef	DBG
/*DBG*/printf("..LINE.. %s", fld1 );
/*DBG*/if( nitm>=2 ) printf( "%s ", fld2 );
/*DBG*/if( nitm>=3 ) printf( "%s ", fld3 );
/*DBG*/if( nitm>=4 ) printf( "%s ", fld4 );
#endif
		if( _getnameandval( nitm, fld1,fld2,fld3,fld4,envnamebuf,
								envvalbuf) < 0 )
		{
#ifdef	DBG
/*DBG*/printf( "\n   => _getnameandval() ERR\n" );
#endif
			if( !strcmp( envnamebuf, envname ) )
			{
				fclose( cfgfd );
				_freeenvtable();
				return(-1);
			}
			continue;		/* ignore error line */
		}
#ifdef	DBG
/*DBG*/printf("   => [%s][%s]\n", envnamebuf, envvalbuf );
#endif

		/* get actual envval from envtable, and getenv() */
		if( _getactenvval( envvalbuf, actualval ) < 0 )
		{
#ifdef	DBG
/*DBG*/printf("\n   => _getactenvval() ERR\n" );
#endif
			if( !strcmp( envnamebuf, envname ) )
			{
				hyerrno = EGP_ENVVALERR;
				fclose( cfgfd );
				_freeenvtable();
				return(-1);
			}
			continue;		/* ignore error line */
		}
#ifdef	DBG
/*DBG*/printf("   => %s\n", actualval );
#endif

		/* envname found */
		if( !strcmp( envnamebuf, envname ) ) {
			strcpy( envval, actualval );
			fclose( cfgfd );
			_freeenvtable();
			return(0);
		}

		/* put envname and actual envvalue into table */
		if( _putenvintotable( envnamebuf, actualval ) < 0 ) {
			hyerrno = EGP_NOMEM;
			fclose( cfgfd );
			_freeenvtable();
			return(-1);
		}
	}

	hyerrno = EGP_NOTEXIST;
	fclose( cfgfd );
	_freeenvtable();
	return( -1 );
}


/* return 0=ok, -1=err */
static	int
_getnameandval( nitm, fld1,fld2,fld3,fld4,envnamebuf,envvalbuf)
int	nitm;
char	*fld1,*fld2,*fld3,*fld4,*envnamebuf,*envvalbuf;
{
	char	*ptr;


	/* check fld1[] */
	ptr = strchr( fld1, '=' );		/* find '=' */

	/* case  aaa=??? ???? ??? ??? */
	if( ptr )
	{				/* aaa=??? */
		*ptr = 0;
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


static	int
_putenvintotable( envname, envval )
char	*envname, *envval;
{
	struct	envs_form	*envstmp;

	envstmp = (struct envs_form *)malloc( sizeof( *envstmp ) );
	if( envstmp == (struct envs_form *)0 )
		return(-1);

	strcpy( envstmp->envname, envname );
	strcpy( envstmp->envval, envval );
	envstmp->next = ( struct envs_form * )0;

	if( startenvs == (struct envs_form *)0 )
		startenvs = currenvs = envstmp;
	else
	{
		currenvs->next = envstmp;
		currenvs = envstmp;
	}
	return(0);
}

static	char	*
_getenvfromtable( envname )
char	*envname;
{
	struct	envs_form	*envsptr;

	if( startenvs == (struct envs_form *)0 )
		return( (char *)0 );

	for( envsptr=startenvs; envsptr; envsptr = envsptr->next )
		if( !strcmp( envname, envsptr->envname ) )
			return( envsptr->envval);

	return( (char *)0 );
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

	for( envvalptr = envval, actenvval[0] = 0; *envvalptr; )
	{
		ptr1 = strchr( envvalptr, '$' );	/* find '$' */

		/* no '$' any more */
		if( !ptr1 )
		{
			strcat( actenvval, envvalptr );
			return(0);
		}

		*ptr1 = '\0';
		strcat( actenvval, envvalptr );

		ptr1++;
		/* find opening '(' or '{' */
		if( *ptr1 != '{' && *ptr1 != '(' ) return(-1);

		/* find closing ')' or '}' */
		ptr2 = strchr( ptr1, *ptr1=='(' ? ')' : '}' );
		if( !ptr2 ) return(-1);		/* no closing char */

		ptr1++;			/* skip '(' */
		*ptr2 = 0;			/* replace ')' to 0 */
		ptr2++;

		/* first, find in table */
		if( ( tmpptr = _getenvfromtable( ptr1 ) ) != (char *)0 )
			strcat( actenvval, tmpptr );
		/* next getenv() */
		else if( ( tmpptr = (char *)getenv( ptr1 ) ) != (char *)0 )
			strcat( actenvval, tmpptr );
		else	return(-1);			/* undefined envname */

		envvalptr = ptr2;
	}
	return(0);
}

static	int
_freeenvtable( )
{
	struct	envs_form	*envsptr;
	struct	envs_form	*nextenvsptr;

	if( !startenvs ) return( 0 );

	for( envsptr=startenvs; envsptr; envsptr = nextenvsptr ) {
		nextenvsptr = envsptr->next;
		free( envsptr );
	}
	startenvs = currenvs = (struct envs_form *)0;
	return( 0 );
}
