{*---------------------------------------------------------------------------
프로그램ID    : LOSTA110P (분실자 수취 확인 입력)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011. 09 .01
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
unit u_LOSTA110P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, common_lib,localCloud,
  checklst, cpakmsg, Grids, u_LOSTA110P_ADDR, Menus, WinSkinData, so_tmax, u_LOSTA110P_CHILD, ComObj;

const
  TITLE   = '콜센터 수취 확인 입력';
  PGM_ID  = 'LOSTA110P';

type
  Tfrm_LOSTA110P = class(TForm)
    Bevel4          : TBevel;
    Bevel6          : TBevel;
    Bevel1          : TBevel;
    Bevel5          : TBevel;
    Bevel25         : TBevel;
    Bevel10         : TBevel;
    Bevel9          : TBevel;
    Bevel7          : TBevel;
    Bevel8          : TBevel;
    Bevel26         : TBevel;
    Bevel20         : TBevel;
    Bevel21         : TBevel;
    Bevel22         : TBevel;
    Bevel23         : TBevel;
    Bevel24         : TBevel;
    Bevel27         : TBevel;
    Bevel28         : TBevel;
    Bevel29         : TBevel;
    Bevel30         : TBevel;
    Bevel50         : TBevel;
    Bevel11         : TBevel;
    Bevel12         : TBevel;
    Bevel13         : TBevel;
    Bevel14         : TBevel;
    Bevel17         : TBevel;
    Bevel19         : TBevel;
    Bevel32         : TBevel;
    Bevel34         : TBevel;
    Bevel35         : TBevel;
    Bevel36         : TBevel;
    Bevel38         : TBevel;
    Bevel39         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel44         : TBevel;
    Bevel43         : TBevel;
    Bevel46         : TBevel;
    Bevel45         : TBevel;
    Bevel31         : TBevel;
    Bevel37         : TBevel;
    Bevel42         : TBevel;
    Bevel47         : TBevel;
    Bevel48         : TBevel;
    Bevel49         : TBevel;
    Bevel18         : TBevel;
    Bevel3          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    Bevel33         : TBevel;
    Bevel53         : TBevel;
    bvl4            : TBevel;
    bvl5            : TBevel;
    bvl6            : TBevel;
    bvl7            : TBevel;
    bvl8            : TBevel;
    bvl1            : TBevel;
    bvl2            : TBevel;
    bvl3            : TBevel;
    bvl9            : TBevel;
    bvl10           : TBevel;
    bvl11           : TBevel;
    bvl12           : TBevel;
    bvl13           : TBevel;
    bvl14           : TBevel;
    bvl15           : TBevel;
    bvl16           : TBevel;
    bvl17           : TBevel;
    Bevel54         : TBevel;
    bvl18           : TBevel;
    bvl19           : TBevel;
    bvl20           : TBevel;
    bvl21           : TBevel;
    bvl22           : TBevel;
    bvl23           : TBevel;
    bvl24           : TBevel;
    bvl25           : TBevel;
    bvl26           : TBevel;
    bvl27           : TBevel;
    bvl28           : TBevel;
    bvl29           : TBevel;
    bvl31           : TBevel;
    bvl32           : TBevel;
    bvl33           : TBevel;
    bvl34           : TBevel;
    bvl35           : TBevel;
    bvl36           : TBevel;
    bvl37           : TBevel;
    bvl38           : TBevel;
    bvl39           : TBevel;
    bvl40           : TBevel;
    bvl41           : TBevel;
    bvl42           : TBevel;
    bvl43           : TBevel;
    bvl44           : TBevel;
    bvl45           : TBevel;
    bvl46           : TBevel;
    bvl47           : TBevel;
    bvl48           : TBevel;
    bvl49           : TBevel;
    bvl50           : TBevel;
    bvl51           : TBevel;
    bvl52           : TBevel;
    bvl53           : TBevel;
    bvl54           : TBevel;
    bvl55           : TBevel;
    bvl56           : TBevel;
    bvl57           : TBevel;
    bvl58           : TBevel;
    bvl59           : TBevel;
    bvl60           : TBevel;
    bvl61           : TBevel;
    bvl62           : TBevel;
    btn3            : TBitBtn;
    btn4            : TBitBtn;
    btn1            : TBitBtn;
    btn2            : TBitBtn;
    cmb_md_cd       : TComboBox;
    cmb_bl_gu       : TComboBox;
    md_cb1          : TComboEdit;
    dte_Bl_dt       : TDateEdit;
    dte_Ip_Dt       : TDateEdit;
    serial_edit     : TEdit;
    edt_ju_yo       : TEdit;
    edt_Id_Nm       : TEdit;
    edt_md_cd       : TEdit;
    edt_birth_date  : TEdit;
    GroupBox1       : TGroupBox;
    GroupBox3       : TGroupBox;
    lbl2            : TLabel;
    lbl3            : TLabel;
    lbl4            : TLabel;
    lbl5            : TLabel;
    lbl6            : TLabel;
    lbl_Nbo_So      : TLabel;
    lbl_Ntl_no      : TLabel;
    lbl7            : TLabel;
    lbl_Gpt_No      : TLabel;
    lbl8            : TLabel;
    Label9          : TLabel;
    lbl_Sn_Dt       : TLabel;
    lbl_gt_yn       : TLabel;
    lbl_gt_no       : TLabel;
    lbl_pt_no       : TLabel;
    lbl_gt_dt       : TLabel;
    lbl_id_nm       : TLabel;
    lbl_tl_no       : TLabel;
    lbl_ju_so       : TLabel;
    lbl_bo_so       : TLabel;
    lbl_Gju_So      : TLabel;
    Label8          : TLabel;
    Label27         : TLabel;
    lbl_Ph_Cd       : TLabel;
    lbl_Gbo_So      : TLabel;
    Label25         : TLabel;
    lbl_Gtl_No      : TLabel;
    lbl_Cg_No       : TLabel;
    Label5          : TLabel;
    Label26         : TLabel;
    lbl_Mt_No       : TLabel;
    lbl_ph_gb       : TLabel;
    Label20         : TLabel;
    Label28         : TLabel;
    lbl_ph_yo       : TLabel;
    Label21         : TLabel;
    lbl_Program_Name: TLabel;
    Label11         : TLabel;
    Label1          : TLabel;
    Label3          : TLabel;
    Label22         : TLabel;
    Label15         : TLabel;
    Label2          : TLabel;
    Label16         : TLabel;
    Label18         : TLabel;
    Label23         : TLabel;
    Label30         : TLabel;
    Label12         : TLabel;
    Label10         : TLabel;
    Label13         : TLabel;
    Label24         : TLabel;
    Label14         : TLabel;
    lbl_Gid_Gu      : TLabel;
    Label17         : TLabel;
    Label6          : TLabel;
    Label19         : TLabel;
    lbl_Nid_Gu      : TLabel;
    lbl_Gid_No      : TLabel;
    lbl_Nid_No      : TLabel;
    Label7          : TLabel;
    lbl_Nid_Nm      : TLabel;
    lbl_Gid_Nm      : TLabel;
    lbl_Npt_No      : TLabel;
    Label4          : TLabel;
    lbl_Nju_So      : TLabel;
    lbl9            : TLabel;
    lbl10           : TLabel;
    lbl11           : TLabel;
    lbl12           : TLabel;
    lbl13           : TLabel;
    lbl14           : TLabel;
    lbl15           : TLabel;
    lbl16           : TLabel;
    lbl17           : TLabel;
    lbl18           : TLabel;
    lbl19           : TLabel;
    lbl20           : TLabel;
    lbl21           : TLabel;
    lbl22           : TLabel;
    lbl23           : TLabel;
    lbl24           : TLabel;
    lbl25           : TLabel;
    lbl26           : TLabel;
    lbl27           : TLabel;
    lbl28           : TLabel;
    lbl29           : TLabel;
    lbl30           : TLabel;
    lbl31           : TLabel;
    lbl_po_nm2      : TLabel;
    lbl_gm_nm       : TLabel;
    lbl_rg_dt       : TLabel;
    lbl_bl_dt       : TLabel;
    lbl_ch_gu       : TLabel;
    lbl_ph_yn       : TLabel;
    lbl_sh_yn       : TLabel;
    lbl_ph_dt       : TLabel;
    lbl_cl_dt       : TLabel;
    lbl_cl_gu       : TLabel;
    lbl_bn_dt       : TLabel;
    lbl_bn_sy       : TLabel;
    lbl_gs_yn       : TLabel;
    lbl_gs_dt       : TLabel;
    lbl_po_dt       : TLabel;
    lbl_ju_dt       : TLabel;
    lbl_jn_dt       : TLabel;
    lbl_gs_id       : TLabel;
    lbl_ip_id       : TLabel;
    lbl_ph_id       : TLabel;
    lbl_cl_id       : TLabel;
    lbl_ju_id       : TLabel;
    lbl_ch_id       : TLabel;
    Label33         : TLabel;
    lbl1            : TLabel;
    edt_phone_no    : TMaskEdit;
    N13             : TMenuItem;
    PageControl1    : TPageControl;
    Panel2          : TPanel;
    Panel4          : TPanel;
    Panel3          : TPanel;
    Panel1          : TPanel;
    pnl_Command     : TPanel;
    mnuLnk          : TPopupMenu;
    rdo_Sh_No       : TRadioButton;
    rdo_Sh_Yes      : TRadioButton;
    rdo_Ph_Yes      : TRadioButton;
    rdo_Ph_No       : TRadioButton;
    SkinData1       : TSkinData;
    btn_Add         : TSpeedButton;
    btn_Update      : TSpeedButton;
    btn_Delete      : TSpeedButton;
    btn_Inquiry     : TSpeedButton;
    btn_Link        : TSpeedButton;
    btn_Print       : TSpeedButton;
    btn_Close       : TSpeedButton;
    btn_query       : TSpeedButton;
    btn_excel       : TSpeedButton;
    btn_reset       : TSpeedButton;
    btn_Addr_Update : TSpeedButton;
    sts_Message     : TStatusBar;
    md_grid1        : TStringGrid;
    TMAX            : TTMAX;
    TabSheet2       : TTabSheet;
    TabSheet3       : TTabSheet;
    TabSheet1       : TTabSheet;
    Bevel51: TBevel;
    Label29: TLabel;
    Bevel52: TBevel;
    lbl_Po_nm: TLabel;
    Bevel2: TBevel;
    lbl32: TLabel;
    Bevel55: TBevel;
    lbl_nm_cd: TLabel;
    Bevel56: TBevel;
    Bevel57: TBevel;
    Label31: TLabel;
    lbl_last_id: TLabel;
    btn_ans_req: TButton;
    lbl_wk_dt: TLabel;
    lbl_seq_wk: TLabel;
    lbl_wk_no: TLabel;
    lbl_id_cd: TLabel;
    Bevel58: TBevel;
    Label32: TLabel;
    Bevel59: TBevel;
    lbl_insu_sts: TLabel;
    TabSheet4: TTabSheet;
    Panel5: TPanel;
    bvl30: TBevel;
    lbl_insu_company: TLabel;
    Bevel61: TBevel;
    Label35: TLabel;
    Panel6: TPanel;
    Bevel60: TBevel;
    lbl_ga_nm: TLabel;
    Panel7: TPanel;
    Bevel62: TBevel;
    lbl_ga_birthday: TLabel;
    Panel8: TPanel;
    Bevel63: TBevel;
    lbl_insu_req_dt: TLabel;
    Panel9: TPanel;
    Bevel64: TBevel;
    lbl_insu_allow_dt: TLabel;
    Panel10: TPanel;
    Bevel65: TBevel;
    lbl_insu_mt_no: TLabel;
    Panel11: TPanel;
    Bevel66: TBevel;
    lbl_ga_tl_no: TLabel;
    Panel12: TPanel;
    Bevel67: TBevel;
    lbl_insu_deny_dt: TLabel;
    Panel13: TPanel;
    Bevel68: TBevel;
    lbl_insu_pay_amt: TLabel;
    Bevel69: TBevel;
    lbl_sl_dt: TLabel;
    Panel14: TPanel;
    Bevel70: TBevel;
    Label34: TLabel;
    cmb_Zp_no: TComboBox;

    procedure FormCreate            (Sender: TObject);
    procedure btn_AddClick          (Sender: TObject);
    procedure btn_DeleteClick       (Sender: TObject);
    procedure btn_InquiryClick      (Sender: TObject);
    procedure btn_CloseClick        (Sender: TObject);
    procedure rdo_Ph_YesClick       (Sender: TObject);
    procedure rdo_Ph_NoClick        (Sender: TObject);
    procedure btn_Addr_UpdateClick  (Sender: TObject);

    procedure md_cb1ButtonClick     (Sender: TObject);
    procedure md_grid1Click         (Sender: TObject);
    procedure md_cb1KeyUp           (Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure cmb_bl_guChange       (Sender: TObject);
    procedure btn_UpdateClick       (Sender: TObject);
    procedure FormShow              (Sender: TObject);
    procedure FormClose             (Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick        (Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure btn_ans_reqClick(Sender: TObject);
    procedure edt_ju_yoClick(Sender: TObject);
    procedure edt_ju_yoEnter(Sender: TObject);
    procedure rdo_Sh_YesClick(Sender: TObject);

  private
    { Private declarations }


    //LOSTZ810Q.exe로 메세지 받을 때 사용
    recvedMessage:Boolean;

    //LOSTZ810Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;

    //검색시 사용
    STR001:String; // 모델코드
    STR002:String; // 단말기일련번호
    STR003:String; // 입고일자

    md_grid1_d :TZ0xxArray;

  public
    { Public declarations }
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;

    procedure InitComponents;
    procedure AttachOnEnterEvent;
    procedure AttachOnKeyPressEvent;
    procedure AttachOnExitEvent;
    procedure DetachOnEnterEvent;

    procedure OnExit(Sender:TObject);
    procedure OnEnter(Sender:TObject);

    //쌍안경 이미지 버튼 클릭
    procedure OnSearchClick(Sender:TObject);

    //검색 조건, 콤포넌트 별 키프레스
    procedure OnKeyPress(Sender: TObject; var Key: Char);

    function ExecExternProg(progID:String):Boolean;

    procedure SetItemNo(number:String);

    // 임시 주민번호 전달
    function frtnRealIdNo(gbn : Integer) : String;
  end;

  (* PGM_STS : 프로그램 상태  *)
  (* 0 : 조회전               *)
  (* 1 : 조회후               *)
  (* 2,3 : 여유분             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTA110P: Tfrm_LOSTA110P;
  strGidNo , strNidNo : String;
  pgm_sts1   : PGM_STS;
  cmb_bl_gu_d : TZ0xxArray;

  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  cmb_Zp_no_d   : TZ0xxArray;

implementation
uses u_LOSTA110P_POP;
{$R *.DFM}

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.InitComponents;
var
  i : Integer;
  component : TComponent;

  color     : TColor;
  styles    : TFontStyles;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if((Pos('lbl_',(component as TLabel).Name) > 0) AND (Pos('lbl_Prog',(component as TLabel).Name) = 0)) then (component as TLabel).Caption := '';
  end;

  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
     else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';
  end;

  {-------------------------    인덱스 초기화      ----------------------------}
  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  cmb_Zp_no.ItemIndex     :=  0;

  // 버튼 초기화
  changeBtn(Self);

  btn_Link.Enabled := True;

  //초기화
  setItemNo('1');

  //처음 실행시 윈도우 클로즈 돕기 위해
  recvedMessage       := True;

  dte_ip_dt.date      := date;
  rdo_Ph_Yes.Checked  := True;
  rdo_Sh_Yes.Checked  := true;
  rdo_Ph_YesClick(Self);

  md_grid1.Row    := 0;
  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

  PageControl1.ActivePageIndex := 0;

  pgm_sts1 := [0];

  color := clBlack;
  styles := [];

  btn_ans_req.Font.Color := color;
  btn_ans_req.Font.Style := styles;

  edt_Id_Nm.SetFocus;
end;

procedure Tfrm_LOSTA110P.AttachOnKeyPressEvent;
begin
	edt_Id_Nm.OnKeyPress      := self.OnKeyPress; // TEdit       성명
	edt_birth_date.OnKeyPress := self.OnKeyPress; // TDateEdit   생년월일
	edt_phone_no.OnKeyPress   := self.OnKeyPress; // TMaskEdit   분실핸드폰번호
	md_cb1.OnKeyPress         := self.OnKeyPress; // TComboEdit  모델명
	serial_edit.OnKeyPress    := self.OnKeyPress; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnKeyPress                                               *)
(* procedure 기 능 : 컴퍼넌트중에 OnKeyPress를 사용하는 개체의                *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

  i : Integer;

begin
	if Key <> #13 then 	//엔터키가 아니면
  begin
    if Sender is TEdit then
    begin
      if (sender as Tedit).Name = 'edt_birth_date' then
      begin
        if not (key in ['0'..'9',#3,#8,#9,#45]) then key := #0;
      end else
      if (Sender as TEdit).Name = 'serial_edit' then
         if not (key in ['0'..'z',#3,#8,#9,#45,#22]) then key := #0;
    end else
    if Sender is TMaskEdit then
    begin
      if (Sender as TMaskEdit).Name = 'edt_phone_no' then
        if not (key in ['0'..'9',#3,#8,#9,#45]) then key := #0;
    end
    else if Sender is TDateEdit then
        if (Sender as TDateEdit).Name = 'dte_Ip_Dt' then
          if not (key in ['0'..'9',#3,#8,#9,#45]) then key := #0;

    exit;
  end;

	if Sender.ClassType = TEdit then
    begin
      edit := Sender as TEdit;
      if edit = edt_Id_Nm            then btn1.OnClick(btn1)  // 성명
      else if edit = serial_edit     then btn4.OnClick(btn4) 	// 시리얼 번호
      else if edit = edt_birth_date  then btn2.OnClick(btn2); // 생년월일
    end
  else if Sender.ClassType = TComboEdit then
    begin
      cedit:= Sender as TComboEdit;

      for i := 0 to md_grid1.rowcount do
        if (md_cb1.Text = md_grid1.Cells[0,i]) then
          lbl_nm_cd.Caption :=  md_grid1_d[i].JCode5;

      if cedit = md_cb1 then
      begin
        if md_grid1.Visible then cedit.Text := md_grid1.Cells[0,md_grid1.Row];
        md_grid1.Visible := False;
        serial_edit.SetFocus;	      //모델명
      end;
    end
  else if Sender.ClassType = TMaskEdit then
  begin
    medit:= Sender as TMaskEdit;
    if medit = edt_phone_no then btn3.OnClick(btn3);
  end;
end;

(******************************************************************************)
(* procedure name  : OnSearchClick                                            *)
(* procedure 기 능 : 컴퍼넌트중에 OnSearchClick를 사용하는 개체의             *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.OnSearchClick(Sender:TObject);
var i : integer;
begin

  //성명
  if Sender = btn1 then
    begin
      edt_Id_Nm.SetFocus;

      if Trim(edt_Id_Nm.Text)= '' then
      begin
        ShowMessage('성명(업체명)을 입력하세요');
        exit;
      end;

      edt_Id_Nm.OnExit(edt_Id_Nm);
      //Application.ProcessMessages;
    end
  else if Sender = btn2 then
    begin
      edt_birth_date.SetFocus;	//날짜

      if Trim(delHyphen(edt_birth_date.Text))='' then
      begin
        ShowMessage('날짜를 입력하세요');
        exit;
      end;

      edt_birth_date.OnExit(edt_birth_date);
    end
  //분실폰번호
  else if Sender = btn3 then
    begin
      edt_phone_no.SetFocus;

      if Trim(edt_phone_no.Text)='' then
      begin
        ShowMessage('폰 번호를 입력하세요');
        exit;
      end;

      edt_phone_no.OnExit(edt_phone_no);

    end
  //시리얼 번호
  else if Sender = btn4 then
  begin
    serial_edit.SetFocus;
    if (Trim(md_cb1.Text) = '') or  (Trim(serial_edit.Text) ='') then
    begin
      ShowMessage('모델명과 시리얼번호를 입력하세요');
      exit;
    end;

    serial_edit.OnExit(serial_edit);
  end;

  CreateMap;	//공유메모리 생성

  self.ExecExternProg('LOSTZ810Q');
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure 기 능 : 컴퍼넌트중에 OnExit를 사용하는 개체의                    *)
(*                   이벤트를 실행한다.                                       *)
(*                   해당 이벤트가 발생한 컴퍼넌트의 값을 전역변수로 설정한다 *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.OnExit(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	value2:= 'dummy';

	if Sender is TEdit then
    begin
      edit := Sender as TEdit;
      //시리얼 번호
      if edit = serial_edit then
        begin
          //value1 := findCodeFromName(Trim(md_cb1.Text), md_grid1_d, md_grid1.RowCount);
          value1 := Trim(md_cb1.Text); //전역변수 설정 -> value1
          value2 := Trim(edit.Text);   //전역변수 설정 -> value2
          if value2 = '' then value2 := 'dummy';
          //edit.Text := value2;
          md_grid1.Visible := False;
        end
      //성명
      else if edit = edt_Id_Nm then
      begin
        value1:= Trim(edt_Id_Nm.Text);

        if value1 = '' then value1 := 'dummy';
        //edit.text := value1;
      end
      else if edit = edt_birth_date then
      begin
        value1:= Trim(edt_birth_date.Text);

        if value1= '' then value1 :='dummy';
      end;
      end
    //모델명
    else if Sender.ClassType = TComboEdit then
    begin
      cedit   := Sender as TComboEdit;

      value1  := Trim(cedit.Text);

      if value1 = '' then
        value1  := 'dummy';
    end
  //분실폰 번호
  else if Sender is TMaskEdit then
  begin
    medit   := Sender as TMaskEdit;
    value1  := Trim(delHyphen(medit.Text));

    if (value1 = '') then
      value1:= 'dummy'; //'010-0000-0000';
      //medit.EditText := value1;
  end;

//    ShowMessage(value1 +#13#10+value2);
end;

(******************************************************************************)
(* procedure name  : DetachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 DetachOnEnterEvent를 사용하는 개체의        *)
(*                   이벤트를 해제한다..                                      *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := nil;         // TEdit       성명
	edt_birth_date.OnEnter:= nil;         // TDateEdit   생년월일
	edt_phone_no.OnEnter  := nil;         // TMaskEdit   분실핸드폰번호
	md_cb1.OnEnter        := nil;         // TComboEdit  모델명
	serial_edit.OnEnter   := nil;         // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnExitEvent                                        *)
(* procedure 기 능 : 컴퍼넌트중에 OnExitEvent를 사용하는 개체의               *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.AttachOnExitEvent;
begin
	edt_Id_Nm.OnExit      := self.OnExit; // TEdit       성명
	edt_birth_date.OnExit := self.OnExit; // TDateEdit   생년월일
	edt_phone_no.OnExit   := self.OnExit; // TMaskEdit   분실핸드폰번호
	md_cb1.OnExit         := self.OnExit; // TComboEdit  모델명
	serial_edit.OnExit    := self.OnExit; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnterEvent를 사용하는 개체의              *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.AttachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := self.OnEnter; // TEdit      성명
	edt_birth_date.OnEnter:= self.OnEnter; // TDateEdit  생년월일
	edt_phone_no.OnEnter  := self.OnEnter; // TMaskEdit  분실핸드폰번호
	md_cb1.OnEnter        := self.OnEnter; // TComboEdit 모델명
	serial_edit.OnEnter   := self.OnEnter; // TEdit      시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnEnter                                                  *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnter를 사용하는 개체의                   *)
(*                   이벤트를 연결한다.                                       *)
(*                   엔터친 컴퍼넌트가 뭔지 파악해서 변수에 숫자를 담고 있는다*)
(******************************************************************************)
procedure Tfrm_LOSTA110P.OnEnter(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	if Sender.ClassType = TEdit then
  begin
    edit := Sender as TEdit;
    //성명
    if edit = edt_Id_Nm then
      SetItemNo('1')
    //시리얼 번호
    else if edit = serial_edit then
      SetItemNo('4')
    else if edit = edt_birth_date then
    // 생년월일
      SetItemNo('2');
  end
  //모델명
  else if Sender.ClassType = TComboEdit then begin
    cedit:= Sender as TComboEdit;
    if cedit = md_cb1 then begin
      md_grid1.Visible := false;
      setItemNo('4');
    end;
  end
  // 분실핸드폰번호
  else if Sender.ClassType = TMaskEdit then begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then
            SetItemNo('3');
  end;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure 기 능 : 엔터친 컴퍼넌트에 대한 숫자를 담고 있는다.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA110P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

procedure Tfrm_LOSTA110P.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;		  //사용중=1,미사용=0 *)
  (*  ProgID      :String[30];	//사용중인 프로그램 *)
  (*                                                *)
  (*  name        :String[30];                      *)
  (*  model_name  :String[30];                      *)
  (*  model_code  :String[30];                      *)
  (*  serial_no   :String[30];                      *)
  (*  ibgo_date   :String[30];                      *)
  (*  birth       :String[30];                      *)
  (*  phone_no    :String[30];                      *)
  (**************************************************)
  smem  :TPSharedMem;
  modelName, serial_no, ibgoil:String;
  str:String;
  i : Integer;

begin
	//'LOSTZ810.exe'으로 부터 메세지를 받았다.
  Self.Show;
	recvedMessage:= True;

  //공유메모리 엑세스 필요여부는 wparam을 참조할 것.
  if Msg.wParam = 1 then
  begin
    //공유메모리를 얻는다.
    smem:= OpenMap;
    if smem <> nil then
    begin
      Lock;  //동시 접속방지

      edt_Id_Nm.Text        := smem^.name;			      //성명(업체명)
      md_cb1.Text           := smem^.model_name;	    //모델명
      serial_edit.Text      := smem^.serial_no;	      //단말기일련번호
      dte_Ip_Dt.Text        := smem^.ibgo_date;		    //입고일
      edt_birth_date.Text   := smem^.birth;			      //생년월일
      edt_phone_no.EditText := Trim(smem^.phone_no);  //분실핸드폰번호

      if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    // 모델 코드명 설정
    for i := 0 to md_grid1.RowCount do
    begin
      if md_cb1.Text = md_grid1_d[i].name then
        lbl_nm_cd.Caption := md_grid1_d[i].JCode5;
    end;

    //'조회' 버튼 클릭
    btn_InquiryClick(self);
  end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTA110P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA110P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
      lbl_nm_cd.Caption := md_grid1_d[md_grid1.Row].JCode5;
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
procedure Tfrm_LOSTA110P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text        := md_grid1.Cells[0,md_grid1.row];
   lbl_nm_cd.Caption  := md_grid1_d[md_grid1.Row].JCode5;
   md_cb1.SetFocus;
   md_grid1.Visible   := false;
end;

//procedure scrinit_rtn;
//begin
//  with frm_LOSTA110P do
//  begin
//     rdo_Ph_Yes.Checked := true;
//     rdo_Ph_No.Checked := false;
//     rdo_Sh_Yes.Checked := true;
//     rdo_Sh_No.Checked := false;
//     dte_Bl_Dt.date := date;
//     cmb_bl_gu.itemindex := -1;
//     edt_ju_yo.text := '';
//     edt_ju_yo.enabled := True;
//     lbl_Gid_Gu.Caption := '';
//     lbl_Gid_No.Caption := '';
//     lbl_Gid_Nm.Caption := '';
//     lbl_Gpt_No.Caption := '';
//     lbl_Gju_So.Caption := '';
//     lbl_Gbo_So.Caption := '';
//     lbl_Gtl_No.Caption := '';
//     lbl_Mt_No.Caption := '';
//     lbl_Sn_Dt.Caption := '';
//     lbl_Nid_Gu.Caption := '';
//     lbl_Nid_No.Caption := '';
//     lbl_Nid_Nm.Caption := '';
//     lbl_Npt_No.Caption := '';
//     lbl_Nju_So.Caption := '';
//     lbl_Nbo_So.Caption := '';
//     lbl_Ntl_No.Caption := '';
//     lbl_Po_Nm.Caption := '';
//     lbl_Ph_Cd.Caption := '';
//
//     lbl_Cg_No.Caption := '';
//     lbl_Ph_Gb.Caption := '';
//     lbl_Ph_Yo.Caption := '';
//  end;
//end;



{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA110P.FormCreate(Sender: TObject);
var i : integer;
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.

	if ParamCount < 5 then begin
    ShowMessage('로그인 후 사용하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능

  //공통변수 설정--common_lib.pas 참조할 것.

  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  //common_seedkey    := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
//  common_userid     := '0294';    //ParamStr(2);
//  common_username   := '정호영';  //ParamStr(3);
//  common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}
  setEdtKeyPress;

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

  // 스킨 초기화
  initSkinForm(SkinData1);

  {=========================    그리드   초기화     ===========================}
  initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1  );
  initComboBoxWithZ0xx ('Z071.dat', cmb_bl_gu_d , '', '',cmb_bl_gu );

  {=========================    콤보박스 초기화     ===========================}
  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  (* 재사용구분 *)  initComboBoxWithZ0xx('Z089',cmb_Zp_no_d   ,'','' ,cmb_Zp_no );

  //콤포넌트에 이벤트를 어태치 한다.
  AttachOnEnterEvent;
  AttachOnExitEvent;
  AttachOnKeyPressEvent;

  btn1.OnClick := self.OnSearchClick;
  btn2.OnClick := self.OnSearchClick;
  btn3.OnClick := self.OnSearchClick;
  btn4.OnClick := self.OnSearchClick;

  edt_ju_yo.OnClick := edt_ju_yoClick;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTA110P.btn_AddClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;

  // 서비스 파라미터
  STRVALUE : array[1..9] of string;

  // 서비스 변수 번호 ex) 001,002..xxx
  STRNUM : string;

  // 서비스 실행 파라미터 ex) I01,U01,D01..
  svcNm  : string;

  // 루프변수
  i : Integer;
  Label LIQUIDATION;
  Label SEEDKEY;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  // 서비스 실행 파라미터 설정
  if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if ( (pgm_sts1 = [0]) and (svcNm = 'I01')) then
  begin
    ShowMessage('초기화 후 저장하실 수 있습니다.');
    Exit;
  end else if (( pgm_sts1 = [0]) and (svcNm = 'U01')) then
  begin
    ShowMessage('조회 후 수정하실 수 있습니다.');
    Exit;
  end;

  if (not fChkLength(serial_edit, 1,1,'Serial-no'))    then Exit;
  if (not fChkLength(dte_Ip_Dt  , 8,1,'입고일자' ))    then Exit;
  if (not fChkLength(dte_Bl_dt  , 8,1,'발송예정일' ))  then Exit;


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

  TMAX.InitBuffer;

  FillChar(STRVALUE,SizeOf(STRVALUE),#0);

  (* 모델코드      *) STRVALUE[1] := edt_md_cd.Text;
  (* 단말기일련번호*) STRVALUE[2] := serial_edit.Text;
  (* 입고일자      *) STRVALUE[3] := delHyphen(dte_Ip_Dt.Text);
  (* 연락상태      *) if rdo_Ph_Yes.Checked then STRVALUE[4] := 'Y' else STRVALUE[4] := 'N';
  (* 수취여부      *) if rdo_Sh_Yes.Checked then STRVALUE[5] := 'Y' else STRVALUE[5] := 'N';
  (* 발송예정일    *) STRVALUE[6] := delHyphen(dte_Bl_dt.Text);
  (* 접속상태코드  *) if cmb_bl_gu.ItemIndex <> -1 then STRVALUE[7] := cmb_bl_gu_d[cmb_bl_gu.itemIndex].code;
  (* 적요          *) STRVALUE[8] := edt_ju_yo.text;
  (* 재사용여부    *)
  if (Length(cmb_Zp_no_d[cmb_Zp_no.itemIndex].code) = 0) then
    STRVALUE[9] := '0'
  else if (cmb_Zp_no_d[cmb_Zp_no.itemIndex].code = '0') then
    STRVALUE[9] := '0'
  else
    STRVALUE[9] := cmb_Zp_no_d[cmb_Zp_no.itemIndex].code;



    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA110P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;

  for i := Low( STRVALUE ) to High( STRVALUE ) do
  begin
    case Length(IntToStr(i)) of
      1 : STRNUM := '00' + IntToStr(i);
      2 : STRNUM := '0'  + IntToStr(i);
      3 : STRNUM :=        IntToStr(i);
    end;

    if (TMAX.SendString('STR' + STRNUM , STRVALUE[i]     ) < 0) then  goto LIQUIDATION;
  end;

    //서비스 호출
	if not TMAX.Call('LOSTA110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' 등록 완료';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA110P.btn_DeleteClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;

  // 서비스 파라미터
  STRVALUE : array[1..3] of string;

  // 서비스 변수 번호 ex) 001,002..xxx
  STRNUM : string;

  // 서비스 실행 파라미터 ex) I01,U01,D01..
  svcNm  : string;

  // 루프변수
  i : Integer;
  Label LIQUIDATION;
  Label SEEDKEY;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  if pgm_sts1 = [0] then
  begin
    ShowMessage('조회 후 삭제하실 수 있습니다.');
    Exit;
  end;

  if MessageDlg('정말 삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
  begin
    sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
    Exit;
  end
  else
  begin

    if (not fChkLength(serial_edit, 1,1,'Serial-no'))    then Exit;
    if (not fChkLength(dte_Ip_Dt  , 8,1,'입고일자' ))    then Exit;
    if (not fChkLength(md_cb1     , 1,1,'모델명' ))  then Exit;


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

  TMAX.InitBuffer;
  
    FillChar(STRVALUE,SizeOf(STRVALUE),#0);

    (* 모델코드      *) STRVALUE[1] := edt_md_cd.Text;
    (* 단말기일련번호*) STRVALUE[2] := serial_edit.Text;
    (* 입고일자      *) STRVALUE[3] := delHyphen(dte_Ip_Dt.Text);

      //공통입력 부분
    if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTA110P')       < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','D01')   < 0) then  goto LIQUIDATION;

    for i := Low( STRVALUE ) to High( STRVALUE ) do
    begin
      case Length(IntToStr(i)) of
        1 : STRNUM := '00' + IntToStr(i);
        2 : STRNUM := '0'  + IntToStr(i);
        3 : STRNUM :=        IntToStr(i);
      end;

      if (TMAX.SendString('STR' + STRNUM , STRVALUE[i]     ) < 0) then  goto LIQUIDATION;
    end;


    //서비스 호출
    if not TMAX.Call('LOSTA110P') then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;

    sts_Message.Panels[1].Text := ' 삭제 완료';
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA110P.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_nano, seed_nanm, seed_natl, seed_gtno, seed_gtnm, seed_gttl : String;
    seed_mtno, seed_isno, seed_isnm, seed_istl, seed_istl2 : String;

    i : integer;
    component : TComponent;
    color     : TColor;
    styles    : TFontStyles;

Label LIQUIDATION;
Label SEEDKEY;

begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_nano := '';
  seed_nanm := '';
  seed_natl := '';
  seed_gtno := '';
  seed_gtnm := '';
  seed_gttl := '';
  seed_mtno := '';
  seed_isno := '';
  seed_isnm := '';
  seed_istl := '';
  seed_istl2 := '';

  if(not fChkLength(md_cb1      ,1,1,'모델코드'       )) then Exit;
  if(not fChkLength(serial_edit ,1,1,'단말기 일련번호')) then Exit;
  if(not fChkLength(dte_Ip_Dt   ,8,0,'입고일자'       )) then Exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//모델코드
	STR002:= serial_edit.Text;			                                        //단말기일련번호
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                    //입고일자


  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if((Pos('lbl_',(component as TLabel).Name) > 0) AND (Pos('lbl_Prog',(component as TLabel).Name) = 0) and ((component as TLabel).Name <> 'lbl_nm_cd')) then (component as TLabel).Caption := '';
  end;

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

  TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA110P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
    begin

      if Pos('단말기',TMAX.RecvString('INF012',0)) = 0 then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        ShowMessage( TMAX.RecvString('INF012',0));
    end
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  (* 모델코드(Z008)          *) edt_md_cd.Text     :=             Trim(TMAX.RecvString('STR101',0));
  (* 모델명                  *) md_cb1.Text        :=             Trim(TMAX.RecvString('STR102',0));
  (* 단말기일련번호          *) serial_edit.Text   :=             Trim(TMAX.RecvString('STR103',0));
  (* 입고일자                *) dte_Ip_Dt.Text     := InsHyphen(  Trim(TMAX.RecvString('STR104',0)));
  (* 단말기종류코드(Z031)    *) //                                Trim(TMAX.RecvString('STR105',0));
  (* 단말기종류              *) lbl_ph_gb.Caption  :=             Trim(TMAX.RecvString('STR106',0));
  (* 단말기적요              *) lbl_ph_yo.Caption  :=             Trim(TMAX.RecvString('STR107',0));
  (* 출고일자                *) lbl_Sn_Dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR108',0)));
  (* 단말기상태코드(Z032)    *) //                                Trim(TMAX.RecvString('STR109',0));
  (* 단말기상태              *) lbl_Ph_Cd.Caption  :=             Trim(TMAX.RecvString('STR110',0));
  (* 창고번호                *) lbl_Cg_No.Caption  :=             Trim(TMAX.RecvString('STR111',0));
  (* 분실핸드폰번호          *) seed_mtno          := TMAX.RecvString('STR112',0);
                                edt_phone_no.Text  :=   Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
                                lbl_Mt_No.Caption  :=   Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
  (* 가입자주민사업자구분코드*) //                                Trim(TMAX.RecvString('STR113',0));
  (* 가입자주민사업자구분    *) lbl_Gid_Gu.Caption :=             Trim(TMAX.RecvString('STR114',0));
  (* 가입자주민사업자번호    *) seed_gano          := TMAX.RecvString('STR115',0);
                                lbl_Gid_No.Caption := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey)));
                                strGidNo           :=             Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* 가입자성명(업체명)      *) seed_ganm          := TMAX.RecvString('STR116',0);
                                lbl_Gid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
  (* 가입자우편번호          *) lbl_Gpt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR117',0)));
  (* 가입자기본주소          *) lbl_Gju_So.Caption :=             Trim(TMAX.RecvString('STR118',0));
  (* 가입자상세주소          *) lbl_Gbo_So.Caption :=             Trim(TMAX.RecvString('STR119',0));
  (* 가입자전화번호          *) seed_gatl          := TMAX.RecvString('STR120',0);
                                lbl_Gtl_No.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
  (* 납부자주민사업자구분코드*) //                                Trim(TMAX.RecvString('STR121',0));
  (* 납부자주민사업자구분    *) lbl_Nid_Gu.Caption :=             Trim(TMAX.RecvString('STR122',0));
  (* 납부자주민사업자번호    *) seed_nano          := TMAX.RecvString('STR123',0);
                                lbl_Nid_No.Caption := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_nano, common_seedkey)));
                                strNidNo           :=             Trim(ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
  (* 납부자성명(업체명)      *) seed_nanm          := TMAX.RecvString('STR124',0);
                                lbl_Nid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_nanm, common_seedkey));
  (* 납부자우편번호          *) lbl_Npt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR125',0)));
  (* 납부자기본주소          *) lbl_Nju_So.Caption :=             Trim(TMAX.RecvString('STR126',0));
  (* 납부자상세주소          *) lbl_Nbo_So.Caption :=             Trim(TMAX.RecvString('STR127',0));
  (* 납부자전화번호          *) seed_natl          := TMAX.RecvString('STR128',0);
                                lbl_Ntl_no.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_natl, common_seedkey));
  (* 습득신고자여부          *) lbl_gt_yn.Caption  :=             Trim(TMAX.RecvString('STR129',0));
  (* 습득자주민사업자번호    *) seed_gtno          := TMAX.RecvString('STR130',0);
                                lbl_gt_no.Caption  := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gtno, common_seedkey)));
  (* 습득신고일자            *) lbl_gt_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR131',0)));
  (* 습득자성명(업체명)      *) seed_gtnm          := TMAX.RecvString('STR132',0);
                                lbl_id_nm.Caption  :=             Trim(ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey));
  (* 습득자우편번호          *) lbl_pt_no.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR133',0)));
  (* 습득자기본주소          *) lbl_ju_so.Caption  :=             Trim(TMAX.RecvString('STR134',0));
  (* 습득자상세주소          *) lbl_bo_so.Caption  :=             Trim(TMAX.RecvString('STR135',0));
  (* 습득자전화번호          *) seed_gttl          := TMAX.RecvString('STR136',0);
                                lbl_tl_no.Caption  :=             Trim(ECPlazaSeed.Decrypt(seed_gttl, common_seedkey));
  (* 접수국코드(Z042)        *) //                                Trim(TMAX.RecvString('STR137',0));
  (* 접수국명                *) lbl_po_nm2.Caption :=             Trim(TMAX.RecvString('STR138',0));
                                lbl_Po_nm.Caption  :=  lbl_po_nm2.Caption;

  (* 총괄국코드              *) //                                Trim(TMAX.RecvString('STR139',0));
  (* 총괄국명                *) lbl_gm_nm.Caption  :=             Trim(TMAX.RecvString('STR140',0));
  (* 우체국등록일            *) lbl_rg_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR141',0)));
  (* 발송예정일              *) lbl_bl_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR142',0)));

  (* 연락상태                *) if TMAX.RecvString('STR145',0) = 'Y' then
                                begin
                                  rdo_Ph_Yes.Checked := True;
                                  rdo_Ph_No.Checked  := False;
                                  rdo_Ph_Yes.OnClick(frm_LOSTA110P);

                                  if TMAX.RecvString('STR148',0) = 'Y' then
                                  begin
                                    rdo_Sh_Yes.Checked  := true;
                                    rdo_Sh_No.Checked   := false;
                                  end
                                  else
                                  begin
                                    rdo_Sh_Yes.Checked := false;
                                    rdo_Sh_No.Checked := true;
                                  end;

                                end else
                                begin
                                  rdo_Ph_Yes.Checked  := False;
                                  rdo_Ph_No.Checked   := True;
                                  rdo_Ph_No.OnClick(frm_LOSTA110P);

                                  cmb_bl_gu.OnChange(frm_LOSTA110P);
                                end;
  (* 처리구분코드(Z040)      *) cmb_bl_gu.ItemIndex:= cmb_bl_gu.Items.IndexOf(
  findNameFromCode(TMAX.RecvString('STR146',0),cmb_bl_gu_d,cmb_bl_gu.Items.Count));

  (* 처리구분                *) lbl_ch_gu.Caption  :=             Trim(TMAX.RecvString('STR144',0));
  (* 연락여부                *) lbl_ph_yn.Caption  :=             Trim(TMAX.RecvString('STR147',0));

  (* 수취여부                *) if TMAX.RecvString('STR148',0) = 'Y' then rdo_Sh_Yes.Checked := True
                                else rdo_Sh_No.Checked := True;

  (* 수취여부                *) lbl_sh_yn.Caption  :=             Trim(TMAX.RecvString('STR148',0));
  (* 수취확인일자            *) lbl_ph_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR149',0)));
  (* 출고일자                *) lbl_cl_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR150',0)));
  (* 출고구분코드(Z041)      *) //                                Trim(TMAX.RecvString('STR151',0));
  (* 출고구분                *) lbl_cl_gu.Caption  :=             Trim(TMAX.RecvString('STR152',0));
  (* 반송일자                *) lbl_bn_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR153',0)));
  (* 반송사유코드(Z034)      *) //                                Trim(TMAX.RecvString('STR154',0));
  (* 반송사유                *) lbl_bn_sy.Caption  :=             Trim(TMAX.RecvString('STR155',0));
  (* 공시여부                *) lbl_gs_yn.Caption  :=             Trim(TMAX.RecvString('STR156',0));
  (* 공시일자                *) lbl_gs_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR157',0)));
  (* 우체국분실폰배달일자    *) lbl_po_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR158',0)));
  (* 우체국출고접수일자      *) lbl_ju_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR159',0)));
  (* 전달일자                *) lbl_jn_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR160',0)));
  (* 공시자ID                *) lbl_gs_id.Caption  :=             Trim(TMAX.RecvString('STR161',0));
  (* 입고자ID                *) lbl_ip_id.Caption  :=             Trim(TMAX.RecvString('STR162',0));
  (* 수취확인자ID            *) lbl_ph_id.Caption  :=             Trim(TMAX.RecvString('STR163',0));
  (* 출고자ID                *) lbl_cl_id.Caption  :=             Trim(TMAX.RecvString('STR164',0));
  (* 우체국접수자ID          *) lbl_ju_id.Caption  :=             Trim(TMAX.RecvString('STR165',0));
  (* 처리자ID                *) lbl_ch_id.Caption  :=             Trim(TMAX.RecvString('STR166',0));
  (* 최종처리자ID            *) lbl_last_id.Caption:=             Trim(TMAX.RecvString('STR170',0));
  (* 사업자식별코드          *) lbl_id_cd.Caption  :=             Trim(TMAX.RecvString('STR171',0));
                                edt_ju_yo.Text     :=             Trim(TMAX.RecvString('STR172',0));

  (* 재사용여부            *)  if(TMAX.RecvString('STR173',0) = '') then
                                   cmb_Zp_no.ItemIndex := 0
                               else
                                   cmb_Zp_no.ItemIndex := cmb_Zp_no.items.indexof(findNameFromCode(TMAX.RecvString('STR173',0),cmb_Zp_no_d,cmb_Zp_no.Items.Count));

  (* 설문작업일자            *) lbl_wk_dt.Caption  :=             Trim(TMAX.RecvString('STR180',0));
  (* 설문작업일련번호        *) lbl_seq_wk.Caption :=             Trim(TMAX.RecvString('INT181',0));
  (* 설문작업일련번호        *) lbl_wk_no.Caption  :=             Trim(TMAX.RecvString('INT182',0));

  (* 주소수정구분            *)
  if TMAX.RecvString('STR167',0) = '' then frm_LOSTA110P_ADDR.cmb_up_gu.ItemIndex := -1
  else frm_LOSTA110P_ADDR.cmb_up_gu.ItemIndex := StrToInt(TMAX.RecvString('STR167',0)) -1;

  {*  보험사명            *}    lbl_insu_company.Caption  := TMAX.RecvString('STR201',0);
  {*  가입자성명          *}    seed_isnm := TMAX.RecvString('STR202',0);
                                lbl_ga_nm.Caption         := ECPlazaSeed.Decrypt(seed_isnm, common_seedkey);
  {*  가입자연락처        *}    seed_istl2 := TMAX.RecvString('STR203',0);
                                lbl_insu_mt_no.Caption    := ECPlazaSeed.Decrypt(seed_istl2, common_seedkey);
  {*  가입자생년월일      *}    seed_isno := TMAX.RecvString('STR204',0);
                                lbl_ga_birthday.Caption   := ECPlazaSeed.Decrypt(seed_isno, common_seedkey);
  {*  가입자연락처        *}    seed_istl := TMAX.RecvString('STR205',0);
                                lbl_ga_tl_no.Caption      := ECPlazaSeed.Decrypt(seed_istl, common_seedkey);
  {*  보험금신청일자      *}    lbl_insu_req_dt.Caption   := TMAX.RecvString('STR206',0);
  {*  보험금지급중지일자  *}    lbl_insu_deny_dt.Caption  := TMAX.RecvString('STR207',0);
  {*  보험금지급승인일자  *}    lbl_insu_allow_dt.Caption := TMAX.RecvString('STR208',0);
  {*  보험금지급(예정)액  *}    lbl_insu_pay_amt.Caption  := TMAX.RecvString('STR209',0);
  {*  보험금처리구분      *}    lbl_insu_sts.Caption      := TMAX.RecvString('STR211',0);

  if (lbl_insu_sts.Caption = '보험금신청') then
    lbl_insu_sts.Font.Color  := clGreen
  else if (lbl_insu_sts.Caption = '보험금지급승인') then
    lbl_insu_sts.Font.Color   := clBlue
  else if (lbl_insu_sts.Caption = '보험금지급중지') then
    lbl_insu_sts.Font.Color   := clRed;

  {*  보험사매각일자      *}    lbl_sl_dt.Caption         := TMAX.RecvString('STR212',0);

  //너머지 버튼 활성화
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

  pgm_sts1 := [1];

  if       (Length(lbl_wk_dt.Caption  ) <> 0 )
      and  (Length(lbl_seq_wk.Caption ) <> 0 )
      and  (Length(lbl_wk_no.Caption  ) <> 0 ) then
  begin
    if Trim(lbl_seq_wk.Caption) <> '0' then
    begin
      color := clRed;
      styles := [fsBold];
    end else
    begin
      color := clBlack;
      styles := [];
    end;
  end
  else
  begin
    color := clBlack;
    styles := [];
  end;

  btn_ans_req.Font.Color := color;
  btn_ans_req.Font.Style := styles;



LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  if ((lbl_insu_sts.Caption = '보험금신청'    ) or
      (lbl_insu_sts.Caption = '보험금지급승인') or
      (lbl_insu_sts.Caption = '단말기매각'    ))
  then
  begin
    rdo_Sh_No.Checked := True;
    frm_LOSTA110P_POP.lbl33.Caption       := lbl_insu_sts.Caption;
    //frm_LOSTC100P.Enabled := False;
    frm_LOSTA110P_POP.FormShow(Sender);
    //pnl_Command.Enabled := False;
    //Panel14.Enabled     := False;

    //pnl1.Enabled := True;
    //pnl1.Show;
  end;

end;

procedure Tfrm_LOSTA110P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

function Tfrm_LOSTA110P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  (****************************************************************************)
  (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
    			      (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - 호출구분          *)+ ' ' +  '01'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle,SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
    
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

    ShowWindow(Self.Handle,SW_SHOW);
   end
end;

procedure Tfrm_LOSTA110P.rdo_Ph_YesClick(Sender: TObject);
begin
     panel4.Enabled       := true;
     dte_bl_dt.Enabled    := true;
     cmb_bl_gu.Enabled    := false;
     rdo_sh_Yes.Checked   := true;
     rdo_sh_No.Checked    := false;
     dte_bl_dt.date       := date;
     cmb_bl_gu.itemindex  := -1;

//     edt_ju_yo.enabled    := false;
//     edt_ju_yo.text       := '';
end;

procedure Tfrm_LOSTA110P.rdo_Ph_NoClick(Sender: TObject);
begin
     Panel4.Enabled       := false;
     dte_bl_dt.Enabled    := false;
     cmb_bl_gu.Enabled    := true;
     rdo_sh_Yes.Checked   := true;
     rdo_sh_No.Checked    := false;
     dte_bl_dt.date       := date;
     cmb_bl_gu.itemindex  := 0;
//     edt_ju_yo.enabled    := True;

end;

procedure Tfrm_LOSTA110P.btn_Addr_UpdateClick(Sender: TObject);
begin
  if ( not fChkLength( md_cb1     , 1, 1,'모델코드'       )) then Exit;
  if ( not fChkLength( serial_edit, 1, 1,'단말기일련번호' )) then Exit;
  if ( not fChkLength( dte_Ip_Dt  , 1, 1,'입고일자'       )) then Exit;

//  ShowWindow(Self.Handle, SW_HIDE);
  Self.Enabled := false;
  frm_LOSTA110P_ADDR.Show;
end;

procedure Tfrm_LOSTA110P.cmb_bl_guChange(Sender: TObject);
begin
   edt_ju_yo.text := '';
   if cmb_bl_gu.ItemIndex = 0 then
   begin
     edt_ju_yo.enabled := true;
   end
   else
   begin
     edt_ju_yo.enabled := false;
   end;

     edt_ju_yo.enabled := true;
     
end;

function Tfrm_LOSTA110P.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTA110P.btn_UpdateClick(Sender: TObject);
begin
  Self.btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA110P.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;

  // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능
  //if ParamStr(6) <> '' then   // 2016.06.21 수정
  if ParamStr(10) <> '' then
  begin
    edt_Id_Nm.Text        :=  fRNVL(ParamStr( 6));
    edt_birth_date.Text   :=  fRNVL(ParamStr( 7));
    md_cb1.Text           :=  fRNVL(ParamStr( 8));
    serial_edit.Text      :=  fRNVL(ParamStr( 9));
    dte_Ip_Dt.Text        :=  fRNVL(ParamStr(10));

    btn_InquiryClick(Self);
  end;
end;

procedure Tfrm_LOSTA110P.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능
  if ParamStr(6) <> '' then
  begin
  	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, 0);
  end;
end;

procedure Tfrm_LOSTA110P.setEdtKeyPress;
var i : Integer;
    edt : TEdit;
begin
  for i := 0 to componentCount -1 do
  begin
    if (Components[i] is TEdit) then
    begin
      (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
    end;
  end;
end;

procedure Tfrm_LOSTA110P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA110P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA110P.btn_LinkClick(Sender: TObject);
var
  Value : array of string;

  commandStr:String;

  progID : string;

	ret:Integer;  
begin
    progID := 'LOSTA120P';

    SetLength(Value, 6 );

    Value[0] := Trim(edt_Id_Nm.Text);       // 성명
    Value[1] := Trim(edt_birth_date.Text);  // 생년월일
    Value[2] := Trim(md_cb1.Text);          // 모델명
    Value[3] := Trim(serial_edit.Text);     // 시리얼번호
    Value[4] := dte_Ip_Dt.Text;             // 입고일자
    Value[5] := edt_phone_no.Text;          // 전화번호

    (****************************************************************************)
    (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
    (****************************************************************************)
    commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
                  (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
                  (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                  (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                  (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                  (* paramstr(5)                     *)+ ' ' +  common_usergroup
                  (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                  (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                  (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                  (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                  (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
                  (* paramstr(11) -                  *)+ ' ' +  fNVL(Value[5])
    ;

  if WinExec(PChar(commandStr), SW_Show) <= 31 then
  begin
    ret := 0;
    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');
  end else
  begin
    Self.Close;
  end;

end;


procedure Tfrm_LOSTA110P.btn_ans_reqClick(Sender: TObject);
begin
  if Length(lbl_wk_dt.Caption) = 0 then
  begin
    ShowMessage('설문조사 대상자가 아닙니다.');
    Exit;
  end;

  fm_LOSTA110P_CHILD.Show;

end;

procedure Tfrm_LOSTA110P.edt_ju_yoClick(Sender: TObject);
begin
  // none
end;

procedure Tfrm_LOSTA110P.edt_ju_yoEnter(Sender: TObject);
begin
  (Sender as Tedit).SelStart := Length((Sender as Tedit).Text);
end;

procedure Tfrm_LOSTA110P.rdo_Sh_YesClick(Sender: TObject);
begin
  if (lbl_insu_sts.Caption = '보험금지급승인') then
  begin
    if (common_usergroup = 'SYSM') then  dte_Bl_dt.Enabled := True
    else
      begin
        ShowMessage('보험금 신청 이후에는 수취하실 수 없습니다.');
        rdo_Sh_No.Checked := True;
      end;
  end;
end;

end.
