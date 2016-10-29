unit u_LOSTC140P_POP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit, ComObj;

const
  TITLE   = '��Ÿ�����ݾ��Է�';
  PGM_ID  = 'LOSTC140P';

type
  Tfrm_LOSTC140P_POP = class(TForm)
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel3: TBevel;
    lbl_Inq_Str: TLabel;
    cmb_Inq_Gu: TComboBox;
    edt_Inq_Str: TEdit;
    grd_display: TStringGrid;
    TMAX: TTMAX;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var
  frm_LOSTC140P_POP: Tfrm_LOSTC140P_POP;

implementation
 uses u_LOSTC140P_CHILD;
{$R *.dfm}

procedure Tfrm_LOSTC140P_POP.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 2;
    RowHeights[0] := 21;

    ColWidths[0] := 200;
    Cells[0,0] :='�Ѱ����ڵ�';

    ColWidths[1] := 250;
    Cells[1,0] :='�Ѱ�����';
    end;
end;

procedure Tfrm_LOSTC140P_POP.FormShow(Sender: TObject);
var i : Integer;
begin

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := '';

  frm_LOSTC140P_CHILD.Enabled := False;
  cmb_Inq_Gu.ItemIndex := 1;
  edt_Inq_Str.Text := GM_CD;
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Print.Enabled := False;
  Self.Show;

  if Length(GM_CD) > 0 then begin
    btn_InquiryClick(Sender);

  end;

  edt_Inq_Str.SetFocus;



end;

procedure Tfrm_LOSTC140P_POP.FormCreate(Sender: TObject);
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

  initStrGrid;	//�׸��� �ʱ�ȭ
  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC140P_POP.btn_CloseClick(Sender: TObject);
begin

  close;
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;

end;

procedure Tfrm_LOSTC140P_POP.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '�Ѱ��� �ڵ�';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 6;
      edt_Inq_Str.Height := 24;
      edt_Inq_Str.Width := 105;

   end
   else
   begin
      lbl_inq_str.Caption := '�Ѱ��� ��';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 20;
      edt_Inq_Str.Height := 24;
      edt_Inq_Str.Width := 105;
   end;
end;

procedure Tfrm_LOSTC140P_POP.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
	  //�׸��� ���÷���
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ
    totalCount :=0;
    grd_display.Cursor := crSQLWait;	//�۾���....

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

//�ݺ� ��ȸ
INQUIRY:

    TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ240P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Inq_Str.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', 'Y' ) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTZ240P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;

    //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
    goto LIQUIDATION;
  end;

    
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i); //�Ѱ����ڵ�
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i); //�Ѱ�����


           Inc(RowPos);
        end;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;
LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;

end;



procedure Tfrm_LOSTC140P_POP.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key =#13 then begin
  btn_InquiryClick(Sender);
 end;
end;



procedure Tfrm_LOSTC140P_POP.grd_displayDblClick(Sender: TObject);
begin
  frm_LOSTC140P_CHILD.edt_gm_cd.Text := grd_display.Cells[0, grd_display.Row];
  frm_LOSTC140P_CHILD.edt_gm_nm.Text := grd_display.Cells[1, grd_display.Row];

  frm_LOSTC140P_CHILD.edt_gm_nm.Enabled := False;

  close;
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;
  frm_LOSTC140P_CHILD.edt_rg_su.SetFocus;
end;

procedure Tfrm_LOSTC140P_POP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;
end;

end.
