{*---------------------------------------------------------------------------
프로그램ID    : LOSTA130P (출고폰 우체국전달 입력)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011. 09. 01
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
unit u_LOSTA130P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, so_tmax, common_lib, ComObj;

const
  TITLE   = '출고폰 우체국전달 입력';
  PGM_ID  = 'LOSTA130P';

type
  Tfrm_LOSTA130P = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    Bevel29         : TBevel;
    Bevel1          : TBevel;
    Bevel3          : TBevel;
    Bevel4          : TBevel;
    Bevel5          : TBevel;
    dte_Ip_Dt_From  : TDateEdit;
    dte_Ip_Dt_To    : TDateEdit;
    Label2          : TLabel;
    Label15         : TLabel;
    Label1          : TLabel;
    lbl_Ju_Dt       : TLabel;
    lbl_Sb_Ct       : TLabel;
    Label3          : TLabel;
    Label16         : TLabel;
    lbl_Sb_Ct2      : TLabel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    TMAX            : TTMAX;
    Label4: TLabel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure FormCreate        (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure FormClose         (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure InitComponents;
    procedure btn_AddClick      (Sender: TObject);
    procedure btn_reloadClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTA130P: Tfrm_LOSTA130P;

implementation
uses cpaklibm;
{$R *.DFM}


procedure Tfrm_LOSTA130P.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
//	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle     := intToStr(self.Handle);
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
  Label4.Caption := TITLE;

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

  // 스킨을 초기화
  initSkinForm(SkinData1);
end;

procedure Tfrm_LOSTA130P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTA130P.FormClose(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_LOSTA130P.btn_InquiryClick(Sender: TObject);
Label LIQUIDATION;
begin
  if ( not fChkLength(dte_ip_dt_From,8,0,'입고일자 From') ) then Exit;
  if ( not fChkLength(dte_Ip_Dt_To  ,8,0,'입고일자 To'  ) ) then Exit;

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
	if (TMAX.SendString('INF003','LOSTA130P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delhyphen(dte_ip_dt_To.Text)     )  < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTA130P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  lbl_ju_dt.Caption   := InsHyphen(TMAX.RecvString('STR101',0));
  lbl_Sb_Ct.Caption   := convertWithCommer(TMAX.RecvString('INT102',0));
  lbl_Sb_Ct2.Caption  := convertWithCommer(TMAX.RecvString('INT103',0));

  dte_Ip_Dt_From.Enabled := False;
  dte_Ip_Dt_To.Enabled    := False;


  sts_Message.Panels[1].Text := ' 조회 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA130P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos('lbl_',(component as TLabel).Name) > 0) then (component as TLabel).Caption := '';
  end;

  dte_Ip_Dt_From.Enabled  := True;
  dte_Ip_Dt_To.Enabled    := True;

  // 버튼이미지 초기화
  changeBtn(Self);

  btn_Update.Enabled := false;
  btn_Delete.Enabled := false;

  dte_Ip_Dt_From.date  := date;
  dte_Ip_Dt_To.date    := date;

end;
procedure Tfrm_LOSTA130P.btn_AddClick(Sender: TObject);
label LIQUIDATION;
begin
  if ( not fChkLength(dte_ip_dt_From,8,0,'입고일자 From') ) then Exit;
  if ( not fChkLength(dte_Ip_Dt_To  ,8,0,'입고일자 To'  ) ) then Exit;

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
	if (TMAX.SendString('INF003','LOSTA130P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delhyphen(dte_ip_dt_To.Text)     )  < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTA130P') then
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

  sts_Message.Panels[1].Text := ' 조회 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA130P.btn_reloadClick(Sender: TObject);
begin
  InitComponents;
end;


procedure Tfrm_LOSTA130P.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTA130P.btn_resetClick(Sender: TObject);
begin
  Self.InitComponents;
end;

end.
