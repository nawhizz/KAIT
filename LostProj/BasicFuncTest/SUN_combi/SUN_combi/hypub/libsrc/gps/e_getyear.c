/* e_getyear() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : convert 2 or 3 length string to 4 length string		*/
/*	  ( 1990бн2089 use )						*/
/*----------------------------------------------------------------------*/
/*
	input	: int	year		year
	return	: >0/-1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
e_getyear( int year )
#else
e_getyear( year )
int	year ;
#endif
{
	if( year >= 1000 )
		return( year );

	if( year < 90 )
		return( year + 2000 );

	return( year + 1900 );
}
