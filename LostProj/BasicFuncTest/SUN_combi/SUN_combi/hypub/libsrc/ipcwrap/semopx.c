/*#define	TERMINAL_SERVICE*/
#include "ipcwrapdef.h"

int	SemOpx CBD2((int semid, struct sembuf *semopbuf,
		   DWORD procid, int piid, HANDLE hevent, int timeoutsec, IPCT *ipct));

int CBD1 
semopx(int semid, struct sembuf *semoparray, HANDLE hevent, int timeoutsec)
{
	int	i;
	int	piid;
	DWORD	procid;	
	int	ret;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

//	StartIPCD();
	if (semid<0 || semid>=MAXNOOFIPC)
	{
		errno=EINVAL;
		return -1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		errno=EFAULT;
		return -1;
	}

	if (ipct->semt[semid].key<0)
	{
		procid=GetCurrentProcessId();
		piid=FindPINFO(OPT_SEM, procid, ipct);
		if (piid>=0)
		{
			for (i=0; i<MAXNSEM; i++)
				ipct->pseminfo[piid].semadj[semid][i]=0;
			ipct->pseminfo[piid].semid[semid]=0;
			InitPINFO(OPT_SEM, piid, ipct);
		}

		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return -1;
	}

	procid=GetCurrentProcessId();
	piid=FindPINFO(OPT_SEM, procid, ipct);
	if (piid<0)
	{
		piid=GetEmptyPINFO(OPT_SEM, ipct);
		if (piid<0)
		{
			errno=ENOSPC;
			FreeIPCT(hIpct, ipct);
			return -1;
		}
		ipct->pseminfo[piid].procid=procid;
//		ipct->pseminfo[piid].semid[semid]=1;
	}

	ret = SemOpx(semid, semoparray, procid, piid, hevent, timeoutsec, ipct);

	FreeIPCT(hIpct, ipct);
	return ret;		// -1 : error, -2 : TIMEOUT, -3 : signaled event.....
			
}

int
SemOpx(int semid, struct sembuf *semopbuf, DWORD procid, int piid, HANDLE hevent, int timeoutsec, IPCT *ipct)
{
	int	i;
	BOOL	ret;
	DWORD	dwret;
	HANDLE	hsem;
	HANDLE	handles[2]={NULL, NULL};
	DWORD	dwmillisec=INFINITE;
#ifndef	TERMINAL_SERVICE
	char	semstr[16];
#else
	char	semstr[30];
#endif	/* TERMINAL_SERVICE */


#ifndef	TERMINAL_SERVICE
	MakeSemstr(semstr, semopbuf->sem_num, semid, ipct->semt[semid].key);
#else
	OSVERSIONINFOEX osvi;

	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

	if( !GetVersionEx ((OSVERSIONINFO *) &osvi) )
	{
	  // If OSVERSIONINFOEX doesn't work, try OSVERSIONINFO.
		osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
		GetVersionEx( (OSVERSIONINFO *) &osvi );
	}

	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		MakeGlobalSemstr(semstr, semopbuf->sem_num, semid, ipct->semt[semid].key);
	else
		MakeSemstr(semstr, semopbuf->sem_num, semid, ipct->semt[semid].key);
#endif	/* TERMINAL_SERVICE */
	hsem=OpenSemaphore(SEMAPHORE_ALL_ACCESS, TRUE, semstr);
	if (hsem==NULL)
	{
		errno=GetLastError();

		return -1;
	}

	if (semopbuf->sem_op<0)
	{
		if (ipct->semb[semid][semopbuf->sem_num].semval
			>= abs((int)semopbuf->sem_op))
			ipct->semb[semid][semopbuf->sem_num].semncnt++;

		if (ipct->semb[semid][semopbuf->sem_num].semval
			< abs((int)semopbuf->sem_op))
		{
			if (semopbuf->sem_flg & IPC_NOWAIT)
			{
				ipct->semb[semid][semopbuf->sem_num].sempid=procid;
				CloseHandle(hsem);
				return 0;
			}
		}

		for (i=0; i<abs((int)semopbuf->sem_op); i++)
		{
			if (timeoutsec>0)
				dwmillisec=timeoutsec*1000;
			else if (timeoutsec==0)
				dwmillisec=0;
			else
				dwmillisec=INFINITE;

			if (hevent)
			{
				handles[0]=hsem;
				handles[1]=hevent;
				dwret=WaitForMultipleObjects(2, handles, FALSE, dwmillisec);
			}
			else
				dwret=WaitForSingleObject(hsem, dwmillisec);

			switch (dwret)
			{

			case	WAIT_OBJECT_0	:
/* by KJC 98.09.24 **************************************
				ipct->semb[semid][semopbuf->sem_num].semval--;
***********************************************************/
				InterlockedDecrement(&ipct->semb[semid][semopbuf->sem_num].semval);
/***********************************************************/
				break;
			case	WAIT_OBJECT_0 + 1 :
				CloseHandle(hsem);
				return -3;

			case	WAIT_TIMEOUT	:
				CloseHandle(hsem);
				return -2;

			case	WAIT_FAILED	:
				errno=GetLastError();
			default	:
				CloseHandle(hsem);
				return -1;
			}
/***************
			} while (dwret==(WAIT_OBJECT_0 + 1));
***************/

			if (semopbuf->sem_flg & SEM_UNDO)
			{
				ipct->pseminfo[piid].semadj[semid][semopbuf->sem_num]++;
			}
		}

		ipct->semb[semid][semopbuf->sem_num].sempid=procid;
		ipct->semb[semid][semopbuf->sem_num].semncnt--;
	//	CloseHandle(hsem);
	}
	else if (semopbuf->sem_op>0)
	{
		ret=ReleaseSemaphore(hsem, semopbuf->sem_op, NULL);
		if (ret==FALSE)
		{

			CloseHandle(hsem);
			return -1;
		}
		ipct->semb[semid][semopbuf->sem_num].sempid=procid;
/* by KJC 98.9.24 ********************************
		ipct->semb[semid][semopbuf->sem_num].semval+=(int)semopbuf->sem_op;
***********************************************************/
		InterlockedExchangeAdd(&ipct->semb[semid][semopbuf->sem_num].semval, (long)semopbuf->sem_op);
/***********************************************************/
	//	CloseHandle(hsem);

		if (semopbuf->sem_flg & SEM_UNDO)
		{
			ipct->pseminfo[piid].semadj[semid][semopbuf->sem_num]-=(int)semopbuf->sem_op;
		}

	}
	else
	{
		if (!ipct->semb[semid][semopbuf->sem_num].semval)
		{
			CloseHandle(hsem);
			return 0;
		}

		if (semopbuf->sem_flg & IPC_NOWAIT)
		{
			CloseHandle(hsem);
			return 0;
		}

		ipct->semb[semid][semopbuf->sem_num].sempid=procid;
		ipct->semb[semid][semopbuf->sem_num].semzcnt++;
		/*###################################*/
		/*###################################*/

	}
	
	CloseHandle(hsem);
	return 0;
}
