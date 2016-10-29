/*----------------------------------------------------------------------------+
| 수정내역								      |
|-----------------------------------------------------------------------------|
| 2000.4.19 : bug 수정							      |
| TERMINAL_SERVICE : 터미널 서비스 추후 고려				      |
+-----------------------------------------------------------------------------*/
/*#define	TERMINAL_SERVICE*/
#include <time.h>
#include "ipcwrapdef.h"

/* #####
#pragma data_seg ("ipcwrap")
struct	sem	semb[MAXNOOFIPC][MAXNSEM]={0};
SEMT		semt[MAXNOOFIPC]={0};
SHMT		shmt[MAXNOOFIPC]={0};
PSEMINFO	pseminfo[MAXNOOFIPC]={0};
PSHMINFO	pshminfo[MAXNOOFIPC]={0};
int		firstload=0;
#pragma data_seg ()
##### */
//HWND	hdwnd=NULL;
HANDLE	l_OpenMutex(char* mutexname);
BOOL	l_WaitMutex(HANDLE hMutex);

int WINAPI DllMain(HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved)
{
	int	i, j, k;
	DWORD	procid;
	HANDLE	hIpct = NULL;
	IPCT	*ipct = NULL;

	switch (fdwReason)
	{
	case	DLL_PROCESS_ATTACH:
/* ####
		if (!firstload)
		{
			firstload=1;
			for (i=0; i<MAXNOOFIPC; i++)
			{
				semt[i].key=-1;
				shmt[i].key=-1;
				for (j=0; j<MAXNOOFIPC; j++)
				{
					pseminfo[i].semid[j]=-1;
					pshminfo[i].hshm[j]=NULL;
				}
			}
		}
*/
//		if (StartIPCD()<0)
//			return 0;
/*
		hIpct=OpenFileMapping(FILE_MAP_ALL_ACCESS, TRUE, "ipct");
		if (hIpct==NULL) return 0;
		ipct=(IPCT *)MapViewOfFile(hIpct, FILE_MAP_ALL_ACCESS, 0, 0, 0);
		if (ipct==NULL)
		{
			CloseHandle(hIpct);
			return 0;
		}
*/

		break;
	case	DLL_PROCESS_DETACH:
		/* semadj value... reset */
		/* process table reset */
		if (GetIPCT(&hIpct, &ipct)<0)
			break;

		procid = GetCurrentProcessId();
l_ipclog("[ipcwrap] GetCurrentProcessId, procid	= %x\n", procid);
		for (i=0; i<MAXNOOFPROC; i++)		/*2001.1.9.MAXNOOFPROC*/
		{
			if (ipct->pseminfo[i].procid == procid)
			{
/* 2001.1.10	JUNG 
				HANDLE	hMutex;
				hMutex = l_OpenMutex( SEMPINFOMUTEX );
				if( !hMutex )
					return -1;

				if( l_WaitMutex(hMutex) == FALSE)
				{
					CloseHandle( hMutex );			
					return -1;
				}
*************************************************************/
				for (j=0; j<MAXNOOFIPC; j++)
				{
					for (k=0; k<MAXNSEM; k++)
						ipct->pseminfo[i].semadj[j][k]=0;
					ipct->pseminfo[i].semid[j]=0;
				}
				ipct->pseminfo[i].procid =0;
/* 2001.1.10	JUNG 
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
*************************************************************/
			}

			if (ipct->pshminfo[i].procid == procid)
			{
/* 2001.1.10	JUNG 
				HANDLE	hMutex;
				hMutex = l_OpenMutex( SEMPINFOMUTEX );
				if( !hMutex )
					return -1;

				if( l_WaitMutex(hMutex) == FALSE)
				{
					CloseHandle( hMutex );			
					return -1;
				}
************************************************************/
				for (j=0; j<MAXNOOFIPC; j++)
				{
					if (ipct->pshminfo[i].shmaddr[j]!=NULL)
						UnmapViewOfFile(ipct->pshminfo[i].shmaddr[j]);

					if (ipct->pshminfo[i].hshm[j]!=NULL)
						CloseHandle(ipct->pshminfo[i].hshm[j]);

					ipct->pshminfo[i].hshm[j]=NULL;
					ipct->pshminfo[i].shmaddr[j]=NULL;
				}
				ipct->pshminfo[i].procid =0;
/* 2001.1.10	JUNG 
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
************************************************************/
			}
		}
/*
		if (ipct!=NULL)
			UnmapViewOfFile(ipct);
		if (hIpct!=NULL)
			CloseHandle(hIpct);
*/

		FreeIPCT(hIpct, ipct);

		break;
	default  :
		break;
	}

	return 1;
}

