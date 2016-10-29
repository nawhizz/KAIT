/* convwin32.h */
/*----------------------------------------------------------------------*/
/* HEADER for CONVERSION WIN32						*/
/*----------------------------------------------------------------------*/
#ifndef CONVWIN32_H
#define CONVWIN32_H

/*-----	Redefine Variable ----------------------------------------------*/
#ifdef	WIN32
typedef	DWORD	pid_t;
typedef	int	key_t;
#endif

/*-----	Redefine Function ----------------------------------------------*/
#ifdef	WIN32
#define	getpid()	GetCurrentProcessId()
#else
#define	chsize(a,b)	ftruncate(a,(off_t)b)
#define	ExitProcess(a)	exit((int)a)
#endif

#endif
/*----------------------------------------------------------------------*/
/* end of convwin32.h */
