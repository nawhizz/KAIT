/********************************************************
 *							*
 *	ISAM file index look up prog.			*
 *	87.12.9  by J.I.KIM				*
 *							*
 *	compile procedure = "cclibcom isinfo"		*
 *							*
 *	Usage : isinfo [file-id]			*
 *							*
 ********************************************************/
#include	<stdio.h>
#include	<string.h>

#ifdef		WIN32
#include	<stdlib.h>
#endif

#include	"cbuni.h"
#include	"iswrap.h"	/* #include	<isam.h> */

struct	flag  {
	int	typ_id;
	char	*typ_nam;
} flg [] = {	/* flags */
	ISNODUPS,	"NODUPS ",
	ISDUPS,		"DUPS ",
	DCOMPRESS,	"DCOMP",	/* 002(o) = 00000010(b) */
	LCOMPRESS,	"LCOMP",	/* 004(o) = 00000100(b) */
	TCOMPRESS,	"TCOMP",	/* 010(o) = 00001000(b) */
	COMPRESS,	"COMP",		/* 016(o) = 00001110(b) */
};

struct	d_typ {
	int	typ_id;
	char	*typ_nam;
} typ [] = {	/* data types */
	CHARTYPE,	"CHAR  ",
	INTTYPE,	"INT   ",
	LONGTYPE,	"LONG  ",
	DOUBLETYPE,	"DOUBLE",
	FLOATTYPE,	"FLOAT ",
};

#define LADIX	".dat"		/* c-isam ver 5.3.4 data file extention */
#define is_ferr 100
#define LINE	"+-----------------------------------------------------------------------------+\n"

void	iserr CBD2(( char *msg ));
void	flgchk CBD2(( int flags, char buf[] ));

void
#if defined( __CB_STDC__ )
main( int argc, char **argv )
#else
main( argc, argv )
int	argc;
char	**argv;
#endif
{
	int			i, j, cc, isfd;
	char			*n, fbuf [80];
	struct	dictinfo	buffer;
	struct	keydesc		key;

	printf( "\n" );
	printf( "+----------------------" );
#ifndef	WIN32
	printf( "[7m" );
#endif
	printf( "  ISAM FILE INDEX INFORMATION  " );
#ifndef	WIN32
	printf( "[0m" );
#endif
	printf( "------------------------+\n\n" );

	if( argc < 2 )
	{
		printf("\n\tUsage : " );
#ifndef	WIN32
		printf( "[7m" );
#endif
		printf( "isinfo" );
#ifndef	WIN32
		printf( "[0m" );
#endif
		printf( " " );
#ifndef	WIN32
		printf( "[7m" );
#endif
		printf( "<fileid>\n" );
#ifndef	WIN32
		printf( "[0m" );
#endif
		printf( "%s", LINE );
		exit (0);
	}

LOOP:	/* More than 1 file support ...................88/04/13 j.i.kim */
	if( *++argv == NULL )		/* Normal job end		*/
	{
		printf( "\n%s", LINE );
		exit( 0 );
	}

	for( n=*argv; *n; n++ ) ;		/* .dat or .idx or .lok */
	n -= 4;
	if (strncmp( n, ".dat", 4 ) == 0 ||
	    strncmp( n, ".idx", 4 ) == 0 ||
	    strncmp( n, ".lok", 4 ) == 0 )
	    *n = 0;
	n = *argv;

	printf( "[ FILE : %s ]\n", n );
	if( ( isfd = isopen ( n, ISINPUT+ ISAUTOLOCK ) ) < 0 )
	{
		printf( "%s", LINE );
		iserr( "isopen" );
		goto LOOP;
	}
	printf( "%s", LINE );
	if( ( cc = isindexinfo( isfd, (struct keydesc *)&buffer, 0 ) ) != 0 )
	{
		iserr( "isindexinfo" );
		isclose( isfd );
		goto LOOP;
	}

	printf( "keys=%2d recsize=%3d idxsize=%5d nrecords=%ld\n",
		buffer.di_nkeys, buffer.di_recsize, buffer.di_idxsize,
		buffer.di_nrecords );

	for( i=1; i<=buffer.di_nkeys; i++ )
	{
		if( ( cc = isindexinfo( isfd, &key, i ) ) != 0 )
		{
			printf( "%s", LINE );
			iserr( "isindexinfo" );
			printf( "%s", LINE );
			isclose( isfd );
			exit(0);
		}

		printf( "%s", LINE );
		for( j=0; j<key.k_nparts; j++ )
		{
			flgchk( key.k_flags, fbuf );
			if( !j )
			{
printf("idxno=%d (%-7s) nparts=%d\tpartno=%2d start=%3d leng=%3d type=%s\n",
	i,				/* index serial no		*/
	fbuf,				/* flags			*/
	key.k_nparts,			/* number of parts in key	*/
	j+1,
	key.k_part[j].kp_start,		/* starting byte of key part	*/
	key.k_part[j].kp_leng,		/* length in bytes		*/
	typ [key.k_part[j].kp_type].typ_nam	/* type of key part	*/
);
			}
			else
			{
printf("                         \tpartno=%2d start=%3d leng=%3d type=%s\n",
    j+1,
    key.k_part[j].kp_start,		/* starting byte of key part	*/
    key.k_part[j].kp_leng,		/* length in bytes		*/
    typ [key.k_part[j].kp_type].typ_nam /* type of key part		*/
);
			}
		}
	}
	isclose( isfd );

	goto LOOP;
}

void
#if defined( __CB_STDC__ )
iserr( char *msg )
#else
iserr( msg )
char	*msg;
#endif
{
	if( iserrno >= is_ferr && iserrno < is_nerr )
		printf("ISAM %s error %d: %s\n", msg, iserrno,
			is_errlist[iserrno-is_ferr]);
	else
		printf ("ISAM %s error %d ", msg, iserrno);
}

void
#if defined( __CB_STDC__ )
flgchk( int flags, char buf[] )
#else
flgchk( flags, buf )
int	flags;
char	buf[];
#endif
{
	int	i;

	memset( buf, '\0', 80 );
	(flags & 01) ?	/* dups ? */
			strcpy( buf, flg [1].typ_nam ):
			strcpy( buf, flg [0].typ_nam );
	for( i=2; i<6; i++ ) /* compress ? */
		if( flags & 016 == flg [i].typ_id & 016 )
			strcat( buf, flg [i].typ_nam );
}
