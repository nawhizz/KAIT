{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA720P (����������ܸ��� ��� �Է�)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013. 10. 21
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
unit u_LOSTA720P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '����������ܸ��� ��� �Է�';
  PGM_ID  = 'LOSTA720P';

type
  Tfrm_LOSTA720P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    lbl_Bl_Dt: TLabel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    lbl_Ph_Cd: TLabel;
    Bevel11: TBevel;
    Label11: TLabel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Label4: TLabel;
    cmb_Cl_Gu: TComboBox;
    pnl_Command: TPanel;
    Bevel4: TBevel;
    Bevel1: TBevel;
    Label2: TLabel;
    lbl_Cl_Id: TLabel;
    cmb_md_cd: TComboBox;
    Bevel19: TBevel;
    Label3: TLabel;
    Bevel25: TBevel;
    lbl_Cg_No: TLabel;
    Bevel31: TBevel;
    Label12: TLabel;
    Bevel32: TBevel;
    lbl_Ph_Gb: TLabel;
    Panel1: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label6: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel17: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel33: TBevel;
    Label13: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    edt_phone_no: TMaskEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    md_grid1: TStringGrid;
    edt_birth_date : TEdit;
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
    SkinData1: TSkinData;
    TMAX: TTMAX;
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    Bevel3: TBevel;
    Label1: TLabel;
    Panel3: TPanel;
    rdo_Bx_yes: TRadioButton;
    rdo_Bx_No: TRadioButton;
    Bevel34: TBevel;
    Label9: TLabel;
    Panel4: TPanel;
    rdo_out_yes: TRadioButton;
    rbo_out_n: TRadioButton;
    Bevel35: TBevel;
    Bevel36: TBevel;
    lbl_insu_sts: TLabel;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    Bevel20: TBevel;
    Bevel26: TBevel;
    Bevel22: TBevel;
    Bevel27: TBevel;
    Bevel23: TBevel;
    Bevel28: TBevel;
    Bevel21: TBevel;
    Bevel29: TBevel;
    Bevel24: TBevel;
    Bevel30: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel7: TBevel;
    lbl_Pt_No: TLabel;
    lbl_Lt_No: TLabel;
    lbl_Lt_Nm: TLabel;
    lbl_Tl_No: TLabel;
    Label7: TLabel;
    lbl_Bo_So: TLabel;
    Label8: TLabel;
    lbl_Ju_So: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label20: TLabel;
    lbl_Lt_Gu: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    Bevel37: TBevel;
    msk_Gt_No: TMaskEdit;
    Bevel38: TBevel;
    edt_Gt_Nm: TEdit;
    Label19: TLabel;
    Label14: TLabel;
    Bevel39: TBevel;
    msk_Gt_Pt: TMaskEdit;
    btn_Postno_Inq: TBitBtn;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Bevel40: TBevel;
    Bevel41: TBevel;
    Bevel42: TBevel;
    Label27: TLabel;
    Bevel43: TBevel;
    edt_Gt_Bo: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Bevel44: TBevel;
    msk_Gt_Tl: TMaskEdit;
    Label32: TLabel;
    lbl_Gt_Ju: TLabel;
    chk_Gt_yn: TCheckBox;
    chk_rodadr_yn: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_Ip_DtExit(Sender: TObject);
    procedure md_Grid1Click(Sender: TObject);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure cmb_Cl_GuChange(Sender: TObject);
    procedure chk_Gt_ynClick(Sender: TObject);
    procedure btn_Postno_InqClick(Sender: TObject);
    procedure chk_rodadr_ynClick(Sender: TObject);
  private
    { Private declarations }
    cmb_Cl_Gu_d,md_grid1_d :TZ0xxArray;

    //LOSTZ830Q.exe�� �޼��� ���� �� ���
    recvedMessage:Boolean;

    //LOSTZ830Q.exe ȣ��� ���
    itemNo        :String;
    value1, value2:String;

    //�˻��� ���
    STR001:String; // ���ڵ�
    STR002:String; // �ܸ����Ϸù�ȣ
    STR003:String; // �԰�����

  public
    { Public declarations }
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure Link_rtn2(var Msg:TMessage); message WM_LOSTPROJECT2;

    procedure SetItemNo(number:String);
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
    function ExecExternProg2(progID:String):Boolean;

    function keyCheck:boolean;

    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;    
  end;

var
  callValue : Integer;
  frm_LOSTA720P: Tfrm_LOSTA720P;

implementation
uses cpaklibm, Clipbrd;
{$R *.DFM}

function Tfrm_LOSTA720P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('�𵨸�, �ø����ȣ �� �԰����ڸ� �Է��ϼ���');
        result := false;
      end;
end;


procedure Tfrm_LOSTA720P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA720P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

begin
	if Key <> #13 then 	//����Ű�� �ƴϸ�
  begin
    if Sender is TEdit then
    begin
      if (((sender as Tedit).Name = 'edt_birth_date') or ((Sender as Tedit).name = 'serial_edit')) then
        if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
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
procedure Tfrm_LOSTA720P.OnSearchClick(Sender:TObject);
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
    //�н�����
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
          if (Trim(md_cb1.Text) = '') or  (Trim(serial_edit.Text) ='') then begin
            ShowMessage('�𵨸�� �ø����ȣ�� �Է��ϼ���');
            exit;
          end;
          serial_edit.OnExit(serial_edit);
    end;

    CreateMap;	//�����޸� ����
	  self.ExecExternProg('LOSTZ810Q');
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure �� �� : ���۳�Ʈ�߿� OnExit�� ����ϴ� ��ü��                    *)
(*                   �̺�Ʈ�� �����Ѵ�.                                       *)
(*                   �ش� �̺�Ʈ�� �߻��� ���۳�Ʈ�� ���� ���������� �����Ѵ� *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.OnExit(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	value2:= 'dummy';

	if Sender.ClassType = TEdit then
    begin
      edit := Sender as TEdit;
      //�ø��� ��ȣ
      if edit = serial_edit then
        begin
          callValue := 1;
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
        callValue := 2;
        value1:= Trim(edt_Id_Nm.Text);

        if value1 = '' then value1 := 'dummy';
        //edit.text := value1;
      end
      else if edit = edt_birth_date then
      begin
        callValue := 3;
        value1:= Trim(edt_birth_date.Text);

        if value1= '' then value1 :='dummy';
      end;
      end
    //�𵨸�
    else if Sender.ClassType = TComboEdit then
    begin
      cedit   := Sender as TComboEdit;

      callValue := 4;
      value1  := Trim(cedit.Text);

      if value1 = '' then
        value1  := 'dummy';
    end
  //�н��� ��ȣ
  else if Sender.ClassType = TMaskEdit then
  begin
    medit   := Sender as TMaskEdit;

    callValue := 5;
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
procedure Tfrm_LOSTA720P.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := nil;         // TEdit       ����
	edt_birth_date.OnEnter    := nil;         // TDateEdit   �������
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
procedure Tfrm_LOSTA720P.AttachOnExitEvent;
begin
	edt_Id_Nm.OnExit      := self.OnExit; // TEdit       ����
	edt_birth_date.OnExit     := self.OnExit; // TDateEdit   �������
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
procedure Tfrm_LOSTA720P.AttachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := self.OnEnter; // TEdit      ����
	edt_birth_date.OnEnter    := self.OnEnter; // TDateEdit  �������
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
procedure Tfrm_LOSTA720P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTA720P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//�ֹ�/�����/�ܱ��ι�ȣ ��ȸ �˾����� �޼����� �����ش�.
procedure Tfrm_LOSTA720P.Link_rtn (var Msg : TMessage);
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
  i : integer;

begin
	//'LOSTZ810.exe'���� ���� �޼����� �޾Ҵ�.
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

      if (callValue = 0 ) then
        edt_Gt_Bo.SetFocus
      else
        btn_InquiryClick(self);

    end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

//�����ȣ��ȸ �˾����� �޼����� �����ش�.
procedure Tfrm_LOSTA720P.Link_rtn2 (var Msg : TMessage);
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
  i : integer;

begin
	//'LOSTZ810.exe'���� ���� �޼����� �޾Ҵ�.
	recvedMessage:= True;

    //�����޸� ������ �ʿ俩�δ� wparam�� ������ ��.
    if Msg.wParam = 1 then
    begin
      //�����޸𸮸� ��´�.
      smem:= OpenMap;

      if smem <> nil then
      begin
        Lock;  //���� ���ӹ���

          msk_Gt_Pt.Text        := smem^.po_no;			    //�����ȣ
          lbl_Gt_Ju.Caption     := smem^.ju_so;	        //�⺻�ּ�

        UnLock;

        //�����޸𸮸� ��� ��.
        CloseMapMain;
        smem:= nil;
      end;

      //if (callValue = 0 ) then
      //  edt_Gt_Bo.SetFocus;
      //else
      //  btn_InquiryClick(self);
      edt_Gt_Bo.SetFocus;

    end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

// ���޺� Ŭ���� �̺�Ʈ
procedure Tfrm_LOSTA720P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA720P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA720P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA720P.FormCreate(Sender: TObject);
begin
  //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
  if ParamCount < 6 then
  begin
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  //common_userid       := '0294'   ;  // ParamStr(3);
  //common_username     := '��ȣ��' ;  // ParamStr(4);
  //common_usergroup    := 'SYSM'   ;  // ParamStr(5);

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

  initComboBoxWithZ0xx ('Z041.dat', cmb_Cl_Gu_d, '', '',cmb_Cl_Gu );
  //initComboBoxWithZ0xx('Z041',cmb_Cl_Gu_d,'','' ,cmb_Cl_Gu  ,'1', '', '');
  initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

  //������Ʈ�� �̺�Ʈ�� ����ġ �Ѵ�.
  AttachOnEnterEvent;
  AttachOnExitEvent;
  AttachOnKeyPressEvent;

  btn1.OnClick := self.OnSearchClick;
  btn2.OnClick := self.OnSearchClick;
  btn3.OnClick := self.OnSearchClick;
  btn4.OnClick := self.OnSearchClick;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  // �ý��� �׷츸 '������� ����' ���� ����
  if (common_usergroup = 'SYSM') then
  begin
    Bevel34.Visible := True;
    Label9.Visible  := True;
    Panel4.Visible  := True;
  end;

  chk_Gt_yn.Checked := false;
  msk_Gt_No.Enabled := false;
  edt_Gt_Nm.Enabled := false;
  msk_Gt_Pt.Enabled := false;
  edt_Gt_Bo.Enabled := false;
  msk_Gt_Tl.Enabled := false;

  chk_rodadr_yn.Checked := true;

end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin

    if (Components[i] is TLabel) then
      if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
       then (Components[i] as TLabel).Caption := '';

    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
     else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';
  end;

  changeBtn(Self);
  btn_Link.Enabled    := True;

  dte_Ip_Dt.Date      := date;

  cmb_Cl_Gu.ItemIndex := 0;
  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

  if(chk_Gt_yn.Checked = false) then
  begin
    msk_Gt_No.Enabled := false;
    edt_Gt_Nm.Enabled := false;
    msk_Gt_Pt.Enabled := false;
    edt_Gt_Bo.Enabled := false;
    msk_Gt_Tl.Enabled := false;
  end;

  //�ʱ�ȭ
  setItemNo('1');

  //ó�� ����� ������ Ŭ���� ���� ����
  recvedMessage:= True;
end;

procedure Tfrm_LOSTA720P.btn_AddClick(Sender: TObject);

var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  str_tmp : String;

	STR004,STR005,STR006:String;
  STR007,STR008,STR009,STR010,STR011,STR012,STR013:String;
  svcNm , Msg: string;

  LABEL LIQUIDATION;
  LABEL SEEDKEY;

begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

	if not keyCheck then
    exit;

  STR004 := '';
  STR005 := '';

  if ((Sender as TSpeedButton) = btn_Add) then svcNm := 'I01'
  else if (Sender as TSpeedButton) = btn_Update then svcNm := 'U01'else svcNm := 'D01';

  if( not fChkLength(md_cb1     ,1,1,'���ڵ�'                 )) then Exit;
  if( not fChkLength(serial_edit,1,1,'�ܸ����Ϸù�ȣ'           )) then Exit;
  if( not fChkLength(dte_Ip_Dt  ,8,0,'�԰�����'                 )) then Exit;

  if (chk_Gt_yn.Checked) then begin
    if( not fChkLength(msk_Gt_No  ,1,1,'�������ֹλ���ڹ�ȣ'     )) then Exit;
    if( not fChkLength(edt_Gt_Nm  ,1,1,'�����ڼ���(��ü��)'       )) then Exit;
    if( not fChkLength(msk_Gt_Pt  ,1,1,'�����ڿ����ȣ'           )) then Exit;
    if( not fChkLength(lbl_Gt_Ju  ,1,1,'�����ڱ⺻�ּ�'           )) then Exit;
    if( not fChkLength(edt_Gt_Bo  ,1,1,'�����ڻ��ּ�'           )) then Exit;
    if( not fChkLength(msk_Gt_Tl  ,1,1,'��������ȭ��ȣ'           )) then Exit;
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

  (*���ڵ�       *) STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);
  (*�ܸ����Ϸù�ȣ *) STR002 := serial_edit.Text;
  (*�԰�����       *) STR003 := delHyphen(dte_Ip_Dt.Text);
  (*������ڵ�   *)
  if(cmb_Cl_Gu.ItemIndex <> -1) then STR004 := IntToStr(cmb_Cl_Gu.itemIndex + 1);
  (*���ڽ�����   *)
  if(rdo_Bx_yes.Checked)  then STR005 := 'Y' else STR005 := 'N';
  (*���������   *)
  if(rdo_out_yes.Checked) then STR006 := 'Y' else STR006 := 'N';
  (*����������ܸ���������ڵ�   *)
  // 1 : ���������, 2 : �н������
  if(chk_Gt_yn.Checked) then STR007 := '1' else STR007 := '2';

  (*�������ֹλ���ڹ�ȣ *) str_tmp:= delhyphen(msk_Gt_No.Text);
                            STR008 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*�����ڼ���(��ü��)   *) str_tmp:= Trim(edt_Gt_Nm.Text);
                            STR009 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*�����ڿ����ȣ       *) STR010 := delhyphen(msk_Gt_Pt.Text);
  (*�����ڱ⺻�ּ�       *) STR011 := Trim(lbl_Gt_Ju.Caption);
  (*�����ڻ��ּ�       *) STR012 := Trim(edt_Gt_Bo.Text);
  (*��������ȭ��ȣ       *) str_tmp:= Trim(delHyphen(msk_Gt_Tl.Text));
                            STR013 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA720P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', STR010) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR011', STR011) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR012', STR012) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR013', STR013) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA720P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
    begin
      if (Pos('����',TMAX.RecvString('INF012',0)) > 0 ) then ShowMessage( TMAX.RecvString('INF012',0))
      else
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    end
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  if ((Sender as TSpeedButton) = btn_Add) then Msg := '���'
  else if (Sender as TSpeedButton) = btn_Update then Msg := '����'
  else Msg := '����';

  ShowMessage('���� ' + Msg + '�Ǿ����ϴ�.');

  sts_Message.Panels[1].Text := Msg + '�Ϸ�';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTA720P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA720P.btn_DeleteClick(Sender: TObject);
	Label LIQUIDATION;
