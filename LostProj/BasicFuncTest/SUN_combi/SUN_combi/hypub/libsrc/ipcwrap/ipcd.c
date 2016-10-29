/*----------------------------------------------------------------------------+
| 수정내역								      |
|-----------------------------------------------------------------------------|
| 2000.9.4 : shared memory 누구나 access 할 수 있도록 보완		      |
| TERMINAL_SERVICE : 터미널 서비스 추후 고려				      |
+-----------------------------------------------------------------------------*/
/*#define	TERMINAL_SERVICE*/
#include <windows.h>
#include <stdio.h>
#include <io.h>
#include <time.h>
#include "ipcwrapdef.h"

/* Global variable */
IPCT	*ipct = NULL;
HANDLE	hIpc = NULL;
HANDLE	hShmIpcMutex = NULL;
HANDLE	hSemIpcMutex = NULL;
HANDLE	hShmPinfoMutex = NULL;
HANDLE	hSemPinfoMutex = NULL;

#ifdef	TERMINAL_SERVICE
OSVERSIONINFOEX	osvi;
#endif	/* TERMINAL_SERVICE */

char	tbuf[256];

/* Function Declaration */
#ifdef	TERMINAL_SERVICE
int	CheckWinVer();
#endif	/* TERMINAL_SERVICE */
void	CheckArguments(char *);
HANDLE	MakeMutex(char *);
void	StopIPCD();
int	CreateIpcTable();
void	InitIPCT();
void	DestroyIpcTable();
void	ShmgetService(int, SCBUF *);
void	ShmctlService(int, SCBUF *);
void	SemgetService(int, SCBUF *);
void	SemctlService(int, SCBUF *);

int WINAPI WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, 
					LPSTR lpCmdLine, int nCmdShow )
{
	HANDLE		hPipe = INVALID_HANDLE_VALUE;
	HANDLE		hEvents[2] = {NULL, NULL};
	LPTSTR		lpszPipeName = "\\\\.\\pipe\\ipcd";
	OVERLAPPED	os;
	BOOL		bRet;
	DWORD		cbRead;
	DWORD		cbWritten;
	DWORD		dwWait;
	SCBUF		scIn;
	SCBUF		scOut;
#ifdef	TERMINAL_SERVICE
	char		*evtname;
#endif	/* TERMINAL_SERVICE */

//	FreeConsole();
#ifdef	TERMINAL_SERVICE
int	CheckWinVer();
#endif	/* TERMINAL_SERVICE */

	CheckArguments(lpCmdLine);

	if (CreateIpcTable()<0)
		ExitProcess(1);

#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		evtname = "Global\\IPCDSTOP";
	else
		evtname = "IPCDSTOP";
#endif	/* TERMINAL_SERVICE */

	hEvents[0] = CreateEvent(
		NULL,		// no security attributes
		TRUE,		// manual reset event
		FALSE,		// not-signalled
#ifdef	TERMINAL_SERVICE
		evtname );
#else
		"IPCDSTOP");	// no name
