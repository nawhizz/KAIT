unit localCloud;

interface
uses
  Windows, Forms, Dialogs;

type
	SharedMem = record
		Name: string[30];
		Phone: string[14];
	end;
	TPSharedMem = ^SharedMem;

const
	SharedMemName:String = 'Lost_Project';
	REQUEST_TIMEOUT = 1000;

function CreateMap:TPSharedMem;forward;
procedure CloseMap;forward;
function OpenMap:TPSharedMem;forward;
function LockMap:Boolean;forward;
procedure UnlockMap;forward;
procedure Lock;forward;
procedure UnLock;forward;

//전역변수 초기화
var	HMapping: THandle = 0;
var PSharedMem: TPSharedMem = nil;
var HMapMutex: THandle =0;
var
	g_CS:TRTLCriticalSection;

implementation

//메인화면에서 사용할 것.
function CreateMap:TPSharedMem;
begin
	if PSharedMem <> nil then begin
    	//CloseMap;
    	result := PSharedMem;
        exit;
    end;

    InitializeCriticalSection(g_CS);

	HMapping := CreateFileMapping(
                 INVALID_HANDLE_VALUE,    // use paging file
                 nil,                    // default security
                 PAGE_READWRITE,          // read/write access
                 0,                       // maximum object size (high-order DWORD)
                 SizeOf(SharedMem),
                 pchar(SharedMemName) );

	if (HMapping = 0) then  begin
    	DeleteCriticalSection(g_CS);
		result := nil;
        exit;
    end;

	PSharedMem := MapViewOfFile(HMapping, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(SharedMem));
	if PSharedMem = nil then  begin
    	DeleteCriticalSection(g_CS);
		CloseHandle(HMapping);
        result := nil;
        exit;
	end;

	FillChar(PSharedMem^, SizeOf(SharedMem), 0);
    InitializeCriticalSection(g_CS);

    result := PSharedMem;
end;

//메인/서브 화면에서 사용할 것.
procedure CloseMap;
begin
	if PSharedMem <> nil then
		UnMapViewOfFile(PSharedMem);

	if HMapping <> 0 then begin
		CloseHandle(HMapping);
    	DeleteCriticalSection(g_CS);
    end;

    HMapping := 0;
    PSharedMem := nil;

//    DeleteCriticalSection(g_CS);
end;

//서브화면에서 사용할 것.
function OpenMap:TPSharedMem;
begin

	if PSharedMem <> nil then begin
    	//CloseMap;
    	result := PSharedMem;
        exit;
    end;

	InitializeCriticalSection(g_CS);

	HMapping := OpenFileMapping(
                   FILE_MAP_ALL_ACCESS,   // read/write access
                   FALSE,                 // do not inherit the name
                   PChar(SharedMemName)); // name of mapping object

	if (HMapping = 0) then  begin
    	DeleteCriticalSection(g_CS);
		result := nil;
        exit;
    end;

	PSharedMem := MapViewOfFile(HMapping, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(SharedMem));
	if PSharedMem = nil then  begin
    	DeleteCriticalSection(g_CS);
		CloseHandle(HMapping);
        result := nil;
        exit;
	end;

	FillChar(PSharedMem^, SizeOf(SharedMem), 0);

    result := PSharedMem;
end;

//공유메모리 동시 엑세스 방지
function LockMap:Boolean;
begin
	Result := true;

	HMapMutex := CreateMutex(nil, false, pchar('MY MUTEX NAME GOES HERE'));
	if HMapMutex = 0 then
		Result := false
	else begin
    	//1초동안 응답이 올때 까지 기다림.
		if WaitForSingleObject(HMapMutex,REQUEST_TIMEOUT) = WAIT_FAILED then
			// timeout
            result := false;
	end;
end;

procedure UnlockMap;
begin
	if HMapMutex <> 0 then begin
		ReleaseMutex(HMapMutex);
		CloseHandle(HMapMutex);
    end;
end;

procedure Lock;
begin
	EnterCriticalSection(g_CS);
end;

procedure UnLock;
begin
	LeaveCriticalSection(g_CS);
end;

end.
