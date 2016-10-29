{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB520L (�԰������(EXCELL))
���α׷� ���� : Online
�ۼ���	      : ������
�ۼ���	      : 2011.8.5
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
unit u_LOSTB520L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '����ǰ�߼۴�����(EXCEL)';
  PGM_ID  = 'LOSTB520L';

type
  Tfrm_LOSTB520L = class(TForm)
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
    grd_display: TStringGrid;
    cmb_id_cd: TComboBox;
    Bevel3: TBevel;
    Label3: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_FromExit(Sender: TObject);
    procedure dte_ToExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    cmb_id_cd_d: TZ0xxArray;

  public
    { Public declarations }
    procedure initStrGrid;
    //������ ������Ʈ �������
    procedure disableComponents;
    //����Ϸ� �� ������Ʈ ��� �����ϰ�
    procedure enableComponents;

  end;

var
  frm_LOSTB520L: Tfrm_LOSTB520L;

implementation
{$R *.DFM}

procedure Tfrm_LOSTB520L.setEdtKeyPress;
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

procedure Tfrm_LOSTB520L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTB520L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTB520L.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_id_cd.Enabled := True;
  btn_query.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB520L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 11;

		Cells[0,0] :='����ڸ�';
		Cells[1,0] :='���ڵ�';
		Cells[2,0] :='�𵨸�';
		Cells[3,0] :='�ܸ����Ϸù�ȣ';
		Cells[4,0] :='�������ֹι�ȣ';
		Cells[5,0] :='�����ڸ�';
		Cells[6,0] :='�����ȣ';
		Cells[7,0] :='�ּ�';
		Cells[8,0] :='��ȭ��ȣ';
		Cells[9,0] :='�԰�����';
		Cells[10,0] :='��ǰ��';
    end;
end;

procedure Tfrm_LOSTB520L.FormCreate(Sender: TObject);
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
  {    }
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�������α׷����� ���� �ϼ���');
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
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', '�Ҹ�ܸ���',cmb_id_cd);
  initStrGrid;

   //�����ͽ��ٿ� ����� ������ �����ش�.
   sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB520L.btn_CloseClick(Sender: TObject);
begin
     self.close;
end;

procedure Tfrm_LOSTB520L.dte_FromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

procedure Tfrm_LOSTB520L.dte_ToExit(Sender: TObject);
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

//'���' ��ư Ŭ��
procedure Tfrm_LOSTB520L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;
    juno:String;	//�ֹι�ȣ

    RowPos:Integer;
	STR004 : String;
	STR005 : String;

    Label LIQUIDATION;
    Label INQUIRY;

begin

   //�׸����ʱ�ȭ
   pInitStrGrd(Self);

	 //�׸��� ���÷���
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ
    STR004 :=' ';
    STR005 :=' ';

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
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB520L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTB520L') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;

    //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    ShowMessage('����� �ڷᰡ �����ϴ�.');
    goto LIQUIDATION;
  end;    

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := TMAX.RecvString('STR102',i);	//����ڸ�
        	Cells[1,RowPos] := TMAX.RecvString('STR103',i);	//���ڵ�
        	Cells[2,RowPos] := TMAX.RecvString('STR104',i); //�𵨸�
        	Cells[3,RowPos] := TMAX.RecvString('STR105',i);	//�ܸ����Ϸù�ȣ

            juno := Trim(TMAX.RecvString('STR106',i));	 	//�������ֹι�ȣ
            juno := getFrontName(juno,'-') + '-*******';
        	Cells[4,RowPos] := juno;
			STR004 := Trim(TMAX.RecvString('STR106',i));

        	Cells[5,RowPos] := TMAX.RecvString('STR107',i);	//�����ڸ�
        	Cells[6,RowPos] := TMAX.RecvString('STR108',i);	//�����ȣ
            STR005 :=  Trim(TMAX.RecvString('STR108',i));

        	Cells[7,RowPos] := TMAX.RecvString('STR109',i);	//�ּ�
        	Cells[8,RowPos] := TMAX.RecvString('STR110',i);	//��ȭ��ȣ
        	Cells[9,RowPos] := TMAX.RecvString('STR111',i);	//�԰�����
        	Cells[10,RowPos] := TMAX.RecvString('STR112',i);	//�ű�


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

    //������ ���
    grd_display.RowCount := grd_display.RowCount -1;
    
  qryStr:= TMAX.RecvString('INF014',0);
	Proc_gridtoexcel('��°���(LOSTB520L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB520L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    enableComponents;
end;

procedure Tfrm_LOSTB520L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTB520L.btn_ResetClick(Sender: TObject);
begin
  changeBtn(Self);

	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex:=0;

	
	dte_from.SetFocus;
end;

procedure Tfrm_LOSTB520L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB520Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
