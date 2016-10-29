{*---------------------------------------------------------------------------
프로그램ID    : LOSTB550L (사은품 반송 내역 출력)
프로그램 종류 : Online
작성자	      : 최대성
작성일	      : 2011. 08. 17
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
unit u_LOSTB550L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, inifiles, common_lib, so_tmax, SimpleSFTP, ComObj;

const
  TITLE   = '사은품반송내역출력';
  PGM_ID  = 'LOSTB550L';

type
  Tfrm_LOSTB550L = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel4          : TBevel;
    Bevel1          : TBevel;
    cmb_sp_cd       : TComboBox;
    cmb_prt_gu      : TComboBox;
    dte_from        : TDateEdit;
    dte_to          : TDateEdit;
    lbl_Program_Name: TLabel;
    Label2          : TLabel;
    Label1          : TLabel;
    Label15         : TLabel;
    Label4          : TLabel;
    pnl_Command     : TPanel;
    Panel2          : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    TMAX            : TTMAX;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;

    procedure PrtFormShow;
    procedure FormCreate      (Sender: TObject);
    procedure btn_CloseClick  (Sender: TObject);
    procedure dte_fromExit    (Sender: TObject);
    procedure dte_toExit      (Sender: TObject);
    procedure btn_PrintClick  (Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
  private
    { Private declarations }
    qryStr : String;
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;

  end;

var
  frm_LOSTB550L: Tfrm_LOSTB550L;
  arrSpCd : TZ0xxArray;  

implementation
uses u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTB550L.setEdtKeyPress;
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

procedure Tfrm_LOSTB550L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTB550L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB550L.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_sp_cd.Enabled := True;
  cmb_prt_gu.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB550L.PrtFormShow;
begin
	// 출력 다이로그 박스
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet('LostB550L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB550L.FormCreate(Sender: TObject);
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
  //common_userid   := '0294';    //ParamStr(2);
  //common_username := '정호영';  //ParamStr(3);
  //common_usergroup:= 'KAIT';    //ParamStr(4);

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);

  initComboBoxWithZ0xx('Z035.dat',arrSpCd,'전체','',cmb_sp_cd);


  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB550L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

//OnExit event - 
procedure Tfrm_LOSTB550L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

//OnExit event --
procedure Tfrm_LOSTB550L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
  begin
		showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then
  begin
		showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
		exit;
	end;
end;

//'출력' 버튼 클릭
procedure Tfrm_LOSTB550L.btn_PrintClick(Sender: TObject);
var
  count1,i : Integer;

  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
  FSFTP:TSimpleSFTP;

  Label LIQUIDATION;
begin
  self.disableComponents;

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB550L')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', copy(cmb_prt_gu.Items[cmb_prt_gu.itemIndex],41,1))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', arrSpCd[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  serviceSuccess := TMAX.Call('LOSTB550L');

  if not serviceSuccess then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

  // 조횟수 카운팅
  count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    ShowMessage('출력할 자료가 없습니다.');
    goto LIQUIDATION;
  end;

  //쿼리 얻기
  qryStr:= TMAX.RecvString('INF014',0);
  
  //파일 패스를 얻는다.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //파일명을 얻는다.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //서버에서 파일을 전송받아 ..\KAI\LostPrj\temp 에 저장한다.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.Host
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
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt', lbl_Program_Name.Caption);

	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  self.enableComponents;
end;

procedure Tfrm_LOSTB550L.btn_ResetClick(Sender: TObject);
begin
  cmb_sp_cd.ItemIndex := 0;

  cmb_prt_gu.ItemS.Insert(0, '전체                                    1');
  cmb_prt_gu.ItemS.Insert(1, '재발송제외                              2');
  cmb_prt_gu.ItemIndex := 0;

  changeBtn(Self);

  dte_from.Date := date-30;
  dte_to.Date := date;
end;

procedure Tfrm_LOSTB550L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTB550L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB550L_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

End.
