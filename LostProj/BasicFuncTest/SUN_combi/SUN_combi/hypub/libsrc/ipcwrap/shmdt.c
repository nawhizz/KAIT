#include <time.h>
#include "ipcwrapdef.h"

/*
extern SHMT		shmt[];
extern PSHMINFO		pshminfo[];
*/

int CBD1
shmdt(const void *shmaddr)
{
	int	shmid;
	int	piid;
	DWORD	procid;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

//	if (StartIPCD()<0)
//	{
//		errno=EFAULT;
//		return -1;
//	}

	if (shmaddr==NULL)
	{
		l_ipclog( "[shmdt] shmaddr = NULL\n");
		errno=EINVAL;
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		l_ipclog( "[shmdt] GetIPCT error\n");
		errno=EFAULT;
		return -1;
	}
	else
		l_ipclog( "[shmdt] GetIPCT Succeed\n");

	procid=GetCurrentProcessId();
	piid=FindPINFO(OPT_SHM, procid, ipct);
	if (piid<0)
	{
		l_ipclog( "[shmdt] FindPINFO error procid = [%d], piid = [%d]\n", procid, piid);
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}
	else
		l_ipclog( "[shmdt] FindPINFO Succeed\n");

	for (shmid=0; shmid<MAXNOOFIPC; shmid++)
	{
		if (ipct->pshminfo[piid].shmaddr[shmid]==shmaddr)
			break;
	}

	if (shmid >= MAXNOOFIPC)
	{
		l_ipclog( "[shmdt] error shmid(%d) >= MAXNOOFIPC(%d)\n", shmid, MAXNOOFIPC);
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

//printf("shmdt()		shmid =[%d], shmaddr = [%x]\n", shmid, shmaddr);
	UnmapViewOfFile(shmaddr);
	CloseHandle(ipct->pshminfo[piid].hshm[shmid]);

l_ipclog( "[shmat] before detach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
printf( "[shmat] before detach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
	ipct->shmt[shmid].shmds.shm_nattch--;
l_ipclog( "[shmat] after detach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
printf( "[shmat] after detach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
	time(&ipct->shmt[shmid].shmds.shm_dtime);
	time(&ipct->shmt[shmid].shmds.shm_ctime);

	ipct->pshminfo[piid].hshm[shmid]=NULL;
	ipct->pshminfo[piid].shmaddr[shmid]=NULL;
	InitPINFO(OPT_SHM, piid, ipct);

	FreeIPCT(hIpct, ipct);
	return 0;
}
