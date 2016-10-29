/* Rotational FIFO Functions */
#include	<fcntl.h>
#include	<sys/types.h>
#ifndef		WIN32
#include	<unistd.h>
#else
#include	<sys/stat.h>
#include	<io.h>
#endif
#include	"gps.h"

struct RF_HEADINFO	{
	int	mark;
	int	recsize;		/* max. record data size */
	int	maxrecno;		/* maximum que length( no of rec) */
	int	head;			/* oldest rec no ( 0 ~ maxrecno-1 ) */
					/* -1 = empty */
	int	tail;			/* newest rec no ( 0 ~ maxrecno-1 ) */
					/* -1 = empty */
	int	quelen; 		/* current no of recs in que */
					/* 0 = empty, 1 ~ maxrecno */
};

/* only for reference, BODY RECORDs in FIFO file
struct	RF_RECDATA	{
	int	datalen;		 : actual valid data record size
	char	data[datalen];		 : valid data record
	char	data[recsize-datalen];	 : remained buffer because of fixed
					   recsize (DAM) structure
};
*/

#define 	RF_MARK 	13579	/* R.FIFO id mark */

#ifdef		WIN32
extern	int	l_ntchmod( char *fpath, int fmode, int attrset );
#endif

/* rf_build() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : build FIFO							*/
/*----------------------------------------------------------------------*/
/*
	ex> fmode   = 0666 ( rw-rw-rw )
	return	: 0, -1(ERR), -2(ALREADY EXIST)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_build( char *fpath, int fmode, int recsize, int maxrecno )
#else
rf_build( fpath, fmode, recsize, maxrecno )
char	*fpath;
int	fmode;
int	recsize;		/* max. record data size */
int	maxrecno;		/* max. no of records in FIFO */
#endif
{
	int			fd;
	struct	RF_HEADINFO	fhead;

	if( fpath == (char *)0 )
		return( -1 );

	if( ( fd = open( fpath, O_RDWR ) ) >= 0 )
	{
		lseek( fd, 0L, SEEK_SET );
		if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		{
			close( fd );
			return(-1);	/*ERR*/
		}
		if( fhead.mark != RF_MARK ||
		    fhead.recsize != recsize ||
		    fhead.maxrecno != maxrecno ||
		    fhead.quelen < 0 )
		{
			close( fd );
			return( -1 );	/*ERR*/
		}
		close( fd );
		return( -2 );	/*ALREADY EXIST*/
	}
	else
	{
#ifndef	WIN32
		if( ( fd = creat( fpath, fmode ) ) < 0 )
			return(-1);			/*ERR*/
#else
		int	acs_mode = 0;

		if( ( fmode / 100 ) & 2 )       /* write mode */
			acs_mode |= _S_IWRITE;
		if( ( fmode / 100 ) & 4 )       /* read mode */
			acs_mode |= _S_IREAD;

		if( ( fd = creat( fpath, acs_mode ) ) < 0 )
			return(-1);			/*ERR*/

		if( l_ntchmod( fpath, fmode, 0 ) < 0 )
			return(-1);			/*ERR*/
#endif

		fhead.mark = RF_MARK;
		fhead.recsize = recsize;
		fhead.maxrecno	= maxrecno;
		fhead.quelen  = 0;
		fhead.tail = fhead.head = -1;
		if( write( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		{
			close( fd );
			unlink( fpath );
			return(-1);	/*ERR*/
		}

		close( fd );
		return(0);	/*OK*/
	}
}

/* rf_open() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : open	existing FIFO						*/
/*----------------------------------------------------------------------*/
/*
	return	: >=0(file-descriptor), -1(ERR)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_open( char *fpath )
#else
rf_open( fpath )
char *fpath ;
#endif
{
	int			fd;
	struct	RF_HEADINFO	fhead;

	if( fpath == (char *)0 )
		return( -1 );

	if( ( fd = open( fpath, O_RDWR ) ) < 0 )
		return(-1);				 /*ERR*/

	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		close( fd );
		return(-1);	/*ERR*/
	}

	if( fhead.mark != RF_MARK ||
	    fhead.recsize < 0 ||
	    fhead.maxrecno < 0 ||
	    fhead.quelen < 0 )
	{
		close( fd );
		return( -1 );	/*ERR*/
	}

	return( fd );
}

