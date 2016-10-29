/************************************************************************
*	GPS library testing program ( data maniplation )		*
************************************************************************/

/*----------------------------------------------------------------------+
|	Include files							|
+----------------------------------------------------------------------*/
#include	<stdio.h>
#include	<stdlib.h>

#include	"cbuni.h"

#include	"gps.h"

/*---------------------------------------------------------------------*/
void
D_ADJNDECIMAL()
{
	char	tmpstr[80];
	char	str[256];
	char	lchar;
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_adjndecimal( char *str(i/o), char lchar(i),   |\n" );
	printf( "|                      int len(i) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " lchar ( 1. ' '  2. '0' ) : " );
	scanf( "%s", tmpstr );
	switch( atoi( tmpstr ) )
	{
	case	1	:	lchar = ' ';	break;
	case	2	:	lchar = '0';	break;
	default		:	printf( "invalid lchar ......\n" ); return;
	}
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_adjndecimal( str, lchar, len ) < 0 )
	{
		printf( "d_adjndecimal error .....\n" );
		return;
	}

	printf( " Result str : [%.*s]\n", len, str );

} /* D_ADJDECIMAL */

/*---------------------------------------------------------------------*/
void
D_D2NSTR()
{
	char	tmpstr[80];
	double	num;
	char	str[128];
	int	destlen;
	int	pntlen;
	char	lchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_d2nstr( double num(i), char dest(o),          |\n" );
	printf( "|        int destlen(i), int pntlen(i), char lchar(i) ) |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " num        : " );
	scanf( "%s", tmpstr );
	if( sscanf( tmpstr, "%lf", &num ) <= 0 )
	{
		printf( "invalid num ...........\n" );
		return;
	}
	printf( " destlen    : " );
	scanf( "%s", tmpstr );
	if( ( destlen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid destlen ......\n" );
		return;
	}
	printf( " pntlen     : " );
	scanf( "%s", tmpstr );
	if( ( pntlen = atoi( tmpstr ) ) <= 0 || pntlen > destlen )
	{
		printf( "invalid pntlen ......\n" );
		return;
	}
	printf( " lchar      : " );
	gets( tmpstr );
	gets( tmpstr );
	lchar = tmpstr[0];

	if( d_d2nstr( num, str, destlen, pntlen, lchar ) < 0 )
	{
		printf( "d_d2nstr error .....\n" );
		return;
	}

	printf( " Result str : [%.*s]\n", destlen, str );

} /* D_D2NSTR */

/*---------------------------------------------------------------------*/
void
D_DECTOINT()
{
	char	tmpstr[80];
	int	num;
	char	str[128];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_dectoint( char str(i), int len(i),            |\n" );
	printf( "|                   int *num(o) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_dectoint( str, len, &num ) < 0 )
	{
		printf( "d_dectoint error .....\n" );
		return;
	}

	printf( " Result num : [%d]\n", num );

} /* D_DECTOINT */

/*---------------------------------------------------------------------*/
void
D_FILLDATA()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	char	filldata[256];
	int	srclen;
	char	maskchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_filldata( char *src(i), int srclen(i),        |\n" );
	printf( "|                char *dest(o), char *filldata(i),      |\n" );
	printf( "|                char maskchar(i) )                     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " filldata    : " );
	gets( filldata );
	gets( filldata );
	printf( " maskchar    : " );
	gets( tmpstr );
	maskchar = tmpstr[0];

	memset( dest, 0, sizeof dest );
	if( d_filldata( src, srclen, dest, filldata, maskchar ) < 0 )
	{
		printf( "d_filldata error .....\n" );
		return;
	}

	printf( " Result dest : [%s]\n", dest );

} /* D_FILLDATA */

/*---------------------------------------------------------------------*/
void
D_FILLFORM()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	char	filldata[256];
	int	srclen;
	int	filllen;
	char	maskchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_fillform( char *src(i), int srclen(i),        |\n" );
	printf( "|                char *dest(o), char *filldata(i),      |\n" );
	printf( "|                int filllen(i), char maskchar(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " filldata    : " );
	gets( filldata );
	gets( filldata );
	printf( " filllen     : " );
	scanf( "%s", tmpstr );
	if( ( filllen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid filllen ......\n" );
		return;
	}
	printf( " maskchar    : " );
	gets( tmpstr );
	gets( tmpstr );
	maskchar = tmpstr[0];

	if( d_fillform( src, srclen, dest, filldata, filllen, maskchar ) < 0 )
	{
		printf( "d_fillform error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", filllen, dest );

} /* D_FILLFORM */

/*---------------------------------------------------------------------*/
void
D_FMASK()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	char	mask[256];
	int	srclen;
	char	lfillchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_fmask( char *src(i), int srclen(i),           |\n" );
	printf( "|                char *dest(o), char *mask(i),          |\n" );
	printf( "|                char lfillchar(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " mask        : " );
	gets( mask );
	gets( mask );
	printf( " lfillchar   : " );
	gets( tmpstr );
	lfillchar = tmpstr[0];

	memset( dest, 0, sizeof dest );
	if( d_fmask( src, srclen, dest, mask, lfillchar ) < 0 )
	{
		printf( "d_fmask error .....\n" );
		return;
	}

	printf( " Result dest : [%s]\n", dest );

} /* D_FMASK */

/*---------------------------------------------------------------------*/
void
D_HANADJT()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_hanadjt( char *src(i), int len(i),            |\n" );
	printf( "|                char *dest(o) )                        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_hanadjt( src, len, dest ) < 0 )
	{
		printf( "d_fanadjt error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_HANADJT */

/*---------------------------------------------------------------------*/
void
D_NHEX2INT()
{
	char	tmpstr[80];
	char	str[128];
	int	len;
	int	num;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_nhex2int( char *str(i), int len(i) )          |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	num = d_nhex2int( str, len );

	printf( " Result num : [%d]\n", num );

} /* D_NHEX2INT */

/*---------------------------------------------------------------------*/
void
D_HEXTOINT()
{
	char	tmpstr[80];
	char	str[128];
	int	len;
	int	num;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_hextoint( char *str(i), int len(i),           |\n" );
	printf( "|                   int *num(o) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_hextoint( str, len, &num ) < 0 )
	{
		printf( "d_hextoint error .....\n" );
		return;
	}

	printf( " Result num : [%d]\n", num );

} /* D_HEXTOINT */

/*---------------------------------------------------------------------*/
void
D_IMASK()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	char	mask[256];
	int	srclen;
	char	lfillchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_imask( char *src(i), int srclen(i),           |\n" );
	printf( "|                char *dest(o), char *mask(i),          |\n" );
	printf( "|                char lfillchar(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " mask        : " );
	gets( mask );
	gets( mask );
	printf( " lfillchar   : " );
	gets( tmpstr );
	lfillchar = tmpstr[0];

	memset( dest, 0, sizeof dest );
	if( d_imask( src, srclen, dest, mask, lfillchar ) < 0 )
	{
		printf( "d_fmask error .....\n" );
		return;
	}

	printf( " Result dest : [%s]\n", dest );

} /* D_IMASK */

/*---------------------------------------------------------------------*/
void
D_INT2NDEC()
{
	char	tmpstr[80];
	int	num;
	int	len;
	char	lchar;
	char	dest[128];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_int2ndec( uint num(i), int len(i),            |\n" );
	printf( "|                   char lchar(i), char *dest(o) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " num         : " );
	scanf( "%s", tmpstr );
	num = atoi( tmpstr );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}
	printf( " lchar       : " );
	gets( tmpstr );
	gets( tmpstr );
	lchar = tmpstr[0];

	d_int2ndec( (unsigned int)num, len, lchar, dest );

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_INT2NDEC */

/*---------------------------------------------------------------------*/
void
D_INT2NHEX()
{
	char	tmpstr[80];
	int	num;
	int	len;
	char	lchar;
	char	dest[128];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_int2nhex( int num(i), int len(i),             |\n" );
	printf( "|                   char lchar(i), char *dest(o) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " num         : " );
	scanf( "%s", tmpstr );
	num = atoi( tmpstr );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}
	printf( " lchar       : " );
	gets( tmpstr );
	gets( tmpstr );
	lchar = tmpstr[0];

	d_int2nhex( num, len, lchar, dest );

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_INT2NHEX */

/*---------------------------------------------------------------------*/
void
D_INTTODEC()
{
	char	tmpstr[80];
	int	num;
	int	len;
	char	lchar;
	char	dest[128];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_inttodec( int num(i), int len(i),             |\n" );
	printf( "|                   char lchar(i), char *dest(o) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " num         : " );
	scanf( "%s", tmpstr );
	num = atoi( tmpstr );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}
	printf( " lchar       : " );
	gets( tmpstr );
	gets( tmpstr );
	lchar = tmpstr[0];

	d_inttodec( num, len, lchar, dest );

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_INTTODEC */

/*---------------------------------------------------------------------*/
void
D_INTTOHEX()
{
	char	tmpstr[80];
	int	num;
	int	len;
	char	lchar;
	char	dest[128];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_inttohex( int num(i), int len(i),             |\n" );
	printf( "|                   char lchar(i), char *dest(o) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " num         : " );
	scanf( "%s", tmpstr );
	num = atoi( tmpstr );
	printf( " len         : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}
	printf( " lchar       : " );
	gets( tmpstr );
	gets( tmpstr );
	lchar = tmpstr[0];

	d_inttohex( num, len, lchar, dest );

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_ITTOHEX */

/*---------------------------------------------------------------------*/
void
D_ISNUMSTR()
{
	char	str[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_isnumstr( char *str(i) )                      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str    : " );
	gets( str );
	gets( str );

	if( d_isnumstr( str ) )
		printf( " Result : TRUE\n" );
	else
		printf( " Result : FALSE\n" );

} /* D_ISNUMSTR */

/*---------------------------------------------------------------------*/
void
D_ISSPACENSTR()
{
	char	tmpstr[80];
	char	str[128];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_isspacenstr( char *str(i), int len(i) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str    : " );
	gets( str );
	gets( str );
	printf( " len    : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_isspacenstr( str, len ) )
		printf( " Result : TRUE\n" );
	else
		printf( " Result : FALSE\n" );

} /* D_ISSPACENSTR */

/*---------------------------------------------------------------------*/
void
D_ISSPACESTR()
{
	char	str[80];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_isspacestr( char *str(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str    : " );
	gets( str );
	gets( str );

	if( d_isspacestr( str ) )
		printf( " Result : TRUE\n" );
	else
		printf( " Result : FALSE\n" );

} /* D_ISSPACESTR */

/*---------------------------------------------------------------------*/
void
D_LEFTALIGN()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	int	srclen;
	char	rfillchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_leftalign( char *src(i), int srclen(i),       |\n" );
	printf( "|                char *dest(o), char rfillchar(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " rfillchar   : " );
	gets( tmpstr );
	gets( tmpstr );
	rfillchar = tmpstr[0];

	if( d_leftalign( src, srclen, dest, rfillchar ) < 0 )
	{
		printf( "d_leftalign error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", srclen, dest );

} /* D_LEFTALIGN */

/*---------------------------------------------------------------------*/
void
D_MKSTR()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	int	srclen;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_mkstr( char *src(i), int srclen(i),           |\n" );
	printf( "|                char *dest(o) )                        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " srclen      : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}

	d_mkstr( src, srclen, dest );

	printf( " Result dest : [%s]\n", dest );

} /* D_MKSTR */

/*---------------------------------------------------------------------*/
void
D_MKSTRADD()
{
	char	presrc[128];
	char	postsrc[128];
	char	dest[256];
	int	destlen;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_mkstradd( char *presrc(i), char *postsrc(i),  |\n" );
	printf( "|                char *dest(o), int *destlen(o) )       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " presrc      : " );
	gets( presrc );
	gets( presrc );
	printf( " postsrc     : " );
	gets( postsrc );

	if( d_mkstradd( presrc, postsrc, dest, &destlen ) < 0 )
	{
		printf( "d_mkstradd error .....\n" );
		return;
	}

	printf( " Result dest : (%d)[%s]\n", destlen, dest );

} /* D_MKSTRADD */

/*---------------------------------------------------------------------*/
void
D_NDEC2INT()
{
	char	tmpstr[80];
	char	str[128];
	int	len;
	int	num;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_ndec2int( char *str(i), int len(i) )          |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	num = d_ndec2int( str, len );

	printf( " Result num : [%d]\n", num );

} /* D_NDEC2INT */

/*---------------------------------------------------------------------*/
void
D_NSTR2D()
{
	char	tmpstr[80];
	char	src[128];
	int	len;
	double	num;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_nstr2d( char *src(i), int len(i),             |\n" );
	printf( "|                double *num(o) )                       |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src        : " );
	gets( src );
	gets( src );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_nstr2d( src, len, &num ) < 0 )
	{
		printf( "d_nstr2d error .....\n" );
		return;
	}

	printf( " Result num : [%lf]\n", num );

} /* D_NSTR2D */

/*---------------------------------------------------------------------*/
void
D_NSTRADD()
{
	char	tmpstr[80];
	char	presrc[128];
	char	postsrc[128];
	char	dest[128];
	int	len;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_nstradd( char *presrc(i), char *postsrc(i),   |\n" );
	printf( "|                char *dest(o), int len(i) )            |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " presrc     : " );
	gets( presrc );
	gets( presrc );
	printf( " postsrc    : " );
	gets( postsrc );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	if( d_nstradd( presrc, postsrc, dest, len ) < 0 )
	{
		printf( "d_nstradd error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", len, dest );

} /* D_NSTRADD */

/*---------------------------------------------------------------------*/
void
D_NSTRADD2()
{
	char	tmpstr[80];
	char	presrc[128];
	char	postsrc[128];
	char	dest[128];
	int	prelen;
	int	postlen;
	int	destlen;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_nstradd2( char *presrc(i), int prelen(i),     |\n" );
	printf( "|                char *postsrc(i), int postlen(i),      |\n" );
	printf( "|                char *dest(o), int destlen(i) )        |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " presrc      : " );
	gets( presrc );
	gets( presrc );
	printf( " prelen      : " );
	scanf( "%s", tmpstr );
	if( ( prelen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid prelen ......\n" );
		return;
	}
	printf( " postsrc     : " );
	gets( postsrc );
	gets( postsrc );
	printf( " postlen     : " );
	scanf( "%s", tmpstr );
	if( ( postlen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid postlen ......\n" );
		return;
	}
	printf( " destlen     : " );
	scanf( "%s", tmpstr );
	if( ( destlen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid destlen ......\n" );
		return;
	}

	if( d_nstradd2( presrc, prelen, postsrc, postlen, dest, destlen ) < 0 )
	{
		printf( "d_nstradd2 error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", destlen, dest );

} /* D_NSTRADD2 */

/*---------------------------------------------------------------------*/
void
D_RIGHTALIGN()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	int	srclen;
	char	lfillchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_rightalign( char *src(i), int srclen(i),      |\n" );
	printf( "|                char *dest(o), char lfillchar(i) )     |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src        : " );
	gets( src );
	gets( src );
	printf( " srclen     : " );
	scanf( "%s", tmpstr );
	if( ( srclen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid srclen ......\n" );
		return;
	}
	printf( " lfillchar  : " );
	gets( tmpstr );
	gets( tmpstr );
	lfillchar = tmpstr[0];

	if( d_rightalign( src, srclen, dest, lfillchar ) < 0 )
	{
		printf( "d_rightalign error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", srclen, dest );

} /* D_RIGHTALIGN */

/*---------------------------------------------------------------------*/
void
D_STRENDNULL()
{
	char	tmpstr[80];
	char	str[128];
	int	len;
	int	num;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_strendnull( char *str(i/o), int len(i) )      |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " str        : " );
	gets( str );
	gets( str );
	printf( " len        : " );
	scanf( "%s", tmpstr );
	if( ( len = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid len ......\n" );
		return;
	}

	num = d_strendnull( str, len );

	printf( " Result src : (%d)[%.*s]\n", num, num, str );

} /* D_STRENDNULL */

/*---------------------------------------------------------------------*/
void
D_STRSORT()
{
	char	tmpstr[80];
	int	keyoff;
	int	keylen;
	int	noofrec;
	int	recsize;
	char	recbuf[2048];

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_strsort( int keyoff(i), int keylen(i),        |\n" );
	printf( "|                  int noofrec(i), int recsize(i),      |\n" );
	printf( "|                  char *recbuf(i/o) )                  |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " keyoff        : " );
	scanf( "%s", tmpstr );
	if( ( keyoff = atoi( tmpstr ) ) < 0 )
	{
		printf( "invalid keyoff ......\n" );
		return;
	}
	printf( " keylen        : " );
	scanf( "%s", tmpstr );
	if( ( keylen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid keylen ......\n" );
		return;
	}
	printf( " noofrec       : " );
	scanf( "%s", tmpstr );
	if( ( noofrec = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid noofrec ......\n" );
		return;
	}
	printf( " recsize       : " );
	scanf( "%s", tmpstr );
	if( ( recsize = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid recsize ......\n" );
		return;
	}
	printf( " recbuf        : " );
	gets( recbuf );
	gets( recbuf );

	if( d_strsort( keyoff, keylen, noofrec, recsize, recbuf ) < 0 )
	{
		printf( "d_strsort error .....\n" );
		return;
	}

	printf( " Result recbuf : [%.*s]\n", noofrec * recsize, recbuf );

} /* D_STRSORT */

/*---------------------------------------------------------------------*/
void
D_UMASK()
{
	char	tmpstr[80];
	char	src[128];
	char	dest[256];
	char	mask[256];
	int	destlen;
	char	lfillchar;

	printf( "+-------------------------------------------------------+\n" );
	printf( "|       d_umask( char *src(i), char *dest(o),           |\n" );
	printf( "|                int destlen(i), char *mask(i),         |\n" );
	printf( "|                char lfillchar(i) )                    |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( " src         : " );
	gets( src );
	gets( src );
	printf( " destlen     : " );
	scanf( "%s", tmpstr );
	if( ( destlen = atoi( tmpstr ) ) <= 0 )
	{
		printf( "invalid destlen ......\n" );
		return;
	}
	printf( " mask        : " );
	gets( mask );
	gets( mask );
	printf( " lfillchar   : " );
	gets( tmpstr );
	lfillchar = tmpstr[0];

	if( d_umask( src, dest, destlen, mask, lfillchar ) < 0 )
	{
		printf( "d_umask error .....\n" );
		return;
	}

	printf( " Result dest : [%.*s]\n", destlen, dest );

} /* D_UMASK */

/*----------------------------------------------------------------------+
|	Display function for data maniplation				|
+----------------------------------------------------------------------*/
void
DisplayDataManF()
{
	printf( "\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "|       GPS library test program ( data maniplation )   |\n" );
	printf( "+-------------------------------------------------------+\n" );
	printf( "\n" );
	printf( "  1. d_adjndecimal  2. d_d2nstr      3. d_dectoint\n" );
	printf( "  4. d_filldata     5. d_fillform    6. d_fmask\n" );
	printf( "  7. d_hanadjt      8. d_nhex2int    9. d_hextoint\n" );
	printf( " 10. d_imask       11. d_int2ndec   12. d_int2nhex\n" );
	printf( " 13. d_inttodec    14. d_inttohex   15. d_isnumstr\n" );
	printf( " 16. d_isspacenstr 17. d_isspacestr 18. d_leftalign\n" );
	printf( " 19. d_mkstr       20. d_mkstradd   21. d_ndec2int\n" );
	printf( " 22. d_nstr2d      23. d_nstradd    24. d_nstradd2\n" );
	printf( " 25. d_rightalign  26. d_strendnull 27. d_strsort\n" );
	printf( " 28. d_umask\n" );
	printf( " 99. Return\n" );
	printf( "\n" );
	printf( "---------------------------------------------------------\n" );
	printf( "\n" );

} /* DisplayDataManF */

/*----------------------------------------------------------------------+
|	Choose function for data maniplation				|
+----------------------------------------------------------------------*/
int
ChooseDataManF()
{
	int	choosenum = 0;
	char	choosestr[80];

	while( choosenum != 99 && ( choosenum < 1 || choosenum > 28 ) )
	{
		printf( "Choose testing function : " );
		scanf( "%s", choosestr );
		choosenum = atoi( choosestr );
	}

	return( choosenum );

} /* ChooseDataManF */

/*----------------------------------------------------------------------+
|	Main function for data maniplation				|
+----------------------------------------------------------------------*/
void
DataManF()
{
	for( ; ; )
	{
		DisplayDataManF();
		switch( ChooseDataManF() )
		{
		case	 1	:	D_ADJNDECIMAL();	break;
		case	 2	:	D_D2NSTR();		break;
		case	 3	:	D_DECTOINT();		break;
		case	 4	:	D_FILLDATA();		break;
		case	 5	:	D_FILLFORM();		break;
		case	 6	:	D_FMASK();		break;
		case	 7	:	D_HANADJT();		break;
		case	 8	:	D_NHEX2INT();		break;
		case	 9	:	D_HEXTOINT();		break;
		case	10	:	D_IMASK();		break;
		case	11	:	D_INT2NDEC();		break;
		case	12	:	D_INT2NHEX();		break;
		case	13	:	D_INTTODEC();		break;
		case	14	:	D_INTTOHEX();		break;
		case	15	:	D_ISNUMSTR();		break;
		case	16	:	D_ISSPACENSTR();	break;
		case	17	:	D_ISSPACESTR();		break;
		case	18	:	D_LEFTALIGN();		break;
		case	19	:	D_MKSTR();		break;
		case	20	:	D_MKSTRADD();		break;
		case	21	:	D_NDEC2INT();		break;
		case	22	:	D_NSTR2D();		break;
		case	23	:	D_NSTRADD();		break;
		case	24	:	D_NSTRADD2();		break;
		case	25	:	D_RIGHTALIGN();		break;
		case	26	:	D_STRENDNULL();		break;
		case	27	:	D_STRSORT();		break;
		case	28	:	D_UMASK();		break;
		default		:				return;
		}
	}

} /* DataManF */

/****** End of dataman.c ***********************************************/