begin

	if not keyCheck then
    exit;

	if MessageDlg('���� �����Ͻðڽ��ϱ� ?',
		mtConfirmation, mbOkCancel, 0) = mrCancel then begin
		sts_Message.Panels[1].text := '������ ��ҵǾ����ϴ�.';
		exit;
	end;

  btn_AddClick(Sender);
end;


procedure Tfrm_LOSTA720P.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_gtno, seed_gtnm, seed_gttl : String;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;

begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_gtno := '';
  seed_gtnm := '';
  seed_gttl := '';

	if not keyCheck then
    	exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	// ���ڵ� md_cb1
	STR002:= serial_edit.Text;			                                        // �ܸ����Ϸù�ȣ
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                    // �԰�����

  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

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

//������ȸ
INQUIRY:

  TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA720P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA720P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

(*  �𵨸�               *) //md_cb1.Text         :=              Trim(TMAX.RecvString('STR124',0));
(*  �ܸ����Ϸù�ȣ       *) //serial_edit.text    :=              Trim(TMAX.RecvString('STR102',0));
(*  �԰�����             *) //dte_Ip_Dt.text      :=              Trim(TMAX.RecvString('STR103',0));
(*  �����ڼ����ü��     *) //edt_Id_Nm.text      :=              Trim(TMAX.RecvString('STR104',0));
(*  ������ڵ�         *) if(TMAX.RecvString('STR105',0) <> '') then cmb_Cl_Gu.ItemIndex := StrToInt(Trim(TMAX.RecvString('STR105',0))) -1;
(*  ���ڽ�����         *) if Trim(TMAX.RecvString('STR106',0)) = 'Y' then rdo_Bx_yes.Checked:= True else rdo_Bx_No.Checked := True;
(*  �߼ۿ�������         *) lbl_Bl_Dt.caption   :=  InsHyphen(  Trim(TMAX.RecvString('STR107',0)));
(*  �ܸ�������ڵ�       *) //                                  Trim(TMAX.RecvString('STR108',0));
(*  �ܸ�������ڵ��     *) lbl_Ph_Cd.caption   :=              Trim(TMAX.RecvString('STR109',0));
(*  �����ID             *) lbl_Cl_Id.caption   :=              Trim(TMAX.RecvString('STR110',0));
(*  ����ڸ�             *) //                                  Trim(TMAX.RecvString('STR111',0));
(*  �����ڱ����ڵ�       *) //                                  Trim(TMAX.RecvString('STR112',0));
(*  �����ڱ����ڵ��     *) lbl_Lt_Gu.caption   :=              Trim(TMAX.RecvString('STR113',0));
(*  �������ֹλ���ڹ�ȣ *) seed_gano := TMAX.RecvString('STR114',0);
                            lbl_Lt_No.caption   :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey)));