int
GetEmptySEMT(IPCT *ipct)
{
	int	i;
	HANDLE	hMutex;

	hMutex = l_OpenMutex( SEMIPCMUTEX );
	if( !hMutex )
		return -1;

	if( l_WaitMutex(hMutex) == FALSE)
	{
		CloseHandle( hMutex );			
		return -1;
	}

	for (i=0; i<MAXNOOFIPC; i++)
	{
		if (ipct->semt[i].key<0)
		{
			ReleaseMutex( hMutex );
			CloseHandle( hMutex );			
			return i;
		}
	}

	ReleaseMutex( hMutex );
	CloseHandle( hMutex );			
	return -1;
}

int
FindSEMT(key_t key, IPCT *ipct)
{
	int	i;

	for (i=0; i<MAXNOOFIPC; i++)
		if (ipct->semt[i].key==key)
			return i;
	return -1;
}

int
GetEmptySHMT(IPCT *ipct)
{
	int	i;
	HANDLE	hMutex;

	hMutex = l_OpenMutex( SHMIPCMUTEX );
	if( !hMutex )
		return -1;

	if( l_WaitMutex(hMutex) == FALSE)
	{
		CloseHandle( hMutex );			
		return -1;
	}

	for (i=0; i<MAXNOOFIPC; i++)
	{
		if (ipct->shmt[i].key<0)
		{
			ipct->shmt[i].key = 0;		/*2001.1.9*/
			ReleaseMutex( hMutex );
			CloseHandle( hMutex );			
			return i;
		}
	}

	ReleaseMutex( hMutex );
	CloseHandle( hMutex );			
	return -1;
}

int
FindSHMT(key_t key, IPCT *ipct)
{
	int	i;

	for (i=0; i<MAXNOOFIPC; i++)
		if (ipct->shmt[i].key==key)
			return i;
	return -1;
}

int
GetEmptyPINFO(int opt, IPCT *ipct)
{
	int	i, j, k;
/*2001.1.9	int	 ret;*/
	HANDLE	phandle;
	DWORD	exitcode;
	HANDLE	hMutex;

	if (opt==OPT_SEM)
	{
		hMutex = l_OpenMutex( SEMPINFOMUTEX );
		if( !hMutex )
			return -1;

		if( l_WaitMutex(hMutex) == FALSE)
		{
			CloseHandle( hMutex );			
			return -1;
		}

		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
		{
			if (ipct->pseminfo[i].procid==0)
			{
/*2001.1.9
				ipct->pseminfo[i].procid = GetCurrentProcessId();
*******************************************************************************/
				ipct->pseminfo[i].procid = 1;	/*2001.1.9*/
					/* 2001.1.9 reserve piid */
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
				return i;
			}
		}
/*2001.1.9	ret = -1; */
		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
		{
			if ( ( phandle = OpenProcess( PROCESS_ALL_ACCESS,
					FALSE, ipct->pseminfo[i].procid ) )
			 && ( GetExitCodeProcess( phandle, &exitcode ) )
			 && ( exitcode == STILL_ACTIVE ) )
			{
				CloseHandle(phandle);
				continue;
			}
			if (phandle) CloseHandle(phandle);

/*2001.1.9
			if (ret<0) ret=i;

			for (j=0; j<MAXNOOFIPC; j++)
			{
				for (k=0; k<MAXNSEM; k++)
					ipct->pseminfo[i].semadj[j][k]=0;
				ipct->pseminfo[i].semid[j]=0;
			}
			ipct->pseminfo[i].procid =0;
------------------------------------------------------------------*/
			ipct->pseminfo[i].procid = 1;
					/* 2001.1.9 reserve piid */
			ReleaseMutex( hMutex );
			CloseHandle( hMutex );
			for (j=0; j<MAXNOOFIPC; j++)
			{
				for (k=0; k<MAXNSEM; k++)
					ipct->pseminfo[i].semadj[j][k]=0;
				ipct->pseminfo[i].semid[j]=0;
			}
			return( i );
/*end of 2001.1.9*/
		}

		ReleaseMutex( hMutex );
		CloseHandle( hMutex );			
/*2001.1.9	return ret; */
		return -1;
	}
	else
	{
		hMutex = l_OpenMutex( SHMPINFOMUTEX );
		if( !hMutex )
			return -1;

		if( l_WaitMutex(hMutex) == FALSE)
		{
			CloseHandle( hMutex );			
			return -1;
		}

		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
		{
			if( ipct->pshminfo[i].procid==0 )
			{
				ipct->pshminfo[i].procid = 1;	/*2001.1.9*/
					/* 2001.1.9 reserve piid */
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
				return i;
			}
		}

/*2001.1.9	ret = -1; */
		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
		{
			if( ( phandle = OpenProcess( PROCESS_ALL_ACCESS,
					FALSE, ipct->pshminfo[i].procid ) )
			 && ( GetExitCodeProcess( phandle, &exitcode ) )
			 && ( exitcode == STILL_ACTIVE ) )
			{
				CloseHandle(phandle);
				continue;
			}
			if (phandle) CloseHandle(phandle);

/*2001.1.9
			if (ret<0) ret=i;

			for (j=0; j<MAXNOOFIPC; j++)
			{
				ipct->pshminfo[i].hshm[j]=NULL;
				ipct->pshminfo[i].shmaddr[j]=NULL;
			}
			ipct->pshminfo[i].procid=0;
------------------------------------------------------------------*/
			ipct->pshminfo[i].procid = 1;
					/* 2001.1.9 reserve piid */
			ReleaseMutex( hMutex );
			CloseHandle( hMutex );
			for (j=0; j<MAXNOOFIPC; j++)
			{
				ipct->pshminfo[i].hshm[j]=NULL;
				ipct->pshminfo[i].shmaddr[j]=NULL;
			}
			return( i );
/*end of 2001.1.9*/
		}

		ReleaseMutex( hMutex );
		CloseHandle( hMutex );	
/*2001.1.9	return ret; */
		return -1;
	}
}

