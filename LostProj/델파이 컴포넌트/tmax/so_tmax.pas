unit so_tmax;

interface   

uses
  Classes, SysUtils, Dialogs, IniFiles, IdTCPClient, Atmi, fml,
  ComCtrls;

const
  DEFAULT_CONNECT_TIMEOUT = 60;
  MAX_MSG_CNT = 9;

type
  ETMAXError = class(Exception);
  ETMAXConnectError = class(ETMAXError);

  TEMsgList = array[0..MAX_MSG_CNT] of LongInt;

  TConnectEvent    = procedure (Sender: TObject; AServer, AHost: string; APort: Integer) of object;
  TDisconnectEvent = procedure (Sender: TObject; AServer, AHost: string; APort: Integer) of object;
  TBeforCallEvent  = procedure (Sender: TObject; AServer, AService: string) of object;
  TAfterCallEvent  = procedure (Sender: TObject; AServer, AService, Msg: string) of object;
  TFreeBufferEvent = procedure (Sender: TObject; ABuffer: Pointer; ASize: Integer) of object;
  TAllocBufferEvent= procedure (Sender: TObject; ABuffer: Pointer; ASize: Integer) of object;


  TTMAX = class(TComponent)
  private
    FFileName: TFileName;
    FIniFile: TIniFile;
    FActive: Boolean;
    FServer: string;
    FHost: string;
    FPort: Integer;
    FTimeout: Integer;

    FBuffer: Pointer;
    FBufferSize: Integer;
    FRecvSize: Integer;

    FServers: TStringList;

    FErrorMsg: string;
    FErrorMsgList: TEMsgList;

    FTCPClient: TIdTCPClient;

    FOnConnect: TConnectEvent;
    FOnDisconnect: TDisconnectEvent;
    FOnBeforCall: TBeforCallEvent;
    FOnAfterCall: TAfterCallEvent;
    FOnFreeBuffer: TFreeBufferEvent;
    FOnAllocBuffer: TAllocBufferEvent;

    procedure SetActive(const Value: Boolean);
    procedure SetFileName(const Value: TFileName);
    procedure SetServer(const Value: string);
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Ping: Boolean;
    function Connect: Boolean;
    function ReadEnvFile(const AFileName: string = ''): Boolean;
    function Start: Boolean;
    procedure InitBuffer;
    function Connected: Boolean;
    function Selected(AServer: string): Boolean;
    function AllocBuffer(Size: Integer): Boolean;
    function BufferAlloced: Boolean;
    function SendString(AKey: string; Value: string): Integer;
    function SendInteger(AKey: string; Value: Integer): Integer;
    function SendDouble(AKey: string; Value: Double): Integer;
    function Call(AService: string): Boolean;
    function RecvString(AKey: string; NoSeq: Integer): string;
    function RecvInteger(AKey: string; NoSeq: Integer): Integer;
    function RecvDouble(AKey: string; NoSeq: Integer): Double;
    procedure FreeBuffer;
    function ToDouble(Value: Double): Double;
    function ToInteger(Value: Integer): Integer;
    procedure EndTMAX;
    procedure Disconnect;
    Function getFoccur(Fname: string): integer;

    property ErrorMsg: string read FErrorMsg write FErrorMsg;
    property ErrorMsgList: TEMsgList read FErrorMsgList write FErrorMsgList;
    property Buffer: Pointer read FBuffer write FBuffer;
    property Servers: TStringList read FServers;
    property RecvSize: Integer read FRecvSize;
    property BufferSize: Integer read FBufferSize;
  published
    property Active: Boolean read FActive write SetActive default FALSE;
    property FileName: TFileName read FFileName write SetFileName;
    property Server: string read FServer write SetServer;
    property Host: string read FHost;
    property Port: Integer read FPort;

    property OnConnect: TConnectEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TDisconnectEvent read FOnDisconnect write FOnDisconnect;
    property OnBeforCall: TBeforCallEvent read FOnBeforCall write FOnBeforCall;
    property OnAfterCall: TAfterCallEvent read FOnAfterCall write FOnAfterCall;
    property OnFreeBuffer: TFreeBufferEvent read FOnFreeBuffer write FOnFreeBuffer;
    property OnAllocBuffer: TAllocBufferEvent read FOnAllocBuffer write FOnAllocBuffer;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('SoTmax', [TTMAX]);
end;


{ TTMAX }

constructor TTMAX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FServers   := TStringList.Create;
  FTCPClient := TIdTCPClient.Create(Self);
  FBuffer    := nil;
  FBufferSize:= 0;
end;

destructor TTMAX.Destroy;
begin
  FreeAndNil(FServers);
  FreeAndNil(FIniFile);
  if FTCPClient.Connected then
    FTCPClient.Disconnect;
  FreeAndNil(FTCPClient);

  inherited Destroy;
