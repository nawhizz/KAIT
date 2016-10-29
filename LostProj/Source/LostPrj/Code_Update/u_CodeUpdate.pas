unit u_CodeUpdate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SimpleSFTP, ComCtrls, Filectrl, WinSkinData, common_lib, IniFiles,
  ExtCtrls, so_tmax;

const
  TITLE   = '공통코드업데이트';
  PGM_ID  = 'CodeUpdate';

type
  TCodeUpdateFrm = class(TForm)
    GetFileButton: TButton;
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

  public
    { Public declarations }
  end;

var
  CodeUpdateFrm: TCodeUpdateFrm;

implementation

{$R *.DFM}

procedure TCodeUpdateFrm.FormCreate(Sender: TObject);
begin
	initSkinForm(SkinData1);

   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	if ParamCount <> 2 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    ShowMessage('로그인에서 실행 하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
    end;

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait  := ParamStr(1);
  common_caller:= ParamStr(2);

  Left  := 100;
  Top   := 100;
end;

//'Code Update' 버튼 클릭
procedure TCodeUpdateFrm.GetFileButtonClick(Sender: TObject);
var
    iniSet:TIniFile;
    f:TextFile;
    localBasicPath:String;
    fileVersion:String;
    oldGubun, newGubun:String;

    buf:Array[0..121]of Char;
    count,i:Integer;

    LABEL LIQUIDATION;

    procedure SetString(start:Integer; src:String);
    var
    	len,i:Integer;
    begin
        if src='' then
        	exit;

        len := Length(src);
        for i:=1 to len do
        	buf[start+i-1]:= src[i];
    end;

    procedure NewFile(fname:String);
    var
    	path:String;
    begin
        path:= localBasicPath + '\Data\' + fname + '.dat';
        AssignFile(f, path);
        ReWrite(f);
    end;

begin
  localBasicPath:= GetCurrentDir; //..\KAIT\LostPrj\Bin
  localBasicPath:= getFrontName(localBasicPath, '\');	//..\KAIT\LostPrj

  //클라이언트의 ini파일의 버젼을 읽어 들인다.
  iniSet:= TIniFile.Create(localBasicPath +'\Ini\LostProj.ini');
  fileVersion := iniSet.ReadString('CLIVER', 'LASTCODE', '');

  if fileVersion = '' then begin
    iniSet.Free;

    StatusBar1.Panels[1].Text := 'LostProj.ini 파일에 LASTCODE 항목이 없습니다';
    Application.ProcessMessages;

    //여기서 호출한 윈도우에 메세지를 보낸다.
    PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 2, 0); //wParam =2, 공통코드에서 센딩..
    PostMessage(self.Handle, WM_QUIT,0 ,0);
  end;

  //서버에서 코드를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ910Q'      ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', fileVersion     ) < 0) then  goto LIQUIDATION;

  StatusBar1.Panels[1].Text := '서버에 연결 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

  //서비스 호출
	if not TMAX.Call('LOSTZ910Q') then begin
    	MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    	goto LIQUIDATION;
  end;


  fileVersion:= TMAX.RecvString('STR100',0);
  //ini파일에 최종 버젼을 업데이트 한다.
  iniSet.WriteString('CLIVER', 'LASTCODE', fileVersion);
  iniSet.Free;

  count := TMAX.RecvInteger('INT100',0);

  ProgressBar1.Min:=0;
  ProgressBar1.Max:= count;
  ProgressBar1.Position:=0;

  StatusBar1.Panels[1].Text := '공통코드 업데이트 중...잠시 기다려 주십시오';
  Application.ProcessMessages;

	oldGubun:='START';

  for i:=0 to count-1 do
  begin
    newGubun := Trim(TMAX.RecvString('STR101', i));

    if oldGubun <> newGubun then
    begin
      if oldGubun <> 'START' then
        CloseFile(f);

      NewFile(newGubun);
    end
    else
      Write(f,#13#10);

    FillChar(buf, SizeOf(buf), Ord(' '));

    SetString(0,  Trim(TMAX.RecvString('STR102',i)));	//코드명
    SetString(40, Trim(TMAX.RecvString('STR103',i)));	//코드번호
    SetString(50, Trim(TMAX.RecvString('STR104',i)));	//전산코드1
    SetString(60, Trim(TMAX.RecvString('STR105',i)));	//전산코드2
    SetString(70, Trim(TMAX.RecvString('STR106',i)));	//전산코드3
    SetString(80, Trim(TMAX.RecvString('STR107',i)));	//전산코드4
    SetString(90, Trim(TMAX.RecvString('STR108',i)));	//사용여부
    SetString(91, Trim(TMAX.RecvString('STR109',i)));	//전산코드5


    Write(f, Copy(StrPas(buf),1,122));

    oldGubun := newGubun;

    ProgressBar1.Position :=  ProgressBar1.Position+1;
    Application.ProcessMessages;

  end;

  if  count<> 0 then
    CloseFile(f);

  StatusBar1.Panels[1].Text := '공통코드 업데이트를 완료 하였습니다';
  Application.ProcessMessages;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  //여기서 호출한 윈도우에 메세지를 보낸다.
  PostMessage(strToInt(common_caller), WM_LOSTPROJECT, 2, 0); //wParam =2, 공통코드에서 센딩..
  PostMessage(self.Handle, WM_QUIT,0 ,0);
end;

procedure TCodeUpdateFrm.FormShow(Sender: TObject);
begin
	Timer1.Enabled:= True;
end;

procedure TCodeUpdateFrm.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled:= False;
  GetFileButtonClick(self);
end;

end.

