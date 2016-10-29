/*#define	TERMINAL_SERVICE*/
#include "ipcwrapdef.h"

int	SemOp CBD2((int semid, struct sembuf *semopbuf, DWORD procid, int piid, IPCT *ipct));

/*
extern struct sem	semb[][MAXNSEM];
extern SEMT		semt[];
extern PSEMINFO		pseminfo[];
*/

char	tbuf[50];

int CBD1 
semop(int semid, struct sembuf semoparray[], size_t nsops)
{
	int	i;
	int	piid;
	DWORD	procid;
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

	for (i=0; i<(int)nsops; i++)
	{
		if (SemOp(semid, &semoparray[i], procid, piid, ipct)<0)
		{
//			ipct->pseminfo[piid].semid[semid]=0;
//			for (j=0; j<MAXNSEM; j++)
//				ipct->pseminfo[piid].semadj[semid][j]=0;
//			InitPINFO(OPT_SEM, piid, ipct);
			FreeIPCT(hIpct, ipct);
			return -1;
		}
	}
//	ipct->pseminfo[piid].semid[semid]=0;
//	for (j=0; j<MAXNSEM; j++)
//		ipct->pseminfo[piid].semadj[semid][j]=0;
//	InitPINFO(OPT_SEM, piid, ipct);
	FreeIPCT(hIpct, ipct);

	return 0;
}

int
SemOp(int semid, struct sembuf *semopbuf, DWORD procid, int piid, IPCT *ipct)
{
	int	i;
	BOOL	ret;
	DWORD	dwret;
	HANDLE	hsem;
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
/**************
			do
			{
				dwret=MsgWaitForMultipleObjects(1, &hsem, 
					FALSE, INFINITE, 
					QS_SENDMESSAGE|QS_POSTMESSAGE|QS_TIMER);
***************/
			dwret=WaitForSingleObject(hsem, INFINITE);
			switch (dwret)
			{
/*****************
			case	WAIT_OBJECT_0 + 1 :
				if (l_peekmessage()<0)
				{
					CloseHandle(hsem);
					return -1;
				}
				break;
*****************/

			case	WAIT_OBJECT_0	:
/* by KJC 98.09.24 **************************************
				ipct->semb[semid][semopbuf->sem_num].semval--;
***********************************************************/
				InterlockedDecrement(&ipct->semb[semid][semopbuf->sem_num].semval);
/***********************************************************/
				break;
			case	WAIT_TIMEOUT	:
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