end;

function TTMAX.Connect: Boolean;
begin
  Result := FALSE;
  if Length(FServer) = 0 then
    Exit;

  if not FActive then
  begin
    if tmaxreadenv(PChar(FFileName), PChar(FServer)) >= 0 then
    begin
      FActive := TRUE;
      if Assigned(FOnConnect) then
        FOnConnect(Self, FServer, FHost, FPort);
    end;
  end;
end;

procedure TTMAX.Disconnect;
begin
  if FActive then
  begin
    if Assigned(FOnDisconnect) then
      FOnDisconnect(Self, FServer, FHost, FPort);

    tpend();
    FActive := FALSE;
  end;
end;

procedure TTMAX.SetActive(const Value: Boolean);
begin
  if Value then
    Connect
  else
    Disconnect;
end;

procedure TTMAX.SetFileName(const Value: TFileName);
begin
  if (csReading in ComponentState) then
    FFileName := Value
  else
  begin
    if not FileExists(Value) then
      FFileName := ''
    else
      FFileName := Value;
  end;

  if FFileName <> '' then
  begin
    if FIniFile <> nil then
      FreeAndNil(FIniFile);

    try
      FIniFile := TIniFile.Create(FFileName);
    finally
      FServers.Clear;
      FIniFile.ReadSections(FServers);
    end;
  end;
end;

function TTMAX.Ping: Boolean;
begin
  Result := FALSE;

  if (Length(FServer) = 0) or (Length(FHost) = 0) or (FPort = -1) then
    Exit;

  FTCPClient.Host := FHost;
  FTCPClient.Port := FPort;

  try
    FTCPClient.Connect(FTimeout);
  except
    on E:Exception do
    begin
    end;
  end;

  if FTCPClient.Connected then
  begin
    FTCPClient.Disconnect;
    Result := TRUE;
  end;
end;

procedure TTMAX.SetServer(const Value: string);
var
  i: Integer;
  ACheckServer: Boolean;
begin
  ACheckServer := FALSE;
  for i:=0 to FServers.Count -1 do
  begin
    if UpperCase(FServers[i]) = Value then
    begin
      ACheckServer := TRUE;
      break;
    end;
  end;

  if not ACheckServer then
  begin
    MessageDlg('['+Value+'] TMAX Server not found.'+#13#13+
               '('+FFileName+')',
               mtError, [mbOK], 0);
    Exit;
  end;

  FServer := Value;

  if FServer = '' then
  begin
    FHost    := '';
    FPort    := -1;
    FTimeout := DEFAULT_CONNECT_TIMEOUT;
  end else
  begin
    FHost    := FIniFile.ReadString (FServer, 'TMAX_HOST_ADDR', '');
    FPort    := FIniFile.ReadInteger(FServer, 'TMAX_HOST_PORT', -1);
    FTimeout := FIniFile.ReadInteger(FServer, 'TMAX_CONNECT_TIMEOUT', DEFAULT_CONNECT_TIMEOUT) * 1000;
  end;
end;

function TTMAX.Connected: Boolean;
begin
  Result := FActive;
end;

function TTMAX.Selected(AServer: string): Boolean;
begin
  if AServer = FServer then
    Result := TRUE
  else
    Result := FALSE;
end;

function TTMAX.AllocBuffer(Size: Integer): Boolean;
begin
    Result := FALSE;

    FBufferSize := Size;
    if not Assigned(FBuffer) then
        FBuffer := tpalloc('FIELD', nil, FBufferSize)
    else
        tprealloc(FBuffer, FBufferSize);

    if Assigned(FBuffer) then
        begin
        Result := TRUE;
        if Assigned(FOnAllocBuffer) then
            FOnAllocBuffer(Self, FBuffer, FBufferSize);
        end;
end;

function TTMAX.BufferAlloced: Boolean;
begin
  Result := Assigned(FBuffer);
end;

function TTMAX.Call(AService: string): Boolean;
var
  i: Integer;
  AErrorMsg: string;
begin
  Result := FALSE;

  if Assigned(FOnBeforCall) then
    FOnBeforCall(Self, FServer, AService);

  AErrorMsg := '';
  FRecvSize := 0;    
  if tpcall(PChar(AService), FBuffer, 0, @FBuffer, @FRecvSize, TPNOTRAN) < 0 then
  begin
    for i:=0 to MAX_MSG_CNT do
    begin
      if FErrorMsgList[i] > 0 then
        AErrorMsg := AErrorMsg + fbgetvals(FBuffer, FErrorMsgList[i],0);
    end;

    if Trim(AErrorMsg) = '' then
    begin
      AErrorMsg := tpstrerror(gettperrno);
      if Trim(AErrorMsg) = '' then
        AErrorMsg := 'TMAX Call fail. ['+FServer+']';
    end;
  end else
    Result := TRUE;

  FErrorMsg := AErrorMsg;

  if Assigned(FOnAfterCall) then
    FOnAfterCall(Self, FServer, AService, AErrorMsg);