/* rf_close() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : close FIFO							*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_close (int fd )
#else
rf_close (fd )
int	fd;
#endif
{
	return( close( fd ) );
}

/* rf_write() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : append newest record into FIFO				*/
/*----------------------------------------------------------------------*/
/*
	return	: >0(length of written record), -4(FULL), -1(ERR)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_write( int fd, char *recdata, int datalen, int waitmsec )
#else
rf_write( fd, recdata, datalen, waitmsec )
int	fd;
char	*recdata;
int	datalen;		/* record data size in bytes */
int	waitmsec;
#endif
{
	struct	RF_HEADINFO	fhead;
	E_TIMESEC		start, currt, gapt;
	int			gapmsec;
	long			offset;

	if( recdata == (char *)0 || datalen < 0 )
		return( -1 );

	/* file locking for exclusive use only */
	/* If can't access until waitmsec elapsed return fail*/
	for( e_gettime( &start ); f_lock(fd) < 0; )
	{
		e_gettime( &currt );
		e_timegap( &start, &currt, &gapt );
		gapmsec = gapt.sec * 1000 + gapt.micro / 1000;
		if( gapmsec > waitmsec)
			return(-1);	/*ERR*/
		else
			e_sleep0001( 5 );	/* usleep(5000) in BSD */
	}

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* check record size overflow */
	if( datalen > fhead.recsize )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* check overflow */
	if(++fhead.quelen > fhead.maxrecno)
	{
		f_unlock(fd);
		return(-4);	/*FULL*/
	}

	/* new record queueing */
	if( ++fhead.tail >= fhead.maxrecno )
		fhead.tail = 0;
	if( fhead.head < 0 )
		fhead.head = 0;

	offset = (long)sizeof(fhead) + (long)fhead.tail *
		( (long)fhead.recsize + sizeof(int) );
	lseek( fd, offset, SEEK_SET );
	if( write( fd, &datalen, sizeof( int ) ) != sizeof( int ) )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}
	if( write( fd, recdata, datalen ) != datalen )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* change header value(tail) */
	lseek( fd, 0L, SEEK_SET );
	if( write( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* unlock file */
	f_unlock(fd);
	return( datalen );      /*OK*/
}

/* rf_get() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get oldest record from FIFO without remove			*/
/*----------------------------------------------------------------------*/
/*
	return	: >0(length of record(data)), -3(EMPTY), -1(ERR)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_get ( int fd, char *recdata )
#else
rf_get ( fd, recdata )
int	fd;
char	*recdata;
#endif
{
	struct	RF_HEADINFO	fhead;
	int	datalen;       /* actual data record length read */
	long	offset;

	if( recdata == (char *)0 )
		return( -1 );

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		return(-1); /*ERR*/

	/* check EMPTY */
	if( fhead.quelen <= 0 )
		return(-3);	/*EMPTY*/

	/* read oldest record datalen */
	offset = (long)sizeof(fhead) + (long)fhead.head *
		( (long)fhead.recsize + sizeof(int) );
	lseek( fd, offset, SEEK_SET );
	if( read( fd, &datalen, sizeof( int ) ) < sizeof( int ) )
		return(-1);		/*ERR*/

	/* get data */
	if( read( fd, recdata, datalen ) < datalen )
		return(-1);		/*ERR*/

	/* return actual record datalen */
	return(datalen);
}

/* rf_getinfo() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get fifo file info						*/
/*----------------------------------------------------------------------*/
/*
	return	: 0/-1
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_getinfo ( int fd, int *recsize, int *maxrecno, int *quelen )
#else
rf_getinfo ( fd, recsize, maxrecno, quelen )
int	fd;
int	*recsize;
int	*maxrecno;
int	*quelen;
#endif
{
	struct	RF_HEADINFO	fhead;

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		return(-1);		/*ERR*/

	if( recsize != (int *)0 )
		*recsize = fhead.recsize;
	if( maxrecno != (int *)0 )
		*maxrecno = fhead.maxrecno;
	if( quelen != (int *)0 )
		*quelen = fhead.quelen;

	return(0);
}