#endif	/* TERMINAL_SERVICE */

	if ( hEvents[0] == NULL)
		goto cleanup;

	hEvents[1] = CreateEvent(
		NULL,	// no security attributes
		TRUE,	// manual reset event
		FALSE,	// not-signalled
		NULL);	// no name

	if ( hEvents[1] == NULL)
		goto cleanup;
	
	hPipe = CreateNamedPipe(
		lpszPipeName,		// name of pipe
		FILE_FLAG_OVERLAPPED |
		PIPE_ACCESS_DUPLEX,	// pipe open mode
		PIPE_TYPE_MESSAGE |
		PIPE_READMODE_MESSAGE |
		PIPE_WAIT,		// pipe IO type
		1,			// number of instances
		0,			// size of outbuf (0 == allocate as necessary)
		0,			// size of inbuf
		1000,			// default time-out value
		NULL);			// security attributes

	if (hPipe == INVALID_HANDLE_VALUE) 
	{
		MessageBox(NULL, "Unable to create named pipe", "IPCD", MB_OK);
		goto cleanup;
	}


	while ( 1 )
	{
		// init the overlapped structure
		//
		memset( &os, 0, sizeof(OVERLAPPED) );
		os.hEvent = hEvents[1];
		ResetEvent( hEvents[1] );

		// wait for a connection...
		//
		ConnectNamedPipe(hPipe, &os);

		if ( GetLastError() == ERROR_IO_PENDING )
		{
			dwWait = WaitForMultipleObjects( 2, hEvents, FALSE, INFINITE );
			if ( dwWait != WAIT_OBJECT_0+1 )	// not overlapped i/o event - error occurred,
				break;				// or ipcd stop signaled
		}

		// init the read, write structure
		scIn.cmd = 0;	scIn.data = 0;
		scOut.cmd = 0;	scOut.data = 0;

		// init the overlapped structure
		//
		memset( &os, 0, sizeof(OVERLAPPED) );
		os.hEvent = hEvents[1];
		ResetEvent( hEvents[1] );

		// grab whatever's coming through the pipe...
		//
		bRet = ReadFile(
			hPipe,		// file to read from
			(char *)&scIn,	// address of input buffer
			sizeof(scIn),	// number of bytes to read
			&cbRead,	// number of bytes read
			&os);		// overlapped stuff, not needed

		if ( !bRet && ( GetLastError() == ERROR_IO_PENDING ) )
		{
			dwWait = WaitForMultipleObjects( 2, hEvents, FALSE, INFINITE );
			if ( dwWait != WAIT_OBJECT_0+1 )	// not overlapped i/o event - error occurred,
				break;				// or server stop signaled
		}

		switch (scIn.cmd)
		{
		case	SNO_SHMGET :
			ShmgetService(scIn.data, &scOut);
			break;

		case	SNO_SHMCTL :
			ShmctlService(scIn.data, &scOut);
			break;

		case	SNO_SEMGET :
			SemgetService(scIn.data, &scOut);
			break;

		case	SNO_SEMCTL :
			SemctlService(scIn.data, &scOut);
			break;

		default :
			scOut.cmd=SNO_ERROR;
			scOut.data=EINVAL;
			break;
		}
		
		// init the overlapped structure
		//
		memset( &os, 0, sizeof(OVERLAPPED) );
		os.hEvent = hEvents[1];
		ResetEvent( hEvents[1] );

		// send it back out...
		//
		bRet = WriteFile(
			hPipe,		// file to write to
			(char *)&scOut,	// address of output buffer
			sizeof(scOut),	// number of bytes to write
			&cbWritten,	// number of bytes written
			&os);		// overlapped stuff, not needed

		if ( !bRet && ( GetLastError() == ERROR_IO_PENDING ) )
		{
			dwWait = WaitForMultipleObjects( 2, hEvents, FALSE, INFINITE );
			if ( dwWait != WAIT_OBJECT_0+1 )	// not overlapped i/o event - error occurred,
				break;				// or server stop signaled
		}

		// drop the connection...
		//
		DisconnectNamedPipe(hPipe);
	}

cleanup:
	if (hShmIpcMutex) CloseHandle(hShmIpcMutex);
	if (hSemIpcMutex) CloseHandle(hSemIpcMutex);
	if (hShmPinfoMutex) CloseHandle(hShmPinfoMutex);
	if (hSemPinfoMutex) CloseHandle(hSemPinfoMutex);

	DestroyIpcTable();

	if (hPipe != INVALID_HANDLE_VALUE )
		CloseHandle(hPipe);

	if (hEvents[0])		// ipcd stop event
		CloseHandle(hEvents[0]);

	if (hEvents[1])		// overlapped i/o event
		CloseHandle(hEvents[1]);

	return TRUE;
}

