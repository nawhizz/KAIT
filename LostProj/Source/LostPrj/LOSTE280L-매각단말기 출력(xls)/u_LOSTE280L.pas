{*---------------------------------------------------------------------------
���α׷�ID    : LOSTE280L (�Ű��ܸ��� ���(EXCEL))
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2012. 01. 19
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
unit u_LOSTE280L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '�Ű��ܸ��� ���(EXCEL)';
  PGM_ID  = 'LOSTE280L';

type
  Tfrm_LOSTE280L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_From: TDateEdit;
    dte_To: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    grd_code: TStringGrid;
    Bevel3: TBevel;
    cmb_in_su: TComboBox;
    Label3: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_FromExit(Sender: TObject);
    procedure dte_ToExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);

  private
    { Private declarations }
    cmb_in_su_d: TZ0xxArray;
    cmb_sts_gu_d :TZ0xxArray;
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    //������ ������Ʈ �������
    procedure disableComponents;
    //����Ϸ� �� ������Ʈ ��� �����ϰ�
    procedure enableComponents;
  end;

var
  frm_LOSTE280L: Tfrm_LOSTE280L;

implementation

{$R *.DFM}
procedure Tfrm_LOSTE280L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTE280L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled := True;
  dte_to.Enabled := True;

  cmb_in_su.Enabled := True;


  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTE280L.initStrGrid;
begin
	with grd_display do begin
    RowCount :=  2;
    ColCount := 12;

    Cells[ 0,0] :='SEQ';
    Cells[ 1,0] :='�Ű�����';
    Cells[ 2,0] :='������';
    Cells[ 3,0] :='â���ȣ';
    Cells[ 4,0] :='�𵨸�';
    Cells[ 5,0] :='�Ϸù�ȣ';
    Cells[ 6,0] :='�԰�����';
    Cells[ 7,0] :='�����ڼ���';
    Cells[ 8,0] :='�������';
    Cells[ 9,0] :='����ݽ�û����';
    Cells[10,0] :='����ݽ�������';
    Cells[11,0] :='����������';

    end;
end;

procedure Tfrm_LOSTE280L.setEdtKeyPress;
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

procedure Tfrm_LOSTE280L.Edt_onKeyPress ( Sender : TObject; var key : Char);
 begin
   if (key = #13) then
     SelectNext( ActiveControl as TEdit , true, True);
 end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE280L.FormCreate(Sender: TObject);
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
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then
  begin
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
//	common_userid     := '0294';    //ParamStr(2);
//	common_username   := '��ȣ��';  //ParamStr(3);
//	common_usergroup  := 'SYSM';    //ParamStr(4);

   initSkinForm(SkinData1);
   initStrGrid;
   initComboBoxWithZ0xx('Z085.dat', cmb_in_su_d, '��ü', ' ',cmb_in_su);

   btn_resetClick(Sender);
    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTE280L.btn_CloseClick(Sender: TObject);
begin
     close;
end;


procedure Tfrm_LOSTE280L.dte_FromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

procedure Tfrm_LOSTE280L.dte_ToExit(Sender: TObject);
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



procedure Tfrm_LOSTE280L.FormShow(Sender: TObject);
begin
  dte_from.SetFocus;
end;


procedure Tfrm_LOSTE280L.btn_PrintClick(Sender: TObject);

var
    i:Integer;
    count1, count2, totalCount:Integer;
    Label LIQUIDATION;
    Label INQUIRY;
begin
  //�׸����ʱ�ȭ
  pInitStrGrd(Self);

  count1 := 0;

  //���۽ú��� �ʱ�ȭ

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
	if (TMAX.SendString('INF002',common_userid                            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003',PGM_ID                                   ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)                  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_in_su_d[cmb_in_su.ItemIndex].code   ) < 0) then  goto LIQUIDATION;


  //���� ȣ��
  if not TMAX.Call(PGM_ID) then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

    //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then
    ShowMessage('����� �ڷᰡ �����ϴ�.')
  else
  begin

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do
    begin
      for i:=0 to count1-1 do
      begin
        Cells[ 0,i+1] := 	IntToStr(i+ 1);               // SEQ
        Cells[ 1,i+1] := 	TMAX.RecvString('STR101',i);  // �Ű�����
        Cells[ 2,i+1] :=  TMAX.RecvString('STR102',i);  // ������
        Cells[ 3,i+1] := 	TMAX.RecvString('STR103',i);  // â���ȣ
        Cells[ 4,i+1] := 	TMAX.RecvString('STR104',i);  // �𵨸�
        Cells[ 5,i+1] := 	TMAX.RecvString('STR105',i);  // �Ϸù�ȣ
        Cells[ 6,i+1] := 	TMAX.RecvString('STR106',i);  // �԰�����
        Cells[ 7,i+1] := 	TMAX.RecvString('STR107',i);  // �����ڼ���
        Cells[ 8,i+1] := 	TMAX.RecvString('STR108',i);  // �������
        Cells[ 9,i+1] := 	TMAX.RecvString('STR109',i);  // ����ݽ�û����
        Cells[10,i+1] := 	TMAX.RecvString('STR110',i);  // ����ݽ�������
        Cells[11,i+1] := 	TMAX.RecvString('STR111',i);  // ����������
      end;
    end;

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

    //����Ʈ�� ������ ���� ��
    count2 := TMAX.RecvInteger('INT100',0);

//    if count1 = count2 then
//      goto INQUIRY;

    qryStr := TMAX.RecvString('INF014',0);

      //������ ���
    Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  if count1 > 0 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTE280L.btn_queryClick(Sender: TObject);
var
  cmdStr    :String;
  filePath  :String;
  f         :TextFile;
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



procedure Tfrm_LOSTE280L.btn_ResetClick(Sender: TObject);
begin
  changeBtn(Self);

	dte_from.Date         := date-30;
	dte_to.Date           := date;
  cmb_in_su.ItemIndex   := 0;
end;

end.
