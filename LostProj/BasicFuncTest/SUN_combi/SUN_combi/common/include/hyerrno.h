/* hyerrno.h */
/*----------------------------------------------------------------------*/
/* HEADER for ERROR NUMBER						*/
/*----------------------------------------------------------------------*/
#ifndef HYERRNO_H
#define HYERRNO_H

#ifndef _HYERRNO
#define _HYERRNO
extern	int	hyerrno;	/* error number variable */
#endif	/* _HYERRNO */

/*----------------------------------------------------------------------*/
/* ERROR NUMBER 							*/
/*----------------------------------------------------------------------*/
/*

hyerrno range	#define state	MODULE			define header
-----------------------------------------------------------------------
10000-10999	EUS_xxxxx	UNTS SERVER 		unsvreno.h	
30000-30199	EGP_xxxxx	LIBGPS ( libgps.a )	gps.h

*/

#endif	/* HYERRNO_H */

/*----------------------------------------------------------------------*/
/* end of hyerrno.h */