#ifdef	TERMINAL_SERVICE
int	CheckWinVer()
{
	BOOL bOsVersionInfoEx;

	ZeroMemory(&osvi, sizeof(OSVERSIONINFOEX));
	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFOEX);

	if( !(bOsVersionInfoEx = GetVersionEx ((OSVERSIONINFO *) &osvi)) )
	{
	  // If OSVERSIONINFOEX doesn't work, try OSVERSIONINFO.
		osvi.dwOSVersionInfoSize = sizeof (OSVERSIONINFO);
		if (! GetVersionEx ( (OSVERSIONINFO *) &osvi) ) 
			return -1;
	}

	if( osvi.dwPlatformId != VER_PLATFORM_WIN32_NT )
		return -1;

	return 0;
}
#endif	/* TERMINAL_SERVICE */

/*
void
CheckArguments(int argc, char *argv[])
{
	if (argc>1)
	{
		if (argv[1][0] == 'D')
		{
			StopIPCD();
			ExitProcess(1);
		}
		else if (argv[1][0] != 'S')
		{
			printf("Usage : ipcd S ; Start IPCD\n");
			printf("        ipcd D ; Stop  IPCD\n");
			ExitProcess(1);
		}

		hMutex=CreateMutex(NULL, FALSE, "IPCDMUTEX");
		if (hMutex==NULL)
		{
			sprintf(tbuf, "Create Mutex error = [%d]", GetLastError());
			MessageBox(NULL, tbuf, "IPC DAEMON", MB_OK);
			ExitProcess(1);
		}
		else
		{
			if (GetLastError()==ERROR_ALREADY_EXISTS)
			{
				MessageBox(NULL, "IPC DAEMON is already active ...", 
				"IPC DAEMON", MB_OK);
				CloseHandle(hMutex);
				ExitProcess(1);
			}
		}
		return;
	}
	printf("Usage : ipcd S ; Start IPCD\n");
	printf("        ipcd D ; Stop  IPCD\n");
	ExitProcess(1);
}
*/
void
CheckArguments(char *argv)
{
	if (argv[0] == 'D' || argv[0] == 'd')
	{
		StopIPCD();
		ExitProcess(1);
	}
	else if (argv[0] != 'S' && argv[0] != 's')
	{
		sprintf(tbuf, "Usage : ipcd s ; Start IPCD\n        ipcd d ; Stop  IPCD\n");
		MessageBox(NULL, tbuf, "IPC DAEMON", MB_OK);
		ExitProcess(1);
	}

	hShmIpcMutex = MakeMutex(SHMIPCMUTEX);
	hSemIpcMutex = MakeMutex(SEMIPCMUTEX);
	hShmPinfoMutex = MakeMutex(SHMPINFOMUTEX);
	hSemPinfoMutex = MakeMutex(SEMPINFOMUTEX);
	return;
}

HANDLE
MakeMutex(char *mutexname)
{
/*2000.9.4 add---------------------------------------------------------------*/
	HANDLE	hMutex;
	char	evtname[128];
	SECURITY_ATTRIBUTES	FileMappingAttributes;
	SECURITY_DESCRIPTOR	SecuDesc;

	InitializeSecurityDescriptor( &SecuDesc, SECURITY_DESCRIPTOR_REVISION );
	SetSecurityDescriptorDacl( &SecuDesc, TRUE, NULL, FALSE );
	FileMappingAttributes.nLength = sizeof(FileMappingAttributes);
	FileMappingAttributes.lpSecurityDescriptor = &SecuDesc;
/*2000.9.4 end---------------------------------------------------------------*/

	strcpy( evtname, mutexname );
#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		sprintf( evtname "Global\\%d", mutexname );
#endif	/* TERMINAL_SERVICE */

	hMutex=CreateMutex( &FileMappingAttributes, FALSE, evtname );
	if (hMutex==NULL)
	{
		sprintf(tbuf, "Create %s Mutex error = [%d]", evtname, GetLastError());
		MessageBox(NULL, tbuf, "IPC DAEMON", MB_OK);
		ExitProcess(1);
	}
	else
	{
		if (GetLastError()==ERROR_ALREADY_EXISTS)
		{
//			MessageBox(NULL, "IPC DAEMON is already active ...", 
//			"IPC DAEMON", MB_OK);
			CloseHandle(hMutex);
			ExitProcess(1);
		}
	}
	return hMutex;
}

