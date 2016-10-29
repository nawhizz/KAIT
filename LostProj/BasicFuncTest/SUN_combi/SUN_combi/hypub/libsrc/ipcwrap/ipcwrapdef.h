/*#define	TERMINAL_SERVICE*/
#ifndef	__IPCWRAPDEF_H__
#define	__IPCWRAPDEF_H__
#include <stdio.h>
#include <errno.h>
#include "ipcwrap.h"

#define	SNO_SHMGET	1
#define	SNO_SHMCTL	2
#define	SNO_SEMGET	3
#define	SNO_SEMCTL	4
#define	SNO_OK		5
#define	SNO_ERROR	6

#define	SEMSTR	"SEM"		/*"%d%s%02d%d", 
				semnum, SEMSTR, semid, semt[semid].key */
#define	SHMSTR	"SHM"		/*"%s%02d%d", 
				SHMSTR, shmid, shmt[shmid].key */

#define SHMIPCMUTEX	"SHMIPCMUTEX"
#define SEMIPCMUTEX	"SEMIPCMUTEX"
#define SHMPINFOMUTEX	"SHMPINFOMUTEX"
#define SEMPINFOMUTEX	"SEMPINFOMUTEX"

#define MakeSemstr(a, b, c, d) \
			sprintf(a, "%dSEM%03d%d", b, c, d); /*2001.1.9 02->03*/
#define MakeShmstr(a, b, c) \
			sprintf(a, "SHM%03d%d", b, c);	/*2001.1.9 02->03*/
#ifdef	TERMINAL_SERVICE
#define MakeGlobalSemstr(a, b, c, d)	sprintf(a, "Global\\%dSEM%03d%d", b, c, d)
#define MakeGlobalShmstr(a, b, c) 	sprintf(a, "Global\\SHM%03d%d", b, c)
#endif	/* TERMINAL_SERVICE */

#define	MAXKEYVAL	0x7fffffff
#define	MAXSTRLEN	16	/* maxumum sem(shm)str len */
/* 980916 requested by SJW */
#define	MAXNOOFIPC	256	/* max. # of SEMT, SHMT */
#define	MAXNOOFPROC	256	/* max. # of concurrent process. 2001.1.9 */

#define	OPT_SEM		0
#define	OPT_SHM		1

typedef struct tagsem {
	key_t	key;
	DWORD	procid;
	HANDLE	hsem[MAXNSEM];
	struct	semid_ds	semds;
} SEMT;

typedef struct tagshm {
	key_t	key;
	DWORD	procid;
	HANDLE	hfile;
	HANDLE	hshm;
	struct	shmid_ds	shmds;
} SHMT;

typedef struct tagpsem {
	DWORD	procid;
	short	semadj[MAXNOOFIPC][MAXNSEM];
	int	semid[MAXNOOFIPC];
} PSEMINFO;

typedef struct tagpshm {
	DWORD	procid;
	HANDLE	hshm[MAXNOOFIPC];
	void	*shmaddr[MAXNOOFIPC];
} PSHMINFO;

union	semun {
	int		val;
	struct semid_ds	*buf;
	ushort		*array;
};

/* add by KJC 98.09.24 **********************************/
struct sem_internal {
	long		semval;		/* semaphore value */
	pid_t		sempid;		/* pid of last operation */
	ushort_t	semncnt;	/* # awaiting semval > cval */
	ushort_t	semzcnt;	/* # awaiting semval = 0 */
	ushort_t	semncnt_cv;
	ushort_t	semzcnt_cv;
};
/*********************************************************/

typedef struct tagipctable {
/* by KJC 98.09.24 *************************************
	struct	sem	semb[MAXNOOFIPC][MAXNSEM];
*******************************************************/
	struct	sem_internal	semb[MAXNOOFIPC][MAXNSEM];
/******************************************************/
	SEMT		semt[MAXNOOFIPC];
	SHMT		shmt[MAXNOOFIPC];
	PSEMINFO	pseminfo[MAXNOOFPROC]; /*2001.1.9. MAXNOOFIPC->MAXNOOFPROC*/
	PSHMINFO	pshminfo[MAXNOOFPROC]; /*2001.1.9. MAXNOOFIPC->MAXNOOFPROC*/
} IPCT;

typedef	struct scbuftag {
	int	cmd;
	int	data;
} SCBUF;

/* Fuction Prototyes */
int	InitSEMT(int semid, IPCT *);
int	GetEmptySEMT(IPCT *);
int	FindSEMT(key_t key, IPCT *);
int	InitSHMT(int shmid, IPCT *);
int	GetEmptySHMT(IPCT *);
int	FindSHMT(key_t key, IPCT *);
int	GetEmptyPINFO(int opt, IPCT *);
int	FindPINFO(int opt, DWORD procid, IPCT *);
int	InitPINFO(int opt, int piid, IPCT *);
//int	StartIPCD();
//int	l_peekmessage(void);
int	GetIPCT(HANDLE *, IPCT **);
void	FreeIPCT(HANDLE , IPCT *);
BOOL	IsProcessForSem(int semid, IPCT *);
BOOL	IsProcessForShm(int shmid, IPCT *);
extern	int	l_ipclog( char *fmt, ... );


#endif	/* __IPCWRAPDEF_H__ */