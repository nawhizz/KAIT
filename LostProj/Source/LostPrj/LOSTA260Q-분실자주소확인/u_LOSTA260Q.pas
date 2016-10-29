{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA260Q (�н��� �ּ� Ȯ��)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 10. 07
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
unit u_LOSTA260Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '�н��� �ּ� Ȯ��';
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

    //�˻��� ���
    STR001:String; // ���ڵ�
    STR002:String; // �ܸ����Ϸù�ȣ
    STR003:String; // �԰�����

    qryStr : String;

  public
    { Public declarations }

    procedure InitComponents;

  end;

var
  frm_LOSTA260Q: Tfrm_LOSTA260Q;

implementation

{$R *.DFM}

// ���޺� Ŭ���� �̺�Ʈ
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

// �� �޺� KeyUp �̺�Ʈ
procedure Tfrm_LOSTA260Q.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
  //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
  //	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then
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

  attachOnEnter;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
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
  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

  i : integer;

  Label LIQUIDATION;
  Label SEEDKEY;
  Label INQUIRY;
begin
  // ��ȣȭ ���
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

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	// ���ڵ� md_cb1
	STR002:= serial_edit.Text;			                                        // �ܸ����Ϸù�ȣ

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
	if (TMAX.SendString('INF003','LOSTA260Q'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTA260Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  qryStr := TMAX.RecvString('INF014',0);

  (* �ܸ�������   *)  lbl_Ph_Gb.Caption  := TMAX.RecvString('STR013',0);
  (* �̵���ȭ��ȣ *)  msk_mt_no.Text     := TMAX.RecvString('STR014',0);
  (* ����𵨸�   *)  lbl_New_md.Caption := TMAX.RecvString('STR015',0);

  for i := 0 to StrToInt(TMAX.RecvString('INF013',0)) -1 do
  begin
    if (TMAX.RecvString('STR101',i) = 'A001') then
    begin

    (* 	�ֹ�/�����/�ܱ��α��� *)	edt_A001Gb_cd.Text	:= TMAX.RecvString('STR102',i);
    (* 	�ֹ�/�����/�ܱ��ι�ȣ *)	seed_idno         	:= TMAX.RecvString('STR103',i);
                                	edt_A001Id_no.Text	:= ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	����(��ü��)           *)	seed_idnm         	:= TMAX.RecvString('STR104',i);
                                	edt_A001Id_Nm.Text	:= ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	�����ȣ               *)	edt_A001Pt_no.Text	:= TMAX.RecvString('STR105',i);
    (* 	�ּ���                 *)	edt_A001Ju_so.Text	:= TMAX.RecvString('STR106',i);
    (* 	�����ּ�               *)	edt_A001Bo_so.Text	:= TMAX.RecvString('STR107',i);
    (* 	��ȭ��ȣ               *)	seed_tlno         	:= TMAX.RecvString('STR108',i);
                                	edt_A001Tl_no.Text	:= ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

      PageControl1.ActivePageIndex := 0;

    end else if (TMAX.RecvString('STR101',i) = 'A003') then
    begin
    (* 	�ֹ�/�����/�ܱ��α��� *)	edt_A003Gb_cd.Text  := TMAX.RecvString('STR102',i);
    (* 	�ֹ�/�����/�ܱ��ι�ȣ *)	seed_idno           := TMAX.RecvString('STR103',i);
                                	edt_A003Id_no.Text  := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	����(��ü��)           *)	seed_idnm           := TMAX.RecvString('STR104',i);
                                	edt_A003Id_Nm.Text  := ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	�����ȣ               *)	edt_A003Pt_no.Text  := TMAX.RecvString('STR105',i);
    (* 	�ּ���                 *)	edt_A003Ju_so.Text  := TMAX.RecvString('STR106',i);
    (* 	�����ּ�               *)	edt_A003Bo_so.Text  := TMAX.RecvString('STR107',i);
    (* 	��ȭ��ȣ               *)	seed_tlno           := TMAX.RecvString('STR108',i);
                                	edt_A003Tl_no.Text  := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

        PageControl1.ActivePageIndex := 1;

    end else if (TMAX.RecvString('STR101',i) = 'A005') then
    begin
    (* 	�ֹ�/�����/�ܱ��α��� *)	edt_A005Gb_cd.Text	:= TMAX.RecvString('STR102',i);
    (* 	�ֹ�/�����/�ܱ��ι�ȣ *)	seed_idno         	:= TMAX.RecvString('STR103',i);
                                	edt_A005Id_no.Text	:= ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
    (* 	����(��ü��)           *)	seed_idnm         	:= TMAX.RecvString('STR104',i);
                                	edt_A005Id_Nm.Text	:= ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
    (* 	�����ȣ               *)	edt_A005Pt_no.Text	:= TMAX.RecvString('STR105',i);
    (* 	�ּ���                 *)	edt_A005Ju_so.Text	:= TMAX.RecvString('STR106',i);
    (* 	�����ּ�               *)	edt_A005Bo_so.Text	:= TMAX.RecvString('STR107',i);
    (* 	��ȭ��ȣ               *)	seed_tlno         	:= TMAX.RecvString('STR108',i);
                                	edt_A005Tl_no.Text	:= ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);

        PageControl1.ActivePageIndex := 2;

    end else
    begin
      ShowMessage('��Ī�Ǵ� ��Ż簡 �����ϴ�.');

      goto LIQUIDATION;
    end;
  end;

  qryStr:= TMAX.RecvString('INF014',0);

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

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
  //������Ʈ �ʱ�ȭ
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
