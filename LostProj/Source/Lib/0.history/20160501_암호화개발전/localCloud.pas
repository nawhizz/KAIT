unit localCloud;

interface
uses
  Windows, Forms;

type
    SharedMem = record
    Using       :Integer;       //사용중=1, 미사용=0
    ProgID      :String[30];    //사용중인 프로그램

    name        :String[30];
    model_name  :String[30];
    model_code  :String[30];
    serial_no   :String[30];
    ibgo_date   :String[30];
    birth       :String[30];
    phone_no    :String[30];    //  분실핸드폰번호
    phone_no2   :String[30];    //  전화번호
    po_no       :String[8];     //  우편번호
    ju_so       :String[70];    //  주소
    ddd_no      :String[4];     //  DDD번호
    po_cd       :String[6];     //  우체국코드
    pg_dt       :String[8];     //  등록일자
    ju_seq      :String[4];     //  접수일련번호
    id_no       :string[13];    //  주민번호

    end;

    TPSharedMem = ^SharedMem;

const
    SharedMemName :String = 'Lost_Project';
    REQUEST_TIMEOUT = 1000;

procedure CloseMap;             forward;
procedure CloseMapMain;         forward;
procedure UnlockMap;            forward;
procedure Lock;                 forward;
procedure UnLock;               forward;

function OpenMap:TPSharedMem;   forward;
function CreateMap:TPSharedMem; forward;
function LockMap:Boolean;       forward;


//전역변수 초기화
var HMapping  : THandle = 0;
var PSharedMem: TPSharedMem = nil;
var HMapMutex : THandle =0;
var
    g_CS:TRTLCriticalSection;

implementation

//메인 app.에서 호출할 것.
function CreateMap:TPSharedMem;
begin
    if PSharedMem <> nil then
  begin
    //CloseMap;
    FillChar(PSharedMem^, SizeOf(SharedMem), 0);
    result := PSharedMem;
    exit;
  end;

  InitializeCriticalSection(g_CS);

    HMapping := CreateFileMapping( INVALID_HANDLE_VALUE ,    // use paging file
                                 nil                  ,    // default security
                                 PAGE_READWRITE       ,    // read/write access
                                 0                    ,    // maximum object size (high-order DWORD)
                                 SizeOf(SharedMem)    ,
                                 pchar(SharedMemName)
                                );

    if (HMapping = 0) then
  begin
    DeleteCriticalSection(g_CS);
        result := nil;
    exit;
  end;

    PSharedMem := MapViewOfFile(HMapping, FILE_MAP_ALL_ACCESS, 0, 0, sizeof(SharedMem));

    if PSharedMem = nil then
  begin
    DeleteCriticalSection(g_CS);
        CloseHandle(HMapping);
    result := nil;
    exit;
    end;

    FillChar(PSharedMem^, SizeOf(SharedMem), 0);
  InitializeCriticalSection(g_CS);

  result := PSharedMem;
end;

//메인 app.에서 호출할 것.(CreateMap 호출 후)
procedure CloseMapMain;
begin
    if PSharedMem <> nil then
        UnMapViewOfFile(PSharedMem);

    if HMapping <> 0 then begin
        CloseHandle(HMapping);  //공유메모리를 완전히 삭제
    DeleteCriticalSection(g_CS);
  end;

  HMapping    := 0;
  PSharedMem  := nil;

//    DeleteCriticalSection(g_CS);
end;

//서브 app.에서 호출할 것. (OpenMap 호출 후)
procedure CloseMap;
begin
    if PSharedMem <> nil then UnMapViewOfFile(PSharedMem);

    if HMapping <> 0 then begin
//      CloseHandle(HMapping); // 공유메모리를 완전히 삭제
        DeleteCriticalSection(g_CS);
    end;

    HMapping := 0;
    PSharedMem := nil;

//    DeleteCriticalSection(g_CS);
end;

//서브 app.에서 호출할 것.
function OpenMap:TPSharedMem;
begin

    if PSharedMem <> nil then begin
        //CloseMap;
        //FillChar(PSharedMem^, SizeOf(SharedMem), 0);  //미사용
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