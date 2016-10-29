/* d_isspacestr() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : test if null terminated string is all space character 	*/
/*	  .max length of string <= 6000)				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	string[]
	return	: 1/0
		  -1	(string size>60000 or not null-terminated)
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_isspacestr( char *string )
#else
d_isspacestr( string )
char	*string;
#endif
{
	register	i;

	for( i=0; i<60000 && string[i]; i++ )
	{
		if( string[i] != ' ' )
			return 0;
	}
	return 1;
}
