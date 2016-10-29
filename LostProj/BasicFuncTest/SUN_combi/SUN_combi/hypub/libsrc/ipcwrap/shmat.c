/*#define	TERMINAL_SERVICE*/
#include <time.h>
#include "ipcwrapdef.h"

/*
extern SHMT		shmt[];
extern PSHMINFO		pshminfo[];
*/

/* shared memory 한개씩 만.... */
void * CBD1	
shmat(int shmid, const void *shmaddr, int shmflg)
{
	int	piid;
	HANDLE	hshm;
	DWORD	procid;
	LPVOID	mapaddr;
#ifndef	TERMINAL_SERVICE
	char	shmstr[16];
#else
	char	semstr[30];
#endif	/* TERMINAL_SERVICE */
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

#ifdef	TERMINAL_SERVICE
	OSVERSIONINFOEX osvi;

	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

	if( !GetVersionEx ((OSVERSIONINFO *) &osvi) )
	{
	  // If OSVERSIONINFOEX doesn't work, try OSVERSIONINFO.
		osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
		GetVersionEx( (OSVERSIONINFO *) &osvi );
	}
#endif	/* TERMINAL_SERVICE */

//	if (StartIPCD()<0)
//	{
//		errno=EFAULT;
//		return (void *)-1;
//	}

//printf("shmat()		11111\n");
	if (shmid<0 || shmid>=MAXNOOFIPC)
	{
		l_ipclog( "[shmat] error shmid(%s)<0 || shmid(%d)>=MAXNOOFIPC(%d)\n", shmid, shmid, MAXNOOFIPC);
		errno=EINVAL;                                                                                                                                                                                            
		return (void *)-1;
	}

	if (GetIPCT(&hIpct, &ipct)<0)
	{
		l_ipclog( "[shmat] GetIPCT error\n");
		errno=EFAULT;
		return (void *)-1;
	}
	else
		l_ipclog( "[shmat] GetIPCT Succeed\n");

//printf("shmat()		22222\n");
/* 2001.1.10 comment only: if invalid shm( ex. other process removed shm after my shmget() )*/
	if (ipct->shmt[shmid].key<0)	 
	{
/* 2001.1.9
		procid=GetCurrentProcessId();
		piid=FindPINFO(OPT_SHM, procid, ipct);
		if (piid>=0)
		{
			ipct->pshminfo[piid].hshm[shmid]=NULL;
			ipct->pshminfo[piid].shmaddr[shmid]=NULL;
			InitPINFO(OPT_SHM, piid, ipct);
		}
----------------------------------------------------------------*/
		l_ipclog( "[shmat] error ipct->shmt[shmid(%d)].key = [%d]\n", shmid, ipct->shmt[shmid].key);
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return (void *)-1;
	}

//printf("shmat()		33333\n");
	procid=GetCurrentProcessId();
	l_ipclog( "[shmat] GetCurrentProcessId, procid	= %x\n", procid);
	piid=FindPINFO(OPT_SHM, procid, ipct);
	l_ipclog( "[shmat] FindPINFO, piid	= %d\n", piid);
	if (piid<0)
	{
		/* 2001.1.10 comment only: if this is the first time of using shm, then register my process into ipct */ 
		piid=GetEmptyPINFO(OPT_SHM, ipct);
		l_ipclog( "[shmat] GetEmptyPINFO, piid	= %d\n", piid);
		if (piid<0)
		{
			l_ipclog( "[shmat] GetEmptyPINFO error\n");
			errno=ENOSPC;
			FreeIPCT(hIpct, ipct);
			return (void *)-1;
		}
/*2001.1.9	ipct->pshminfo[piid].procid=procid;*/
	}
/*	2001.1.10 */
	else	
	{
/*
		case  1. piid 가 쪽난 경우( ipcwrap 버그에 의해서 )
			  2. 동일 프로세스가 shmat 을 두번 호출한 경우
			  3. 동일한 procid를 가진 이전 프로세스가 fault가 
			     나서 ipcwrap.c의 DLL_PROCESS_DETATCH 를 타지 못한 경우
*/
		ipct->pshminfo[piid].hshm[shmid]=NULL;
		ipct->pshminfo[piid].shmaddr[shmid]=NULL;
	}
/****************************************************
// 2001.1.9 if new piid is duplicated(bug) or shm alreay attached 
	if(ipct->pshminfo[piid].hshm[shmid]!=NULL)
	{
		l_ipclog( "[shmat] error ipct->pshminfo[piid(%d)].hshm[shmid(%d)] = [%d]\n", 
			piid, shmid, ipct->pshminfo[piid].hshm[shmid] );
		errno=EINVAL;
		FreeIPCT(hIpct, ipct);
		return (void *)-1;
	}
*******************************************************/

#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		MakeGlobalShmstr(shmstr, shmid, ipct->shmt[shmid].key);
	else
		MakeShmstr(shmstr, shmid, ipct->shmt[shmid].key);
#else
//printf("shmat()		44444-2\n");
	MakeShmstr(shmstr, shmid, ipct->shmt[shmid].key);
//printf("shmat()		shmstr=[%s]\n", shmstr);
#endif	/* TERMINAL_SERVICE */

	hshm=OpenFileMapping(FILE_MAP_ALL_ACCESS, TRUE, shmstr);
	if (hshm==NULL)
	{
		errno=GetLastError();
		l_ipclog( "[shmat] OpenFileMapping error shmstr=[%s], errno=[%d]\n", shmstr, errno );
		ipct->pshminfo[piid].hshm[shmid]=NULL;
		ipct->pshminfo[piid].shmaddr[shmid]=NULL;
		InitPINFO(OPT_SHM, piid, ipct);
//printf("shmat()		errno=[%d]\n", errno);
		FreeIPCT(hIpct, ipct);
		return (void *)-1;
	}

//printf("shmat()		shmid=[%d], hshm=[%x]\n", shmid, hshm);
//printf("shmat()		77777\n");

	mapaddr=MapViewOfFile(hshm, FILE_MAP_ALL_ACCESS, 0, 0, 0);
	if (mapaddr==NULL)
	{
		errno=GetLastError();
		l_ipclog( "[shmat] MapViewOfFile error errno=[%d]\n", errno );
		CloseHandle(hshm);
		ipct->pshminfo[piid].hshm[shmid]=NULL;
		ipct->pshminfo[piid].shmaddr[shmid]=NULL;
		InitPINFO(OPT_SHM, piid, ipct);
//printf("shmat()		errno=[%d]\n", errno);
		FreeIPCT(hIpct, ipct);
		return (void *)-1;
	}
//printf("shmat()		88888\n");
//printf("shmat()		shmid = [%d], shmaddr = [%x]\n", shmid, mapaddr);

l_ipclog( "[shmat] before attach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
printf( "[shmat] before attach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
	ipct->shmt[shmid].shmds.shm_nattch++;
l_ipclog( "[shmat] after attach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
printf( "[shmat] after attach, shm_nattch	= %d\n", ipct->shmt[shmid].shmds.shm_nattch);
	time(&ipct->shmt[shmid].shmds.shm_atime);
	time(&ipct->shmt[shmid].shmds.shm_ctime);

	ipct->pshminfo[piid].hshm[shmid]=hshm;
	ipct->pshminfo[piid].shmaddr[shmid]=mapaddr;
	ipct->pshminfo[piid].procid=procid;	/*2001.1.9*/

	FreeIPCT(hIpct, ipct);
	return mapaddr;
}
