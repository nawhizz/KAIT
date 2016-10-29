{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA140P (�н��� �ݼ۳��� �Է�)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 09. 01
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
unit u_LOSTA140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, so_tmax, WinSkinData,common_lib,localCloud,u_LOSTA140P_ADDR,
  ShellAPI, ComObj;

const
  TITLE   = '�н��� �ݼ۳��� �Է�';
  PGM_ID  = 'LOSTA140P';

type
  Tfrm_LOSTA140P = class(TForm)
    Bevel2          : TBevel;
    Bevel6          : TBevel;
    Bevel17         : TBevel;
    Bevel43         : TBevel;
    Bevel44         : TBevel;
    Bevel4          : TBevel;
    Bevel3          : TBevel;
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
    Bevel11         : TBevel;
    Bevel12         : TBevel;
    Bevel13         : TBevel;
    Bevel5          : TBevel;
    Bevel19         : TBevel;
    Bevel25         : TBevel;
    Bevel32         : TBevel;
    Bevel34         : TBevel;
    Bevel35         : TBevel;
    Bevel36         : TBevel;
    Bevel38         : TBevel;
    Bevel39         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel31         : TBevel;
    Bevel33         : TBevel;
    Bevel37         : TBevel;
    Bevel42         : TBevel;
    cmb_Bn_Sy       : TComboBox;
    cmb_Md_Cd       : TComboBox;
    dte_Bn_Dt       : TDateEdit;
    GroupBox1       : TGroupBox;
    GroupBox3       : TGroupBox;
    lbl_Gid_Gu      : TLabel;
    Label17         : TLabel;
    Label7          : TLabel;
    Label19         : TLabel;
    lbl_Nid_Gu      : TLabel;
    lbl_Gid_No      : TLabel;
    lbl_Nid_No      : TLabel;
    Label13         : TLabel;
    lbl_Nid_Nm      : TLabel;
    lbl_Gid_Nm      : TLabel;
    lbl_Npt_No      : TLabel;
    Label11         : TLabel;
    lbl_Nju_So      : TLabel;
    Label33         : TLabel;
    lbl_Nbo_So      : TLabel;
    lbl_Ntl_no      : TLabel;
    lbl_Gpt_No      : TLabel;
    Label5          : TLabel;
    lbl_Ju_Dt       : TLabel;
    lbl_Ph_Gb       : TLabel;
    Label6          : TLabel;
    lbl_Gju_So      : TLabel;
    Label8          : TLabel;
    lbl_Cg_No       : TLabel;
    lbl_Gbo_So      : TLabel;
    lbl_Gtl_No      : TLabel;
    Label20         : TLabel;
    Label9          : TLabel;
    Label21         : TLabel;
    lbl_Program_Name: TLabel;
    Label2          : TLabel;
    Label22         : TLabel;
    lbl_Cl_Dt       : TLabel;
    Label23         : TLabel;
    Label12         : TLabel;
    Label3          : TLabel;
    Label4          : TLabel;
    Label24         : TLabel;
    Label14         : TLabel;
    N13             : TMenuItem;
    pnl_Command     : TPanel;
    Panel1          : TPanel;
    mnuLnk          : TPopupMenu;
    SkinData1       : TSkinData;
    btn_Addr_Update : TSpeedButton;
    sts_Message     : TStatusBar;
    md_grid1        : TStringGrid;
    TMAX            : TTMAX;
    edt_md_cd: TEdit;
    Panel2: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label1: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel45: TBevel;
    Label25: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    edt_phone_no: TMaskEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    edt_birth_date: TEdit;
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
    procedure btn_AddClick      (Sender: TObject);
    procedure btn_UpdateClick   (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure dte_Ip_DtExit     (Sender: TObject);
    procedure dte_Bn_DtExit     (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_grid1Click     (Sender: TObject);
    procedure md_cb1KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Addr_UpdateClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    
  private
    { Private declarations }
    cmb_Bn_Sy_d,md_grid1_d :TZ0xxArray;

    //LOSTZ810Q.exe�� �޼��� ���� �� ���
    recvedMessage:Boolean;

    //LOSTZ810Q.exe ȣ��� ���
    itemNo        :String;
    value1, value2:String;

    //�˻��� ���
    STR001:String; // ���ڵ�
    STR002:String; // �ܸ����Ϸù�ȣ
    STR003:String; // �԰�����

  public
    { Public declarations }

    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
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

    function keyCheck:boolean;

    // �ӽ� �ֹι�ȣ ����
    function frtnRealIdNo(gbn : Integer) : String;
  end;

var
  frm_LOSTA140P: Tfrm_LOSTA140P;
  strGidNo , strNidNo : String;

implementation
{$R *.DFM}

function Tfrm_LOSTA140P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('�𵨸�, �ø����ȣ �� �԰����ڸ� �Է��ϼ���');
        result := false;
      end;
end;

procedure Tfrm_LOSTA140P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA140P.OnKeyPress(Sender: TObject; var Key: Char);
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
procedure Tfrm_LOSTA140P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTA140P.OnExit(Sender:TObject);
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
  else if Sender.ClassType = TMaskEdit then
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
procedure Tfrm_LOSTA140P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTA140P.AttachOnExitEvent;
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
procedure Tfrm_LOSTA140P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTA140P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTA140P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'���� �޼����� �����ش�.
procedure Tfrm_LOSTA140P.Link_rtn (var Msg : TMessage);
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
        edt_phone_no.EditText := Trim(smem^.phone_no2);  //�н��ڵ�����ȣ

        if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

        UnLock;

        //�����޸𸮸� ��� ��.
        CloseMapMain;
        smem:= nil;
      end;

      //'��ȸ' ��ư Ŭ��
      btn_InquiryClick(self);
    end;
    
    ShowWindow(Self.Handle, SW_SHOW);
    ShowWindow(Self.Handle, SW_RESTORE);
end;

// ���޺� Ŭ���� �̺�Ʈ
procedure Tfrm_LOSTA140P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA140P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA140P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA140P.FormCreate(Sender: TObject);
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
//	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
	  if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '��ȣ��';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

    {----------------------- ���� ���ø����̼� ���� ---------------------------}

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
    initComboBoxWithZ0xx ('Z034.dat', cmb_Bn_Sy_d, '', '',cmb_Bn_Sy );
    initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

    //������Ʈ�� �̺�Ʈ�� ����ġ �Ѵ�.
    AttachOnEnterEvent;
    AttachOnExitEvent;
    AttachOnKeyPressEvent;
    btn1.OnClick := self.OnSearchClick;
    btn2.OnClick := self.OnSearchClick;
    btn3.OnClick := self.OnSearchClick;
    btn4.OnClick := self.OnSearchClick;

    //������Ʈ �ʱ�ȭ
    InitComponents;

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA140P.InitComponents;
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

    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
    else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';


  end;

  //�ʱ�ȭ
  setItemNo('1');

  changeBtn(self);
  btn_Link.Enabled := True;

  recvedMessage := true;

  dte_Ip_Dt.Date  := date;
  dte_Bn_Dt.Date  := date;

  cmb_Bn_Sy.ItemIndex := -1;
  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];
        
end;

//'���' ��ư Ŭ��
procedure Tfrm_LOSTA140P.btn_AddClick(Sender: TObject);
var
	STR004,STR005:String;
    LABEL LIQUIDATION;
begin
{
_I01

�Է�:
STR001,"���ڵ�"
STR002,"�ܸ����Ϸù�ȣ"
STR003,"�԰�����"
STR004,"�ݼ�����"
STR005,"�ݼۻ����ڵ�"

���:
RETURN = TURE �ϰ�� �޼���
}
	if not keyCheck then
    	exit;

  if (Trim(delHyphen(dte_Bn_Dt.Text))='') or (Trim(cmb_Bn_Sy.Text) ='') then begin
    ShowMessage('�ݼ����� �� ������ �Է��ϼ���');
      exit;
  end;

  // �Ǽ� �� ����ȸ�� ���� ������ ���� ����
  STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	      //���ڵ� md_cb1
  STR002:= serial_edit.Text;			                                              //�ܸ����Ϸù�ȣ    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                          //�԰�����  dte_Ip_Dt
  STR004:= delHyphen(dte_Bn_Dt.Text);	                                          //�ݼ�����
  STR005:= findCodeFromName(cmb_Bn_Sy.Text,cmb_Bn_Sy_d, cmb_Bn_Sy.Items.Count);	//�ݼۻ���

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01')   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA140P') then
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

//'����' ��ư Ŭ��
procedure Tfrm_LOSTA140P.btn_UpdateClick(Sender: TObject);
var
	STR004,STR005:String;
  LABEL LIQUIDATION;
begin
{
_U01

�Է�:
STR001,"���ڵ�" 
STR002,"�ܸ����Ϸù�ȣ" 
STR003,"�԰�����" 
STR004,"�ݼ�����"
STR005,"�ݼۻ����ڵ�"

���:
RETURN = TURE �ϰ�� �޼���
}
	if not keyCheck then
    	exit;

  if (Trim(delHyphen(dte_Bn_Dt.Text))='') or (Trim(cmb_Bn_Sy.Text) ='') then begin
    ShowMessage('�ݼ����� �� ������ �Է��ϼ���');
      exit;
  end;

  STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//���ڵ� md_cb1
  STR002:= serial_edit.Text;			//�ܸ����Ϸù�ȣ    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	//�԰�����  dte_Ip_Dt
  STR004:= delHyphen(dte_Bn_Dt.Text);	//�ݼ�����
  STR005:= findCodeFromName(cmb_Bn_Sy.Text,cmb_Bn_Sy_d, cmb_Bn_Sy.Items.Count);	//�ݼۻ���

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U01')   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' ���� �Ϸ�';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTA140P.btn_DeleteClick(Sender: TObject);
	Label LIQUIDATION;
begin
{
_D01

�Է�:

STR001,"���ڵ�"
STR002,"�ܸ����Ϸù�ȣ"
STR003,"�԰�����"

���:
RETURN = TURE �ϰ�� �޼���
}
	if not keyCheck then
    exit;

	if MessageDlg('���� �����Ͻðڽ��ϱ� ?',
		mtConfirmation, mbOkCancel, 0) = mrCancel then begin
		sts_Message.Panels[1].text := '������ ��ҵǾ����ϴ�.';
		exit;
	end;

	STR001  := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//���ڵ� md_cb1
	STR002  := serial_edit.Text;			                                        //�ܸ����Ϸù�ȣ    serial_edit
  STR003  := delHyphen(dte_Ip_Dt.Text);	                                    //�԰�����  dte_Ip_Dt

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

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01')             < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001)           < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002)           < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003)           < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA140P') then begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
  end;

   	sts_Message.Panels[1].Text := ' ���� �Ϸ�';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

