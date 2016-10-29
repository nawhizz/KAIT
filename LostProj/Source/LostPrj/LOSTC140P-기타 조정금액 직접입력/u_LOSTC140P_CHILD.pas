unit u_LOSTC140P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit,u_LOSTC140P_POP, ComObj;

const
  TITLE   = '��Ÿ�����ݾ��Է�';
  PGM_ID  = 'LOSTC140P';

type
  Tfrm_LOSTC140P_CHILD = class(TForm)
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_ct_ym: TEdit;
    edt_gm_cd: TEdit;
    edt_ct_am: TEdit;
    edt_bi_go: TEdit;
    sts_Message: TStatusBar;
    btn_Print: TSpeedButton;
    btn1: TBitBtn;
    edt_gm_nm: TEdit;
    btn_Inquiry: TSpeedButton;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    edt_rg_su: TEdit;
    edt_cl_su: TEdit;
    edt_ag_su: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure edt_rg_suChange(Sender: TObject);
    procedure edt_cl_suChange(Sender: TObject);
    procedure edt_ag_suChange(Sender: TObject);
    procedure edt_rg_suKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cl_suKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ag_suKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_rg_suKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_cl_suKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_gm_cdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GM_CD : String;

  frm_LOSTC140P_CHILD: Tfrm_LOSTC140P_CHILD;

implementation
uses u_LOSTC140P;

{$R *.dfm}


{-----------------------------------------------------------------------------}
procedure Tfrm_LOSTC140P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
  sts_Message.Panels[1].Text := '';

  frm_LOSTC140P.Enabled := False;

  if (Button.Name = 'btn_Add') then begin

    changeBtn(Self);
    btn_Add.Enabled := true;
    btn_Update.Enabled := false;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;

    edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
    edt_gm_cd.Text := '';
    edt_gm_nm.Text := '';
    edt_rg_su.Text := '0';
    edt_cl_su.Text := '0';
    edt_ag_su.Text := '0';
    edt_ct_am.Text := '0';
    edt_bi_go.Text := '';

    edt_ct_ym.Enabled := False;
    edt_gm_cd.Enabled := True;
    edt_gm_nm.Enabled := False;
    edt_ct_am.Enabled := False;
    edt_bi_go.Enabled := True;

    self.Show;
    edt_gm_cd.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin

   changeBtn(Self);
   btn_Add.Enabled := false;
   btn_Update.Enabled := true;
   btn_Delete.Enabled := false;
   btn_Inquiry.Enabled := false;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := frm_LOSTC140P.grd_display.Cells[5, frm_LOSTC140P.grd_display.Row];
   edt_cl_su.Text := frm_LOSTC140P.grd_display.Cells[6, frm_LOSTC140P.grd_display.Row];
   edt_ag_su.Text := frm_LOSTC140P.grd_display.Cells[7, frm_LOSTC140P.grd_display.Row];

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := False;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := True;

   edt_rg_su.SelectAll;

   self.Show;
  end else if (Button.Name = 'btn_Update') then  begin

   changeBtn(Self);
   btn_Add.Enabled := false;
   btn_Update.Enabled := True;
   btn_Delete.Enabled := False;
   btn_Inquiry.Enabled := false;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := RG_SU;
   edt_cl_su.Text := CL_SU;
   edt_ag_su.Text := AG_SU;

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := True;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := True;

   self.Show;
  end else if (Button.Name = 'btn_Delete') then  begin

   changeBtn(Self);
   btn_Add.Enabled := False;
   btn_Update.Enabled := False;
   btn_Delete.Enabled := True;
   btn_Inquiry.Enabled := False;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := RG_SU;
   edt_cl_su.Text := CL_SU;
   edt_ag_su.Text := AG_SU;

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := False;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := False;

   self.Show;
  end;

end;

procedure Tfrm_LOSTC140P_CHILD.btn_CloseClick(Sender: TObject);
begin
 close;
 frm_LOSTC140P.Enabled := True;
 frm_LOSTC140P.Show;
 frm_LOSTC140P.btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTC140P_CHILD.btn1Click(Sender: TObject);
