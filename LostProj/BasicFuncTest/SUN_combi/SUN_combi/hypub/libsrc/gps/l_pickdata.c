/* l_pickdata() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : pick datano'th item from linebuffer by use of delimeters      */
/*----------------------------------------------------------------------*/
/*
	input	: char	*linebuffer
		  int	linelen
		  char	*delimeters	null terminated
	output	: char	*databuffer
		  int	*datalen
		  int	datano		>0
	return	: 0/-1
*/
#include	<ctype.h>

#include	"gps.h"

static	int
#if	defined( __CB_STDC__ )
l_delimeter( char data, char *delimeters )
#else
l_delimeter( data, delimeters )
char	data;
char	*delimeters;
#endif
{
	register	k;

	for( k=0; delimeters[k]; k++ )
		if( data != delimeters[k] )
			return( 0 );

	return( 1 );
}

int
#if	defined( __CB_STDC__ )
l_pickdata( char *linebuffer, int linelen, char *databuffer, int *datalen, int datano, char *delimeters )
#else
l_pickdata( linebuffer, linelen, databuffer, datalen, datano, delimeters )
char	*linebuffer;
int	linelen;
char	*databuffer;
int	*datalen;
int	datano;
char	*delimeters;
#endif
{
	int	no=0;
	int	lineptr=0;
	int	startptr=0;	/* element start ptr including space.etc */
	int	endptr=0;	/* element end ptr including space.etc */
				/* :   aaaaaa	:
				    ............ */

	if( linebuffer == (char *)0 || linelen <= 0 ||
	    databuffer == (char *)0 || datalen == (int *)0 ||
	    delimeters == (char *)0 )
	{
		return( -1 );
	}

	*datalen = 0;

	/* find startptr */
	for( no=0; no<datano; )
	{
		if( lineptr >= linelen )
			return( -1 );
		for( ; lineptr<linelen; )
		{
			if( l_delimeter( linebuffer[lineptr++], delimeters ) )
			{
				no++;
				break;
			}
		}
	}

	startptr = lineptr;
	if( l_delimeter( linebuffer[lineptr], delimeters ) )
		startptr++;

	if( startptr >= linelen )
		return(0);

	/* find endptr */
	for( ; lineptr<linelen; lineptr++ )
	{
		if( l_delimeter( linebuffer[lineptr], delimeters ) )
			break;
	}

	endptr = lineptr-1;

	if( startptr > endptr )
		return(0);

	/* adjust pointer excluding tab,space,cr.etc */
	for( ; startptr<=endptr; startptr++ )
		if( ! isspace( linebuffer[ startptr ] ) )	/* \t \r ' ' */
			break;

	if( startptr > endptr )
		return(0);

	/* get datalen and element contents until endptr or space char appear */
	for( ; startptr<=endptr; startptr++, (*datalen)++ )
	{
		if( isspace( linebuffer[ startptr ] ) )	/* \t \r ' ' */
			break;
		databuffer[ (*datalen) ] = linebuffer[ startptr ];
	}
	return(0);
}