int
FindPINFO(int opt, DWORD procid, IPCT *ipct)
{
	int	i;

	if (opt==OPT_SEM)
	{
		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
			if (ipct->pseminfo[i].procid==procid)
				return i;
		return -1;
	}
	else
	{
		for (i=0; i<MAXNOOFPROC; i++)	/*2001.1.9. MAXNOOFPROC*/
			if (ipct->pshminfo[i].procid==procid)
				return i;
		return -1;
	}
}

int
InitSEMT(int semid, IPCT *ipct)
{
	int	i;
	HANDLE	hMutex;

	hMutex = l_OpenMutex( SEMIPCMUTEX );
	if( !hMutex )
		return -1;

	if( l_WaitMutex(hMutex) == FALSE)
	{
		CloseHandle( hMutex );			
		return -1;
	}

	for (i=0; i<MAXNSEM; i++)
	{
		ipct->semt[semid].hsem[i]=NULL;
		memset( (char *)&ipct->semb[semid][i], 0, sizeof(ipct->semb[semid][i]));
	}
	memset( (char *)&ipct->semt[semid].semds, 0, sizeof(ipct->semt[semid].semds));
	ipct->semt[semid].procid=0;
	ipct->semt[semid].key=-1;

	ReleaseMutex( hMutex );
	CloseHandle( hMutex );			
	return 0;
}


int
InitSHMT(int shmid, IPCT *ipct)
{
	HANDLE	hMutex;

	hMutex = l_OpenMutex( SHMIPCMUTEX );
	if( !hMutex )
		return -1;

	if( l_WaitMutex(hMutex) == FALSE)
	{
		CloseHandle( hMutex );			
		return -1;
	}

	ipct->shmt[shmid].hfile=INVALID_HANDLE_VALUE;
	ipct->shmt[shmid].hshm=NULL;
	memset( (char *)&ipct->shmt[shmid].shmds, 0, sizeof(ipct->shmt[shmid].shmds));
	ipct->shmt[shmid].procid=0;
	ipct->shmt[shmid].key=-1;

	ReleaseMutex( hMutex );
	CloseHandle( hMutex );			
	return 0;
}

