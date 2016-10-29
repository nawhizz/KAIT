/* k_getchar() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : input a char from std-in at current cursor position		*/
/*----------------------------------------------------------------------*/
/*
	output	: short *keyval 	keyvalue
*/
#include	<stdio.h>
#include	"gps.h"

void CBD1
#if	defined( __CB_STDC__ )
k_getchar(short *keyval)
#else
k_getchar(keyval)
short	*keyval;
#endif
{
	for( ; ( *keyval=getchar() ) == 0x0a; ) ;

	for( ; getchar()!=0x0a; ) ;
}
