/* gpsdef.h */
/*----------------------------------------------------------------------*/
/* Internal HEADER for GPSLIB						*/
/*----------------------------------------------------------------------*/
#ifndef GPSDEF_H
#define GPSDEF_H

#define	MAXMSGCNT	5
#define	MAXMSGBUF	256

/*	98.09.16 for MultiThread by JJH ( ADD Start )	*/
#ifdef	WIN32
struct	GPS_GLOBAL_DATA
{
	int	g_hyerrno;
	int	g_msgidx;
	char	g_msgbuf[5][256];
};
#endif
/*	98.09.16 for MultiThread by JJH ( ADD End )	*/

#endif

/*----------------------------------------------------------------------*/
/* end of gpsdef.h */
