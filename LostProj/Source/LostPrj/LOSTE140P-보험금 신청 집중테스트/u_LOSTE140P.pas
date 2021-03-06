{*---------------------------------------------------------------------------
프로그램ID    : LOSTE140P (보험금 신청 집중테스트)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2012. 01. 26
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
unit u_LOSTE140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '보험금 신청 집중테스트';
  PGM_ID  = 'LOSTE140P';

type
  Tfrm_LOSTE140P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    GroupBox3: TGroupBox;
    pnl_Command: TPanel;
    cmb_md_cd: TComboBox;
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    md_grid1: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel2: TPanel;
    Bevel16: TBevel;
    Label15: TLabel;
    md_cb1: TComboEdit;
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
    Bevel1: TBevel;
    Label1: TLabel;
    cmb_pc_gu: TComboBox;
    Bevel3: TBevel;
    Label2: TLabel;
    cmb_da_gu: TComboBox;
    Bevel4: TBevel;
    Label3: TLabel;
    cmb_in_su: TComboBox;
    Bevel5: TBevel;
    Label4: TLabel;
    Bevel6: TBevel;
    Label5: TLabel;
    Bevel7: TBevel;
    Label6: TLabel;
    Bevel8: TBevel;
    Label7: TLabel;
    edt_ga_nm: TEdit;
    Bevel9: TBevel;
    Label8: TLabel;
    msk_sr_no: TMaskEdit;
    msk_mt_no: TMaskEdit;
    msk_ga_no: TMaskEdit;
    msk_ga_tl: TMaskEdit;
    Bevel10: TBevel;
    Label9: TLabel;
    cmb_dt_gu: TComboBox;
    Bevel11: TBevel;
    Label10: TLabel;
    dt_rq_dt: TDateEdit;
    Bevel12: TBevel;
    Label11: TLabel;
    dt_fx_dt: TDateEdit;
    Bevel13: TBevel;
    Label12: TLabel;
    dt_ap_dt: TDateEdit;
    Bevel14: TBevel;
    Label13: TLabel;
    Bevel15: TBevel;
    Label14: TLabel;
    edt_rg_id: TEdit;
    mmo1: TMemo;
    msk_in_amt: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure md_Grid1Click(Sender: TObject);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure msk_in_amtKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cmb_in_su_d,md_grid1_d :TZ0xxArray;

  public
    { Public declarations }

    procedure InitComponents;

  end;

var
  frm_LOSTE140P: Tfrm_LOSTE140P;

implementation
uses cpaklibm;
{$R *.DFM}

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTE140P.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick  := nil;
   md_cb1.OnKeyUp        := nil;
   md_grid1.OnClick      := nil;

   if not md_Grid1.Visible then md_Grid1.Visible  := true
   else md_Grid1.Visible  := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 모델 콤보 KeyUp 이벤트
procedure Tfrm_LOSTE140P.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   // 엔터 누를 시
   if key = 13 then
   begin
      if md_grid1.Visible then
         md_grid1.Visible := false
      else
         md_grid1.Visible := true;
      md_cb1.Text := '';
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else

   //방향키 위로 누를 시
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
         md_grid1.Row := md_grid1.Row - 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else

   // 방향키 아래로 누를 시
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
         md_grid1.Row := md_grid1.Row + 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then
         md_grid1.Visible := true;
      for i := 0 to md_grid1.RowCount-1 do
      if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
      begin
         md_grid1.Row := i;
         break;
      end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 모델 그리드 클릭시
procedure Tfrm_LOSTE140P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;


procedure Tfrm_LOSTE140P.FormCreate(Sender: TObject);
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
//  common_userid     := '0294';    //ParamStr(2);
//  common_username   := '정호영';  //ParamStr(3);
//  common_usergroup  := 'KAIT';    //ParamStr(4);

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

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1   );
  initComboBoxWithZ0xx('Z085.dat', cmb_in_su_d , '', '',cmb_in_su  );


  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTE140P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin

  changeBtn(Self);

 mmo1.Clear;

  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Inquiry.Enabled := False;

  msk_mt_no.Text := '';
  msk_ga_tl.Text := '';
  msk_in_amt.Text := '';
  msk_sr_no.Text := '';
  msk_ga_no.Text := '';
  edt_ga_nm.Text := '';
  edt_rg_id.Text := '';

  cmb_pc_gu.ItemIndex := 0;
  cmb_da_gu.ItemIndex := 0;
  cmb_in_su.ItemIndex := 0;
  cmb_dt_gu.ItemIndex := 0;

  md_grid1.Row    := 0;
  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

end;

procedure Tfrm_LOSTE140P.btn_AddClick(Sender: TObject);
var
  svcNm , Msg: string;

  LABEL LIQUIDATION;

begin

  if cmb_da_gu.Items.Strings[cmb_da_gu.ItemIndex] = '1' then svcNm := 'I01' else svcNm := 'I02';

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
	if not TMAX.Start then
  begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
    goto LIQUIDATION;
	end;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003',PGM_ID           )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',  svcNm) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', cmb_pc_gu.Items.Strings[cmb_pc_gu.ItemIndex]) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', cmb_da_gu.Items.Strings[cmb_da_gu.ItemIndex]) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_in_su_d[cmb_in_su.ItemIndex].code       ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', Trim(msk_sr_no.Text)                        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', delHyphen(msk_mt_no.Text)                   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', delHyphen(msk_ga_no.Text)                   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', edt_ga_nm.Text                              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', delHyphen(msk_ga_tl.Text)                   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR010', IntToStr(cmb_dt_gu.ItemIndex + 1)           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', delHyphen(dt_rq_dt.EditText)                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR012', delHyphen(dt_fx_dt.EditText)                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR013', delHyphen(dt_ap_dt.EditText)                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR014', Trim(msk_in_amt.Text)                       ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR015', Trim(edt_rg_id.Text)                        ) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call(PGM_ID) then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  mmo1.Clear;

  mmo1.Lines.Add(Trim(TMAX.RecvString('STR101',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR102',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR103',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR104',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR105',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR106',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR107',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR108',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR109',0)));
  mmo1.Lines.Add(Trim(TMAX.RecvString('STR110',0)));

  if ((Sender as TSpeedButton) = btn_Add) then Msg := '등록'
  else if (Sender as TSpeedButton) = btn_Update then Msg := '수정'
  else Msg := '삭제';

  ShowMessage('정상 ' + Msg + '되었습니다.');

  sts_Message.Panels[1].Text := Msg + '완료';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'수정' 버튼 클릭
procedure Tfrm_LOSTE140P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTE140P.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTE140P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;


procedure Tfrm_LOSTE140P.btn_CloseClick(Sender: TObject);
begin
  Self.Close;
end;

procedure Tfrm_LOSTE140P.msk_in_amtKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
end;

end.
