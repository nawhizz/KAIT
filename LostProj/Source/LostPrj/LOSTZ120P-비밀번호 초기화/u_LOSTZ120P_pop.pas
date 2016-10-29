unit u_LOSTZ120P_pop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '��й�ȣ�ʱ�ȭ';
  PGM_ID  = 'LOSTZ120P';

type
  Tfrm_LOSTZ120P_pop = class(TForm)
    pnl_Command: TPanel;
    btn_Update: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Close: TSpeedButton;
    lbl_Program_Name: TLabel;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_Cd_Gu: TEdit;
    TMAX: TTMAX;
    btn_Reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btn_ResetClick(Sender: TObject);
    procedure edt_Cd_GuKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var
  frm_LOSTZ120P_pop: Tfrm_LOSTZ120P_pop;

implementation
uses u_LOSTZ120P;

{$R *.dfm}

procedure Tfrm_LOSTZ120P_POP.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 4;
    	RowHeights[0] := 21;

    	ColWidths[0] := 120;
		Cells[0,0] :='�����ID';

    	ColWidths[1] := 140;
		Cells[1,0] :='����ڸ�';

      ColWidths[2] := 110;
		Cells[2,0] :='����ڱ׷��';

      ColWidths[3] := 110;
		Cells[3,0] :='����ڷ���';

    end;
end;


{--------------------------------------------------------------------------}
procedure Tfrm_LOSTZ120P_pop.btn_CloseClick(Sender: TObject);
begin
   close;
   frm_LOSTZ120P.Enabled := True;
   frm_LOSTZ120P.Show;
end;


procedure Tfrm_LOSTZ120P_pop.FormCreate(Sender: TObject);
begin
  {----------------------- ���� ���ø����̼� ���� ---------------------------}
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
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
 //	common_userid:= '0294'; //ParamStr(2);
 //	common_username:= '��ȣ��';
 // ParamStr(3);
 //	common_usergroup:= 'KAIT'; //ParamStr(4);

  initStrGrid;	//�׸��� �ʱ�ȭ
  //initSkinForm(SkinData1);
  
  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ120P_pop.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);

  if Length(US_ID) > 0 then
    btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ120P_pop.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;

    RowPos:Integer;

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
	if (TMAX.SendString('INF003','LOSTZ120P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', edt_Cd_Gu.Text ) < 0) then  goto LIQUIDATION;


  //���� ȣ��
  if not TMAX.Call('LOSTZ120P') then
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
      Cells[0,RowPos] := TMAX.RecvString('STR101',i); //�ڵ��ȣ
      Cells[1,RowPos] := TMAX.RecvString('STR102',i); //�ڵ��
      Cells[2,RowPos] := TMAX.RecvString('STR103',i); //�ڵ��
      Cells[3,RowPos] := TMAX.RecvString('STR104',i); //�ڵ��
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

  if count1 > 0 then
  begin
    grd_display.RowCount := grd_display.RowCount -1;
    grd_display.SetFocus;
  end;
end;



procedure Tfrm_LOSTZ120P_pop.grd_displayDblClick(Sender: TObject);
begin

   frm_LOSTZ120P.edt_Ur_Id.Text := grd_display.Cells[0, grd_display.Row];
   frm_LOSTZ120P.edt_Ur_Nm.Text := grd_display.Cells[1, grd_display.Row];
   frm_LOSTZ120P.Enabled := True;
   frm_LOSTZ120P.Show;
   self.Hide;
   close;
end;

procedure Tfrm_LOSTZ120P_pop.btn_UpdateClick(Sender: TObject);
begin
   frm_LOSTZ120P.edt_Ur_Id.Text := grd_display.Cells[0, grd_display.Row];
   frm_LOSTZ120P.edt_Ur_Nm.Text := grd_display.Cells[1, grd_display.Row];
   close;
end;

procedure Tfrm_LOSTZ120P_pop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frm_LOSTZ120P.Enabled := True;
   frm_LOSTZ120P.Show;
end;

procedure Tfrm_LOSTZ120P_pop.btn_ResetClick(Sender: TObject);
var i : Integer;
begin
  edt_Cd_Gu.Text := US_ID;

  sts_Message.Panels[1].Text := '';

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;
  edt_Cd_Gu.SetFocus;

  frm_LOSTZ120P.Enabled := False;

  changeBtn(Self);
end;

procedure Tfrm_LOSTZ120P_pop.edt_Cd_GuKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ120P_pop.grd_displayKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then grd_displayDblClick(sender);  
end;

end.
