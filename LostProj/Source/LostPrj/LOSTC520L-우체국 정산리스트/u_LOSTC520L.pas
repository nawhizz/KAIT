{*---------------------------------------------------------------------------
���α׷�ID    : LOSTC520L (��ü��������Ȳ Excel)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 10. 04
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
unit u_LOSTC520L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit, ComObj;

const
  TITLE   = '��ü�����긮��Ʈ(EXCEL)';
  PGM_ID  = 'LOSTC520L';

type
  Tfrm_LOSTC520L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel; 
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label2: TLabel;
    cmb_pl_cd: TComboBox;
    cmb_inq_gu: TComboBox;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    CalendarMonth1: TCalendarMonth;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure cmb_inq_guChange(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    cmb_pl_cd_d: TZ0xxArray;
    qryStr:String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTC520L: Tfrm_LOSTC520L;

implementation
uses   u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTC520L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC520L.enableComponents;
begin
  changeBtn(Self);

	CalendarMonth1.Enabled := True;
  cmb_inq_gu.Enabled := True;
  cmb_pl_cd.Enabled := True;

  if cmb_inq_gu.ItemIndex = 0 then begin
  cmb_pl_cd.Enabled := False;
  end else begin
  cmb_pl_cd.Enabled := True;
  end;
  
  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC520L.setEdtKeyPress;
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

procedure Tfrm_LOSTC520L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTC520L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 20;

  Cells[0,0]  :='SEQ';
  Cells[1,0]  :='ü��û��ȣ';
  Cells[2,0]  :='ü��ûû��';
  Cells[3,0]  :='�Ѱ�����ȣ';
  Cells[4,0]  :='�Ѱ���û��';
  Cells[5,0]  :='���¹�ȣ';
  Cells[6,0]  :='���ͳݵ�ϰǼ�';
  Cells[7,0]  :='���ͳݵ�ϼ��ݾ�';
  Cells[8,0]  :='��ü�����Ǽ�';
  Cells[9,0]  :='��ü�����ݾ�';
  Cells[10,0]  :='����Ǽ�';
  Cells[11,0]  :='���������';
  Cells[12,0]  :='�μ��������Ǽ�';
  Cells[13,0] :='�μ��������ݾ�';
  Cells[14,0] :='�ڵ��������Ǽ�';
  Cells[15,0] :='�ڵ��������ݾ�';
  Cells[16,0] :='��Ÿ�����Ǽ�';
  Cells[17,0] :='��Ÿ�����ݾ�';
  Cells[18,0] :='�Ǽ��հ�';
  Cells[19,0] :='�ݾ��հ�';
    end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTC520L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTC520L.FormCreate(Sender: TObject);
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

  initStrGrid;
	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.
  initComboBoxWithZ0xx('Z050.dat', cmb_pl_cd_d, '��ü', '',cmb_pl_cd);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC520L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTC520L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    seq,count1, count2, totalCount:Integer;

    RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

   //�׸����ʱ�ȭ
   pInitStrGrd(Self);

	//�׸��� ���÷���
  seq := 1;
  RowPos:= 1;	//�׸��� ���ڵ� ������
  grd_display.RowCount := 2;

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
	if (TMAX.SendString('INF003','LOSTC520L') < 0) then  goto LIQUIDATION;

  if cmb_inq_gu.ItemIndex = 0 then begin
  	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
  end else begin
  	if (TMAX.SendString('INF001','P02') < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
	  if (TMAX.SendString('STR002', cmb_pl_cd_d[cmb_pl_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
  end;

  //���� ȣ��
  if not TMAX.Call('LOSTC520L') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;

  //������ ��´�.
  qryStr:= TMAX.RecvString('INF014',0);


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
            Cells[0,RowPos]  := IntToStr(seq);
            Cells[1,RowPos]  := TMAX.RecvString('STR118',i);  // ü��û��ȣ
            Cells[2,RowPos]  := TMAX.RecvString('STR119',i);  // ü��û��
            Cells[3,RowPos]  := TMAX.RecvString('STR101',i);  // �Ѱ�����ȣ
            Cells[4,RowPos]  := TMAX.RecvString('STR102',i);  // �Ѱ���û��
            Cells[5,RowPos]  := TMAX.RecvString('STR103',i);  // ���¹�ȣ
            Cells[6,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i)));    // ���ͳݵ�ϰǼ�
            Cells[7,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL105',i)));   // ���ͳݵ�ϼ�����
            Cells[8,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i)));    // ��ü�����Ǽ�
            Cells[9,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL107',i)));   // ��ü����������
            Cells[10,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i)));    // ����Ǽ�
            Cells[11,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL109',i)));   // ���������
            Cells[12,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT110',i)));    // �μ��������Ǽ�
            Cells[13,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL111',i)));   // �μ��������ݾ�
            Cells[14,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT112',i)));    // �ڵ��������Ǽ�
            Cells[15,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL113',i)));   // �ڵ��������ݾ�
            Cells[16,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT114',i)));    // ��Ÿ�����Ǽ�
            Cells[17,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL115',i)));   // ��Ÿ�����ݾ�
            Cells[18,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT116',i)));    // �Ǽ��հ�
            Cells[19,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL117',i)));   // �ݾ��հ�

          Inc(seq);
          Inc(RowPos);
        end;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

    //����Ʈ�� ������ ���� ��


    //������ ���
	Proc_gridtoexcel('��ü��������Ȳ(EXCEL)(LOSTC520L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC520L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;

procedure Tfrm_LOSTC520L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC520L_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTC520L.cmb_inq_guChange(Sender: TObject);
begin
 if cmb_inq_gu.ItemIndex = 0 then begin
  cmb_pl_cd.Enabled := False;
 end else begin
  cmb_pl_cd.Enabled := True;
 end;
end;

procedure Tfrm_LOSTC520L.btn_ResetClick(Sender: TObject);
begin
  CalendarMonth1.SetFocus;
  cmb_inq_gu.ItemIndex := 1;
  cmb_pl_cd.Enabled := False;
  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
  changeBtn(Self);
  cmb_inq_guChange(Sender);
end;

end.
