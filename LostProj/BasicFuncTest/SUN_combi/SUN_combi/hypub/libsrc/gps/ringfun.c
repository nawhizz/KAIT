#define 	D_NRINGBUF	10	/* max. no of ringbufio */
#define 	D_ROPENED	7
#define 	D_RCLOSED	1
#define 	D_REMPTY	1
#define 	D_RFULL 	2

struct	RINGBUF {
	int	sts;
	int	size;
	int	rsts;
	char	*hptr;
	char	*tptr;
	char	*sptr;
	char	*eptr;
};
static	struct	RINGBUF _d_rbf[D_NRINGBUF];

/* d_ringopen() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : initialization of ring buffer manipulation			*/
/*----------------------------------------------------------------------*/
/*
	input	: char	*rbuf		ring buffer
		  int	bufsize 	length of string
	return	: >0 ( ring buffer handle)
		  -1
*/

#include	"gps.h"

int CBD1
#if	defined( __CB_STDC__ )
d_ringopen( char *rbuf, int bufsize )
#else
d_ringopen( rbuf, bufsize )
char	*rbuf;
int	bufsize;
#endif
{
	register	i;

	if( rbuf == (char *)0 || bufsize <= 0 )
		return(-1);

	for( i=0; i<D_NRINGBUF; i++)
	{
		if(_d_rbf[i].sts != D_ROPENED)
		{
			_d_rbf[i].hptr = rbuf;
			_d_rbf[i].tptr = rbuf;
			_d_rbf[i].sptr = rbuf;
			_d_rbf[i].eptr = rbuf + bufsize - 1;
			_d_rbf[i].size = bufsize;
			_d_rbf[i].sts = D_ROPENED;
			_d_rbf[i].rsts = D_REMPTY;
			return( ++i );
		}
	}
	return( -1 );
}

/* d_ringclose() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : close of ring buffer manipulation				*/
/*----------------------------------------------------------------------*/
/*
	input	: int	rd		ring buffer handle
	return	: 0/-1
*/
int CBD1
#if	defined( __CB_STDC__ )
d_ringclose( int rd )
#else
d_ringclose( rd )
int	rd;
#endif
{
	rd--;
	if(_d_rbf[rd].sts != D_ROPENED)
		return -1;
	_d_rbf[rd].sts = D_RCLOSED;
	return 0;
}

/* d_ringread() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : read data from ring buffer to databuffer			*/
/*----------------------------------------------------------------------*/
/*
	input	: int	rd		ring buffer handle
		  int	*len		length of data to read
	output	: char	*data		destination buffer
	return	: 0/-1
		  -2 (not enough data in ring buffer)
*/

int
#if	defined( __CB_STDC__ )
l_readnbytes( int index, char *data, int nbytes, int *dptr )
#else
l_readnbytes( index, data, nbytes, dptr )
int	index;
char	*data;
int	nbytes;
int	*dptr;
#endif
{
	if( nbytes == 0 )
		return 0;

	memcpy( &data[*dptr], _d_rbf[index].hptr, nbytes );
	*dptr += nbytes;

	_d_rbf[index].rsts = 0;
	_d_rbf[index].hptr = _d_rbf[index].hptr + nbytes;
	if( _d_rbf[index].hptr > _d_rbf[index].eptr )
		_d_rbf[index].hptr = _d_rbf[index].sptr;

	return 0;
}

int CBD1
#if	defined( __CB_STDC__ )
d_ringread( int rd, char *data, int *len )
#else
d_ringread( rd, data, len )
int	rd;
char	*data;
int	*len;
#endif
{
	int	nbytes = *len;
	int	retval = 0;
	int	dptr = 0;
	char	*temp;

	if( rd < 1 || rd > D_NRINGBUF )
		return -1;

	if( _d_rbf[--rd].sts != D_ROPENED )
		return -1;

	if( _d_rbf[rd].rsts == D_REMPTY )
		return -2;

	*len = 0;
	if( _d_rbf[rd].hptr < _d_rbf[rd].tptr )
	{
		if( _d_rbf[rd].tptr < _d_rbf[rd].hptr + nbytes )
		{
			nbytes = _d_rbf[rd].tptr - _d_rbf[rd].hptr;
			retval = -2;
		}
	}
	else
	{
		if( nbytes > (int)( _d_rbf[rd].eptr - _d_rbf[rd].hptr + 1 ) )
		{
			temp = _d_rbf[rd].hptr;
			l_readnbytes( rd, data,
				_d_rbf[rd].eptr -_d_rbf[rd].hptr + 1, &dptr);
			*len += _d_rbf[rd].eptr - temp + 1;
			nbytes -= _d_rbf[rd].eptr - temp + 1;
			if(_d_rbf[rd].tptr < _d_rbf[rd].hptr + nbytes )
			{
				nbytes = _d_rbf[rd].tptr - _d_rbf[rd].hptr;
				retval = -2;
			}
		}
	}

	l_readnbytes(rd, data, nbytes, &dptr);
	*len += nbytes;

	if( _d_rbf[rd].hptr == _d_rbf[rd].tptr )
		_d_rbf[rd].rsts = D_REMPTY;

	return( retval );
}

/* d_ringwrite() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : write data from databuffer to ringbuffer			*/
/*----------------------------------------------------------------------*/
/*
	input	: int	rd		ring buffer handle
		  char	*data		destination buffer
	inout	: int	*len		length of data to write /
					length of data actually written
	return	: 0/-1
		  -2 (too much data to write)
*/