//'��ȸ' ��ư Ŭ��
procedure Tfrm_LOSTA140P.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_nano, seed_nanm, seed_natl, seed_mtno : String;

    Label LIQUIDATION;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_nano := '';
  seed_nanm := '';
  seed_natl := '';
  seed_mtno := '';

	if not keyCheck then
    	exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//���ڵ� md_cb1
	STR002:= serial_edit.Text;			//�ܸ����Ϸù�ȣ    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	//�԰�����  dte_Ip_Dt

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
    end;

  (* ���ڵ�               *) edt_md_cd.Text     :=              TMAX.RecvString('STR101',0);
  (* �𵨸�                 *) md_cb1.Text        :=              TMAX.RecvString('STR102',0);
  (* �ܸ����Ϸù�ȣ         *) serial_edit.Text   :=              TMAX.RecvString('STR103',0);
  (* �԰�����               *) dte_Ip_Dt.Text     := InsHyphen(   TMAX.RecvString('STR104',0));
  (* ���뿩��               *) //                 :=              TMAX.RecvString('STR105',0);
  (* ó�������ڵ�           *) //                 :=              TMAX.RecvString('STR106',0);
  (* �ܸ��������ڵ�         *) //                 :=              TMAX.RecvString('STR107',0);
  (* �ܸ���������           *) lbl_Ph_Gb.Caption  :=              TMAX.RecvString('STR108',0);
  (* �ܸ�������             *) //                 :=              TMAX.RecvString('STR109',0);
  (* �������               *) lbl_Cl_Dt.Caption  :=              TMAX.RecvString('STR110',0);
  (* ��ü�������������     *) lbl_Ju_Dt.Caption  := InsHyphen(   TMAX.RecvString('STR111',0));
  (* �ܸ�������ڵ�         *) //                 :=              TMAX.RecvString('STR112',0);
  (* �ܸ�����¸�           *) //                 :=              TMAX.RecvString('STR113',0);
  (* â���ȣ               *) lbl_Cg_No.Caption  :=              TMAX.RecvString('STR114',0);
  (* �ݼ�����               *) dte_Bn_Dt.Text     := InsHyphen(   TMAX.RecvString('STR115',0));
  (* �ݼۻ����ڵ�           *)
  if  dte_Bn_Dt.Text = '    -  -  '  then
  begin
    dte_Bn_Dt.Date := date;
    cmb_Bn_Sy.ItemIndex :=-1
  end
  else
    cmb_Bn_Sy.Text := TMAX.RecvString('STR116',0);
  (* �ݼۻ���               *) //                 :=              TMAX.RecvString('STR117',0);
  (* �������ֹλ���ڱ���   *) //                 :=              TMAX.RecvString('STR118',0);
  (* �������ֹλ���ڱ��и� *) lbl_Gid_Gu.Caption :=              TMAX.RecvString('STR119',0);
  (* �������ֹλ���ڹ�ȣ   *) seed_gano          := TMAX.RecvString('STR120',0);
                               lbl_Gid_No.Caption := InsHyphen(   ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* �����ڼ���(��ü��)     *) seed_ganm          := TMAX.RecvString('STR121',0);
                               lbl_Gid_Nm.Caption :=              ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
  (* �����ڿ����ȣ         *) lbl_Gpt_No.Caption := InsHyphen(   TMAX.RecvString('STR122',0));
  (* �����ڱ⺻�ּ�         *) lbl_Gju_So.Caption :=              TMAX.RecvString('STR123',0);
  (* �����ڻ��ּ�         *) lbl_Gbo_So.Caption :=              TMAX.RecvString('STR124',0);
  (* ��������ȭ��ȣ         *) seed_gatl          := TMAX.RecvString('STR125',0);
                               lbl_Gtl_No.Caption := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
  (* �н��ڵ�����ȣ         *) seed_mtno          := TMAX.RecvString('STR126',0);
                               edt_phone_no.Text  :=              ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
  (* �������ֹλ���ڱ���   *) //                 :=              TMAX.RecvString('STR127',0);
  (* �������ֹλ���ڱ��и� *) lbl_Nid_Gu.Caption :=              TMAX.RecvString('STR128',0);
  (* �������ֹλ���ڹ�ȣ   *) seed_nano          := TMAX.RecvString('STR129',0);
                               lbl_Nid_No.Caption := InsHyphen(   ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
  (* �����ڼ���(��ü��)     *) seed_nanm          := TMAX.RecvString('STR130',0);
                               lbl_Nid_Nm.Caption :=              ECPlazaSeed.Decrypt(seed_nanm, common_seedkey);
  (* �����ڿ����ȣ         *) lbl_Npt_No.Caption := InsHyphen(   TMAX.RecvString('STR131',0));
  (* �����ڱ⺻�ּ�         *) lbl_Nju_So.Caption :=              TMAX.RecvString('STR132',0);
  (* �����ڻ��ּ�         *) lbl_Nbo_So.Caption :=              TMAX.RecvString('STR133',0);
  (* ��������ȭ��ȣ         *) seed_natl          := TMAX.RecvString('STR134',0);
                               lbl_Ntl_no.Caption := ECPlazaSeed.Decrypt(seed_natl, common_seedkey);
  (* �ּ��������������ڵ�   *)
  if TMAX.RecvString('STR135',0) <> '' then
    frm_LOSTA140P_ADDR.cmb_up_gu.ItemIndex := StrToInt(TMAX.RecvString('STR135',0));


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

procedure Tfrm_LOSTA140P.btn_CloseClick(Sender: TObject);
begin
    //ȣ���� APP�� ���� ������ �޼���....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'�� ���� ���� �Ͻʽÿ�.');
      exit;
  end;

  close;
end;

//On-Exit (�԰�����)
procedure Tfrm_LOSTA140P.dte_Ip_DtExit(Sender: TObject);
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

//On-Eixt (�ݼ���)
procedure Tfrm_LOSTA140P.dte_Bn_DtExit(Sender: TObject);
begin
{
     try
     dte_Bn_Dt.Date := strtodate(dte_Bn_Dt.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('���� �Է� ����'+#13+
		       '�������ڷ� ����˴ϴ�');
	   dte_Bn_Dt.date := date;
	   dte_Bn_Dt.setfocus;
	end;
     end;
}
end;

//common_lib.pas�� �ִ� �Լ��� �ٸ���.
function Tfrm_LOSTA140P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '02'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  itemNo
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(self.Handle, SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');

   end
end;

function Tfrm_LOSTA140P.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTA140P.btn_Addr_UpdateClick(Sender: TObject);
begin
  frm_LOSTA140P_ADDR.Show;

  ShowWindow(Self.Handle,SW_HIDE);
end;

procedure Tfrm_LOSTA140P.btn_LinkClick(Sender: TObject);
const
  URL = 'http://post.handphone.or.kr/post/npost/jem.php';
begin
  shellexecute(0, 'open', 'iexplore.exe',pchar(URL), nil, SW_MAXIMIZE);
end;

procedure Tfrm_LOSTA140P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

end.
