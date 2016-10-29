#include "ipcwrapdef.h"

key_t CBD1
ftok(const char *path, int id)
{
	register	i;
	key_t		keyval;
	unsigned char	tmpval;

//	StartIPCD();

	if (path == NULL)
	{
		errno = EINVAL;
		return -1;
	}

	/* first byte is id */
	keyval = (key_t)( id * 0x01000000 );

	/* second byte is length of path */
	tmpval = (unsigned char)strlen( path );
	keyval += (key_t)( tmpval * 0x00010000 );

	/* third byte is sum each byte of path */
	for( i=0, tmpval=0; path[i]; i++ )
	{
		if( path[i] == '/' )
			tmpval += '\\';
		else if( path[i] >= 'A' && path[i] <= 'Z' )
			tmpval += path[i] - 'A' + 'a';
		else
			tmpval += (unsigned char)path[i];
	}
	keyval += (key_t)( tmpval * 0x00000100 );

	/* forth byte is x-or each byte of path */
	for( i=0, tmpval=0; path[i]; i++ )
	{
		if( path[i] == '/' )
			tmpval ^= '\\';
		else if( path[i] >= 'A' && path[i] <= 'Z' )
			tmpval ^= path[i] - 'A' + 'a';
		else
			tmpval ^= (unsigned char)path[i];
	}
	keyval += (key_t)( tmpval * 0x00000001 );

	return( keyval );
}
