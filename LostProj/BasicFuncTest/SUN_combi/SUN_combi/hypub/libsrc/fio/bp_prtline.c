/* bp_prtline() : LIB fio */
/*----------------------------------------------------------------------*/
/* FUNC : print out line data without CR/LF				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	pfd		file descriptor
		  char	*linedata	linedata for print
		  int	linelen 	length of linedata
	return	: 0/-1
*/

#include	"fio.h"

int CBD1
#if	defined( __CB_STDC__ )
bp_prtline( int	pfd, char *linedata, int linelen )
#else
bp_prtline( pfd, linedata, linelen )
int	pfd;
char	*linedata;
int	linelen;
#endif
{
	if( bp_prtdata( pfd, linedata, linelen ) < 0 )
		return( -1 );

	return( bp_prtdata( pfd, "\r\n", 2 ) );
}
