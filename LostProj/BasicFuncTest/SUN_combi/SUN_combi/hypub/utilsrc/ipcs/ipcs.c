#include <time.h>
#include <stdio.h>
#include <string.h>
#include "ipcwrap.h"
#include <errno.h>

void usage()
{
	printf("SYNOPSIS : ipcs [ -abmost]\n");
}

#define MAXNOOFIPC	256
#define	SHMINFO		1
#define	SEMINFO		2

#define BIGGEST		1
#define CREATOR		2  //after add CREATOR option, add the option -c to the function 'usage()'
#define OUTSTANDING	4
#define PID		8
#define TIME		16

int main(int argc, char *argv[])
{
	int display = SHMINFO | SEMINFO;
	int option = 0;
	unsigned int i = 0;
	int j = 0;
	char ch;
	
	int shmid, semid;
	int pshmid;
	int psemid;
	struct shmid_ds shmbuf;
	struct semid_ds sembuf;
	union semun {
			int	val;
			struct semid_ds *buf;
			ushort	*array;
	} semarg;

	semarg.buf = &sembuf;
	
	while(++j < argc)
	{
		if ( (argv[j][0] != '-') && (strlen(argv[j]) < 2) )
		{
			usage();
			return 1;
		}
		i = 0;
		while( ++i < strlen(argv[j]))
		{
			ch = argv[j][i];
			switch(ch)
			{
			case 'm':
				display = SHMINFO;
				break;
			case 's':
				display = SEMINFO;
				break;
			case 'a':
				option = BIGGEST | CREATOR | OUTSTANDING | PID | TIME;
				break;
			case 'b':
				option |= BIGGEST;
				break;
			case 'c':
				option |= CREATOR;
				break;
			case 'o':
				option |= OUTSTANDING;
				break;
			case 'p':
				option |= PID;
				break;
			case 't':
				option |= TIME;
				break;
			case '?':
				usage();
				return 1;
			default:
				usage();
				return 1;
			}
			continue;
		}
	}

	if (display & SHMINFO)
	{	
		printf("SHARED MEMORY:\n");
		printf("T     ID");
//		if (option & CREATOR)
//			printf("  CREATOR   CGROUP");
		if (option & OUTSTANDING)
			printf(" NATTCH");
		if (option & BIGGEST)
			printf("  SEGSZ");
		if (option & PID)
			printf("   CPID   LPID");
		if (option & TIME)
			printf(" ATIME    DTIME    CTIME");
		printf("\n");
		
		pshmid = -1;
		for( ; ; )
		{
			if ((shmid = getshmid(pshmid)) < 0)
				break;
		
			if (shmctl(shmid, IPC_STAT, &shmbuf) < 0)
			{
				printf("Error!! errno = %d\n", errno);	
				break;
			}
			pshmid = shmid;
				
			printf("m %6d ",shmid);
//			if (option & CREATOR)
//				printf("");  
			if (option & OUTSTANDING)
				printf("%6d ", shmbuf.shm_nattch);
			if (option & BIGGEST)
				printf("%6d ", shmbuf.shm_segsz);
			if (option & PID)
				printf("%6d %6d ", shmbuf.shm_cpid, shmbuf.shm_lpid);
			if (option & TIME)
			{
				time_t currenttime;
				struct tm *tmshm;

				time(&currenttime);

				if (shmbuf.shm_atime !=0 )
				{
					tmshm = localtime(&shmbuf.shm_atime);
					if ((currenttime - shmbuf.shm_atime) >= 86400 )	
						printf("%02d/%02d/%02d ",
							tmshm->tm_year % 100,
							tmshm->tm_mon + 1,
							tmshm->tm_mday);
					else
						printf("%02d:%02d:%02d ",
							tmshm->tm_hour,
							tmshm->tm_min,
							tmshm->tm_sec);
				}
				else
					printf("         ");
				if (shmbuf.shm_dtime !=0 )
				{
					tmshm = localtime(&shmbuf.shm_dtime);
					if ((currenttime - shmbuf.shm_dtime) >= 86400 )	
						printf("%02d/%02d/%02d ",
							tmshm->tm_year % 100,
							tmshm->tm_mon + 1,
							tmshm->tm_mday);
					
					else
						printf("%02d:%02d:%02d ",
							tmshm->tm_hour,
							tmshm->tm_min,
							tmshm->tm_sec);
				}
				else
					printf("         ");
				if (shmbuf.shm_ctime != 0)
				{
					tmshm = localtime(&shmbuf.shm_ctime);
					if ((currenttime - shmbuf.shm_ctime) >= 86400 )
						printf("%02d/%02d/%02d ",
							tmshm->tm_year % 100,
							tmshm->tm_mon + 1,
							tmshm->tm_mday);
					
					else
						printf("%02d:%02d:%02d ",
							tmshm->tm_hour,
							tmshm->tm_min,
							tmshm->tm_sec);
				}
			}	
			printf("\n");
		}
	}
	
	if (display & SEMINFO)
	{
		printf("\nSEMAPHORES:\n");
		printf("T     ID");
//		if (option & CREATOR)
//			printf("  CREATOR   CGROUP");
		if (option & BIGGEST)
			printf("  NSEMS");
		if (option & TIME)
			printf("  OTIME    CTIME");
		printf("\n");
		
		psemid = -1;
		for( ; ; )
		{
			if ((semid = getsemid(psemid)) < 0)
				break;
		
			if (semctl(semid, 0, IPC_STAT, semarg) < 0)
			{
				printf("Error!! errno = %d\n", errno);
				break;
			}
			psemid = semid;

			printf("s %6d ",semid);
//			if (option & CREATOR)
//				printf("");  
			if (option & BIGGEST)
				printf("%6d ",semarg.buf->sem_nsems);
//			if (option & PID)
//				printf("");
			if (option & TIME)
			{
				struct tm *tmsem;
				time_t currenttime2;

				time(&currenttime2);
				
				if (semarg.buf->sem_otime != 0)
				{
					tmsem = localtime(&(semarg.buf->sem_otime));
					if ((currenttime2 - semarg.buf->sem_otime) >= 86400 )
						printf("%02d/%02d/%02d ",
							tmsem->tm_year % 100,
							tmsem->tm_mon + 1,
							tmsem->tm_mday);

					else
						printf("%02d:%02d:%02d ",
							tmsem->tm_hour,
							tmsem->tm_min,
							tmsem->tm_sec);
				}
				else
					printf("         ");
				
				if (semarg.buf->sem_ctime != 0)
				{
					tmsem = localtime(&(semarg.buf->sem_ctime));
					if ((currenttime2 - semarg.buf->sem_ctime) >= 86400 )
						printf("%02d/%02d/%02d ",
							tmsem->tm_year % 100,
							tmsem->tm_mon + 1,
							tmsem->tm_mday);
					
					else
						printf("%02d:%02d:%02d ",
							tmsem->tm_hour,
							tmsem->tm_min,
							tmsem->tm_sec);
				}
			}
			printf("\n");
		}
	}
	return 0;
}