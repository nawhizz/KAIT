/* l_readline() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : read buffer from fromptr until new line character appears	*/
/*	  for distinguish one line from buffer				*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*buffer
		: int	size
	inout	: int	*fromptr
	output	: char	*linebuffer
		  int	*len
	return	: 1 (end of file)
		  0
		 -1 (error / no data to move)
*/

int
#if	defined( __CB_STDC__ )
l_readline( char *buffer, int size, int *fromptr, char *linebuffer, int *len )
#else
l_readline( buffer, size, fromptr, linebuffer, len )
char	*buffer;
int	size;
int	*fromptr;
char	*linebuffer;
int	*len;
#endif
{
	register	i;

	if( buffer == (char *)0 || size <= 0 || fromptr == (int *)0 ||
	    linebuffer == (char *)0 || len == (int *)0 )
	{
		return( -1 );
	}

	if( *fromptr >= size )
		return( -1 );

	for( i=*fromptr; i<size; i++ )
	{
		if( buffer[i] == '\n' )
		{
			*len = i - *fromptr;	/* except new line character */
			*fromptr = i+1;
			return( 0 );
		}
		linebuffer[ i - *fromptr ] = buffer[i];
	}

	*len = i - *fromptr;
	*fromptr = i;
	return( 1 );
}
