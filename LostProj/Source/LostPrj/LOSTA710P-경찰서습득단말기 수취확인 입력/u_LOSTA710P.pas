{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA710P (�н��� ���� Ȯ�� �Է�)                       
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013. 10 .21
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTA710P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, common_lib,localCloud,
  checklst, cpakmsg, Grids, u_LOSTA710P_ADDR, Menus, WinSkinData, so_tmax, u_LOSTA710P_CHILD, ComObj;

const
  TITLE   = '����������ܸ��� ���� Ȯ�� �Է�';
  PGM_ID  = 'LOSTA710P';

type
  Tfrm_LOSTA710P = class(TForm)
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
    bvl5            : TBevel;
    bvl6            : TBevel;
    bvl7            : TBevel;
    bvl8            : TBevel;
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
    bvl22           : TBevel;
    bvl24           : TBevel;
    bvl25           : TBevel;
    bvl26           : TBevel;
    bvl27           : TBevel;
    bvl28           : TBevel;
    bvl31           : TBevel;
    bvl32           : TBevel;
    bvl33           : TBevel;
    bvl34           : TBevel;
    bvl35           : TBevel;
    bvl36           : TBevel;
    bvl37           : TBevel;
    bvl38           : TBevel;
    bvl40           : TBevel;
    bvl41           : TBevel;
    bvl42           : TBevel;
    bvl43           : TBevel;
    bvl44           : TBevel;
    bvl46           : TBevel;
    bvl49           : TBevel;
    bvl50           : TBevel;
    bvl51           : TBevel;
    bvl52           : TBevel;
    bvl53           : TBevel;
    bvl54           : TBevel;
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
    lbl15           : TLabel;
    lbl18           : TLabel;
    lbl19           : TLabel;
    lbl20           : TLabel;
    lbl21           : TLabel;
    lbl22           : TLabel;
    lbl23           : TLabel;
    lbl25           : TLabel;
    lbl26           : TLabel;
    lbl27           : TLabel;
    lbl28           : TLabel;
    lbl29           : TLabel;
    lbl30           : TLabel;
    lbl31           : TLabel;
    lbl_po_nm2      : TLabel;
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
    lbl_jn_dt       : TLabel;
    lbl_gs_id       : TLabel;
    lbl_ip_id       : TLabel;
    lbl_ph_id       : TLabel;
    lbl_cl_id       : TLabel;
    Label33         : TLabel;
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
    Bevel71: TBevel;
    lbl_mn_no: TLabel;
    Bevel72: TBevel;
    Label36: TLabel;
    Bevel73: TBevel;
    lbl_md_nm: TLabel;
    Bevel74: TBevel;
    Label37: TLabel;
    Bevel75: TBevel;
    lbl_sr_no: TLabel;

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


    //LOSTZ810Q.exe�� �޼��� ���� �� ���
    recvedMessage:Boolean;

    //LOSTZ810Q.exe ȣ��� ���
    itemNo        :String;
    value1, value2:String;

    //�˻��� ���
    STR001:String; // ���ڵ�
    STR002:String; // �ܸ����Ϸù�ȣ
    STR003:String; // �԰�����

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

    //�־Ȱ� �̹��� ��ư Ŭ��
    procedure OnSearchClick(Sender:TObject);

    //�˻� ����, ������Ʈ �� Ű������
    procedure OnKeyPress(Sender: TObject; var Key: Char);

    function ExecExternProg(progID:String):Boolean;

    procedure SetItemNo(number:String);

    // �ӽ� �ֹι�ȣ ����
    function frtnRealIdNo(gbn : Integer) : String;
  end;

  (* PGM_STS : ���α׷� ����  *)
  (* 0 : ��ȸ��               *)
  (* 1 : ��ȸ��               *)
  (* 2,3 : ������             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTA710P: Tfrm_LOSTA710P;
  strGidNo , strNidNo : String;
  pgm_sts1   : PGM_STS;
  cmb_bl_gu_d : TZ0xxArray;


implementation
uses u_LOSTA710P_POP;
{$R *.DFM}

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.InitComponents;
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

  // ��ư �ʱ�ȭ
  changeBtn(Self);

  btn_Link.Enabled := True;

  //�ʱ�ȭ
  setItemNo('1');

  //ó�� ����� ������ Ŭ���� ���� ����
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

procedure Tfrm_LOSTA710P.AttachOnKeyPressEvent;
begin
	edt_Id_Nm.OnKeyPress      := self.OnKeyPress; // TEdit       ����
	edt_birth_date.OnKeyPress := self.OnKeyPress; // TDateEdit   �������
	edt_phone_no.OnKeyPress   := self.OnKeyPress; // TMaskEdit   �н��ڵ�����ȣ
	md_cb1.OnKeyPress         := self.OnKeyPress; // TComboEdit  �𵨸�
	serial_edit.OnKeyPress    := self.OnKeyPress; // TEdit       �ø����ȣ
end;

(******************************************************************************)
(* procedure name  : OnKeyPress                                               *)
(* procedure �� �� : ���۳�Ʈ�߿� OnKeyPress�� ����ϴ� ��ü��                *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

  i : Integer;

begin
	if Key <> #13 then 	//����Ű�� �ƴϸ�
  begin
    if Sender is TEdit then
    begin
      if (sender as Tedit).Name = 'edt_birth_date' then
      begin
        if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
      end else
      if (Sender as TEdit).Name = 'serial_edit' then
         if not (key in ['0'..'z',#8,#9,#45,#22]) then key := #0;
    end else
    if Sender is TMaskEdit then
    begin
      if (Sender as TMaskEdit).Name = 'edt_phone_no' then
        if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
    end
    else if Sender is TDateEdit then
        if (Sender as TDateEdit).Name = 'dte_Ip_Dt' then
          if not (key in ['0'..'9',#8,#9,#45]) then key := #0;

    exit;
  end;

	if Sender.ClassType = TEdit then
    begin
      edit := Sender as TEdit;
      if edit = edt_Id_Nm            then btn1.OnClick(btn1)  // ����
      else if edit = serial_edit     then btn4.OnClick(btn4) 	// �ø��� ��ȣ
      else if edit = edt_birth_date  then btn2.OnClick(btn2); // �������
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
        serial_edit.SetFocus;	      //�𵨸�
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
(* procedure �� �� : ���۳�Ʈ�߿� OnSearchClick�� ����ϴ� ��ü��             *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.OnSearchClick(Sender:TObject);
var i : integer;
begin

  //����
  if Sender = btn1 then
    begin
      edt_Id_Nm.SetFocus;

      if Trim(edt_Id_Nm.Text)= '' then
      begin
        ShowMessage('����(��ü��)�� �Է��ϼ���');
        exit;
      end;

      edt_Id_Nm.OnExit(edt_Id_Nm);
      //Application.ProcessMessages;
    end
  else if Sender = btn2 then
    begin
      edt_birth_date.SetFocus;	//��¥

      if Trim(delHyphen(edt_birth_date.Text))='' then
      begin
        ShowMessage('��¥�� �Է��ϼ���');
        exit;
      end;

      edt_birth_date.OnExit(edt_birth_date);
    end
  //�н�����ȣ
  else if Sender = btn3 then
    begin
      edt_phone_no.SetFocus;

      if Trim(edt_phone_no.Text)='' then
      begin
        ShowMessage('�� ��ȣ�� �Է��ϼ���');
        exit;
      end;

      edt_phone_no.OnExit(edt_phone_no);

    end
  //�ø��� ��ȣ
  else if Sender = btn4 then
  begin
    serial_edit.SetFocus;
    if (Trim(md_cb1.Text) = '') or  (Trim(serial_edit.Text) ='') then
    begin
      ShowMessage('�𵨸�� �ø����ȣ�� �Է��ϼ���');
      exit;
    end;

    serial_edit.OnExit(serial_edit);
  end;

  CreateMap;	//�����޸� ����

  self.ExecExternProg('LOSTZ810Q');     // ������ȸ
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure �� �� : ���۳�Ʈ�߿� OnExit�� ����ϴ� ��ü��                    *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                   �ش� �̺�Ʈ�� �߻��� ���۳�Ʈ�� ���� ���������� �����Ѵ� *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.OnExit(Sender:TObject);
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
      //�ø��� ��ȣ
      if edit = serial_edit then
        begin
          //value1 := findCodeFromName(Trim(md_cb1.Text), md_grid1_d, md_grid1.RowCount);
          value1 := Trim(md_cb1.Text); //�������� ���� -> value1
          value2 := Trim(edit.Text);   //�������� ���� -> value2
          if value2 = '' then value2 := 'dummy';
          //edit.Text := value2;
          md_grid1.Visible := False;
        end
      //����
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
    //�𵨸�
    else if Sender.ClassType = TComboEdit then
    begin
      cedit   := Sender as TComboEdit;

      value1  := Trim(cedit.Text);

      if value1 = '' then
        value1  := 'dummy';
    end
  //�н��� ��ȣ
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
(* procedure �� �� : ���۳�Ʈ�߿� DetachOnEnterEvent�� ����ϴ� ��ü��        *)
(*                   �̺�Ʈ�� �����Ѵ�..                                      *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := nil;         // TEdit       ����
	edt_birth_date.OnEnter:= nil;         // TDateEdit   �������
	edt_phone_no.OnEnter  := nil;         // TMaskEdit   �н��ڵ�����ȣ
	md_cb1.OnEnter        := nil;         // TComboEdit  �𵨸�
	serial_edit.OnEnter   := nil;         // TEdit       �ø����ȣ
end;

(******************************************************************************)
(* procedure name  : AttachOnExitEvent                                        *)
(* procedure �� �� : ���۳�Ʈ�߿� OnExitEvent�� ����ϴ� ��ü��               *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.AttachOnExitEvent;
begin
	edt_Id_Nm.OnExit      := self.OnExit; // TEdit       ����
	edt_birth_date.OnExit := self.OnExit; // TDateEdit   �������
	edt_phone_no.OnExit   := self.OnExit; // TMaskEdit   �н��ڵ�����ȣ
	md_cb1.OnExit         := self.OnExit; // TComboEdit  �𵨸�
	serial_edit.OnExit    := self.OnExit; // TEdit       �ø����ȣ
end;

(******************************************************************************)
(* procedure name  : AttachOnEnterEvent                                       *)
(* procedure �� �� : ���۳�Ʈ�߿� OnEnterEvent�� ����ϴ� ��ü��              *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.AttachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := self.OnEnter; // TEdit      ����
	edt_birth_date.OnEnter:= self.OnEnter; // TDateEdit  �������
	edt_phone_no.OnEnter  := self.OnEnter; // TMaskEdit  �н��ڵ�����ȣ
	md_cb1.OnEnter        := self.OnEnter; // TComboEdit �𵨸�
	serial_edit.OnEnter   := self.OnEnter; // TEdit      �ø����ȣ
end;

(******************************************************************************)
(* procedure name  : OnEnter                                                  *)
(* procedure �� �� : ���۳�Ʈ�߿� OnEnter�� ����ϴ� ��ü��                   *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                   ����ģ ���۳�Ʈ�� ���� �ľ��ؼ� ������ ���ڸ� ��� �ִ´�*)
(******************************************************************************)
procedure Tfrm_LOSTA710P.OnEnter(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	if Sender.ClassType = TEdit then
  begin
    edit := Sender as TEdit;
    //����
    if edit = edt_Id_Nm then
      SetItemNo('1')
    //�ø��� ��ȣ
    else if edit = serial_edit then
      SetItemNo('4')
    else if edit = edt_birth_date then
    // �������
      SetItemNo('2');
  end
  //�𵨸�
  else if Sender.ClassType = TComboEdit then begin
    cedit:= Sender as TComboEdit;
    if cedit = md_cb1 then begin
      md_grid1.Visible := false;
      setItemNo('4');
    end;
  end
  // �н��ڵ�����ȣ
  else if Sender.ClassType = TMaskEdit then begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then
            SetItemNo('3');
  end;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure �� �� : ����ģ ���۳�Ʈ�� ���� ���ڸ� ��� �ִ´�.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA710P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

procedure Tfrm_LOSTA710P.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;		  //�����=1,�̻��=0 *)
  (*  ProgID      :String[30];	//������� ���α׷� *)
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
	//'LOSTZ830.exe'���� ���� �޼����� �޾Ҵ�.
  Self.Show;
	recvedMessage:= True;

  //�����޸� ������ �ʿ俩�δ� wparam�� ������ ��.
  if Msg.wParam = 1 then
  begin
    //�����޸𸮸� ��´�.
    smem:= OpenMap;
    if smem <> nil then
    begin
      Lock;  //���� ���ӹ���

      edt_Id_Nm.Text        := smem^.name;			      //����(��ü��)
      md_cb1.Text           := smem^.model_name;	    //�𵨸�
      serial_edit.Text      := smem^.serial_no;	      //�ܸ����Ϸù�ȣ
      dte_Ip_Dt.Text        := smem^.ibgo_date;		    //�԰���
      edt_birth_date.Text   := smem^.birth;			      //�������
      edt_phone_no.EditText := Trim(smem^.phone_no);  //�н��ڵ�����ȣ

      if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //�����޸𸮸� ��� ��.
      CloseMapMain;
      smem:= nil;
    end;

    // �� �ڵ�� ����
    for i := 0 to md_grid1.RowCount do
    begin
      if md_cb1.Text = md_grid1_d[i].name then
        lbl_nm_cd.Caption := md_grid1_d[i].JCode5;
    end;

    //'��ȸ' ��ư Ŭ��
    btn_InquiryClick(self);
  end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

// ���޺� Ŭ���� �̺�Ʈ
procedure Tfrm_LOSTA710P.md_cb1ButtonClick(Sender: TObject);
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

// �� �޺� KeyUp �̺�Ʈ
procedure Tfrm_LOSTA710P.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   // ���� ���� ��
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

   //����Ű ���� ���� ��
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

   // ����Ű �Ʒ��� ���� ��
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

// �� �׸��� Ŭ����
procedure Tfrm_LOSTA710P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text        := md_grid1.Cells[0,md_grid1.row];
   lbl_nm_cd.Caption  := md_grid1_d[md_grid1.Row].JCode5;
   md_cb1.SetFocus;
   md_grid1.Visible   := false;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA710P.FormCreate(Sender: TObject);
var i : integer;
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.

	if ParamCount < 5 then begin
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  // �ܺ� ȣ���� ��쿡�� ���� ex) LOSTA200Q ���� �� ���α׷� ȣ�� ����

  //���뺯�� ����--common_lib.pas ������ ��.

  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  //common_seedkey    := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  //common_userid     := '0294';    //ParamStr(2);
  //common_username   := '��ȣ��';  //ParamStr(3);
  //common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}
  setEdtKeyPress;

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ĸ�� ����
  lbl_Program_Name.Caption := TITLE;

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // �޼��� �� ���� ����
  pSetStsWidth(sts_Message);

  // �ؽ�Ʈ ���ý� ��ü ���� ���
  pSetTxtSelAll(Self);

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  
  //common_lib.pas�� �ִ�.
  initSkinForm(SkinData1);

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1  );
  initComboBoxWithZ0xx ('Z071.dat', cmb_bl_gu_d , '', '',cmb_bl_gu );

  //������Ʈ�� �̺�Ʈ�� ����ġ �Ѵ�.
  AttachOnEnterEvent;
  AttachOnExitEvent;
  AttachOnKeyPressEvent;

  btn1.OnClick := self.OnSearchClick;
  btn2.OnClick := self.OnSearchClick;
  btn3.OnClick := self.OnSearchClick;
  btn4.OnClick := self.OnSearchClick;

  edt_ju_yo.OnClick := edt_ju_yoClick;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTA710P.btn_AddClick(Sender: TObject);
var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  // ���� �Ķ����
  STRVALUE : array[1..8] of string;

  // ���� ���� ��ȣ ex) 001,002..xxx
  STRNUM : string;

  // ���� ���� �Ķ���� ex) I01,U01,D01..
  svcNm  : string;

  // ��������
  i : Integer;
  Label LIQUIDATION;
  Label SEEDKEY;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  // ���� ���� �Ķ���� ����
  if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if ( (pgm_sts1 = [0]) and (svcNm = 'I01')) then
  begin
    ShowMessage('�ʱ�ȭ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end else if (( pgm_sts1 = [0]) and (svcNm = 'U01')) then
  begin
    ShowMessage('��ȸ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end;

  if (not fChkLength(serial_edit, 1,1,'Serial-no'))    then Exit;
  if (not fChkLength(dte_Ip_Dt  , 8,1,'�԰�����' ))    then Exit;
  if (not fChkLength(dte_Bl_dt  , 8,1,'�߼ۿ�����' ))  then Exit;


  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

//SEED KEY ��ȸ
SEEDKEY:

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //���� ȣ��
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ

  TMAX.InitBuffer;
  
  FillChar(STRVALUE,SizeOf(STRVALUE),#0);

  (* ���ڵ�      *) STRVALUE[1] := edt_md_cd.Text;
  (* �ܸ����Ϸù�ȣ*) STRVALUE[2] := serial_edit.Text;
  (* �԰�����      *) STRVALUE[3] := delHyphen(dte_Ip_Dt.Text);
  (* ��������      *) if rdo_Ph_Yes.Checked then STRVALUE[4] := 'Y' else STRVALUE[4] := 'N';
  (* ���뿩��      *) if rdo_Sh_Yes.Checked then STRVALUE[5] := 'Y' else STRVALUE[5] := 'N';
  (* �߼ۿ�����    *) STRVALUE[6] := delHyphen(dte_Bl_dt.Text);
  (* ���ӻ����ڵ�  *) if cmb_bl_gu.ItemIndex <> -1 then STRVALUE[7] := cmb_bl_gu_d[cmb_bl_gu.itemIndex].code;
  (* ����          *) STRVALUE[8] := edt_ju_yo.text;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA710P')       < 0) then  goto LIQUIDATION;

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

    //���� ȣ��
	if not TMAX.Call('LOSTA710P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' ��� �Ϸ�';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA710P.btn_DeleteClick(Sender: TObject);
var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;

  // ���� �Ķ����
  STRVALUE : array[1..3] of string;

  // ���� ���� ��ȣ ex) 001,002..xxx
  STRNUM : string;

  // ���� ���� �Ķ���� ex) I01,U01,D01..
  svcNm  : string;

  // ��������
  i : Integer;
  Label LIQUIDATION;
  Label SEEDKEY;

begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  if pgm_sts1 = [0] then
  begin
    ShowMessage('��ȸ �� �����Ͻ� �� �ֽ��ϴ�.');
    Exit;
  end;

  if MessageDlg('���� �����Ͻðڽ��ϱ� ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
  begin
    sts_Message.Panels[1].text := '������ ��ҵǾ����ϴ�.';
    Exit;
  end
  else
  begin

    if (not fChkLength(serial_edit, 1,1,'Serial-no'))    then Exit;
    if (not fChkLength(dte_Ip_Dt  , 8,1,'�԰�����' ))    then Exit;
    if (not fChkLength(md_cb1     , 1,1,'�𵨸�' ))  then Exit;


    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

//SEED KEY ��ȸ
SEEDKEY:

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //���� ȣ��
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ

  TMAX.InitBuffer;
  
    FillChar(STRVALUE,SizeOf(STRVALUE),#0);

    (* ���ڵ�      *) STRVALUE[1] := edt_md_cd.Text;
    (* �ܸ����Ϸù�ȣ*) STRVALUE[2] := serial_edit.Text;
    (* �԰�����      *) STRVALUE[3] := delHyphen(dte_Ip_Dt.Text);

      //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTA710P')       < 0) then  goto LIQUIDATION;

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


    //���� ȣ��
    if not TMAX.Call('LOSTA710P') then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end;

    sts_Message.Panels[1].Text := ' ���� �Ϸ�';
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA710P.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_mtno, seed_gano, seed_ganm, seed_gatl, seed_nano, seed_nanm, seed_natl : String;
    seed_gtno, seed_gtnm, seed_gttl, seed_imtno, seed_igano, seed_iganm, seed_igatl : String;

    i : integer;
    component : TComponent;
    color     : TColor;
    styles    : TFontStyles;

Label LIQUIDATION;
Label SEEDKEY;

begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_mtno   := '';
    seed_gano   := '';
    seed_ganm   := '';
    seed_gatl   := '';
    seed_nano   := '';
    seed_nanm   := '';
    seed_natl   := '';
    seed_gtno   := '';
    seed_gtnm   := '';
    seed_gttl   := '';
    seed_imtno  := '';
    seed_igano  := '';
    seed_iganm  := '';
    seed_igatl  := '';

  if(not fChkLength(md_cb1      ,1,1,'���ڵ�'       )) then Exit;
  if(not fChkLength(serial_edit ,1,1,'�ܸ��� �Ϸù�ȣ')) then Exit;
  if(not fChkLength(dte_Ip_Dt   ,8,0,'�԰�����'       )) then Exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//���ڵ�
	STR002:= serial_edit.Text;			                                        //�ܸ����Ϸù�ȣ
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                    //�԰�����


  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if((Pos('lbl_',(component as TLabel).Name) > 0) AND (Pos('lbl_Prog',(component as TLabel).Name) = 0) and ((component as TLabel).Name <> 'lbl_nm_cd')) then (component as TLabel).Caption := '';
  end;

  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

//SEED KEY ��ȸ
SEEDKEY:

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //���� ȣ��
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ

  TMAX.InitBuffer;
  
    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA710P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA710P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
    begin

      if Pos('�ܸ���',TMAX.RecvString('INF012',0)) = 0 then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        ShowMessage( TMAX.RecvString('INF012',0));
    end
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  (* ���ڵ�(Z008)          *) edt_md_cd.Text     :=             Trim(TMAX.RecvString('STR101',0));
  (* �𵨸�                  *) md_cb1.Text        :=             Trim(TMAX.RecvString('STR102',0));
  (* �ܸ����Ϸù�ȣ          *) serial_edit.Text   :=             Trim(TMAX.RecvString('STR103',0));
  (* �԰�����                *) dte_Ip_Dt.Text     := InsHyphen(  Trim(TMAX.RecvString('STR104',0)));
  (* �ܸ��������ڵ�(Z031)    *) //                                Trim(TMAX.RecvString('STR105',0));
  (* �ܸ�������              *) lbl_ph_gb.Caption  :=             Trim(TMAX.RecvString('STR106',0));
  (* �ܸ�������              *) lbl_ph_yo.Caption  :=             Trim(TMAX.RecvString('STR107',0));
  (* �������                *) lbl_Sn_Dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR108',0)));
  (* �ܸ�������ڵ�(Z032)    *) //                                Trim(TMAX.RecvString('STR109',0));
  (* �ܸ������              *) lbl_Ph_Cd.Caption  :=             Trim(TMAX.RecvString('STR110',0));
  (* â���ȣ                *) lbl_Cg_No.Caption  :=             Trim(TMAX.RecvString('STR111',0));
  (* �н��ڵ�����ȣ          *) seed_mtno          :=             TMAX.RecvString('STR112',0);
                                edt_phone_no.Text  :=   Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
                                lbl_Mt_No.Caption  :=   Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
  (* �������ֹλ���ڱ����ڵ�*) //                                Trim(TMAX.RecvString('STR113',0));
  (* �������ֹλ���ڱ���    *) lbl_Gid_Gu.Caption :=             Trim(TMAX.RecvString('STR114',0));
  (* �������ֹλ���ڹ�ȣ    *) seed_gano          :=             TMAX.RecvString('STR115',0);
                                lbl_Gid_No.Caption := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey)));
                                strGidNo           :=             Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* �����ڼ���(��ü��)      *) seed_ganm          :=             TMAX.RecvString('STR116',0);
                                lbl_Gid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
  (* �����ڿ����ȣ          *) lbl_Gpt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR117',0)));
  (* �����ڱ⺻�ּ�          *) lbl_Gju_So.Caption :=             Trim(TMAX.RecvString('STR118',0));
  (* �����ڻ��ּ�          *) lbl_Gbo_So.Caption :=             Trim(TMAX.RecvString('STR119',0));
  (* ��������ȭ��ȣ          *) seed_gatl          :=             TMAX.RecvString('STR120',0);
                                lbl_Gtl_No.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
  (* �������ֹλ���ڱ����ڵ�*) //                                Trim(TMAX.RecvString('STR121',0));
  (* �������ֹλ���ڱ���    *) lbl_Nid_Gu.Caption :=             Trim(TMAX.RecvString('STR122',0));
  (* �������ֹλ���ڹ�ȣ    *) seed_nano          :=             TMAX.RecvString('STR123',0);
                                lbl_Nid_No.Caption := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_nano, common_seedkey)));
                                strNidNo           :=             Trim(ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
  (* �����ڼ���(��ü��)      *) seed_nanm          :=             TMAX.RecvString('STR124',0);
                                lbl_Nid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_nanm, common_seedkey));
  (* �����ڿ����ȣ          *) lbl_Npt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR125',0)));
  (* �����ڱ⺻�ּ�          *) lbl_Nju_So.Caption :=             Trim(TMAX.RecvString('STR126',0));
  (* �����ڻ��ּ�          *) lbl_Nbo_So.Caption :=             Trim(TMAX.RecvString('STR127',0));
  (* ��������ȭ��ȣ          *) seed_natl          :=             TMAX.RecvString('STR128',0);
                                lbl_Ntl_no.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_natl, common_seedkey));
  (* �������ֹλ���ڹ�ȣ    *) seed_gtno          :=             TMAX.RecvString('STR129',0);
                                lbl_gt_no.Caption  := InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gtno, common_seedkey)));
  (* �����ڼ���(��ü��)      *) seed_gtnm          :=             TMAX.RecvString('STR130',0);
                                lbl_id_nm.Caption  :=             Trim(ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey));
  (* �����ڿ����ȣ          *) lbl_pt_no.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR131',0)));
  (* �����ڱ⺻�ּ�          *) lbl_ju_so.Caption  :=             Trim(TMAX.RecvString('STR132',0));
  (* �����ڻ��ּ�          *) lbl_bo_so.Caption  :=             Trim(TMAX.RecvString('STR133',0));
  (* ��������ȭ��ȣ          *) seed_gttl          :=             TMAX.RecvString('STR134',0);
                                lbl_tl_no.Caption  :=             Trim(ECPlazaSeed.Decrypt(seed_gttl, common_seedkey));
  (* �������ڵ�(Z042)        *) //                                Trim(TMAX.RecvString('STR135',0));
  (* ��������                *) lbl_po_nm2.Caption :=             Trim(TMAX.RecvString('STR136',0));
                                lbl_Po_nm.Caption  :=  lbl_po_nm2.Caption;
  (* �����������            *) lbl_rg_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR137',0)));
  (* �߼ۿ�����              *) lbl_bl_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR138',0)));

  (* ��������                *) if TMAX.RecvString('STR141',0) = 'Y' then
                                begin
                                  rdo_Ph_Yes.Checked := True;
                                  rdo_Ph_No.Checked  := False;
                                  rdo_Ph_Yes.OnClick(frm_LOSTA710P);

                                  if TMAX.RecvString('STR144',0) = 'Y' then
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
                                  rdo_Ph_No.OnClick(frm_LOSTA710P);

                                  cmb_bl_gu.OnChange(frm_LOSTA710P);
                                end;
  (* ó�������ڵ�(Z040)      *) cmb_bl_gu.ItemIndex:= cmb_bl_gu.Items.IndexOf(
  findNameFromCode(TMAX.RecvString('STR142',0),cmb_bl_gu_d,cmb_bl_gu.Items.Count));

  (* ó������                *) lbl_ch_gu.Caption  :=             Trim(TMAX.RecvString('STR140',0));
  (* ��������                *) lbl_ph_yn.Caption  :=             Trim(TMAX.RecvString('STR143',0));

  (* ���뿩��                *) if TMAX.RecvString('STR144',0) = 'Y' then rdo_Sh_Yes.Checked := True
                                else rdo_Sh_No.Checked := True;

  (* ���뿩��                *) lbl_sh_yn.Caption  :=             Trim(TMAX.RecvString('STR144',0));
  (* ����Ȯ������            *) lbl_ph_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR145',0)));
  (* �������                *) lbl_cl_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR146',0)));
  (* ������ڵ�(Z041)      *) //                                Trim(TMAX.RecvString('STR147',0));
  (* �����                *) lbl_cl_gu.Caption  :=             Trim(TMAX.RecvString('STR148',0));
  (* �ݼ�����                *) lbl_bn_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR149',0)));
  (* �ݼۻ����ڵ�(Z034)      *) //                                Trim(TMAX.RecvString('STR150',0));
  (* �ݼۻ���                *) lbl_bn_sy.Caption  :=             Trim(TMAX.RecvString('STR151',0));
  (* ���ÿ���                *) lbl_gs_yn.Caption  :=             Trim(TMAX.RecvString('STR152',0));
  (* ��������                *) lbl_gs_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR153',0)));
  (* �������н����������    *) lbl_po_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR154',0)));
  (* ��������                *) lbl_jn_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR155',0)));
  (* ������ID                *) lbl_gs_id.Caption  :=             Trim(TMAX.RecvString('STR156',0));
  (* �԰���ID                *) lbl_ip_id.Caption  :=             Trim(TMAX.RecvString('STR157',0));
  (* ����Ȯ����ID            *) lbl_ph_id.Caption  :=             Trim(TMAX.RecvString('STR158',0));
  (* �����ID                *) lbl_cl_id.Caption  :=             Trim(TMAX.RecvString('STR159',0));
  (* ����ó����ID            *) lbl_last_id.Caption:=             Trim(TMAX.RecvString('STR163',0));
  (* ����ڽĺ��ڵ�          *) lbl_id_cd.Caption  :=             Trim(TMAX.RecvString('STR164',0));
  (* ����                    *) edt_ju_yo.Text     :=             Trim(TMAX.RecvString('STR165',0));
  (* ����û������ȣ-ȹ����� *) lbl_mn_no.Caption  :=             Trim(TMAX.RecvString('STR166',0));

  (* ����û�Է� �𵨸�       *) lbl_md_nm.Caption  :=             Trim(TMAX.RecvString('STR168',0));
  (* ����û�Է� �Ϸù�ȣ     *) lbl_sr_no.Caption  :=             Trim(TMAX.RecvString('STR169',0));

  (* �ּҼ�������            *)
  if TMAX.RecvString('STR161',0) = '' then frm_LOSTA710P_ADDR.cmb_up_gu.ItemIndex := -1
  else frm_LOSTA710P_ADDR.cmb_up_gu.ItemIndex := StrToInt(TMAX.RecvString('STR161',0)) -1;

  {*  ������            *}    lbl_insu_company.Caption  := TMAX.RecvString('STR201',0);
  {*  �����ڼ���          *}    seed_iganm                := TMAX.RecvString('STR202',0);
                                lbl_ga_nm.Caption         := ECPlazaSeed.Decrypt(seed_iganm, common_seedkey);
  {*  �����ڿ���ó        *}    seed_imtno                := TMAX.RecvString('STR203',0);
                                lbl_insu_mt_no.Caption    := ECPlazaSeed.Decrypt(seed_imtno, common_seedkey);
  {*  �����ڻ������      *}    seed_igano                := TMAX.RecvString('STR204',0);
                                lbl_ga_birthday.Caption   := ECPlazaSeed.Decrypt(seed_igano, common_seedkey);
  {*  �����ڿ���ó        *}    seed_igatl                := TMAX.RecvString('STR205',0);
                                lbl_ga_tl_no.Caption      := ECPlazaSeed.Decrypt(seed_igatl, common_seedkey);
  {*  ����ݽ�û����      *}    lbl_insu_req_dt.Caption   := TMAX.RecvString('STR206',0);
  {*  �����������������  *}    lbl_insu_deny_dt.Caption  := TMAX.RecvString('STR207',0);
  {*  ��������޽�������  *}    lbl_insu_allow_dt.Caption := TMAX.RecvString('STR208',0);
  {*  ���������(����)��  *}    lbl_insu_pay_amt.Caption  := TMAX.RecvString('STR209',0);
  {*  �����ó������      *}    lbl_insu_sts.Caption      := TMAX.RecvString('STR211',0);

  if (lbl_insu_sts.Caption = '����ݽ�û') then
    lbl_insu_sts.Font.Color  := clGreen
  else if (lbl_insu_sts.Caption = '��������޽���') then
    lbl_insu_sts.Font.Color   := clBlue
  else if (lbl_insu_sts.Caption = '�������������') then
    lbl_insu_sts.Font.Color   := clRed;

  {*  �����Ű�����      *}    lbl_sl_dt.Caption         := TMAX.RecvString('STR212',0);

  //������ ��ư Ȱ��ȭ
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

  pgm_sts1 := [1];

  color := clBlack;
  styles := [];

  btn_ans_req.Font.Color := color;
  btn_ans_req.Font.Style := styles;



LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  if ((lbl_insu_sts.Caption = '����ݽ�û'    ) or
      (lbl_insu_sts.Caption = '��������޽���') or
      (lbl_insu_sts.Caption = '�ܸ���Ű�'    ))
  then
  begin
    rdo_Sh_No.Checked := True;
    frm_LOSTA710P_POP.lbl33.Caption       := lbl_insu_sts.Caption;
    //frm_LOSTC100P.Enabled := False;
    frm_LOSTA710P_POP.FormShow(Sender);
    //pnl_Command.Enabled := False;
    //Panel14.Enabled     := False;

    //pnl1.Enabled := True;
    //pnl1.Show;
  end;

end;

procedure Tfrm_LOSTA710P.btn_CloseClick(Sender: TObject);
begin
    //ȣ���� APP�� ���� ������ �޼���....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'�� ���� ���� �Ͻʽÿ�.');
      exit;
  end;

  close;
end;

function Tfrm_LOSTA710P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  (****************************************************************************)
  (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
    			      (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '21'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  itemNo
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle,SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
    
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');

    ShowWindow(Self.Handle,SW_SHOW);
   end
end;

procedure Tfrm_LOSTA710P.rdo_Ph_YesClick(Sender: TObject);
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

procedure Tfrm_LOSTA710P.rdo_Ph_NoClick(Sender: TObject);
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

procedure Tfrm_LOSTA710P.btn_Addr_UpdateClick(Sender: TObject);
begin
  if ( not fChkLength( md_cb1     , 1, 1,'���ڵ�'       )) then Exit;
  if ( not fChkLength( serial_edit, 1, 1,'�ܸ����Ϸù�ȣ' )) then Exit;
  if ( not fChkLength( dte_Ip_Dt  , 1, 1,'�԰�����'       )) then Exit;

//  ShowWindow(Self.Handle, SW_HIDE);
  Self.Enabled := false;
  frm_LOSTA710P_ADDR.Show;
end;

procedure Tfrm_LOSTA710P.cmb_bl_guChange(Sender: TObject);
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

function Tfrm_LOSTA710P.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTA710P.btn_UpdateClick(Sender: TObject);
begin
  Self.btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA710P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
  InitComponents;

  // �ܺ� ȣ���� ��쿡�� ���� ex) LOSTA200Q ���� �� ���α׷� ȣ�� ����
  //if ParamStr(6) <> '' then   // 2016.06.21 ����
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

procedure Tfrm_LOSTA710P.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // �ܺ� ȣ���� ��쿡�� ���� ex) LOSTA200Q ���� �� ���α׷� ȣ�� ����
  if ParamStr(6) <> '' then
  begin
  	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, 0);
  end;
end;

procedure Tfrm_LOSTA710P.setEdtKeyPress;
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

procedure Tfrm_LOSTA710P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA710P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA710P.btn_LinkClick(Sender: TObject);
var
  Value : array of string;

  commandStr:String;

  progID : string;

	ret:Integer;  
begin
    ret := 0;
    progID := 'LOSTA720P';

    SetLength(Value, 6 );

    Value[0] := Trim(edt_Id_Nm.Text);       // ����
    Value[1] := Trim(edt_birth_date.Text);  // �������
    Value[2] := Trim(md_cb1.Text);          // �𵨸�
    Value[3] := Trim(serial_edit.Text);     // �ø����ȣ
    Value[4] := dte_Ip_Dt.Text;             // �԰�����
    Value[5] := edt_phone_no.Text;          // ��ȭ��ȣ

    (****************************************************************************)
    (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
    (****************************************************************************)
    commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
                  (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
                  (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                  (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                  (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
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

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');
  end else
  begin
    Self.Close;
  end;

end;


procedure Tfrm_LOSTA710P.btn_ans_reqClick(Sender: TObject);
begin
  if Length(lbl_wk_dt.Caption) = 0 then
  begin
    ShowMessage('�������� ����ڰ� �ƴմϴ�.');
    Exit;
  end;

  fm_LOSTA710P_CHILD.Show;

end;

procedure Tfrm_LOSTA710P.edt_ju_yoClick(Sender: TObject);
begin
  // none
end;

procedure Tfrm_LOSTA710P.edt_ju_yoEnter(Sender: TObject);
begin
  (Sender as Tedit).SelStart := Length((Sender as Tedit).Text);
end;

procedure Tfrm_LOSTA710P.rdo_Sh_YesClick(Sender: TObject);
begin
  if (lbl_insu_sts.Caption = '��������޽���') then
  begin
    if (common_usergroup = 'SYSM') then  dte_Bl_dt.Enabled := True
    else
      begin
        ShowMessage('����� ��û ���Ŀ��� �����Ͻ� �� �����ϴ�.');
        rdo_Sh_No.Checked := True;
      end;
  end;
end;

end.