/* rf_delete() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : delete oldest record from FIFO				*/
/*----------------------------------------------------------------------*/
/*
	return	: 0(OK), -1(ERR), -3(EMPTY)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_delete( int fd, int waitmsec )
#else
rf_delete( fd, waitmsec )
int	fd;
int	waitmsec;
#endif
{
	E_TIMESEC		start, currt, gapt;
	struct	RF_HEADINFO	fhead;
	int			gapmsec;

	/* file locking for exclusive use only */
	/* If can't access until waitmsec elapsed return fail*/
	for( e_gettime( &start ); f_lock(fd) < 0; )
	{
		e_gettime( &currt );
		e_timegap( &start, &currt, &gapt );
		gapmsec = gapt.sec * 1000 + gapt.micro / 1000;
		if( gapmsec > waitmsec)
			return(-1);		/*ERR*/
		else
			e_sleep0001( 5 );	/* usleep(5000) in BSD */
	}

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if(read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* check underflow */
	if( --fhead.quelen < 0 )
	{
		f_unlock(fd);
		return(-3);	/*EMPTY*/
	}

	/* change header value(header) */
	if(fhead.quelen == 0)
		fhead.head = fhead.tail = -1;
	else if( ++fhead.head >= fhead.maxrecno )
		fhead.head = 0;

	lseek( fd, 0L, SEEK_SET );
	if( write( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);	/*ERR*/
	}

	/* unlock file */
	f_unlock(fd);
	return(0);	/*OK*/
}

/* rf_read() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : read & delete oldest record from FIFO 			*/
/*----------------------------------------------------------------------*/
/*
	return	: >0(length of data), -3(EMPTY), -1(ERR)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_read( int fd, char *recdata, int waitmsec )
#else
rf_read( fd, recdata, waitmsec )
int	fd;
char	*recdata;
int	waitmsec;
#endif
{
	struct	RF_HEADINFO	fhead;
	E_TIMESEC		start, currt, gapt;
	int			gapmsec;
	int			datalen;	/* actual data record length */
	long			offset;

	if( recdata == (char *)0 )
		return( -1 );

	/* file locking for exclusive use only */
	/* If can't access until waitmsec elapsed return fail*/
	for( e_gettime( &start ); f_lock(fd) < 0; )
	{
		e_gettime( &currt );
		e_timegap( &start, &currt, &gapt );
		gapmsec = gapt.sec * 1000 + gapt.micro / 1000;
		if( gapmsec > waitmsec)
			return(-1);		/*ERR*/
		else
			e_sleep0001( 5 );	/* usleep(5000) in BSD */
	}

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read(fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);		/*ERR*/
	}

	/* check underflow */
	if( --fhead.quelen < 0 )
	{
		f_unlock(fd);
		return(-3);		/*EMPTY*/
	}

	/* get oldest record */
	offset = (long)sizeof(fhead) + (long)fhead.head *
		( (long)fhead.recsize + sizeof(int) );
	lseek( fd, offset, SEEK_SET );
	if( read(fd, &datalen, sizeof( int ) ) != sizeof( int ) )
	{
		f_unlock(fd);
		return(-1);		/*ERR*/
	}
	if( read( fd, recdata, datalen ) < datalen )
	{
		f_unlock(fd);
		return(-1);		/*ERR*/
	}

	/* change header value(header) */
	if( fhead.quelen == 0 )
		fhead.head = fhead.tail = -1;
	else if( ++fhead.head >= fhead.maxrecno )
		fhead.head = 0;

	lseek( fd, 0L, SEEK_SET );
	if( write( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
	{
		f_unlock(fd);
		return(-1);		/*ERR*/
	}

	/* unlock file */
	f_unlock(fd);

	/* return actual record datalen */
	return( datalen );
}

/* rf_getd() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get directly n( or -n )-th fifo data				*/
/*----------------------------------------------------------------------*/
/*	recno	: 1 (1st oldest)
		  2 (2nd oldest)
		  n (nth oldest)
		 -1 (1st newest)
		 -2 (2nd newest)
		 -n (nth newest)

	return	: 0 (empty. no more n(-n)-th fifo data)
		 >0 (actual data record length read)
		 -1 (error)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_getd( int fd, int recno, char *recdata )
#else
rf_getd( fd, recno, recdata )
int	fd;
int	recno;
char	*recdata;
#endif
{
	if( recno > 0 )
		return( rf_getold( fd, recno, recdata ) );
	else if( recno < 0 )
		return( rf_getnew( fd, -recno, recdata ) );
	else	return( -1 );
}

/* rf_getold() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get directly n-th oldest fifo data				*/
/*----------------------------------------------------------------------*/
/*	recno	: 1 (1st oldest)
		  2 (2nd oldest)
		  n (nth oldest)

	return	: 0 (empty. no n-th oldest fifo data)
		 >0 (actual data record length read)
		 -1 (error)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_getold( int fd, int recno, char *recdata )
#else
rf_getold( fd, recno, recdata )
int	fd;
int	recno;
char	*recdata;
#endif
{
	struct	RF_HEADINFO	fhead;
	int	datalen;       /* actual data record length read */
	long	offset;
	int	i;

	if( recdata == (char *)0 )
		return( -1 );

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		return(-1); /*ERR*/

	/* skip n-1 records */
	for( i=1; i<recno; i++ )
	{
		/* check EMPTY */
		if(--fhead.quelen < 0 )
			return(-3);	/*EMPTY*/

		/* change header value(header) */
		if(fhead.quelen == 0)
			fhead.head = fhead.tail = -1;
		else if( ++fhead.head >= fhead.maxrecno )
			fhead.head = 0;
	}

	/* check EMPTY */
	if(--fhead.quelen < 0)
		return(-3);	/*EMPTY*/

	/* read oldest record datalen */
	offset = (long)sizeof(fhead) + (long)fhead.head *
		( (long)fhead.recsize + sizeof(int) );
	lseek( fd, offset, SEEK_SET );
	if( read( fd, &datalen, sizeof( int ) ) < sizeof( int ) )
		return(-1);		/*ERR*/

	/* get data */
	if( read( fd, recdata, datalen ) < datalen )
		return(-1);		/*ERR*/

	/* return actual record datalen */
	return(datalen);
}

