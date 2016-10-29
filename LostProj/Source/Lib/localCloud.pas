unit localCloud;

interface
uses
  Windows, Forms;

type
    SharedMem = record
    Using       :Integer;       //�����=1, �̻��=0
    ProgID      :String[30];    //������� ���α׷�

    name        :String[30];
    model_name  :String[30];
    model_code  :String[30];
    serial_no   :String[30];
    ibgo_date   :String[30];
    birth       :String[30];
    phone_no    :String[30];    //  �н��ڵ�����ȣ
    phone_no2   :String[30];    //  ��ȭ��ȣ
    po_no       :String[8];     //  �����ȣ
    ju_so       :String[70];    //  �ּ�
    ddd_no      :String[4];     //  DDD��ȣ
    po_cd       :String[6];     //  ��ü���ڵ�
    pg_dt       :String[8];     //  �������
    ju_seq      :String[4];     //  �����Ϸù�ȣ
    id_no       :string[13];    //  �ֹι�ȣ

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


//�������� �ʱ�ȭ
var HMapping  : THandle = 0;
var PSharedMem: TPSharedMem = nil;
var HMapMutex : THandle =0;
var
    g_CS:TRTLCriticalSection;

implementation

//���� app.���� ȣ���� ��.
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

//���� app.���� ȣ���� ��.(CreateMap ȣ�� ��)
procedure CloseMapMain;
begin
    if PSharedMem <> nil then
        UnMapViewOfFile(PSharedMem);

    if HMapping <> 0 then begin
        CloseHandle(HMapping);  //�����޸𸮸� ������ ����
    DeleteCriticalSection(g_CS);
  end;

  HMapping    := 0;
  PSharedMem  := nil;

//    DeleteCriticalSection(g_CS);
end;

//���� app.���� ȣ���� ��. (OpenMap ȣ�� ��)
procedure CloseMap;
begin
    if PSharedMem <> nil then UnMapViewOfFile(PSharedMem);

    if HMapping <> 0 then begin
//      CloseHandle(HMapping); // �����޸𸮸� ������ ����
        DeleteCriticalSection(g_CS);
    end;

    HMapping := 0;
    PSharedMem := nil;

//    DeleteCriticalSection(g_CS);
end;

//���� app.���� ȣ���� ��.
function OpenMap:TPSharedMem;
begin

    if PSharedMem <> nil then begin
        //CloseMap;
        //FillChar(PSharedMem^, SizeOf(SharedMem), 0);  //�̻��
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

//�����޸� ���� ������ ����
function LockMap:Boolean;
begin
    Result := true;

    HMapMutex := CreateMutex(nil, false, pchar('MY MUTEX NAME GOES HERE'));
    if HMapMutex = 0 then
        Result := false
    else begin
        //1�ʵ��� ������ �ö� ���� ��ٸ�.
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