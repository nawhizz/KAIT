unit u_FileDownload;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SimpleSFTP, ComCtrls, Filectrl, WinSkinData, common_lib, IniFiles,
  ExtCtrls, so_tmax;

const
  TITLE   = '���ϴٿ�ε�';
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
    underFlag:boolean;	//���� �ٿ�ε��� '_'�� �ִ� �ܿ� true;

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

//   ======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
//    if ParamCount <> 2 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
//      ShowMessage('�α��ο��� ���� �ϼ���');
//      PostMessage(self.Handle, WM_QUIT, 0,0);
//      exit;
//    end;

    // ���α׷� ĸ�� ����
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // �׽�ũ�� ĸ�Ǽ���
    Application.Title := TITLE;

    // ���α׷� ���� ������ ����
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // ���α׷� ���� ��ġ ����
    Self.Position     := poScreenCenter;
    //���뺯�� ����--common_lib.pas ������ ��.
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

  //Ŭ���̾�Ʈ�� ini������ ������ �о� ���δ�.
  iniSet       := TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');

  localVersion := iniSet.ReadInteger('CLIVER', 'LASTVER', 0);
  firstVersion := iniSet.ReadString('CLIVER', '���ʹ����ٿ�ε忩��', 'NO');
  iniSet.Free;
  iniSet:= nil;

  if firstVersion = 'YES' then
    versionFile:= 'version0000.txt'
  else
    versionFile:= 'versionFile.txt';

  localVersionFile:= localBasicPath + '\Temp\'+ versionFile;


  underFlag:= false;	//fileDownload_.exe �� lostLogin_.exe �� ���� ��� True;

  if firstVersion = 'NO' then begin
    if localVersion = 0 then begin
      StatusBar1.Panels[1].Text := '�ٿ�ε��� �����Ͱ� �����ϴ�...��� ��ٷ� �ֽʽÿ�';
      Application.ProcessMessages;

      PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0); //wParam =1, fileDownload.exe���� Sent
      PostMessage(self.Handle, WM_QUIT,0 ,0);
    end;
  end;

  StatusBar1.Panels[1].Text := '�ٿ�ε� ������ ���� ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

  FSFTP := TSimpleSFTP.Create;

  FSFTP.Connect(Self.ftp.ftpIp,Self.ftp.ftpPort, Self.ftp.ftpId, Self.ftp.ftpPw);

  //������ �ʿ��� ������ �ִ��� Ȯ�� �ϴ� ������� �ٸ� �޼ҵ带 ����� ���� ������
  //�޼Ҵ� �� �۵����� ���� ����� �Ʒ��� ���� ����� ����Ѵ�.
  //���ʹ��� �ٿ�ε� �ϴ� ���
  try
    FSFTP.GetFile(remoteBasicPath, versionFile , localVersionFile ,True,True,False,0,nil,nil);
  except
    StatusBar1.Panels[1].Text := '���Ϲ�������('+ versionFile+ ')�� �����ϴ�...��� ��ٷ� �ֽʽÿ�';
    Application.ProcessMessages;

    FSFTP.Disconnect;
    //FSFTP.Free; <---�̷л� ����  �̷��� �ؾ� �ϴµ�...GetFile�޼ҵ� ȣ��� ������ �߻�������
    //������Ʈ �����Ͱ� ������....
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

      StatusBar1.Panels[1].Text := '������Ʈ�� ������ �����ϴ�...��� ��ٷ� �ֽʽÿ�';
      Application.ProcessMessages;

      FSFTP.Disconnect;
      FSFTP.Free;

      PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 1, 0);
      PostMessage(self.Handle, WM_QUIT,0 ,0);

      Exit;
    end;
  end;

  //ini���Ͽ� ���� ������ ������Ʈ �Ѵ�.
  iniSet:= TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');

  if firstVersion = 'YES' then
    iniSet.WriteString('CLIVER', '���ʹ����ٿ�ε忩��', 'NO')
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

  //�ٿ�ε� �� ��ü ���� ����� ���Ѵ�.
  TotalFSize := 0;

  for i:=0 to fileCount-1 do begin
    buf:= remoteBasicPath + '/'+ remoteFileDir +'/'+ downFiles[i].DownFile;
    TotalFSize := TotalFSize + FSFTP.GetFileSize(buf);
  end;

  StatusBar1.Panels[1].Text := '�ٿ�ε� ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

  //������ �ٿ�ε� �Ѵ�.
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

  StatusBar1.Panels[1].Text := '������ ������ ���� ��...��� ��ٷ� �ֽʽÿ�';
  Application.ProcessMessages;

  FSFTP.Disconnect;
  FSFTP.Free;

  if underFlag then  	 //�ٿ�ε� ���� ������...download.exe �� lostLogin.exe ������ �ִ�.
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


  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

  ftp.ftpIp   := TMAX.Host;
  ftp.ftpPort := fGetftpPort;
  ftp.ftpId   := fGetftpId;
  ftp.ftpPw   := fGetftpPw;

  result := ftp;

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server�� ã���� �����ϴ�.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX ������ ����Ǿ� ���� �ʽ��ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);

	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX �޸� �Ҵ翡 ���� �Ͽ����ϴ�.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

	if not TMAX.Start then begin
    ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                      ) < 0) then  goto LIQUIDATION;


  //���� ȣ��
  if not TMAX.Call('LOSTZ900Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

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