int
InitPINFO(int opt, int piid, IPCT *ipct)
{
	int	i;
/*2001.1.9
	int	i, j;
	HANDLE	hMutex;
******************************************************/

	if (opt==OPT_SEM)
	{
/*2001.1.9
		hMutex = l_OpenMutex( SEMPINFOMUTEX );
		if( !hMutex )
			return -1;

		if( l_WaitMutex(hMutex) == FALSE)
		{
			CloseHandle( hMutex );			
			return -1;
		}
******************************************************/

		for (i=0; i<MAXNOOFIPC; i++)
		{
			if (ipct->pseminfo[piid].semid[i]==1)
			{
/*2001.1.9
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
******************************************************/
				return -1;
			}
		}

/*2001.1.9
		for (i=0; i<MAXNOOFIPC; i++)
		{
			for (j=0; j<MAXNSEM; j++)
				ipct->pseminfo[piid].semadj[i][j]=0;
			ipct->pseminfo[piid].semid[i]=0;
		}
******************************************************/

		ipct->pseminfo[piid].procid=0;
/*2001.1.9
		ReleaseMutex( hMutex );
		CloseHandle( hMutex );			
******************************************************/
		return 0;
	}
	else
	{
/*2001.1.9
		hMutex = l_OpenMutex( SHMPINFOMUTEX );
		if( !hMutex )
			return -1;

		if( l_WaitMutex(hMutex) == FALSE)
		{
			CloseHandle( hMutex );			
			return -1;
		}
******************************************************/
		for (i=0; i<MAXNOOFIPC; i++)
		{
			if (ipct->pshminfo[piid].hshm[i]!=NULL)
			{
/*2001.1.9
				ReleaseMutex( hMutex );
				CloseHandle( hMutex );			
******************************************************/
				return -1;
			}
		}

/*2001.1.9
		for (i=0; i<MAXNOOFIPC; i++)
		{
			ipct->pshminfo[piid].hshm[i]=NULL;
			ipct->pshminfo[piid].shmaddr[i]=NULL;
		}
******************************************************/

		ipct->pshminfo[piid].procid=0;
/*2001.1.9
		ReleaseMutex( hMutex );
		CloseHandle( hMutex );			
******************************************************/
		return 0;
	}
}

/*
int
StartIPCD()
{
	char	*ieaphome;
	char	ipcdpath[100];
	HWND	hwnd;
	STARTUPINFO	si;
	PROCESS_INFORMATION	pi;

	hwnd=FindWindow("IPCD", NULL);
	if (hwnd!=NULL)
	{
		hdwnd=hwnd;
		return 0;
	}
	ieaphome=getenv("IEAPHOME");

	if (ieaphome==NULL) return -1;

	strcpy(ipcdpath, ieaphome);
	strcat(ipcdpath, "\\bin\\ipcd S");

	memset((char *)&si, 0, sizeof(si));
	if (!CreateProcess(NULL, ipcdpath, NULL, NULL,
		FALSE, 0, NULL, NULL, &si, &pi))
	{
		return -1;
	}

	WaitForInputIdle(pi.hProcess, 30000);

	hdwnd=FindWindow("IPCD", NULL);

	return 0;
}
*/

int
GetIPCT(HANDLE *hIpct, IPCT **ipct)
{
#ifdef	TERMINAL_SERVICE
	char	tbuf[256];
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
		strcpy( tbuf, "Global\\ipct" );
	else
		strcpy( tbuf, "ipct" );

	*hIpct=OpenFileMapping(FILE_MAP_ALL_ACCESS, TRUE, tbuf);
#else
	*hIpct=OpenFileMapping(FILE_MAP_ALL_ACCESS, TRUE, "ipct");
#endif	/* TERMINAL_SERVICE */
	if (*hIpct==NULL) return -1;

	*ipct=(IPCT *)MapViewOfFile(*hIpct, FILE_MAP_ALL_ACCESS, 0, 0, 0);
	if (*ipct==NULL)
	{
		CloseHandle(*hIpct);
		return -1;
	}

	return 0;
}

void
FreeIPCT(HANDLE hIpct, IPCT *ipct)
{
	if (ipct!=NULL)
		UnmapViewOfFile(ipct);
	if (hIpct!=NULL)
		CloseHandle(hIpct);
}

BOOL
IsProcessForSem(int semid, IPCT *ipct)
{
	int	i, j, k;
	HANDLE	phandle;
	DWORD	exitcode;

	for (i=0; i<MAXNOOFPROC; i++)			/*2001.1.9.MAXNOOFPROC*/
	{
		if (ipct->pseminfo[i].semid[semid])
		{
			if ( !ipct->pseminfo[i].procid )
			{
				for (j=0; j<MAXNOOFIPC; j++)
				{
					for (k=0; k<MAXNSEM; k++)
						ipct->pseminfo[i].semadj[j][k]=0;
					ipct->pseminfo[i].semid[j]=0;
				}

				continue;
			}

			/*2001.1.9 if reserved status */
			else if ( ipct->pseminfo[i].procid == 1 )
				return 1;
			/*end of 2001.1.9*/

			if( ( phandle = OpenProcess( PROCESS_ALL_ACCESS,
					FALSE, ipct->pseminfo[i].procid ) )
			 && ( GetExitCodeProcess( phandle, &exitcode ) )
			 && ( exitcode == STILL_ACTIVE ) )
			{
				CloseHandle(phandle);
				return 1;
			}
			if (phandle)
				CloseHandle(phandle);

			for (j=0; j<MAXNOOFIPC; j++)
			{
				for (k=0; k<MAXNSEM; k++)
					ipct->pseminfo[i].semadj[j][k]=0;
				ipct->pseminfo[i].semid[j]=0;
			}
			ipct->pseminfo[i].procid=0;
		}
	}

	return 0;
}

