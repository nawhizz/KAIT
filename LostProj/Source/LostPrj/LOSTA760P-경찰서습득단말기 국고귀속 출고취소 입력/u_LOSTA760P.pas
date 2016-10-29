{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA760P (����������ܸ��� ����ͼ� ������ �Է�)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013. 10. 28
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
unit u_LOSTA760P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '����������ܸ��� ����ͼ� ������ �Է�';
  PGM_ID  = 'LOSTA760P';

type
  Tfrm_LOSTA760P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    GroupBox3: TGroupBox;
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
    Bevel27: TBevel;
    Bevel28: TBevel;
    Bevel29: TBevel;
    lbl_Pt_No: TLabel;
    Bevel30: TBevel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel8: TBevel;
    lbl_Bo_So: TLabel;
    Bevel9: TBevel;
    lbl_Tl_No: TLabel;
    Bevel10: TBevel;
    Bevel26: TBevel;
    lbl_Bl_Dt: TLabel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    lbl_Ph_Cd: TLabel;
    Bevel11: TBevel;
    Label11: TLabel;
    Bevel12: TBevel;
    lbl_Lt_Gu: TLabel;
    lbl_Lt_Nm: TLabel;
    lbl_Ju_So: TLabel;
    lbl_Lt_No: TLabel;
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
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    md_grid1: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel2: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label1: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel3: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel45: TBevel;
    Label25: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    edt_birth_date: TEdit;
    edt_phone_no: TMaskEdit;
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
  private
    { Private declarations }
    cmb_Cl_Gu_d,md_grid1_d :TZ0xxArray;

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
  end;

  (* PGM_STS : ���α׷� ����  *)
  (* 0 : ��ȸ��               *)
  (* 1 : ��ȸ��               *)
  (* 2,3 : ������             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTA760P: Tfrm_LOSTA760P;

  pgm_sts1   : PGM_STS;

implementation
uses cpaklibm, Clipbrd;
{$R *.DFM}

function Tfrm_LOSTA760P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('�𵨸�, �ø����ȣ �� �԰����ڸ� �Է��ϼ���');
        result := false;
      end;
end;

procedure Tfrm_LOSTA760P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA760P.OnKeyPress(Sender: TObject; var Key: Char);
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
procedure Tfrm_LOSTA760P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTA760P.OnExit(Sender:TObject);
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
procedure Tfrm_LOSTA760P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTA760P.AttachOnExitEvent;
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
procedure Tfrm_LOSTA760P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTA760P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTA760P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'���� �޼����� �����ش�.
procedure Tfrm_LOSTA760P.Link_rtn (var Msg : TMessage);
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
procedure Tfrm_LOSTA760P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA760P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA760P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;


procedure Tfrm_LOSTA760P.FormCreate(Sender: TObject);
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then begin
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
  //common_userid     := '0294';    //ParamStr(2);
  //common_username   := '��ȣ��';  //ParamStr(3);
  //common_usergroup  := 'KAIT';    //ParamStr(4);

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
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA760P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin

  edt_Id_Nm.Text      := '';
  edt_birth_date.Text := '';
  edt_phone_no.Text   := '';
  md_cb1.Text         := '';
  serial_edit.Text    := '';
  dte_Ip_Dt.Text      := '';

  changeBtn(Self);
  
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos('lbl_',(component as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(component as TLabel).Name) = 0)
        then (component as TLabel).Caption := '';
  end;

  //�ʱ�ȭ
  setItemNo('1');

  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;


  //ó�� ����� ������ Ŭ���� ���� ����
  recvedMessage:= True;

  dte_Ip_Dt.Date  := date;

  md_grid1.Row    := 0;
  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

  pgm_sts1 := [0];    
end;

procedure Tfrm_LOSTA760P.btn_AddClick(Sender: TObject);

var
	STR004,STR005:String;
  svcNm , Msg: string;

  LABEL LIQUIDATION;


begin

	if not keyCheck then
    	exit;

  STR004 := '';
  STR005 := '';

  if ((Sender as TSpeedButton) = btn_Add) then svcNm := 'I01'
  else if (Sender as TSpeedButton) = btn_Update then svcNm := 'U01'else svcNm := 'D01';



  // �Ǽ� �� ����ȸ�� ���� ������ ���� ����
  STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	      //���ڵ� md_cb1
  STR002 := serial_edit.Text;			                                              //�ܸ����Ϸù�ȣ    serial_edit
  STR003 := delHyphen(dte_Ip_Dt.Text);	                                          //�԰�����  dte_Ip_Dt

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
	if (TMAX.SendString('INF003','LOSTA760P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA760P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  if ((Sender as TSpeedButton) = btn_Add) then Msg := '���'
  else if (Sender as TSpeedButton) = btn_Update then Msg := '����'
  else Msg := '����';

  ShowMessage('���� ' + Msg + '�Ǿ����ϴ�.');

  sts_Message.Panels[1].Text := Msg + '�Ϸ�';

  pgm_sts1 := [0];

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTA760P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA760P.btn_DeleteClick(Sender: TObject);
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


procedure Tfrm_LOSTA760P.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_mtno : String;

    Label LIQUIDATION;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_mtno := '';

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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA760P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA760P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  (* ���ڵ�                *)   //                :=           Trim(TMAX.RecvString('STR101',0));
  (* �𵨸�                  *)   md_cb1.Text       :=           Trim(TMAX.RecvString('STR102',0));
  (* �ܸ����Ϸù�ȣ          *)   serial_edit.Text  :=           Trim(TMAX.RecvString('STR103',0));
  (* �԰�����                *)   dte_Ip_Dt.Text    := InsHyphen(Trim(TMAX.RecvString('STR104',0)));
  (* �ܸ��������ڵ�          *)   //                :=           Trim(TMAX.RecvString('STR105',0));
  (* �ܸ�������              *)   lbl_Ph_Gb.Caption :=           Trim(TMAX.RecvString('STR106',0));
  (* �߼ۿ�����              *)   lbl_Bl_Dt.Caption := InsHyphen(Trim(TMAX.RecvString('STR107',0)));
  (* �ܸ�������ڵ�          *)   //                :=           Trim(TMAX.RecvString('STR108',0));
  (* �ܸ������              *)   lbl_Ph_Cd.Caption :=           Trim(TMAX.RecvString('STR109',0));
  (* â���Ϸù�ȣ            *)   lbl_Cg_No.Caption :=           Trim(TMAX.RecvString('STR110',0));
  (* �������ֹλ���ڱ����ڵ�*)   //                :=           Trim(TMAX.RecvString('STR111',0));
  (* �������ֹλ���ڱ���    *)   lbl_Lt_Gu.Caption :=           Trim(TMAX.RecvString('STR112',0));
  (* �������ֹλ���ڹ�ȣ    *)   seed_gano := TMAX.RecvString('STR113',0);
                                  lbl_Lt_No.Caption :=           Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* �����ڼ���(��ü��)      *)   seed_ganm := TMAX.RecvString('STR114',0);
                                  lbl_Lt_Nm.Caption :=           Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
  (* �����ڿ����ȣ          *)   lbl_Pt_No.Caption := InsHyphen(Trim(TMAX.RecvString('STR115',0)));
  (* �����ڱ⺻�ּ�          *)   lbl_Ju_So.Caption :=           Trim(TMAX.RecvString('STR116',0));
  (* �����ڻ��ּ�          *)   lbl_Bo_So.Caption :=           Trim(TMAX.RecvString('STR117',0));
  (* ��������ȭ��ȣ          *)   seed_gatl := TMAX.RecvString('STR118',0);
                                  lbl_Tl_No.Caption := InsHyphen(Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey)));
  (* ����Է���ID            *)   lbl_Cl_Id.Caption :=           Trim(TMAX.RecvString('STR119',0));
  (* ����Է���              *)   //                             Trim(TMAX.RecvString('STR120',0));

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

  //�ʸ��� ��ư Ȱ��ȭ
  btn_Add.Enabled     := True;

  pgm_sts1 := [1];    

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA760P.btn_CloseClick(Sender: TObject);
begin
    //ȣ���� APP�� ���� ������ �޼���....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'�� ���� ���� �Ͻʽÿ�.');
      exit;
  end;

  close;
end;

//On-Exit (�԰�����)
procedure Tfrm_LOSTA760P.dte_Ip_DtExit(Sender: TObject);
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
function Tfrm_LOSTA760P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '22'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  itemNo
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

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

procedure Tfrm_LOSTA760P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
  InitComponents;
end;

procedure Tfrm_LOSTA760P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

end.
