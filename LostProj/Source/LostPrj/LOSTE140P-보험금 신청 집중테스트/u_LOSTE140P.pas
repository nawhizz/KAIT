{*---------------------------------------------------------------------------
���α׷�ID    : LOSTE140P (����� ��û �����׽�Ʈ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2012. 01. 26
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
unit u_LOSTE140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '����� ��û �����׽�Ʈ';
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

// ���޺� Ŭ���� �̺�Ʈ
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

// �� �޺� KeyUp �̺�Ʈ
procedure Tfrm_LOSTE140P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTE140P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;


procedure Tfrm_LOSTE140P.FormCreate(Sender: TObject);
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
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
//  common_userid     := '0294';    //ParamStr(2);
//  common_username   := '��ȣ��';  //ParamStr(3);
//  common_usergroup  := 'KAIT';    //ParamStr(4);

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

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1   );
  initComboBoxWithZ0xx('Z085.dat', cmb_in_su_d , '', '',cmb_in_su  );


  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
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
	if not TMAX.Start then
  begin
		ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

    //�����Է� �κ�
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

    //���� ȣ��
	if not TMAX.Call(PGM_ID) then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

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
procedure Tfrm_LOSTE140P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTE140P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
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