(*  �����ڼ����ü��     *) seed_ganm := TMAX.RecvString('STR115',0);
                            lbl_Lt_Nm.caption   :=              Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
(*  �����ڿ����ȣ       *) lbl_Pt_No.caption   :=  InsHyphen(  Trim(TMAX.RecvString('STR116',0)));
(*  �����ڱ⺻�ּ�       *) lbl_Ju_So.caption   :=              Trim(TMAX.RecvString('STR117',0));
(*  �����ڻ��ּ�       *) lbl_Bo_So.caption   :=              Trim(TMAX.RecvString('STR118',0));
(*  ��������ȭ��ȣ       *) seed_gatl := TMAX.RecvString('STR119',0);
                            lbl_Tl_No.caption   :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey)));
(*  â���Ϸù�ȣ         *) lbl_Cg_No.caption   :=              Trim(TMAX.RecvString('STR120',0));
(*  �ܸ���κ�ǰ�����ڵ� *) //                                  Trim(TMAX.RecvString('STR121',0));
(*  �ܸ���κ�ǰ������   *) lbl_Ph_Gb.caption   :=              Trim(TMAX.RecvString('STR122',0));
(*  ���뿩��             *) //                                  Trim(TMAX.RecvString('STR123',0));
                            lbl_insu_sts.Caption:=              Trim(TMAX.RecvString('STR124',0));

