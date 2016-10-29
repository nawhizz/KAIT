#include <stdio.h>
#include <errno.h>
#include <string.h>
#include "ipcwrap.h"

void errhandler();
void usage();

/*============================================================================================*/

int main(int argc, char *argv[])
{
	int i;
	char ch, arg;
	int idkey, id; 
	
	if ((argc < 3) || (argv[1][0] != '-'))
	{
		usage();
		return 1;
	}
	
	for ( i = 1; i < argc; i++)
	{
		ch = argv[i][0];
		if (ch == '-')
		{
			arg = argv[i][1];
			if (!((arg=='m')||(arg=='s')||(arg=='M')||(arg=='S')))
			{
				usage();
				return 1;
			}
		}
		else
		{
			if ((ch < '0') || (ch > '9'))
			{
				usage();
				return 1;
			}
			idkey = atoi(argv[i]);
			switch(arg)
			{
			case 'm':
				if (shmctl(idkey, IPC_RMID, NULL) < 0)
				{	
					errhandler();
					return 1;
				}
				printf("Shared Memory(ID=%d) Removed Successfully!!\n", idkey);
				break;
			case 's':
				if (semctl(idkey, 0, IPC_RMID) < 0)
				{
					errhandler();
					return 1;
				}
				printf("Semaphore(ID=%d) Removed Successfully!!\n", idkey);
				break;
			case 'M':
				if ( idkey == 0 )
				{	
					printf("The Key can't be Zero!!\n");
					return 1;
				}
				if ((id = getshmid(idkey)) < 0)
				{
					printf("Error in getting Shared Memory ID.\n");
					return 1;
				}
				if (shmctl(id, IPC_RMID, NULL) < 0)
				{	
					errhandler();
					return 1;
				}
				printf("Shared Memory(Key=%d) Removed Successfully!!\n", idkey); 
				break;
			case 'S':				
				if (idkey == 0)
				{
					printf("The key can't  be Zero!!\n");
					return 1;
				}
				if ((id = getsemid(idkey)) < 0)
				{
					printf("Error in getting Semaphore ID.\n");
					return 1;
				}
				if (semctl( id, 0, IPC_RMID) < 0)
				{
					errhandler();
					return 1;
				}
				printf("Semaphore(Key=%d) Removed Successfully!!\n", idkey);
				break;
			}
		}	
	}
	return 0;
}

/*============================================================================================*/

void usage()
{
	printf("SYNOPSIS :\n");
	printf("	ipcrm [ -m shmid ] [ -s semid ] [ -M shmkey ] [-S semkey ]\n");
}

/*============================================================================================*/

void errhandler()
{
	switch(errno)
	{
	case EACCES:
		printf("Error!! Operation permission is denied to the calling process.\n");
		break;
	case EINVAL:
		printf("Error!! (semid or shmid) is not a valid semaphore ID\n");
		break; 
	case EPERM:
		printf("Error!! Effective user of this process is not super-user,\n");
		break;
	default:
		printf("Error! Error Number = %d\n", errno);
		break;
	}
}