BOOL
IsProcessForShm(int shmid, IPCT *ipct)
{
	int	i;
	HANDLE	phandle;
	DWORD	exitcode;

	if(!ipct->shmt[shmid].procid)
		return 0;

	if( ( phandle = OpenProcess( PROCESS_ALL_ACCESS,
			FALSE, ipct->shmt[shmid].procid ) )
	 && ( GetExitCodeProcess( phandle, &exitcode ) )
	 && ( exitcode == STILL_ACTIVE ) )
	{
		CloseHandle(phandle);
		return 1;
	}
	if (phandle)
		CloseHandle(phandle);


	for (i=0; i<MAXNOOFPROC; i++)		/*2001.1.9. MAXNOOFPROC*/
	{
		if (ipct->pshminfo[i].procid==ipct->shmt[shmid].procid)
		{
			ipct->pshminfo[i].hshm[shmid]=NULL;
			ipct->pshminfo[i].shmaddr[shmid]=NULL;
			ipct->pshminfo[i].procid=0;
			continue;
		}

/*2000.4.19 change -------------------------------------------------------------
		if (ipct->pshminfo[i].hshm!=NULL)
------------------------------------------------------------------------------*/
		if (ipct->pshminfo[i].hshm[shmid]!=NULL)
/*end of 2000.4.19 -----------------------------------------------------------*/
		{
			if (!ipct->pshminfo[i].procid )
			{
				ipct->pshminfo[i].hshm[shmid]=NULL;
				ipct->pshminfo[i].shmaddr[shmid]=NULL;
				continue;
			}

			/*2001.1.9 if reserved status */
			else if (ipct->pshminfo[i].procid == 1)
				return 1;
			/*end of 2001.1.9*/

			if( ( phandle = OpenProcess( PROCESS_ALL_ACCESS,
					FALSE, ipct->pshminfo[i].procid ) )
			 && ( GetExitCodeProcess( phandle, &exitcode ) )
			 && ( exitcode == STILL_ACTIVE ) )
			{
				CloseHandle(phandle);
				return 1;
			}
			if (phandle)
				CloseHandle(phandle);

			ipct->pshminfo[i].hshm[shmid]=NULL;
			ipct->pshminfo[i].shmaddr[shmid]=NULL;
			ipct->pshminfo[i].procid=0;
		}

	}
	return 0;
}

HANDLE	
l_OpenMutex(char* mutexname)
{
	return OpenMutex( MUTEX_ALL_ACCESS, FALSE, mutexname );
}

BOOL
l_WaitMutex( HANDLE hMutex )
{
	DWORD	dwWaitResult;
	
	dwWaitResult = WaitForSingleObject( hMutex, 1000 ); 
	switch( dwWaitResult )
	{
	case	WAIT_OBJECT_0 :
	case	WAIT_ABANDONED :
		break;
	case	WAIT_TIMEOUT :
	case	WAIT_FAILED :
	default :
		return FALSE;
	}
	return TRUE;
}

/*----------------------------------------------------------------------+
|	logging with time						|
+----------------------------------------------------------------------*/
extern	int
l_ipclog( char *fmt, ... )
{
	char	logpath[128];
	va_list vlist;
	time_t	tv;
	struct	tm	*t;
	FILE	*fd;

	GetTempPath(sizeof(logpath), logpath);
	strcat( logpath, "\\ipcd.log" ); 
	if( ( fd = fopen( logpath, "a" ) ) == (FILE *)0 )
		return 0;
	va_start( vlist, fmt );

	time(&tv);
	t = localtime( &tv );
	fprintf( fd, "[%06d]%04d/%02d/%02d %02d:%02d:%02d ", GetCurrentProcessId(),
		t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
		t->tm_hour, t->tm_min, t->tm_sec );
	vfprintf( fd, fmt, vlist );
	va_end( vlist );

	fclose( fd );
	return 0;
}

/********
int
l_peekmessage(void)
{
     MSG msg;
     BOOL ret;
     * get the next message if any *
     ret = (BOOL)PeekMessage(&msg, NULL, 0, 0, PM_REMOVE);
     * if we got one, process it *
     if (ret) {
	  TranslateMessage(&msg);
	  DispatchMessage(&msg);
     }
     * TRUE if we got a message *
     if (msg.message==WM_CLOSE||msg.message==WM_DESTROY)
	     ret=-1;
     return ret;
}
*********/