/* rf_getnew() : LIB gps */
/*----------------------------------------------------------------------*/
/* FUNC : get directly n-th newest fifo data				*/
/*----------------------------------------------------------------------*/
/*	recno	: 1 (1st newest)
		  2 (2nd newest)
		  n (nth newest)

	return	: 0 (empty. no n-th newest fifo data)
		 >0 (actual data record length read)
		 -1 (error)
*/
int CBD1
#if	defined( __CB_STDC__ )
rf_getnew( int fd, int recno, char *recdata )
#else
rf_getnew( fd, recno, recdata )
int	fd;
int	recno;
char	*recdata;
#endif
{
	struct	RF_HEADINFO	fhead;
	int	datalen;       /* actual data record length read */
	long	offset;
	int	i;

	if( recdata == (char *)0 )
		return( -1 );

	/* load header information */
	lseek( fd, 0L, SEEK_SET );
	if( read( fd, &fhead, sizeof( fhead ) ) < sizeof( fhead ) )
		return(-1);		/*ERR*/

	/* skip n-1 records */
	for( i=1; i<recno; i++ )
	{
		/* check EMPTY */
		if( --fhead.quelen < 0 )
			return(-3);	/*EMPTY*/

		/* change tail value */
		if( fhead.quelen == 0 )
			fhead.head = fhead.tail = -1;
		else if( --fhead.tail < 0 )
			fhead.tail = fhead.maxrecno - 1;
	}

	/* check EMPTY */
	if( --fhead.quelen < 0 )
		return(-3);	/*EMPTY*/

	/* read newest record datalen */
	offset = (long)sizeof(fhead) + (long)fhead.tail *
		( (long)fhead.recsize + sizeof(int) );
	lseek( fd, offset, SEEK_SET );
	if( read( fd, &datalen, sizeof( int ) ) < sizeof( int ) )
		return(-1);		/*ERR*/

	/* get data */
	if( read( fd, recdata, datalen ) < datalen )
		return(-1);		/*ERR*/

	/* return actual record datalen */
	return(datalen);
}
