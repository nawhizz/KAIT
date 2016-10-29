/* DATE Function's common header */
/* Included internally within LIB */

#ifndef	E_DATE_H
#define	E_DATE_H

/*----------------------------------------------------------------------*/
/* internal structure define						*/
/*----------------------------------------------------------------------*/
typedef struct {
	char	year[5];	/* save year */
	char	month[3];	/* save month */
	char	day[3]; 	/* save day */
	char	dummy[1];	/* for alignment */
	int	iyear;		/* int. year */
	int	imonth; 	/* int. month */
	int	iday;		/* int. day */
	int	lastday[12];	/* last days of all months */
} E_DATEINFO;

#endif
