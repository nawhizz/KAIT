unit u_FileDownload;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SimpleSFTP, ComCtrls, Filectrl, WinSkinData, common_lib, IniFiles,
  ExtCtrls, so_tmax;

const
  TITLE   = '파일다운로드';
  PGM_ID  = 'FileDownload';

type
	TDownloadFile = record
    DownFile:String[50];
    AuxDir:String[30];
end;

TArrayDownloadFile = Array of TDownloadFile;

  ftpInfo = record
    ftpIp   : string;
    ftpPort : string;
    ftpId   : string;
    ftpPw   : string;
  end;

type
  TFileDownloadFrm = class(TForm)
    GetFileButton: TButton;
    ProgressBar: TProgressBar;
    FileNameLabel: TLabel;
    ProgressBar1: TProgressBar;
    SkinData1: TSkinData;
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    TMAX: TTMAX;
    procedure FormCreate(Sender: TObject);
    procedure GetFileButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    DefaultPosi:Int64;
    PrevCurrent:Int64;
    TotalFSize:Int64;
    underFlag:boolean;	//파일 다운로드중 '_'가 있는 겨우 true;

    ftp : ftpInfo;

  public
    { Public declarations }
    function getFtpIp: ftpInfo;
    function TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
  end;

var
  FileDownloadFrm: TFileDownloadFrm;

implementation

{$R *.DFM}

procedure TFileDownloadFrm.FormCreate(Sender: TObject);
begin
	initSkinForm(SkinData1);

//   ======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
//    if ParamCount <> 2 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
//      ShowMessage('로그인에서 실행 하세요');
//      PostMessage(self.Handle, WM_QUIT, 0,0);
//      exit;
//    end;

    // 프로그램 캡션 설정
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // 테스크바 캡션설정
    Application.Title := TITLE;

    // 프로그램 보더 아이콘 설정
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // 프로그램 시작 위치 설정
    Self.Position     := poScreenCenter;
    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait:= ParamStr(1);
	  common_caller:= ParamStr(2);

    Self.ftp := getFtpIp;

    underFlag:= false;

    FileNameLabel.Caption:='   ';

    Left:= 100;
    Top:=100;
end;

function TFileDownloadFrm.TransferProgress(UserData:Pointer;Current,Total:Int64):Boolean;
begin
  if Total=0 then begin
  	ProgressBar.Position:=0;
    DefaultPosi:= DefaultPosi + PrevCurrent;
  end
  else begin
  	ProgressBar.Position  :=Round(Current/Total*ProgressBar.Max);
  	ProgressBar1.Position :=Round((DefaultPosi+Current)/TotalFSize*ProgressBar1.Max);
    PrevCurrent:= Current;
  end;

  Application.ProcessMessages;
  Result:=True;
end;

procedure TFileDownloadFrm.GetFileButtonClick(Sender: TObject);
var
    IniSet:TIniFile;
    FSFTP:TSimpleSFTP;
    F:TextFile;

    firstVersion:String;	//YES or NO
    versionFile:String;		//versionFile.txt or version0000.txt
    buf:String;
    fileCount:Integer;

    localBasicPath:String;
    localVersionFile:String;
    remoteBasicPath:String;
    remoteFileDir:String;

    localVersion:Integer;
    remoteVersion:Integer;
    i:Integer;

    downFiles:TArrayDownloadFile;