void
StopIPCD()
{
	HANDLE	hServerStopEvent=NULL;
#ifdef	TERMINAL_SERVICE
	char	*evtname;
#endif	/* TERMINAL_SERVICE */

#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		evtname = "Global\\IPCDSTOP";
	else
		evtname = "IPCDSTOP";
#endif	/* TERMINAL_SERVICE */

#ifdef	TERMINAL_SERVICE
	hServerStopEvent=OpenEvent( EVENT_ALL_ACCESS, FALSE, evtname );
#else
	hServerStopEvent=OpenEvent( EVENT_ALL_ACCESS, FALSE, "IPCDSTOP" );
#endif	/* TERMINAL_SERVICE */ksh
	if (hServerStopEvent == NULL)
	{
		sprintf(tbuf, "IPC DAEMON is inactive ...\n");
		MessageBox(NULL, tbuf, "IPC DAEMON", MB_OK);
		return;
	}
	SetEvent(hServerStopEvent);
	CloseHandle(hServerStopEvent);
}

int
CreateIpcTable()
{
/*2000.9.4 add---------------------------------------------------------------*/
	SECURITY_ATTRIBUTES	FileMappingAttributes;
	SECURITY_DESCRIPTOR	SecuDesc;
#ifdef	TERMINAL_SERVICE
	char	*evtname;
#endif	/* TERMINAL_SERVICE */

	InitializeSecurityDescriptor( &SecuDesc, SECURITY_DESCRIPTOR_REVISION );
	SetSecurityDescriptorDacl( &SecuDesc, TRUE, NULL, FALSE );
	FileMappingAttributes.nLength = sizeof(FileMappingAttributes);
l_ipclog("[ipcd] CreateIpcTable, FileMappingAttributes.nLength	= %d\n", FileMappingAttributes.nLength);
	FileMappingAttributes.lpSecurityDescriptor = &SecuDesc;
/*2000.9.4 end---------------------------------------------------------------*/

#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		evtname = "Global\\ipct";
	else
		evtname = "ipct";
#endif	/* TERMINAL_SERVICE */

	/*2000.9.4 change. NULL -> &FileMappingAttributes */
	hIpc=CreateFileMapping( (HANDLE)0xFFFFFFFF, &FileMappingAttributes,
#ifdef	TERMINAL_SERVICE
		PAGE_READWRITE,	0, sizeof(IPCT), evtname );
#else
		PAGE_READWRITE,	0, sizeof(IPCT), "ipct" );
#endif	/* TERMINAL_SERVICE */
	if (hIpc==NULL)
	{
		errno=GetLastError();
		return -1;
	}

	ipct=(IPCT *)MapViewOfFile(hIpc, FILE_MAP_ALL_ACCESS, 0, 0, 0);
	if (ipct==NULL)
	{
		errno=GetLastError();
		return -1;
	}

	InitIPCT();

	return 0;
}

void 
InitIPCT()
{
	int	i, j;

	for (i=0; i<MAXNOOFIPC; i++)
	{
		for (j=0; j<MAXNSEM; j++)
			memset((char *)&ipct->semb[i][j], 0, sizeof(ipct->semb[i][j]));
		memset((char *)&ipct->semt[i], 0, sizeof(SEMT));
		ipct->semt[i].key=-1;
		memset((char *)&ipct->shmt[i], 0, sizeof(SHMT));
		ipct->shmt[i].key=-1;

		memset((char *)&ipct->pseminfo[i], 0, sizeof(PSEMINFO));
		memset((char *)&ipct->pshminfo[i], 0, sizeof(PSHMINFO));
	}
}

void
DestroyIpcTable()
{
	if (ipct!=NULL)
		UnmapViewOfFile(ipct);
	if (hIpc!=NULL)
		CloseHandle(hIpc);
}

