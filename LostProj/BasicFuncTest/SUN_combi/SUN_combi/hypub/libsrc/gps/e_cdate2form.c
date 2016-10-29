/* e_cdate2form() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert date to masked date					*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*srcdate	source date string
		  int	form		masked form number
					  1 : YYMMDD	 (ex>'921011')
					  2 : YY.MM.DD	 (ex>'92.10.11')
					  3 : YYYYMMDD	 (ex>'19921011')
					  4 : YYYY.MM.DD (ex>'1992.10.11')
	output	: char	*dstdate	masked date string
	return	: 0/-1
*/
#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_cdate2form( char *srcdate, int form, char *dstdate)
#else
e_cdate2form( srcdate, form, dstdate)
char	*srcdate ;
int	form ;
char	*dstdate ;
#endif
{
	int	year, month, date, ptr ;
	int	form10, form1 ;

	/* Parameter Error Check */
	if( form / 10 < 1 || form / 10 > 4 || form % 10 < 1 || form % 10 > 4 ||
	    srcdate == (char *)0 || dstdate == ( char *)0 )
	{
		return -1;
	}

	form10 = form / 10;
	form1  = form % 10;

	/* 주어진 연월일  check */
	if( e_chkdate( srcdate, form10 ) < 0 ) return(-1) ;

	year  = d_ndec2int( srcdate, (form10/3)*2 + 2 ) ;
	month = d_ndec2int( &srcdate[form10+1], 2 ) ;
	ptr = (form10%2==1)?(form10+3):(form10+4);
	date  = d_ndec2int( &srcdate[ptr], 2 ) ;

	if( ( year = e_getyear( year ) ) < 0 )
		return -1;

	switch( form1 )
	{
	case	1	:
		year = year % 100;
		d_int2ndec( year, 2, '0', dstdate );
		d_int2ndec( month, 2, '0', dstdate + 2 );
		d_int2ndec( date, 2, '0', dstdate + 4 );
		break;
	case	2	:
		year = year % 100;
		d_int2ndec( year, 2, '0', dstdate );
		dstdate[2] = '.';	
		d_int2ndec( month, 2, '0', dstdate + 3 );
		dstdate[5] = '.';	
		d_int2ndec( date, 2, '0', dstdate + 6 );
		break;
	case	3	:
		d_int2ndec( year, 4, '0', dstdate );
		d_int2ndec( month, 2, '0', dstdate + 4 );
		d_int2ndec( date, 2, '0', dstdate + 6 );
		break;
	case	4	:
		d_int2ndec( year, 4, '0', dstdate );
		dstdate[4] = '.';	
		d_int2ndec( month, 2, '0', dstdate + 5 );
		dstdate[7] = '.';	
		d_int2ndec( date, 2, '0', dstdate + 8 );
		break;
	default :
		return -1;
	}
	return 0;
}
