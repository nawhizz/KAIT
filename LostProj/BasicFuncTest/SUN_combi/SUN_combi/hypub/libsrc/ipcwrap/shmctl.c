#include "ipcwrapdef.h"


/*extern SHMT		shmt[];
extern PSHMINFO		pshminfo[];
*/
//extern HWND	hdwnd;

int CBD1	
shmctl(int shmid, int cmd, struct shmid_ds *buf)
{
	int	piid;
	DWORD	procid;
	BOOL	lret;
	LPTSTR	lpszPipeName = "\\\\.\\pipe\\ipcd";
	SCBUF	scIn, scOut;
	DWORD	bytesRead;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

//	if (StartIPCD()<0)
//	{
//		errno=EFAULT;
//		return -1;
//	}

	if (shmid<0 || shmid>=MAXNOOFIPC)
	{
		l_ipclog( "[shmctl] error shmid(%d)<0 || shmid(%d)>=MAXNOOFIPC(%d)\n", 
			shmid, shmid, MAXNOOFIPC);
		errno=EINVAL;                                                                                                                                                                                            
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		l_ipclog( "[shmctl] GetIPCT error\n");
		errno=EFAULT;
		return -1;
	}

/*2001.1.9
	if (ipct->shmt[shmid].key<0)
**************************************/
	if (ipct->shmt[shmid].key<=0)
	{
		procid=GetCurrentProcessId();
		piid=FindPINFO(OPT_SHM, procid, ipct);
		if (piid>=0)
		{
			ipct->pshminfo[piid].hshm[shmid]=NULL;
			ipct->pshminfo[piid].shmaddr[shmid]=NULL;
			InitPINFO(OPT_SHM, piid, ipct);
		}

		l_ipclog( "[shmctl] Error, ipct->shmt[shmid(%d)].key=[%d]\n", shmid, ipct->shmt[shmid].key);
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	/* #####PENDING  °¢ case º° coding...*/
	switch (cmd)
	{
	case	IPC_STAT:
		if (buf == NULL)
		{
			l_ipclog( "[shmctl] Error, IPC_STAT buf = NULL\n");
			errno=EFAULT;
			FreeIPCT(hIpct, ipct);
			return -1;
		}

		buf->shm_segsz=ipct->shmt[shmid].shmds.shm_segsz;
		buf->shm_lkcnt=ipct->shmt[shmid].shmds.shm_lkcnt;
		buf->shm_lpid=ipct->shmt[shmid].shmds.shm_lpid;
		buf->shm_cpid=ipct->shmt[shmid].shmds.shm_cpid;
		buf->shm_nattch=ipct->shmt[shmid].shmds.shm_nattch;
		buf->shm_cnattch=ipct->shmt[shmid].shmds.shm_cnattch;
		buf->shm_atime=ipct->shmt[shmid].shmds.shm_atime;
		buf->shm_dtime=ipct->shmt[shmid].shmds.shm_dtime;
		buf->shm_ctime=ipct->shmt[shmid].shmds.shm_ctime;
		FreeIPCT(hIpct, ipct);
		return 0;
	
	case	IPC_SET:
		FreeIPCT(hIpct, ipct);
		return 0;
	
	case	IPC_RMID:
//printf("shmctl()	RMID START !!!\n");		
		scIn.cmd=SNO_SHMCTL;
		scIn.data=shmid;

		lret = CallNamedPipe(lpszPipeName,
			 (char *)&scIn, sizeof(scIn),
			 (char *)&scOut, sizeof(scOut),
			 &bytesRead, NMPWAIT_WAIT_FOREVER);

		if (lret==FALSE) 
		{
			errno=GetLastError();
			l_ipclog( "[shmctl] CallNamedPipe error, shmid=[%d], errno=[%d]\n", shmid, errno);
			FreeIPCT(hIpct, ipct);
			return -1;
		}
		if (scOut.cmd!=SNO_OK)
		{
			errno=scOut.data;
			l_ipclog( "[shmctl] Error, scOut.cmd!=SNO_OK\n" );
			FreeIPCT(hIpct, ipct);
			return -1;
		}

		if( InitSHMT(shmid, ipct) <0 )
		{
			l_ipclog( "[shmctl] InitSHMT error, shmid=[%d]\n", shmid );
			FreeIPCT(hIpct, ipct);	/* 2001.1.10	JUNG		*/
			return -1;
		}

		FreeIPCT(hIpct, ipct);
		return 0;
/*
	case	SHM_LOCK:
		return 0;

	case	SHM_UNLOCK:
		return 0;
*/
	default:
		l_ipclog( "[shmctl] Error, cmd=[%d]\n", cmd );
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}
	
	FreeIPCT(hIpct, ipct);
	return 0;
}