int
#if	defined( __CB_STDC__ )
l_writenbytes( int index, char *data, int nbytes, int *dptr )
#else
l_writenbytes( index, data, nbytes, dptr )
int	index;
char	*data;
int	nbytes;
int	*dptr;
#endif
{
	if( nbytes == 0 )
	 	return 0;

	memcpy( _d_rbf[index].tptr, &data[*dptr], nbytes );
	*dptr += nbytes;

	_d_rbf[index].rsts=0;
	_d_rbf[index].tptr += nbytes;
	if( _d_rbf[index].tptr > _d_rbf[index].eptr )
		_d_rbf[index].tptr = _d_rbf[index].sptr;
	return 0;
}

int CBD1
#if	defined( __CB_STDC__ )
d_ringwrite( int rd, char *data, int *len )
#else
d_ringwrite( rd, data, len )
int	rd;
char	*data;
int	*len;
#endif
{
	int	nbytes = *len;
	int	retval = 0;
	int	dptr = 0;
	char	*temp;

	if( rd < 1 || rd > D_NRINGBUF )
		return -1;

	if( _d_rbf[--rd].sts != D_ROPENED )
		return -1;

	if( _d_rbf[rd].rsts == D_RFULL )
		return -2;

	*len=0;
	if( _d_rbf[rd].tptr < _d_rbf[rd].hptr )
	{
		if( _d_rbf[rd].hptr < _d_rbf[rd].tptr + nbytes )
		{
			nbytes = _d_rbf[rd].hptr - _d_rbf[rd].tptr;
			retval = -2;
		}
	}
	else
	{
		if( nbytes > (int)(_d_rbf[rd].eptr - _d_rbf[rd].tptr + 1 ) )
		{
			temp = _d_rbf[rd].tptr;
			l_writenbytes( rd, data,
				_d_rbf[rd].eptr - _d_rbf[rd].tptr + 1, &dptr );
			*len += _d_rbf[rd].eptr - temp + 1;
			nbytes -= _d_rbf[rd].eptr - temp + 1;
			if( _d_rbf[rd].hptr < _d_rbf[rd].tptr + nbytes)
			{
				nbytes = _d_rbf[rd].hptr - _d_rbf[rd].tptr;
				retval = -2;
			}
		}
	}

	l_writenbytes( rd, data, nbytes, &dptr);
	*len += nbytes;

	if(_d_rbf[rd].hptr == _d_rbf[rd].tptr )
		_d_rbf[rd].rsts = D_RFULL;
	return( retval );
}

/* d_ringcopy() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : copy data from ringbuffer to databuffer			*/
/*	  (not flush ringbuffer data)					*/
/*----------------------------------------------------------------------*/
/*
	input	: int	rd		ring buffer handle
	inout	: char	*data		destination buffer
		  int	*len		length of data to copy /
					length of data actually copied
	return	: 0/-1
		  -2 (not enough data in ring buffer)
*/

int
#if	defined( __CB_STDC__ )
l_copynbytes( int index, char *data, int nbytes, int *dptr, char **hptr2 )
#else
l_copynbytes( index, data, nbytes, dptr, hptr2 )
int	index;
char	*data;
int	nbytes;
int	*dptr;
char	**hptr2;
#endif
{
	if( nbytes == 0 )
	 	return 0;

	memcpy( &data[*dptr], *hptr2, nbytes );
	*dptr += nbytes;

	_d_rbf[index].rsts = 0;
	*hptr2 += nbytes;

	if(*hptr2 > _d_rbf[index].eptr)
		*hptr2 = _d_rbf[index].sptr;

	return 0;
}

int CBD1
#if	defined( __CB_STDC__ )
d_ringcopy( int rd, char *data, int *len )
#else
d_ringcopy( rd, data, len )
int	rd;
char	*data;
int	*len;
#endif
{
	int	nbytes = *len;
	int	retval=0;
	int	dptr = 0;
	char	*hptr2;
	char	*temp;

	if( rd < 1 || rd > D_NRINGBUF )
		return -1;

	if( _d_rbf[--rd].sts != D_ROPENED )
		return -1;

	if(_d_rbf[rd].rsts == D_REMPTY)
		return -2;

	*len=0;
	hptr2 = _d_rbf[rd].hptr;

	if( hptr2 < _d_rbf[rd].tptr )
	{
		if( _d_rbf[rd].tptr < hptr2 + nbytes )
		{
			nbytes = _d_rbf[rd].tptr - hptr2;
			retval = -2;
		}
	}
	else
	{
		temp = hptr2;
		if( nbytes > _d_rbf[rd].eptr - temp + 1 )
		{
			l_copynbytes( rd, data,
				_d_rbf[rd].eptr - temp + 1, &dptr, &hptr2 );
			*len += _d_rbf[rd].eptr - temp + 1;
			nbytes -= _d_rbf[rd].eptr - temp + 1;
			if( _d_rbf[rd].tptr < hptr2 + nbytes )
			{
				nbytes = _d_rbf[rd].tptr-hptr2;
				retval = -2;
			}
		}
	}

	l_copynbytes( rd, data, nbytes, &dptr, &hptr2);
	*len += nbytes;
	return( retval );
}
