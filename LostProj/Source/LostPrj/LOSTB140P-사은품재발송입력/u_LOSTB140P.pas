{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB140P (����ǰ ��߼� �Է�)
���α׷� ���� : Online
�ۼ���	      : �ִ뼺
�ۼ���	      : 2011. 08. 10
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	          :
-----------------------------------------------------------------------------*}
unit u_LOSTB140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud, ComObj;

const
  TITLE   = '����ǰ ��߼� �Է�';
  PGM_ID  = 'LOSTB140P';

type
  Tfrm_LOSTB140P = class(TForm)
    Bevel2          : TBevel;
    Bevel20         : TBevel;
    Bevel23         : TBevel;
    Bevel24         : TBevel;
    Bevel25         : TBevel;
    Bevel28         : TBevel;
    Bevel30         : TBevel;
    Bevel31         : TBevel;
    Bevel7          : TBevel;
    Bevel8          : TBevel;
    Bevel9          : TBevel;
    Bevel10         : TBevel;
    Bevel26         : TBevel;
    Bevel44         : TBevel;
    Bevel43         : TBevel;
    Bevel1          : TBevel;
    Bevel4          : TBevel;
    Bevel16         : TBevel;
    Bevel5          : TBevel;
    Bevel3          : TBevel;
    Bevel12         : TBevel;
    Bevel14         : TBevel;
    Bevel19         : TBevel;
    Bevel22         : TBevel;
    dte_Sh_Dt       : TDateEdit;
    GroupBox3       : TGroupBox;
    lbl_Gt_Nm       : TLabel;
    lbl_Ju_Dt       : TLabel;
    lbl_Tl_No       : TLabel;
    lbl_Ju_So       : TLabel;
    Label2          : TLabel;
    lbl_Gt_Dt       : TLabel;
    Label5          : TLabel;
    lbl_Sp_Cd       : TLabel;
    lbl_Ph_Gb       : TLabel;
    Label13         : TLabel;
    Label7          : TLabel;
    Label8          : TLabel;
    Label25         : TLabel;
    Label4          : TLabel;
    lbl_Gt_No       : TLabel;
    lbl_Bo_So       : TLabel;
    Label20         : TLabel;
    lbl_Pt_No       : TLabel;
    Label23         : TLabel;
    lbl_Sp_Gu       : TLabel;
    lbl_Program_Name: TLabel;
    Label9          : TLabel;
    Label24         : TLabel;
    Label3          : TLabel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    md_grid1        : TStringGrid;
    TMAX            : TTMAX;
    btn_Close: TSpeedButton;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;
    Panel1: TPanel;
    Bevel18: TBevel;
    Bevel6: TBevel;
    Bevel15: TBevel;
    Label6: TLabel;
    Label10: TLabel;
    Bevel11: TBevel;
    Label15: TLabel;
    Bevel17: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel33: TBevel;
    Label1: TLabel;
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
    Bevel13: TBevel;
    Label11: TLabel;
    Bevel21: TBevel;
    lbl_Rt_dt: TLabel;

    procedure FormCreate        (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure btn_AddClick      (Sender: TObject);
    procedure btn_UpdateClick   (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure md_Grid1Click     (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_cb1KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_resetClick(Sender: TObject);


  private
    { Private declarations }
    md_grid1_d :TZ0xxArray;

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
    procedure SetLabelCaption(var lbl:TLabel; strtag:String);    

  end;

var
  frm_LOSTB140P: Tfrm_LOSTB140P;

implementation
{$R *.DFM}


procedure Tfrm_LOSTB140P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTB140P.OnKeyPress(Sender: TObject; var Key: Char);
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
      if (Sender as TEdit) = edt_birth_date then
        if not (key in ['0'..'9',#8,#9]) then key := #0;
    end else
    begin
    if Sender is TMaskEdit then
      if (Sender as TMaskEdit) = edt_phone_no then
        if not (key in ['0'..'9',#8,#9]) then key := #0;
    end;

    Exit;
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
procedure Tfrm_LOSTB140P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTB140P.OnExit(Sender:TObject);
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
    value1  := StringReplace(Trim(delHyphen(medit.Text)),' ','_',[rfReplaceAll]);

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
procedure Tfrm_LOSTB140P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTB140P.AttachOnExitEvent;
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
procedure Tfrm_LOSTB140P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTB140P.OnEnter(Sender:TObject);
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
            SetItemNo('5');
  end;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure �� �� : ����ģ ���۳�Ʈ�� ���� ���ڸ� ��� �ִ´�.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB140P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'���� �޼����� �����ش�.
procedure Tfrm_LOSTB140P.Link_rtn (var Msg : TMessage);
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

  hThreadID: Cardinal;
  FocusWnd: THandle;

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

      edt_Id_Nm.Text        := smem^.name;			      // ����(��ü��)
      md_cb1.Text           := smem^.model_name;	    // �𵨸�
      serial_edit.Text      := smem^.serial_no;	      // �ܸ����Ϸù�ȣ
      dte_Ip_Dt.Text        := smem^.ibgo_date;		    // �԰���
      edt_birth_date.Text   := smem^.birth;			      // �������
      edt_phone_no.EditText := Trim(smem^.phone_no2); // ��ȭ��ȣ

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
procedure Tfrm_LOSTB140P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTB140P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTB140P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

(******************************************************************************)
(* procedure name  : SetLabelCaption                                          *)
(* procedure �� �� : �󺧸�� ĸ���� �޾� �� ĸ������ �����Ѵ�.             *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB140P.SetLabelCaption(var lbl:TLabel; strtag:String);
begin
    lbl.Caption:= TMAX.RecvString(strtag,0);
end;


procedure Tfrm_LOSTB140P.FormCreate(Sender: TObject);
var i : integer;
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

procedure Tfrm_LOSTB140P.InitComponents;
var i : Integer;
begin

  //���, �˻����� �ʱ�ȭ
	edt_Id_Nm.Text        :=  '';	              //����(��ü��)[1]
  edt_birth_date.Text   :=  '';
	md_cb1.Text           :=  '';	              //�𵨸�[4]
	serial_edit.Text      :=  '';	              //�ܸ����Ϸù�ȣ[5]
	dte_Ip_Dt.Text        :=  '    -  -  ';	    //�԰���[7]
	edt_phone_no.EditText :=  '    -    -    ';  //�н��ڵ�����ȣ[6]

  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

  dte_Sh_Dt.Date := date;

  //�ʱ�ȭ
  setItemNo('1');

  //ó�� ����� ������ Ŭ���� ���� ����
  recvedMessage:= True;

  for i := 0 to ComponentCount -1 do
  if Components[i] is TLabel then
  begin
   if (Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0) then
    (Components[i] as TLabel).Caption := '';

  end;

  changeBtn(Self);
end;

procedure Tfrm_LOSTB140P.btn_AddClick(Sender: TObject);
var
	STR004 :String;
  svcNm : string; // ���� ���и�
  LABEL LIQUIDATION;

begin

  // �Է��ʵ� üũ
  (********************************************************************)
  (* common_lib.pas                                                   *)
  (* function Name : fChkLength / Return Value : True/False           *)
  (* fChkLength(  Component Name                                      *)
  (*            , Length                                              *)
  (*            , Condition Value(0 : Equal , 1: Minimum, 2: Maximum) *)
  (*            , Component Text)                                     *)
  (********************************************************************)
  if ( not fChkLength(md_cb1      ,1,1,'�𵨸�'     )) then Exit;
  if ( not fChkLength(serial_edit ,1,1,'�Ϸù�ȣ'   )) then Exit;
  if ( not fChkLength(dte_Ip_Dt   ,8,0,'�԰�����'   )) then Exit;
  if ( not fChkLength(dte_Sh_Dt   ,8,0,'��߼�����' )) then Exit;

  if      ((Sender as TSpeedButton).Name = 'btn_Add'   ) then svcNm := 'I01'
  else if ((Sender as TSpeedButton).Name = 'btn_Update') then svcNm := 'U01'
  else if ((Sender as TSpeedButton).Name = 'btn_Delete') then svcNm := 'D01';

  // �Ǽ� �� ����ȸ�� ���� ������ ���� ����
	(* ���ڵ�       *) STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);
	(* �ܸ����Ϸù�ȣ *) STR002 := serial_edit.Text;
  (* �԰�����       *) STR003 := delHyphen(dte_Ip_Dt.Text);
  (* ��߼�Ȯ������ *) STR004 := delHyphen(dte_Sh_Dt.Text);

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
	if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB140P'      ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', svcNm           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004          ) < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTB140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end;

  // �޼����˸�
       if ( svcNm = 'I01') then ShowMessage('���������� �����Ͽ����ϴ�.')
  else if ( svcNm = 'U01') then ShowMessage('���������� �����Ͽ����ϴ�.')
  else if ( svcNm = 'D01') then ShowMessage('���������� �����Ͽ����ϴ�.');

  sts_Message.Panels[1].Text := ' ��� �Ϸ�';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTB140P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

//'����' ��ư Ŭ��
procedure Tfrm_LOSTB140P.btn_DeleteClick(Sender: TObject);
begin
	if MessageDlg('���� �����Ͻðڽ��ϱ� ?',
		mtConfirmation, mbOkCancel, 0) = mrCancel then begin
		sts_Message.Panels[1].text := '������ ��ҵǾ����ϴ�.';
		exit;
	end;

  btn_AddClick(Sender);
end;

//'��ȸ' ��ư Ŭ��
procedure Tfrm_LOSTB140P.btn_InquiryClick(Sender: TObject);
var
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

  Label LIQUIDATION;
begin
  // ��ȣȭ ���
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_idnm := '';
  seed_idno := '';
  seed_tlno := '';
  seed_mtno := '';

  if ( not fChkLength(md_cb1      ,1,1,'�𵨸�'     )) then Exit;
  if ( not fChkLength(serial_edit ,1,1,'�Ϸù�ȣ'   )) then Exit;
  if ( not fChkLength(dte_Ip_Dt   ,8,0,'�԰�����'   )) then Exit;

	(* ���ڵ�       *) STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);
	(* �ܸ����Ϸù�ȣ *) STR002:= serial_edit.Text;
  (* �԰�����       *) STR003:= delHyphen(dte_Ip_Dt.Text);

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
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB140P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTB140P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  (* �ܸ��������ڵ�      *)   //				                     TMAX.RecvString('STR101',0);
  (* �ܸ���������        *)   lbl_Ph_Gb.Caption :=           TMAX.RecvString('STR102',0);
  (* �����ڸ�            *)   seed_idnm         :=           TMAX.RecvString('STR103',0);
                              lbl_Gt_Nm.Caption := ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
  (* �������ֹι�ȣ      *)   seed_idno         :=           TMAX.RecvString('STR104',0);
                              lbl_Gt_No.Caption := InsHyphen(ECPlazaSeed.Decrypt(seed_idno, common_seedkey));
  (* �����ڿ�����ȭ��ȣ  *)   seed_tlno         :=           TMAX.RecvString('STR105',0);
                              lbl_Tl_No.Caption := InsHyphen(ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
  (* �����ڿ����ȣ      *)   lbl_Pt_No.Caption := InsHyphen(TMAX.RecvString('STR106',0));
  (* �����ڱ⺻�ּ�      *)   lbl_Ju_So.Caption :=           TMAX.RecvString('STR107',0);
  (* �����ڻ��ּ�      *)   lbl_Bo_So.Caption :=           TMAX.RecvString('STR108',0);
  (* ��������            *)   lbl_Gt_Dt.Caption := InsHyphen(TMAX.RecvString('STR109',0));
  (* ����ǰ��߼�Ȯ������*)   dte_Sh_Dt.Text    :=           TMAX.RecvString('STR110',0);
  (* ����ǰ�߼�����      *)   //				                     TMAX.RecvString('STR111',0);
  (* ����ǰ��ǰ�����ڵ�  *)   //				                     TMAX.RecvString('STR112',0);
  (* ����ǰ��ǰ���и�    *)   lbl_Sp_Gu.Caption :=           TMAX.RecvString('STR113',0);
  (* ��ǰ�ڵ�            *)   //				                     TMAX.RecvString('STR114',0);
  (* ��ǰ��              *)   lbl_Sp_Cd.Caption :=           TMAX.RecvString('STR115',0);
  (* ����ǰ�߼�����      *)   lbl_Ju_Dt.Caption := InsHyphen(TMAX.RecvString('STR111',0));
  (* ����ǰ�ݼ�����      *)   lbl_Rt_Dt.Caption := InsHyphen(TMAX.RecvString('STR117',0));

  if ( Trim(delHyphen(dte_Sh_Dt.Text)) = '') then dte_Sh_Dt.Date := date;

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

procedure Tfrm_LOSTB140P.btn_CloseClick(Sender: TObject);
begin
     close;
end;

//common_lib.pas�� �ִ� �Լ��� �ٸ���.
function Tfrm_LOSTB140P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - ȣ�ⱸ��          *)+ ' ' +  '13'
                (* paramstr(7) - ȣ�� ���۳�Ʈ ����*)+ ' ' +  itemNo
                (* paramstr(8) - ���� ���� 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - ���� ���� 2       *)+ ' ' +  fNVL(value2)
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

    ShowWindow(Self.Handle, SW_SHOW);
    ShowWindow(Self.Handle, SW_RESTORE);
  end;


end;

procedure Tfrm_LOSTB140P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

end.
