#ifndef	__IPCWRAP_H__
#define	__IPCWRAP_H__

#include <io.h>
#include "cbuni.h"

#define	MAXNSEM		8		/* maximum # of nsem */

typedef	int	key_t;			/* IPC keytype	*/
typedef	DWORD	pid_t;			/* Process ID	*/
typedef unsigned short	ushort;
typedef unsigned short	ushort_t;
typedef	unsigned long	ulong;

/* Common IPC Definitions. */
/* Mode bits. */
#define	IPC_ALLOC	0100000		/* entry currently allocated */
#define	IPC_CREAT	0001000		/* create entry if key doesn't exist */
#define	IPC_EXCL	0002000		/* fail if key exists */
#define	IPC_NOWAIT	0004000		/* error if request must wait */

/* Keys. */
#define IPC_PRIVATE     (key_t)0        /* private key */

/* Control Commands. */
#define	IPC_RMID	10		/* remove identifier */
#define	IPC_SET		11		/* set options */
#define	IPC_STAT	12		/* get options */
/*
 * Permission Definitions.
 */

#define	SEM_A	0200		/* alter permission */
#define	SEM_R	0400		/* read permission */

/*
 * Semaphore Operation Flags.
 */

#define	SEM_UNDO	010000	/* set up adjust on exit entry */

/*
 * Semctl Command Definitions.
 */

#define	GETNCNT	3	/* get semncnt */
#define	GETPID	4	/* get sempid */
#define	GETVAL	5	/* get semval */
#define	GETALL	6	/* get all semval's */
#define	GETZCNT	7	/* get semzcnt */
#define	SETVAL	8	/* set semval */
#define	SETALL	9	/* set all semval's */
/*
 *Permission Definitions.
 */
#define	SHM_R	0400	/* read permission */
#define	SHM_W	0200	/* write permission */

/*
 *Message Operation Flags.
 */
#define	SHM_RDONLY	010000	/* attach read-only (else read-write) */
#define SHM_RND		020000	/* round attach address to SHMLBA */
#define	SHM_SHARE_MMU	040000	/* share VM resources such as page table */

struct sembuf {
	ushort_t	sem_num;	/* semaphore # */
	short		sem_op;		/* semaphore operation */
	short		sem_flg;	/* operation flags */
};

struct sem {
	ushort_t	semval;		/* semaphore value */
	pid_t		sempid;		/* pid of last operation */
	ushort_t	semncnt;	/* # awaiting semval > cval */
	ushort_t	semzcnt;	/* # awaiting semval = 0 */
	ushort_t	semncnt_cv;
	ushort_t	semzcnt_cv;
};

struct semid_ds {
/*	struct ipc_perm	sem_perm;	 operation permission struct */
	struct sem	*sem_base;	/* ptr to first semaphore in set */
	ushort_t	sem_nsems;	/* # of semaphores in set */
	time_t		sem_otime;	/* last semop time */
	time_t		sem_ctime;	/* last change time */
	long		sem_binary;	/* flag indicating semaphore type */
};

struct shmid_ds {
/*	struct ipc_perm	shm_perm;	 operation permission struct */
	size_t		shm_segsz;	/* size of segment in bytes */
	ushort_t	shm_lkcnt;	/* number of times it is being locked */
	pid_t		shm_lpid;	/* pid of last shmop */
	pid_t		shm_cpid;	/* pid of creator */
	ulong		shm_nattch;	/* used only for shminfo */
	ulong		shm_cnattch;	/* used only for shminfo */
	time_t		shm_atime;	/* last shmat time */
	time_t		shm_dtime;	/* last shmdt time */
	time_t		shm_ctime;	/* last change time */
};


#ifdef	__cplusplus
extern "C" {
#endif

int CBD1	semget(key_t key, int nsems, int flag);
int CBD1	semctl(int semid, int semnum, int cmd, ...);
int CBD1	semop(int semid, struct sembuf semoparray[], size_t nsops);
int CBD1	semopx(int semid, struct sembuf *semoparray, 
					HANDLE hevent, int timeoutsec);
int CBD1	shmget(key_t key, size_t size, int flag);
int CBD1	shmctl(int shmid, int cmd, struct shmid_ds *buf);
void * CBD1	shmat(int shmid, const void *shmaddr, int shmflg);
int CBD1	shmdt(const void *shmaddr);
key_t CBD1	ftok(const char *path, int id);
int CBD1	getshmid(int pshmid);
int CBD1	getsemid(int pshmid);

#ifdef	__cplusplus
}
#endif

#endif	/* __IPCWRAP_H__ */