(*  ������ڵ�         *) if Trim(TMAX.RecvString('STR125',0)) = '1' then chk_Gt_yn.Checked   :=  True else chk_Gt_yn.Checked := false;
(*  �������ֹλ���ڹ�ȣ *) seed_gtno := TMAX.RecvString('STR127',0);
                            msk_Gt_No.Text      :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gtno, common_seedkey)));
(*  �����ڼ����ü��     *) seed_gtnm := TMAX.RecvString('STR128',0);
                            edt_Gt_Nm.Text      :=              Trim(ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey));
(*  �����ڿ����ȣ       *) msk_Gt_Pt.Text      :=  InsHyphen(  Trim(TMAX.RecvString('STR129',0)));
(*  �����ڱ⺻�ּ�       *) lbl_Gt_Ju.caption   :=              Trim(TMAX.RecvString('STR130',0));
(*  �����ڻ��ּ�       *) edt_Gt_Bo.Text      :=              Trim(TMAX.RecvString('STR131',0));
(*  ��������ȭ��ȣ       *) seed_gttl := TMAX.RecvString('STR132',0);
                            msk_Gt_Tl.Text      :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gttl, common_seedkey)));

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

  //�ʸ��� ��ư Ȱ��ȭ
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA720P.btn_CloseClick(Sender: TObject);
begin
    //ȣ���� APP�� ���� ������ �޼���....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ830Q.exe' +''''+'�� ���� ���� �Ͻʽÿ�.');
      exit;
  end;

  close;