end;

function TTMAX.RecvString(AKey: string; NoSeq: Integer): string;
begin
  Result := '';
  if FBuffer = nil then
    Exit;

  Result := Trim(fbgetvals(FBuffer, Fldid(PChar(AKey)), NoSeq));
end;

procedure TTMAX.FreeBuffer;
begin
  if Assigned(FOnFreeBuffer) then
    FOnFreeBuffer(Self, FBuffer, FBufferSize);

  if Assigned(FBuffer) then
  begin
    tpFree(FBuffer);
    FBuffer := nil;
  end;
end;

function TTMAX.ToDouble(Value: Double): Double;
var
  pdbl: ^Double;
  pbts,
  rbts: array[0..8] of byte;
  i: Integer;
begin
  pdbl  := @pbts;
  pdbl^ := Value;

  for i := 0 to 7 do
    rbts[7 - i] := pbts[i];

  pdbl    := @rbts;

  Result := pdbl^;
end;

function TTMAX.ToInteger(Value: Integer): Integer;
var
  pdbl: ^Integer;
  pbts,
  rbts: array[0..4]   of byte;
  i: Integer;
begin
  pdbl := @pbts;
  pdbl^ := Value;

  for i := 0 to 3 do
    rbts[3 - i] := pbts[i];

  pdbl := @rbts;

  Result := pdbl^;
end;

function TTMAX.Start: Boolean;
var
  TPInfo: pTPSTART;
begin
  Result := FALSE;

  TPInfo := tpalloc('TPSTART', nil, 100);
  if TPInfo <> nil then
  begin
    Result := TRUE;
    tpfree(TPInfo);
  end;
end;

function TTMAX.SendDouble(AKey: string; Value: Double): Integer;
begin
  if FBuffer = nil then
  begin
    Result := -1;
    Exit;
  end;

  if fbput(FBuffer, Fldid(PChar(AKey)), @Value, 0) < 0 then
  begin
    Result := -2;
    Exit;
  end;

  Result := 0;
end;

function TTMAX.SendInteger(AKey: string; Value: Integer): Integer;
begin
  if FBuffer = nil then
  begin
    Result := -1;
    Exit;
  end;

  if fbput(FBuffer, Fldid(PChar(AKey)), @Value, 0) < 0 then
  begin
    Result := -2;
    Exit;
  end;

  Result := 0;
end;

function TTMAX.SendString(AKey: string; Value: string): Integer;
begin
  if FBuffer = nil then
  begin
    Result := -1;
    Exit;
  end;

  if fbput(FBuffer, Fldid(PChar(AKey)), PChar(Value), 0) < 0 then
  begin
    Result := -2;
    Exit;
  end;

  Result := 0;
end;

procedure TTMAX.InitBuffer;
begin
  fbinit(FBuffer, fbget_fbsize(FBuffer));
  tpend();
end;

function TTMAX.RecvDouble(AKey: string; NoSeq: Integer): Double;
begin
  Result := 0;
  if FBuffer = nil then
    Exit;

  Result := StrToFloatDef(Trim(fbgetvals(FBuffer, Fldid(PChar(AKey)), NoSeq)), 0);
end;

function TTMAX.RecvInteger(AKey: string; NoSeq: Integer): Integer;
begin
  Result := 0;
  if FBuffer = nil then
    Exit;

  Result := StrToIntDef(Trim(fbgetvals(FBuffer, Fldid(PChar(AKey)), NoSeq)), 0);
end;

function TTMAX.ReadEnvFile(const AFileName: string): Boolean;
var
  sFileName: string;
begin
  Result := FALSE;

  if Length(FServer) = 0 then
    Exit;
      
  sFileName := '';
  if Length(FileName) = 0 then
  begin
    if FFileName = '' then
      Exit
    else
      sFileName := FFileName;
  end else
    sFileName := FileName;

  if not FileExists(sFileName) then
    Exit;

  if tmaxreadenv(PChar(sFileName), PChar(FServer)) >= 0 then
  begin
    FileName := sFileName;
    FActive := TRUE;
    if Assigned(FOnConnect) then
      FOnConnect(Self, FServer, FHost, FPort);
  end;
end;

procedure TTMAX.EndTMAX;
begin
  tpend();
end;

Function TTMAX.getFoccur(Fname: string): integer;
var
   ret: integer;
begin
   ret := fbkeyoccur(FBuffer, fbget_fldkey(PChar(Fname)));
   Result := ret;
end;

end.
