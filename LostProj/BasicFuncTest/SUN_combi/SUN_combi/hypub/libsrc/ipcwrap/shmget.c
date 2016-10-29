#include <time.h>
#include "ipcwrapdef.h"

/*
extern SHMT		shmt[];
extern PSHMINFO		pshminfo[];
*/
//extern HWND	hdwnd;

int CBD1	
shmget(key_t key, size_t size, int shmflag)
{
	int	shmid = -1;
/*2001.1.9
	int	piid;
*********************/
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

	if (key<0 || key>MAXKEYVAL || size<0)
	{
		l_ipclog( "[shmget] error key(%d)<0 || key(%d)>=MAXKEYVAL(%d) || size(%d)<0\n", 
			key, key, MAXKEYVAL, size);
		errno=EINVAL;
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		l_ipclog( "[shmget] GetIPCT error\n");
		errno=EFAULT;
		return -1;
	}

	procid=GetCurrentProcessId();

/*2001.1.9
	piid=FindPINFO(OPT_SHM, procid, ipct);
	if (piid<0)
	{
		piid=GetEmptyPINFO(OPT_SHM, ipct);
		if (piid<0)
		{
			l_ipclog( "[shmget] GetEmptyPINFO error\n");
			errno=ENOSPC;
			FreeIPCT(hIpct, ipct);
			return -1;
		}
	}
*********************************************************************/

	if (key!=IPC_PRIVATE)
	{
		shmid=FindSHMT(key, ipct);
		if (shmid>=0)
		{
			if (shmflag & IPC_CREAT || shmflag & IPC_EXCL)
			{
/*create한 process가 살아있으면 재생성시 오류 처리( 내가 아닌 경우 )*/
/*2001.1.9
				if (IsProcessForShm(shmid, ipct))
*/
				if( ( ipct->shmt[shmid].procid != procid ) &&
				    IsProcessForShm(shmid, ipct) )
				{
					l_ipclog( "[shmget] IsProcessForShm error shmid=[%d]\n", shmid);
					errno=EEXIST;
					FreeIPCT(hIpct, ipct);
					return -1;
				}

/*create한 process가 죽었으면 재생성 허용(truncate)*/
				if( InitSHMT(shmid, ipct) < 0 )
				{
					l_ipclog( "[shmget] InitSHMT error shmid=[%d]\n", shmid);
					FreeIPCT(hIpct, ipct);		/* 2001.1.10	JUNG	*/
					return -1;
				}
/*다시 creation 하는 경우*/
				else
				{
					;
				}
			}
			else
			{
/*있고 creation 이 아닌 경우*/
				if (size<ipct->shmt[shmid].shmds.shm_segsz 
				&&  size!=0)
				{
					l_ipclog( "[shmget] shmid=[%d], size=[%d]\n", shmid, size);
					errno=EINVAL;
					FreeIPCT(hIpct, ipct);
					return -1;
				}

/*2001.1.9			ipct->pshminfo[piid].procid=procid;*/
				FreeIPCT(hIpct, ipct);
				return shmid;
			}
		}
		if (shmflag & IPC_CREAT)
		{
			if (size==0)
			{
				l_ipclog( "[shmget] (shmflag & IPC_CREAT) shmid=[%d], size=[%d]\n", shmid, size);
				errno=EINVAL;
				FreeIPCT(hIpct, ipct);
				return -1;
			}
		}
		else
		{
/*없는데 get만하는 경우*/
			errno=ENOENT;
			FreeIPCT(hIpct, ipct);
			return -1;
		}
	}
	else
	{
/*2001.1.9. PENDING. PRIVATE 인 경우. key 값을 unique 하게 생성해야 함
		if (shmflag & IPC_CREAT)
		{
			if (size==0)
			{
				l_ipclog( "[shmget] (shmflag & IPC_CREAT) shmid=[%d], size=[%d]\n", shmid, size);
				errno=EINVAL;
				FreeIPCT(hIpct, ipct);
				return -1;
			}
		}
		else
		{
			l_ipclog( "[shmget] !(shmflag & IPC_CREAT) shmid=[%d]\n", shmid);
			errno=EINVAL;
			FreeIPCT(hIpct, ipct);
			return -1;
		}
*******************************************/
		FreeIPCT(hIpct, ipct);		/* 2001.1.10	JUNG	*/
		return( -1 );
	}

	shmid=GetEmptySHMT(ipct);
	if (shmid<0)
	{
		l_ipclog( "[shmget] GetEmptySHMT error\n");
		errno=ENOSPC;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

//printf("shmget()	key=[%d]\n", key);
	ipct->shmt[shmid].key=key;
	ipct->shmt[shmid].procid=procid;

	ipct->shmt[shmid].shmds.shm_segsz=size;
	ipct->shmt[shmid].shmds.shm_lkcnt=0;
	ipct->shmt[shmid].shmds.shm_lpid=0;
	ipct->shmt[shmid].shmds.shm_cpid=0;
	ipct->shmt[shmid].shmds.shm_nattch=0;
	ipct->shmt[shmid].shmds.shm_cnattch=0;
	ipct->shmt[shmid].shmds.shm_atime=0;
	ipct->shmt[shmid].shmds.shm_dtime=0;
	time(&ipct->shmt[shmid].shmds.shm_ctime);

/*2001.1.9	ipct->pshminfo[piid].procid=procid;*/

//printf("shmget()	shmid=[%d]\n", shmid);
//printf("shmget()	shmt[%d].key=[%d]\n", shmid, shmt[shmid].key);
//printf("shmget()	hdwnd=[%x]\n", hdwnd);

	scIn.cmd=SNO_SHMGET;
	scIn.data=shmid;

	lret = CallNamedPipe(lpszPipeName,
		 (char *)&scIn, sizeof(scIn),
		 (char *)&scOut, sizeof(scOut),
		 &bytesRead, NMPWAIT_WAIT_FOREVER);

	if (lret==FALSE) 
	{
		errno=GetLastError();
		l_ipclog( "[shmget] CallNamedPipe error, errno=[%d]\n", errno);
		ipct->shmt[shmid].shmds.shm_segsz=0;
		ipct->shmt[shmid].shmds.shm_ctime=0;
		ipct->shmt[shmid].procid=0;
		ipct->shmt[shmid].key=-1;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	if (scOut.cmd!=SNO_OK)
	{
		l_ipclog( "[shmget] scOut.cmd!=SNO_OK\n");
		errno=scOut.data;
		ipct->shmt[shmid].shmds.shm_segsz=0;
		ipct->shmt[shmid].shmds.shm_ctime=0;
		ipct->shmt[shmid].procid=0;
		ipct->shmt[shmid].key=-1;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	FreeIPCT(hIpct, ipct);
	return shmid;
}