void
ShmgetService(int shmid, SCBUF *scOut)
{
#ifdef	TERMINAL_SERVICE
	char	shmstr[30];
	char	shmfile[30];
#else
	char	shmstr[16];
#endif	/* TERMINAL_SERVICE */
	char	shmpath[128];
	HANDLE	hfile;
	HANDLE	hshm;
/*2000.9.4 add---------------------------------------------------------------*/
	SECURITY_ATTRIBUTES	FileMappingAttributes;
	SECURITY_DESCRIPTOR	SecuDesc;

	InitializeSecurityDescriptor( &SecuDesc, SECURITY_DESCRIPTOR_REVISION );
	SetSecurityDescriptorDacl( &SecuDesc, TRUE, NULL, FALSE );
	FileMappingAttributes.nLength = sizeof(FileMappingAttributes);
	FileMappingAttributes.lpSecurityDescriptor = &SecuDesc;
/*2000.9.4 end---------------------------------------------------------------*/

/*
sprintf(tbuf, "ShmgetService()	start !!!");
MessageBox(NULL, tbuf, "11111", MB_OK);
sprintf(tbuf, "ShmgetService()	shmid = [%d]", shmid);
MessageBox(NULL, tbuf, "11111", MB_OK);
sprintf(tbuf, "ShmgetService()	shmt[%d].key = [%d]", shmid, shmt[shmid].key);
MessageBox(NULL, tbuf, "11111", MB_OK);
*/
	GetTempPath(sizeof(shmpath), shmpath);
#ifdef	TERMINAL_SERVICE
	MakeShmstr(shmfile, shmid, ipct->shmt[shmid].key);
#else
	MakeShmstr(shmstr, shmid, ipct->shmt[shmid].key);
#endif	/* TERMINAL_SERVICE */
	if (shmpath[strlen(shmpath)-1]!='\\' 
	&&  shmpath[strlen(shmpath)-1]!='/')
		strcat(shmpath, "\\");
#ifdef	TERMINAL_SERVICE
	strcat(shmpath, shmfile);
#else
	strcat(shmpath, shmstr);
#endif	/* TERMINAL_SERVICE */

/*
sprintf(tbuf, "ShmgetService()	shmstr = [%s]", shmstr);
MessageBox(NULL, tbuf, "11111", MB_OK);
sprintf(tbuf, "ShmgetService()	shmpath = [%s]", shmpath);
MessageBox(NULL, tbuf, "11111", MB_OK);
*/
	hfile=CreateFile(shmpath, GENERIC_READ|GENERIC_WRITE,
		FILE_SHARE_READ|FILE_SHARE_WRITE, NULL, CREATE_ALWAYS,
		FILE_ATTRIBUTE_NORMAL, NULL);

	if (hfile==INVALID_HANDLE_VALUE)
	{
		errno=GetLastError();
		scOut->cmd=SNO_ERROR;
		scOut->data=errno;
		return;
	}

	ipct->shmt[shmid].hfile=hfile;
/*
sprintf(tbuf, "ShmgetService()	hfile = [%x]", hfile);
MessageBox(NULL, tbuf, "11111", MB_OK);
*/
#ifdef	TERMINAL_SERVICE
	if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
		MakeGlobalShmstr( shmstr, shmid, ipct->shmt[shmid].key );
	else
		MakeShmstr( shmstr, shmid, ipct->shmt[shmid].key );
#endif	/* TERMINAL_SERVICE */

	/*2000.9.4 change. NULL -> &FileMappingAttributes */
	hshm=CreateFileMapping(hfile, &FileMappingAttributes, PAGE_READWRITE, 
		0, (DWORD)ipct->shmt[shmid].shmds.shm_segsz, shmstr);
	if (hshm==NULL)
	{
		errno=GetLastError();
		scOut->cmd=SNO_ERROR;
		scOut->data=errno;
		return;
	}
/*
sprintf(tbuf, "ShmgetService()	hshm = [%x]", hshm);
MessageBox(NULL, tbuf, "11111", MB_OK);
*/

	ipct->shmt[shmid].hshm=hshm;
	scOut->cmd=SNO_OK;
	scOut->data=0;
	return;
}