end;

//On-Exit (�԰�����)
procedure Tfrm_LOSTA720P.dte_Ip_DtExit(Sender: TObject);
begin
{
     try
     dte_Ip_Dt.Date := strtodate(dte_Ip_Dt.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����'+#13+
		       '�������ڷ� ����˴ϴ�');
	   dte_Ip_Dt.date := date;
	   dte_Ip_Dt.setfocus;
	end;
     end;
}
end;

//common_lib.pas�� �ִ� �Լ��� �ٸ���.
function Tfrm_LOSTA720P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;
  ret := 0;

	recvedMessage:= false;

  if (value1 = 'dummy') then value1 := '';
  if (value2 = 'dummy') then value2 := '';

  (****************************************************************************)
  (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
    			      (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '23'
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

function Tfrm_LOSTA720P.ExecExternProg2(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  if (value1 = 'dummy') then value1 := '';
  if (value2 = 'dummy') then value2 := '';

  (****************************************************************************)
  (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
    			      (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '12'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  '1'
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  value1
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  value2
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);

		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');

    ShowWindow(Self.Handle, SW_SHOW     );
    ShowWindow(Self.Handle, SW_RESTORE  );
  end;

end;

procedure Tfrm_LOSTA720P.FormShow(Sender: TObject);
begin
    //������Ʈ �ʱ�ȭ
    InitComponents;

    // �ܺ� ȣ���� ��쿡�� ���� ex) LOSTA200Q ���� �� ���α׷� ȣ�� ����
    //if ParamStr(6) <> '' then   // 2016.06.21 ����
    if ParamStr(10) <> '' then
    begin
      edt_Id_Nm.Text        :=  fRNVL(ParamStr( 6));
      edt_birth_date.Text   :=  fRNVL(InsHyphen(ParamStr( 7)));
      md_cb1.Text           :=  fRNVL(ParamStr( 8));
      serial_edit.Text      :=  fRNVL(ParamStr( 9));
      dte_Ip_Dt.Text        :=  fRNVL(ParamStr(10));
      edt_phone_no.Text     :=  fRNVL(ParamStr(11));

      btn_InquiryClick(Self);
    end;
end;

procedure Tfrm_LOSTA720P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA720P.setEdtKeyPress;
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

procedure Tfrm_LOSTA720P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA720P.btn_LinkClick(Sender: TObject);
var
  Value : array of string;

  commandStr:String;

  progID : string;

	ret:Integer;  
begin
    progID := 'LOSTA710P';
    ret := 0;

    SetLength(Value, 5 );

    Value[0] := Trim(edt_Id_Nm.Text);       // ����
    Value[1] := Trim(edt_birth_date.Text);  // �������
    Value[2] := Trim(md_cb1.Text);          // �𵨸�
    Value[3] := Trim(serial_edit.Text);     // �ø����ȣ
    Value[4] := dte_Ip_Dt.Text;             // �԰�����

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

procedure Tfrm_LOSTA720P.cmb_Cl_GuChange(Sender: TObject);
begin
  case cmb_Cl_Gu.ItemIndex of
    0 : rdo_Bx_yes.Checked := True;
    1 : rdo_Bx_No.Checked  := True;
    2 : rdo_Bx_No.Checked  := True;
  end;
end;

procedure Tfrm_LOSTA720P.chk_Gt_ynClick(Sender: TObject);
begin

  if(chk_Gt_yn.Checked) then
  begin
    msk_Gt_No.Enabled := true;
    edt_Gt_Nm.Enabled := true;
    msk_Gt_Pt.Enabled := true;
    edt_Gt_Bo.Enabled := true;
    msk_Gt_Tl.Enabled := true;
  end else
  begin
    msk_Gt_No.Text := '';
    msk_Gt_No.Enabled := false;
    edt_Gt_Nm.Text := '';
    edt_Gt_Nm.Enabled := false;
    msk_Gt_Pt.Text := '';
    msk_Gt_Pt.Enabled := false;
    lbl_Gt_Ju.caption := '';
    edt_Gt_Bo.Text := '';
    edt_Gt_Bo.Enabled := false;
    msk_Gt_Tl.Text := '';
    msk_Gt_Tl.Enabled := false;
  end;
end;

procedure Tfrm_LOSTA720P.btn_Postno_InqClick(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
  chkBox : TCheckBox;
begin
  bitBtn := nil;
  mskEdt := nil;
  chkBox := nil;

  if (chk_Gt_yn.Checked = true) then
  begin
    if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit) or ( Sender.ClassType = TCheckBox)) then
    begin
      if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
        else if (Sender.ClassType = TMaskEdit) then mskEdt := Sender as TMaskEdit
          else chkBox := Sender as TCheckBox;
            value1 := msk_Gt_Pt.Text;
      end;

    CreateMap;	//�����޸� ����

    // ���θ��ּ� üũ�� ���� �����ȣ �˾� ����
    if(bitBtn = btn_Postno_Inq) or ( mskEdt = msk_Gt_Pt ) or ( chkBox = chk_rodadr_yn ) then
      begin
        if (chk_rodadr_yn.Checked = true) then self.ExecExternProg2('LOSTZ850Q')
        else self.ExecExternProg2('LOSTZ800Q');
      end;
  end;
end;

procedure Tfrm_LOSTA720P.chk_rodadr_ynClick(Sender: TObject);
begin
   if ((chk_Gt_yn.Checked = true) and (chk_rodadr_yn.Checked = true)) then
   begin
      btn_Postno_InqClick(Sender);
   end;
end;

end.