begin
  GM_CD := '';
  GM_CD := edt_gm_cd.Text;
  frm_LOSTC140P_POP.FormShow(Sender);
end;

procedure Tfrm_LOSTC140P_CHILD.FormCreate(Sender: TObject);
begin
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '��ȣ��';
  // ParamStr(3);
  //	common_usergroup:= 'KAIT'; //ParamStr(4);

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
  
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC140P_CHILD.btn_AddClick(Sender: TObject);
  LABEL LIQUIDATION;
begin

  if(edt_gm_cd.Text = '' ) then begin
       ShowMessage('�Ѱ��ڵ带 �Է����ֽʽÿ�.');
    exit;
   end;

  if(edt_ct_ym.Text = '') then begin
       ShowMessage('�������� �Է����ֽʽÿ�.');
    exit;
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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrToInt(delDelimiter(edt_rg_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT004', StrToInt(delDelimiter(edt_cl_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT005', StrToInt(delDelimiter(edt_ag_su.Text,','))  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT006', StrToInt(delDelimiter(edt_ct_am.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTC140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ��� �Ϸ�';
         ShowMessage('���������� ��ϵǾ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  edt_gm_cd.Text := '';
  edt_gm_nm.Text := '';
  edt_rg_su.Text := '0';
  edt_cl_su.Text := '0';
  edt_ag_su.Text := '0';
  edt_ct_am.Text := '0';
  edt_bi_go.Text := '';
  edt_gm_cd.SetFocus;
end;

procedure Tfrm_LOSTC140P_CHILD.btn_UpdateClick(Sender: TObject);
  LABEL LIQUIDATION;
begin

  if(edt_gm_cd.Text = '' ) then begin
       ShowMessage('�Ѱ��ڵ带 �Է����ֽʽÿ�.');
    exit;
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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrToInt(delDelimiter(edt_rg_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT004', StrToInt(delDelimiter(edt_cl_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT005', StrToInt(delDelimiter(edt_ag_su.Text,','))  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT006', StrToInt(delDelimiter(edt_ct_am.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTC140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ���� �Ϸ�';
         ShowMessage('���������� ���� �Ǿ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  frm_LOSTC140P.btn_InquiryClick(Sender);
  close;

 end;
procedure Tfrm_LOSTC140P_CHILD.btn_DeleteClick(Sender: TObject);
  LABEL LIQUIDATION;
begin
 if MessageDlg('�����Ͻðڽ��ϱ� ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='������ ��ҵǾ����ϴ�';
      exit;
   end else
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
    if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;

      //���� ȣ��
    if not TMAX.Call('LOSTC140P') then
      begin
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

        goto LIQUIDATION;
      end
    else
      begin
          sts_Message.Panels[1].Text := ' ���� �Ϸ�';
           ShowMessage('���������� ���� �Ǿ����ϴ�.')
      end;

  LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

 end; // begin ~ end

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suChange(Sender: TObject);
var
   cnt : Integer;
begin
{
  edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
  edt_rg_su.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
  edt_cl_su.Text := frm_LOSTC140P.grd_display.Cells[5, frm_LOSTC140P.grd_display.Row];
  edt_ag_su.Text := frm_LOSTC140P.grd_display.Cells[6, frm_LOSTC140P.grd_display.Row];
 }
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 �ִ뼺 ���� *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suChange(Sender: TObject);
var
   cnt : Integer;
begin
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 �ִ뼺 ���� *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_ag_suChange(Sender: TObject);
var
   cnt : Integer;
begin
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 �ִ뼺 ���� *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('���ڸ� �Է��ϼ���');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('���ڸ� �Է��ϼ���');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_ag_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('���ڸ� �Է��ϼ���');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 frm_LOSTC140P.Enabled := True;
 frm_LOSTC140P.Show;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then begin edt_cl_su.SetFocus; end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then begin edt_ag_su.SetFocus; end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_gm_cdKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then begin
  btn1Click(Sender);
 end;
end;

end.