begin
	//current execution file = ..\KAIT\LostPrj\Bin\FileDownload.exe
  localBasicPath:= GetCurrentDir; //..\KAIT\LostPrj\Bin
  localBasicPath:= getFrontName(localBasicPath, '\');	//..\KAIT\LostPrj
  remoteBasicPath:= './version';

  //클라이언트의 ini파일의 버젼을 읽어 들인다.
  iniSet       := TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');

  localVersion := iniSet.ReadInteger('CLIVER', 'LASTVER', 0);
  firstVersion := iniSet.ReadString('CLIVER', '최초버전다운로드여부', 'NO');
  iniSet.Free;
  iniSet:= nil;

  if firstVersion = 'YES' then
    versionFile:= 'version0000.txt'
  else
    versionFile:= 'versionFile.txt';

  localVersionFile:= localBasicPath + '\Temp\'+ versionFile;


  underFlag:= false;	//fileDownload_.exe 나 lostLogin_.exe 이 있을 경우 True;

  if firstVersion = 'NO' then begin
    if localVersion = 0 then begin
      StatusBar1.Panels[1].Text := '다운로드할 데이터가 없습니다...잠시 기다려 주십시오';
      Application.ProcessMessages;

      PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0); //wParam =1, fileDownload.exe에서 Sent
      PostMessage(self.Handle, WM_QUIT,0 ,0);
    end;
  end;

  StatusBar1.Panels[1].Text := '다운로드 서버에 연결 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

  FSFTP := TSimpleSFTP.Create;

  FSFTP.Connect(Self.ftp.ftpIp,Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);

  //서버에 필요한 파일이 있는지 확인 하는 방법으로 다른 메소드를 사용할 수도 있으나
  //메소다 잘 작동하지 않은 관계로 아래와 같은 방법을 사용한다.
  //최초버전 다운로드 하는 방법
  try
    FSFTP.GetFile(remoteBasicPath, versionFile , localVersionFile ,True,True,False,0,nil,nil);
  except
    StatusBar1.Panels[1].Text := '파일버전정보('+ versionFile+ ')가 없습니다...잠시 기다려 주십시오';
    Application.ProcessMessages;

    FSFTP.Disconnect;
    //FSFTP.Free; <---이론상 으론  이렇게 해야 하는데...GetFile메소드 호출시 에러가 발생함으로
    //오브젝트 포인터가 없어짐....
    PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0);
    PostMessage(self.Handle, WM_QUIT,0 ,0);
  end;

  AssignFile(f, localVersionFile);
  Reset(f);
  ReadLn(f, buf);
  buf:= Trim(buf);

  remoteFileDir:= getFrontName(buf, '|');
  remoteVersion:= StrToInt(remoteFileDir);

  if firstVersion = 'NO' then begin
    if  remoteVersion <= localVersion then begin
      CloseFile(f);

      StatusBar1.Panels[1].Text := '업데이트할 파일이 없습니다...잠시 기다려 주십시오';
      Application.ProcessMessages;

      FSFTP.Disconnect;
      FSFTP.Free;

      PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0);
      PostMessage(self.Handle, WM_QUIT,0 ,0);

      Exit;
    end;
  end;

  //ini파일에 최종 버젼을 업데이트 한다.
  iniSet:= TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');

  if firstVersion = 'YES' then
    iniSet.WriteString('CLIVER', '최초버전다운로드여부', 'NO')
  else
    iniSet.WriteInteger('CLIVER', 'LASTVER', remoteVersion);

  iniSet.Free;

  fileCount:= strToInt(GetFinalName(buf,'|'));
  SetLength(downFiles, fileCount);

  for i:=0 to fileCount-1 do
  begin
    ReadLn(f, buf);
    buf:= Trim(buf);
    downFiles[i].AuxDir:= Trim(GetFrontName(buf,'\'));
    downFiles[i].DownFile:= Trim(GetFinalName(buf,'\'));
  end;

  CloseFile(f);

  //다운로드 할 전체 파일 사이즈를 구한다.
  TotalFSize := 0;

  for i:=0 to fileCount-1 do begin
    buf:= remoteBasicPath + '/'+ remoteFileDir +'/'+ downFiles[i].DownFile;
    TotalFSize := TotalFSize + FSFTP.GetFileSize(buf);
  end;

  StatusBar1.Panels[1].Text := '다운로드 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

  //파일을 다운로드 한다.
  for i:=0 to fileCount-1 do
  begin
    if (UpperCase(downFiles[i].DownFile) = 'LOSTLOGIN.EXE') or
       (UpperCase(downFiles[i].DownFile) = 'FILEDOWNLOAD.EXE') then
    begin
      buf:= localBasicPath + '\'+ downFiles[i].AuxDir + '\'+ fChngUnderbar(downFiles[i].DownFile);
      underFlag:= True;
    end
    else
      buf:= localBasicPath + '\'+ downFiles[i].AuxDir + '\'+ downFiles[i].DownFile;

    FileNameLabel.Caption:= downFiles[i].DownFile;
    TransferProgress(nil,0,0);
    FSFTP.GetFile(remoteBasicPath + '/'+ remoteFileDir, downFiles[i].DownFile,
    buf,True,True,False,0,TransferProgress,nil);
  end;

  StatusBar1.Panels[1].Text := '서버와 연결을 끊는 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

  FSFTP.Disconnect;
  FSFTP.Free;

  if underFlag then  	 //다운로드 받은 파일중...download.exe 와 lostLogin.exe 파일이 있다.
    PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 1)
  else
    PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0);

  PostMessage(self.Handle, WM_QUIT,0 ,0);
end;

procedure TFileDownloadFrm.FormShow(Sender: TObject);
begin
	Timer1.Enabled:= True;
end;

procedure TFileDownloadFrm.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled:= False;
  GetFileButtonClick(self);
end;

function TFileDownloadFrm.getFtpIp: ftpInfo;
var ftp : ftpInfo;

  Label LIQUIDATION;
begin


  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := fGetftpPort;
  ftp.ftpId   := fGetftpId;
  ftp.ftpPw   := fGetftpPw;

  result := ftp;

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
    goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);

	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

	if not TMAX.Start then begin
    ShowMessage('TMAX 시작에 실패 하였습니다.');
    goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                      ) < 0) then  goto LIQUIDATION;


  //서비스 호출
  if not TMAX.Call('LOSTZ900Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := TMAX.RecvString('STR402',0);
  ftp.ftpId   := TMAX.RecvString('STR403',0);
  ftp.ftpPw   := TMAX.RecvString('STR404',0);

  Result := ftp;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

end;

end.

