/* wfm_str2strarr() : LIB wfm */
/*----------------------------------------------------------------------*/
/* FUNC : move string ended by double null to string array		*/
/*----------------------------------------------------------------------*/
/* internal function */
/*
	input	: char	*str	: input string ended by double null char
		: char	*strarr[]: output string array
	return	: 0		: OK
		: -1		: error return
*/

#include	"wfm_fun.h"

int
#if	defined( __CB_STDC__ )
wfm_str2strarr( char *str, char *strarr[] )
#else
wfm_str2strarr( str, strarr )
char	*str;
char	*strarr[];
#endif
{
	int		cnt;
	register	ipos;
	register	fpos;

	if( str[0] == 0 && str[1] == 0 )
	{
		strarr[0] = (char *)0;
		return 0;
	}

	for(ipos=fpos=cnt=0; cnt < 1024-1 ;fpos++)
	{
		if( str[fpos] != '\0' ) continue;

		strarr[cnt] = &str[ipos];
		ipos = ++fpos;
		cnt++;
		if( str[ipos] == '\0' ) break;
	}

	strarr[cnt] = (char *)0;

	return 0;
}
