#include <time.h>
#include "ipcwrapdef.h"

/*
extern struct sem	semb[][MAXNSEM];
extern SEMT		semt[];
extern PSEMINFO		pseminfo[];
*/
//extern HWND	hdwnd;

int CBD1 
semget(key_t key, int nsems, int semflag)
{
	int	i, j;
	int	semid;
	int	piid;
	DWORD	procid;
	BOOL	lret;
	LPTSTR	lpszPipeName = "\\\\.\\pipe\\ipcd";
	SCBUF	scIn, scOut;
	DWORD	bytesRead;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

//	StartIPCD();
	if (key<0 || key>MAXKEYVAL 
		|| nsems<0 || nsems>MAXNSEM)
	{
		errno=EINVAL;
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		l_ipclog( "[semget] GetIPCT error\n");
		errno=EFAULT;
		return -1;
	}

	procid=GetCurrentProcessId();

	piid=FindPINFO(OPT_SEM, procid, ipct);
	if (piid<0)
	{
		piid=GetEmptyPINFO(OPT_SEM, ipct);
		if (piid<0)
		{
			l_ipclog( "[semget] GetEmptyPINFO error, procid=[%d]\n", procid);
			errno=ENOSPC;
			FreeIPCT(hIpct, ipct);
			return -1;
		}
	}

	if (key!=IPC_PRIVATE)
	{
		semid=FindSEMT(key, ipct);
		if (semid>=0)
		{
			if (semflag & IPC_CREAT)
			{
				if (IsProcessForSem(semid, ipct))
				{
					l_ipclog( "[semget] IsProcessForSem error, semid=[%d]\n", semid);
					errno=EEXIST;
					FreeIPCT(hIpct, ipct);
					return -1;
				}
				if( InitSEMT(semid, ipct) < 0 )
				{
					l_ipclog( "[semget] InitSEMT error, semid=[%d]\n", semid);
					FreeIPCT(hIpct, ipct);	/* 2001.1.10.	JUNG	*/
					return -1;
				}
	
				for (i=0; i<MAXNOOFIPC; i++)
				{
					for (j=0; j<MAXNSEM; j++)
						ipct->pseminfo[i].semadj[semid][j]=0;
					ipct->pseminfo[i].semid[semid]=0;
				}
			}
			else
			{
				if (nsems>ipct->semt[semid].semds.sem_nsems 
					&& nsems!=0 )
				{
					l_ipclog( "[semget] error, semid=[%d], nsems=[%d]\n", semid, nsems);
					errno=EINVAL;
					FreeIPCT(hIpct, ipct);
					return -1;
				}

				ipct->pseminfo[piid].procid=procid;
				ipct->pseminfo[piid].semid[semid]=1;
				FreeIPCT(hIpct, ipct);
				return semid;
			}
		}
	}

	if (nsems==0) 
	{
		l_ipclog( "[semget] error, nsems=0\n");
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	semid=GetEmptySEMT(ipct);
	if (semid<0) 
	{
		l_ipclog( "[semget] GetEmptySEMT error, semid=[%d]\n", semid);
		errno=ENOSPC;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	ipct->semt[semid].key=key;
	ipct->semt[semid].semds.sem_nsems=nsems;
	ipct->semt[semid].semds.sem_otime=0;
	time(&ipct->semt[semid].semds.sem_ctime);
	ipct->semt[semid].semds.sem_base=(struct sem *)&ipct->semb[semid][0];
	for (i=0; i<nsems; i++)
	{
//		semt[semid].hsem[i]=hsem[i];
		ipct->semb[semid][i].semval=0;
		ipct->semb[semid][i].sempid=procid;
		ipct->semb[semid][i].semncnt=0;
		ipct->semb[semid][i].semzcnt=0;
	}

	scIn.cmd=SNO_SEMGET;
	scIn.data=semid;

	lret = CallNamedPipe(lpszPipeName,
		 (char *)&scIn, sizeof(scIn),
		 (char *)&scOut, sizeof(scOut),
		 &bytesRead, NMPWAIT_WAIT_FOREVER);

	if (lret==FALSE) 
	{
		errno=GetLastError();
		l_ipclog( "[semget] CallNamedPipe error, errno=[%d]\n", errno);
		ipct->semt[semid].key=-1;
		ipct->semt[semid].semds.sem_nsems=0;
		ipct->semt[semid].semds.sem_ctime=0;
		ipct->semt[semid].semds.sem_base=NULL;
		for (i=0; i<nsems; i++)
			ipct->semb[semid][i].sempid=0;

		FreeIPCT(hIpct, ipct);
		return -1;
	}

	if (scOut.cmd!=SNO_OK)
	{
		l_ipclog( "[semget] scOut.cmd!=SNO_OK\n");
		errno=scOut.data;
		ipct->semt[semid].key=-1;
		ipct->semt[semid].semds.sem_nsems=0;
		ipct->semt[semid].semds.sem_ctime=0;
		ipct->semt[semid].semds.sem_base=NULL;
		for (i=0; i<nsems; i++)
			ipct->semb[semid][i].sempid=0;

		FreeIPCT(hIpct, ipct);
		return -1;
	}

	ipct->pseminfo[piid].procid=procid;
	ipct->pseminfo[piid].semid[semid]=1;

	FreeIPCT(hIpct, ipct);
	return semid;
}