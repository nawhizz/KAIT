{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA660L(�������� ������ ����)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 05
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
unit u_LOSTA660L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '������������������(EXCEL)';
  PGM_ID  = 'LOSTA660L';

type
  Tfrm_LOSTA660L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    grd_code: TStringGrid;
    Label1: TLabel;
    Bevel1: TBevel;
    dtp_tm_to: TDateTimePicker;
    Label3: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    dtp_tm_from: TDateTimePicker;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTA660L: Tfrm_LOSTA660L;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA660L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA660L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled := True;
  dte_to.Enabled := True;
  dtp_tm_from.Enabled := True;
  dtp_tm_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA660L.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount :=13;

		Cells[0,0]  :='����ȣ';
		Cells[1,0]  :='�߷�';
		Cells[2,0]  :='���';
		Cells[3,0]  :='������ڵ�';
		Cells[4,0]  :='����';
		Cells[5,0]  :='�ּ�';
		Cells[6,0]  :='�����ȣ';
		Cells[7,0]  :='�𵨸�';
		Cells[8,0]  :='�Ϸù�ȣ';
		Cells[9,0]  :='â���ȣ';
    Cells[10,0] :='�ݼۿ���';
    Cells[11,0] :='�����ڿ���ó';
    Cells[12,0] :='����ݻ���';    

  end;
end;

procedure Tfrm_LOSTA660L.setEdtKeyPress;
var i : Integer;
begin
 for i := 0 to componentCount -1 do
 begin
   if (Components[i] is TEdit) then
   begin
     (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
   end;
 end;
end;

procedure Tfrm_LOSTA660L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA660L.FormCreate(Sender: TObject);
begin
  {----------------------- ���� ���ø����̼� ���� ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  {   }
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '��ȣ��'; //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  //common_lib.pas�� �ִ�.
  initSkinForm(SkinData1);
  initStrGrid;
  btn_ResetClick(Sender);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA660L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA660L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

procedure Tfrm_LOSTA660L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� �۰� ������ �� �����ϴ�.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then begin
		showmessage('�������ڴ� �������� ���ķ� ������ �� �����ϴ�.');
		exit;
	end;
end;

procedure Tfrm_LOSTA660L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;


  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;
  STR010 : String;
  tempdtfrom : String;
  tempdtto : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin

   //�׸����ʱ�ȭ
   pInitStrGrd(Self);

	 //�׸��� ���÷���
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;
    datetimetostring(tempdtfrom, 'hhmmss', dtp_tm_from.time);
    datetimetostring(tempdtto, 'hhmmss', dtp_tm_to.time);
    //���۽ú��� �ʱ�ȭ

    
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';
    STR010 :=' ';
    qryStr := ' ';

    totalCount :=0;
    grd_display.Cursor := crSQLWait;	//�۾���....
    disableComponents;	//�۾��� �ٸ� ��� ��� ����.


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
	if (TMAX.SendString('INF002',common_userid            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA660L'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', FormatDateTime('HHMMSS',dtp_tm_from.time) ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', FormatDateTime('HHMMSS',dtp_tm_to.time)   ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', STR010) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTA660L') then
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

    ShowMessage('����� �ڷᰡ �����ϴ�.');

    goto LIQUIDATION;
  end;
    
  totalCount:= totalCount + count1;
  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin

      Cells[ 3,RowPos]  := TMAX.RecvString('STR101',i);     //������ڵ�
      Cells[ 4,RowPos]  := TMAX.RecvString('STR102',i);     //����
      Cells[ 5,RowPos]  := TMAX.RecvString('STR103',i);     //�ּ�
      Cells[ 6,RowPos]  := TMAX.RecvString('STR104',i);     //�����ȣ
      Cells[ 7,RowPos]  := TMAX.RecvString('STR105',i);     //�𵨸�
      Cells[ 8,RowPos]  := TMAX.RecvString('STR111',i);     //�𵨸�
      Cells[ 9,RowPos]  := TMAX.RecvString('STR106',i);     //â���ȣ
      Cells[10,RowPos]  := TMAX.RecvString('STR107',i);     //�ݼۿ���
      Cells[11,RowPos] := TMAX.RecvString('STR108',i);      //�̵���ȭ
      Cells[12,RowPos] := TMAX.RecvString('STR114',i);      //����ݻ���

      STR005 := Trim(TMAX.RecvString('STR109',i)); // ��ȸ���� �����ڵ�
      STR006 := Trim(TMAX.RecvString('STR106',i)); // ��ȸ���� â���ȣ
      STR007 := Trim(TMAX.RecvString('STR110',i)); // ��ȸ���� ���ð�
      STR008 := Trim(TMAX.RecvString('STR113',i)); // ��ȸ���� ���ڵ�
      STR009 := Trim(TMAX.RecvString('STR111',i)); // ��ȸ���� �Ϸù�ȣ
      STR010 := Trim(TMAX.RecvString('STR112',i)); // ��ȸ���� �԰�����

      Inc(RowPos);
    end;
  end;

  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

  //����Ʈ�� ������ ���� ��
  count2 := TMAX.RecvInteger('INT100',0);

  if count1 = count2 then
    goto INQUIRY;

  qryStr:= TMAX.RecvString('INF014',0);
  //������ ���
	Proc_gridtoexcel('�н�������(LOSTA660L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA660L');

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTA660L.btn_ResetClick(Sender: TObject);
begin
	dte_from.Date     := date-1;
	dte_to.Date       := date-1;
  dtp_tm_from.Time  := StrToTime('���� 7:00:00');
  dtp_tm_to.Time    := StrToTime('���� 11:00:00');

  changeBtn(Self);

end;

procedure Tfrm_LOSTA660L.btn_queryClick(Sender: TObject);
var
  cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\LOSTA660L_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA660L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

end.
