{*---------------------------------------------------------------------------
프로그램ID    : LOSTA260Q (분실자 주소 확인)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011. 10. 07
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
unit u_LOSTA260Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '분실자 주소 확인';
  PGM_ID  = 'LOSTA260Q';

type
  Tfrm_LOSTA260Q = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    cmb_md_cd: TComboBox;
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    Panel1: TPanel;
    Bevel18: TBevel;
    Bevel16: TBevel;
    Label15: TLabel;
    Label18: TLabel;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    md_grid1: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
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
    Bevel25: TBevel;
    Label11: TLabel;
    Bevel31: TBevel;
    Label12: TLabel;
    Bevel32: TBevel;
    lbl_New_md: TLabel;
    Bevel38: TBevel;
    Label13: TLabel;
    Bevel49: TBevel;
    lbl_Ph_Gb: TLabel;
    msk_mt_no: TMaskEdit;
    PageControl1: TPageControl;
    tab_A001: TTabSheet;
    Bevel7: TBevel;
    Label7: TLabel;
    Bevel8: TBevel;
    Bevel20: TBevel;
    Label20: TLabel;
    Bevel21: TBevel;
    Label21: TLabel;
    Bevel22: TBevel;
    Label22: TLabel;
    Bevel23: TBevel;
    Label23: TLabel;
    Bevel24: TBevel;
    Label24: TLabel;
    Label8: TLabel;
    tab_A003: TTabSheet;
    Bevel41: TBevel;
    Label30: TLabel;
    Bevel42: TBevel;
    Bevel44: TBevel;
    Label31: TLabel;
    Bevel45: TBevel;
    Label32: TLabel;
    Bevel46: TBevel;
    Label33: TLabel;
    Bevel47: TBevel;
    Label34: TLabel;
    Bevel48: TBevel;
    Label35: TLabel;
    Label43: TLabel;
    Tab_A005: TTabSheet;
    Bevel70: TBevel;
    Label29: TLabel;
    Bevel71: TBevel;
    Bevel73: TBevel;
    Label36: TLabel;
    Bevel74: TBevel;
    Label37: TLabel;
    Bevel75: TBevel;
    Label38: TLabel;
    Bevel76: TBevel;
    Label39: TLabel;
    Bevel77: TBevel;
    Label41: TLabel;
    Label48: TLabel;
    edt_A001Gb_cd: TEdit;
    edt_A001Id_no: TEdit;
    edt_A001Id_Nm: TEdit;
    edt_A001Pt_no: TEdit;
    edt_A001Ju_so: TEdit;
    edt_A001Bo_so: TEdit;
    edt_A001Tl_no: TEdit;
    edt_A003Gb_cd: TEdit;
    edt_A003Id_no: TEdit;
    edt_A003Id_Nm: TEdit;
    edt_A003Pt_no: TEdit;
    edt_A003Ju_so: TEdit;
    edt_A003Bo_so: TEdit;
    edt_A003Tl_no: TEdit;
    edt_A005Gb_cd: TEdit;
    edt_A005Id_no: TEdit;
    edt_A005Id_Nm: TEdit;
    edt_A005Pt_no: TEdit;
    edt_A005Ju_so: TEdit;
    edt_A005Bo_so: TEdit;
    edt_A005Tl_no: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure md_Grid1Click(Sender: TObject);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_resetClick(Sender: TObject);
    procedure md_cb1Exit(Sender: TObject);
    procedure md_grid1KeyPress(Sender: TObject; var Key: Char);
    procedure md_cb1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure serial_editKeyPress(Sender: TObject; var Key: Char);
    procedure serial_editEnter(Sender: TObject);
    procedure onEnter(Sender: TObject);
    procedure onKeypress(Sender: TObject; var Key: Char);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    md_grid1_d :TZ0xxArray;

    //검색시 사용
    STR001:String; // 모델코드
    STR002:String; // 단말기일련번호
    STR003:String; // 입고일자

    qryStr : String;

  public
    { Public declarations }

    procedure InitComponents;

  end;

var
  frm_LOSTA260Q: Tfrm_LOSTA260Q;

implementation

{$R *.DFM}

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTA260Q.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA260Q.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA260Q.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   // md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA260Q.FormCreate(Sender: TObject);

  procedure attachOnEnter;
  var
    i : Integer;
  begin
    for i := 0 to ComponentCount -1 do
    begin
      if Components[i] is TEdit then
        if Pos('edt_A',(Components[i] As TEdit).Name) > 0 then
        begin
           (Components[i] As TEdit).OnEnter     := Self.onEnter;
           (Components[i] As TEdit).OnKeyPress  := Self.OnKeyPress;
        end;
    end;
  end;

begin
  //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
  //	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
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

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

  attachOnEnter;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA260Q.InitComponents;
var
  i : Integer;
  component : TComponent;
begin

  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then( Components[i] as TEdit).Text := ''
    else if ( Components[i] is TMaskEdit) then ( Components[i] as TMaskEdit).Text := ''
      else if (Components[i] is TLabel) then
        if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
          then (Components[i] as TLabel).Caption := '';
  end;

  changeBtn(Self);

  btn_query.Enabled := false;
  btn_excel.Enabled := False;

  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

  qryStr := '';

end;

procedure Tfrm_LOSTA260Q.btn_InquiryClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

  i : integer;

  Label LIQUIDATION;
  Label SEEDKEY;
  Label INQUIRY;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_idnm := '';
  seed_idno := '';
  seed_tlno := '';
  seed_mtno := '';

  qryStr := '';

  PageControl1.ActivePageIndex := 0;

  for i := 0 to componentcount -1 do
    if (Components[i] is TEdit) then
      if Pos('edt_A',(Components[i] As TEdit).Name) > 0 then (Components[i] AS TEdit).Text := '';

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	// 모델코드 md_cb1
	STR002:= serial_edit.Text;			                                        // 단말기일련번호

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

//SEED KEY 조회
SEEDKEY:

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //서비스 호출
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키

//내역조회
INQUIRY:
  TMAX.InitBuffer;

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA260Q'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA260Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  qryStr := TMAX.RecvString('INF014',0);

  (* 단말기종류   *)  lbl_Ph_Gb.Caption  := TMAX.RecvString('STR013',0);
  (* 이동전화번호 *)  msk_mt_no.Text     := TMAX.RecvString('STR014',0);
  (* 유사모델명   *)  lbl_New_md.Caption := TMAX.RecvString('STR015',0);

  for i := 0 to StrToInt(TMAX.RecvString('INF013',0)) -1 do
  begin
    if (TMAX.RecvString('STR101',i) = 'A001') then
    begin

    (* 	주민/사업자/외국인구분 *)	edt_A001Gb_cd.Text	:= TMAX.RecvString('STR102',i);
    (* 	주민/사업자/외국인번호 *)	seed_idno         	:= TMAX.RecvString('STR103',i);
                                	edt_A001Id_no.Text	:= ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	성명(업체명)           *)	seed_idnm         	:= TMAX.RecvString('STR104',i);
                                	edt_A001Id_Nm.Text	:= ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	우편번호               *)	edt_A001Pt_no.Text	:= TMAX.RecvString('STR105',i);
    (* 	주소지                 *)	edt_A001Ju_so.Text	:= TMAX.RecvString('STR106',i);
    (* 	보조주소               *)	edt_A001Bo_so.Text	:= TMAX.RecvString('STR107',i);
    (* 	전화번호               *)	seed_tlno         	:= TMAX.RecvString('STR108',i);
                                	edt_A001Tl_no.Text	:= ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

      PageControl1.ActivePageIndex := 0;

    end else if (TMAX.RecvString('STR101',i) = 'A003') then
    begin
    (* 	주민/사업자/외국인구분 *)	edt_A003Gb_cd.Text  := TMAX.RecvString('STR102',i);
    (* 	주민/사업자/외국인번호 *)	seed_idno           := TMAX.RecvString('STR103',i);
                                	edt_A003Id_no.Text  := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	성명(업체명)           *)	seed_idnm           := TMAX.RecvString('STR104',i);
                                	edt_A003Id_Nm.Text  := ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	우편번호               *)	edt_A003Pt_no.Text  := TMAX.RecvString('STR105',i);
    (* 	주소지                 *)	edt_A003Ju_so.Text  := TMAX.RecvString('STR106',i);
    (* 	보조주소               *)	edt_A003Bo_so.Text  := TMAX.RecvString('STR107',i);
    (* 	전화번호               *)	seed_tlno           := TMAX.RecvString('STR108',i);
                                	edt_A003Tl_no.Text  := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

        PageControl1.ActivePageIndex := 1;

    end else if (TMAX.RecvString('STR101',i) = 'A005') then
    begin
    (* 	주민/사업자/외국인구분 *)	edt_A005Gb_cd.Text	:= TMAX.RecvString('STR102',i);
    (* 	주민/사업자/외국인번호 *)	seed_idno         	:= TMAX.RecvString('STR103',i);
                                	edt_A005Id_no.Text	:= ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	성명(업체명)           *)	seed_idnm         	:= TMAX.RecvString('STR104',i);
                                	edt_A005Id_Nm.Text	:= ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	우편번호               *)	edt_A005Pt_no.Text	:= TMAX.RecvString('STR105',i);
    (* 	주소지                 *)	edt_A005Ju_so.Text	:= TMAX.RecvString('STR106',i);
    (* 	보조주소               *)	edt_A005Bo_so.Text	:= TMAX.RecvString('STR107',i);
    (* 	전화번호               *)	seed_tlno         	:= TMAX.RecvString('STR108',i);
                                	edt_A005Tl_no.Text	:= ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

        PageControl1.ActivePageIndex := 2;

    end else
    begin
      ShowMessage('매칭되는 통신사가 없습니다.');

      goto LIQUIDATION;
    end;
  end;

  qryStr:= TMAX.RecvString('INF014',0);

  sts_Message.Panels[1].Text := ' 조회 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA260Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;


procedure Tfrm_LOSTA260Q.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;


procedure Tfrm_LOSTA260Q.md_cb1Exit(Sender: TObject);
begin
  md_grid1.Visible := False;
end;

procedure Tfrm_LOSTA260Q.md_grid1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    SelectNext( sender as TWinControl,True,True);
end;

procedure Tfrm_LOSTA260Q.md_cb1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
    SelectNext(sender as TWinControl, true,True);
  end;
end;

procedure Tfrm_LOSTA260Q.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTA260Q.serial_editKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'z',#3,#8,#9,#45,#22]) then key := #0;
end;

procedure Tfrm_LOSTA260Q.serial_editEnter(Sender: TObject);
begin
  md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA260Q.onEnter(Sender: TObject);
begin
  (Sender as TEdit).ImeMode := imAlpha;
end;

procedure Tfrm_LOSTA260Q.onKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key <> #3 then key := #0;
end;

procedure Tfrm_LOSTA260Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

  filePath:='..\Temp\' + PGM_ID + '_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
