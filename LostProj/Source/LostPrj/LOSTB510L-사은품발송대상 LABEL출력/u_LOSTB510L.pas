{*---------------------------------------------------------------------------
프로그램ID    : LOSTB510P (사은품발송대상LABEL출력)
프로그램 종류 : Online
작성자	      : 정 홍 렬 
작성일	      : 2011. 09. 23
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTB510L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, inifiles, common_lib, so_tmax, SimpleSFTP, ComObj;

const
  TITLE   = '사은품발송대상LABEL출력';
  PGM_ID  = 'LOSTB510L';

type
  Tfrm_LOSTB510L = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_From: TDateEdit;
    dte_to: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    Label3: TLabel;
    Label4: TLabel;
    Bevel4: TBevel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    cmb_sp_cd: TComboBox;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure PrtFormShow;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_FromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    cmb_id_cd_d: TZ0xxArray;
    cmb_sp_cd_d: TZ0xxArray;
    qryStr : String;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTB510L: Tfrm_LOSTB510L;

implementation
uses u_landprt;

{$R *.DFM}
procedure Tfrm_LOSTB510L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB510L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_sp_cd.Enabled := True;
  cmb_id_cd.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB510L.PrtFormShow;
begin
	// 출력 다이로그 박스
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	//frm_LANDPRT.FormSet('LOSTB510L.txt', lbl_Program_Name.Caption,'P',56,39,8,85);
  frm_LANDPRT.FormSet('LOSTB510L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;

procedure Tfrm_LOSTB510L.setEdtKeyPress;
var i : Integer;
begin
 for i := 0 to componentCount -1 do
 begin
   if (Components[i] is TEdit) then
   begin
     (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
   end;
 end;
end;

procedure Tfrm_LOSTB510L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB510L.FormCreate(Sender: TObject);
begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
   {     }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영'; //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  //common_lib.pas에 있다.
	initSkinForm(SkinData1);
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', '불명단말기',cmb_id_cd);
  initComboBoxWithZ0xx('Z035.dat', cmb_sp_cd_d, '전체', '',cmb_sp_cd);

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB510L.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTB510L.dte_FromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

procedure Tfrm_LOSTB510L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then begin
		showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
		exit;
	end;
end;

procedure Tfrm_LOSTB510L.btn_PrintClick(Sender: TObject);
var
  count1,i : Integer;

	remoteFilePath:String;
  fileName:String;
  localFilePath:String;

  serviceSuccess:Boolean;
	FSFTP:TSimpleSFTP;

  Label LIQUIDATION;
begin
	self.disableComponents;

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
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

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB510L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003',cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004',cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	//출력구분

  //서비스 호출
  serviceSuccess := TMAX.Call('LOSTB510L');

  if not serviceSuccess then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;


  qryStr:= TMAX.RecvString('INF014',0);

  // 조횟수 카운팅
  count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    ShowMessage('출력할 자료가 없습니다.');
    goto LIQUIDATION;
  end;

  //파일 패스를 얻는다.
  remoteFilePath:= TMAX.RecvString('STR101',0);
  //파일명을 얻는다.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //서버에서 파일을 전송받아 ..\KAI\LostPrj\temp 에 저장한다.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.RecvString('STR401',0)
               ,TMAX.RecvString('STR402',0)
               ,TMAX.RecvString('STR403',0)
               ,TMAX.RecvString('STR404',0)
               );

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //출력 다이어로그를 보여줌.
  Self.PrtFormShow;

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  self.enableComponents;
end;

procedure Tfrm_LOSTB510L.FormShow(Sender: TObject);
begin
  //btn_Print.Enabled := True;


  btn_ResetClick(sender);
end;

procedure Tfrm_LOSTB510L.btn_ResetClick(Sender: TObject);
begin
 	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;
  cmb_sp_cd.ItemIndex := 0;
  changeBtn(Self);
end;



procedure Tfrm_LOSTB510L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB510P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