void
ShmctlService(int shmid, SCBUF *scOut)
{
#ifdef	TERMINAL_SERVICE
	char	shmstr[30];
#else
	char	shmstr[16];
#endif	/* TERMINAL_SERVICE */
	char	shmpath[128];

/*
sprintf(tbuf, "ShmctlService()	hshm = [%x], hfile = [%x]", 
	shmt[shmid].hshm, shmt[shmid].hfile);
MessageBox(NULL, tbuf, "ShmctlService()", MB_OK);
*/
	CloseHandle(ipct->shmt[shmid].hshm);
	CloseHandle(ipct->shmt[shmid].hfile);
	GetTempPath(sizeof(shmpath), shmpath);
	MakeShmstr(shmstr, shmid, ipct->shmt[shmid].key);
	if (shmpath[strlen(shmpath)-1]!='\\' 
	&&  shmpath[strlen(shmpath)-1]!='/')
		strcat(shmpath, "\\");
	strcat(shmpath, shmstr);
/*
sprintf(tbuf, "ShmctlService()	shmpath = [%s]", shmpath);
MessageBox(NULL, tbuf, "ShmctlService()", MB_OK);
*/

	if (DeleteFile(shmpath)==FALSE)
	{
		errno=GetLastError();
		scOut->cmd=SNO_ERROR;
		scOut->data=errno;
		return;
	}

	scOut->cmd=SNO_OK;
	scOut->data=0;
	return;
}

void
SemgetService(int semid, SCBUF *scOut)
{
	int	i;
	char	semstr[16];
	HANDLE	hsem[MAXNSEM];
/*2000.9.4 add---------------------------------------------------------------*/
	SECURITY_ATTRIBUTES	FileMappingAttributes;
	SECURITY_DESCRIPTOR	SecuDesc;

	InitializeSecurityDescriptor( &SecuDesc, SECURITY_DESCRIPTOR_REVISION );
	SetSecurityDescriptorDacl( &SecuDesc, TRUE, NULL, FALSE );
	FileMappingAttributes.nLength = sizeof(FileMappingAttributes);
	FileMappingAttributes.lpSecurityDescriptor = &SecuDesc;
/*2000.9.4 end---------------------------------------------------------------*/


	for (i=0; i<ipct->semt[semid].semds.sem_nsems; i++)
	{
#ifdef	TERMINAL_SERVICE
		if( osvi.dwMajorVersion >= 5 )	/* Windows 2000 */
			MakeGlobalSemstr(semstr,i,semid,ipct->semt[semid].key);
		else
			MakeSemstr( semstr, i, semid, ipct->semt[semid].key );
#else
		MakeSemstr( semstr, i, semid, ipct->semt[semid].key );
#endif	/* TERMINAL_SERVICE */

		/*2000.9.4 change. NULL -> &FileMappingAttributes */
		hsem[i]=CreateSemaphore(&FileMappingAttributes, 0, 10, semstr);
		if (hsem==NULL)
		{
			errno=GetLastError();
			scOut->cmd=SNO_ERROR;
			scOut->data=errno;
			return;
		}
	}

/* by KJC 98.09.24 *********************************************
	ipct->semt[semid].semds.sem_base=&ipct->semb[semid][0];
****************************************************************/
	ipct->semt[semid].semds.sem_base=(struct sem *)&ipct->semb[semid][0];
/*****************************************************************/
	for (i=0; i<ipct->semt[semid].semds.sem_nsems; i++)
		ipct->semt[semid].hsem[i]=hsem[i];

	scOut->cmd=SNO_OK;
	scOut->data=0;
	return;
}

void
SemctlService(int semid, SCBUF *scOut)
{
	int	i;

	for (i=0; i<ipct->semt[semid].semds.sem_nsems; i++)
		CloseHandle(ipct->semt[semid].hsem[i]);

	scOut->cmd=SNO_OK;
	scOut->data=0;
	return;
}


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
	fprintf( fd, "[%06d] %04d/%02d/%02d %02d:%02d:%02d ", GetCurrentProcessId(),
		t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
		t->tm_hour, t->tm_min, t->tm_sec );
	vfprintf( fd, fmt, vlist );
	va_end( vlist );

	fclose( fd );
	return 0;
}
