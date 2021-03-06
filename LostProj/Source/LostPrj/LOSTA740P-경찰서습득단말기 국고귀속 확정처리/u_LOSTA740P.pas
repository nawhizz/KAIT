{*---------------------------------------------------------------------------
프로그램ID    : LOSTA740P (경찰서습득단말기 국고귀속 확정처리)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10 .24
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
unit u_LOSTA740P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  so_tmax, WinSkinData, common_lib, ComObj;

const
  TITLE   = '경찰서습득단말기 국고귀속 확정처리';
  PGM_ID  = 'LOSTA740P';

type
  Tfrm_LOSTA740P = class(TForm)
    Bevel2      : TBevel;
    Bevel15     : TBevel;
    Bevel16     : TBevel;
    Bevel18     : TBevel;
    Bevel29     : TBevel;
    Bevel3      : TBevel;
    dte_Gt_Dt_From: TDateEdit;
    Label18     : TLabel;
    lbl_Program_Name: TLabel;
    Label16     : TLabel;
    lbl_Gs_Ct   : TLabel;
    Label15     : TLabel;
    lbl_Gs_Dt   : TLabel;
    Panel2      : TPanel;
    pnl_Command : TPanel;
    SkinData1   : TSkinData;
    btn_Add     : TSpeedButton;
    btn_Update  : TSpeedButton;
    btn_Delete  : TSpeedButton;
    btn_Inquiry : TSpeedButton;
    btn_Link    : TSpeedButton;
    btn_Print   : TSpeedButton;
    btn_Close   : TSpeedButton;
    btn_query   : TSpeedButton;
    btn_excel   : TSpeedButton;
    btn_reset   : TSpeedButton;
    sts_Message : TStatusBar;
    TMAX        : TTMAX;
    Bevel1: TBevel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    chk_S_grade: TCheckBox;
    chk_A_grade: TCheckBox;
    chk_B_grade: TCheckBox;
    chk_C_grade: TCheckBox;
    chk_No_grade: TCheckBox;

    procedure FormCreate        (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure FormClose         (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure InitComponents;
    procedure btn_AddClick      (Sender: TObject);
    procedure dte_Gt_Dt_FromKeyPress(Sender: TObject; var Key: Char);
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
  private
    { Private declarations }
    qryStr:String;

    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTA740P: Tfrm_LOSTA740P;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTA740P.disableComponents;
begin
    btn_query.Enabled:= False;
end;

procedure Tfrm_LOSTA740P.enableComponents;
begin
    btn_query.Enabled:= True;;
end;

procedure Tfrm_LOSTA740P.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
	if ParamCount <> 6 then
  begin
    ShowMessage('로그인 후 사용하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle   := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

    {----------------------- 공통 어플리케이션 설정 ---------------------------}

    // 프로그램 캡션 설정
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // 테스크바 캡션설정
    Application.Title := TITLE;

    // 프로그램 내부 캡션 설정
    lbl_Program_Name.Caption := TITLE;

    // 프로그램 상단 아이콘 설정
    fSetIcon(Application);

    // 메세지 바 넓이 설정
    pSetStsWidth(sts_Message);

    // 텍스트 선택시 전체 선택 기능
    pSetTxtSelAll(Self);

    // 프로그램 보더 아이콘 설정
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // 프로그램 시작 위치 설정
    Self.Position     := poScreenCenter;
    {--------------------------------------------------------------------------}

    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

    // 스킨을 초기화
    initSkinForm(SkinData1);

    // 상태등급 초기화
    chk_S_grade.Checked := true;
    chk_A_grade.Checked := true;
    chk_B_grade.Checked := true;
    chk_C_grade.Checked := true;

end;

procedure Tfrm_LOSTA740P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTA740P.FormClose(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_LOSTA740P.btn_InquiryClick(Sender: TObject);
var
  STR002,STR003,STR004,STR005,STR006:String;
  Label LIQUIDATION;
begin
  STR002 := '';
  STR003 := '';
  STR004 := '';
  STR005 := '';
  STR006 := '';

  qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  if ( not fChkLength(dte_gt_dt_From,8,0,'습득일자 From') ) then Exit;

  if ((not chk_S_grade.Checked) and (not chk_A_grade.Checked) and (not chk_B_grade.Checked) and (not chk_C_grade.Checked)) then begin
    ShowMessage('상태등급은 1개이상이 반드시 선택되어야 합니다.');
    goto LIQUIDATION;
  end;

  if(chk_S_grade.Checked)  then STR002 := 'S' else STR002 := 'X';
  if(chk_A_grade.Checked)  then STR003 := 'A' else STR003 := 'X';
  if(chk_B_grade.Checked)  then STR004 := 'B' else STR004 := 'X';
  if(chk_C_grade.Checked)  then STR005 := 'C' else STR005 := 'X';
  if(chk_No_grade.Checked) then STR006 := 'N' else STR006 := 'X';

  disableComponents;	//작업중 다른 기능 잠시 중지.

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA740P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_gt_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA740P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  lbl_Gs_Ct.Caption   := convertWithCommer(TMAX.RecvString('INT101',0));
  lbl_Gs_Dt.Caption   := InsHyphen(TMAX.RecvString('STR102',0));

  sts_Message.Panels[1].Text := ' 조회 완료';

  dte_Gt_Dt_From.Enabled := False;

  //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
    qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  enableComponents;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA740P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
    begin
      component := Components[i];

      if (component is TLabel) then
        if(Pos('lbl_',(component as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(component as TLabel).Name) = 0)
          then (component as TLabel).Caption := '';
    end;

    changeBtn(Self);

    btn_Update.Enabled     := false;
    btn_Delete.Enabled     := false;

    dte_Gt_Dt_From.date    := date;

    dte_Gt_Dt_From.Enabled := True;
    
    dte_Gt_Dt_From.SetFocus;

end;
procedure Tfrm_LOSTA740P.btn_AddClick(Sender: TObject);
var
  STR002,STR003,STR004,STR005,STR006:String;
  Label LIQUIDATION;
begin
  STR002 := '';
  STR003 := '';
  STR004 := '';
  STR005 := '';
  STR006 := '';

  if ( not fChkLength(dte_gt_dt_From,8,0,'습득일자 From') ) then Exit;

  if ((not chk_S_grade.Checked) and (not chk_A_grade.Checked) and (not chk_B_grade.Checked) and (not chk_C_grade.Checked)) then begin
    ShowMessage('상태등급은 1개이상이 반드시 선택되어야 합니다.');
    goto LIQUIDATION;
  end;

  if(chk_S_grade.Checked) then STR002 := 'S' else STR002 := 'X';
  if(chk_A_grade.Checked) then STR003 := 'A' else STR003 := 'X';
  if(chk_B_grade.Checked) then STR004 := 'B' else STR004 := 'X';
  if(chk_C_grade.Checked) then STR005 := 'C' else STR005 := 'X';
  if(chk_No_grade.Checked) then STR006 := 'N' else STR005 := 'X';

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA740P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_gt_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;

  //서비스 호출

	if not TMAX.Call('LOSTA740P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  ShowMessage('성공적으로 저장하였습니다.');

  // 컴포넌트 초기화
  InitComponents;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA740P.dte_Gt_Dt_FromKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA740P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA740P.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTA740P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA740P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
