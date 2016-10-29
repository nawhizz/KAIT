{*---------------------------------------------------------------------------
���α׷�ID    :  LOSTA550(�����ڷ���º����(EXCEL))
���α׷� ���� : Online
�ۼ���	      : ��ȫ��
�ۼ���	      : 2011. 08. 24
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
unit u_LOSTA550L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '�����ڷ���º����(EXCEL)';
  PGM_ID  = 'LOSTA550L';

type
  Tfrm_LOSTA550L = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    Label3: TLabel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    GroupBox: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    cmb_id_cd_d: TZ0xxArray;
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
    procedure CheckValue;
  end;

var
  frm_LOSTA550L: Tfrm_LOSTA550L;

  checked1:String;
  checked2:String;
  checked3:String;
  checked4:String;
  checked5:String;
  checked6:String;
  checked7:String;
  checked8:String;
  checked9:String;
  checked10:String;
  checked11:String;

implementation
{$R *.DFM}
procedure Tfrm_LOSTA550L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA550L.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  btn_Print.Enabled := True;
  cmb_id_cd.Enabled := True;
  btn_query.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA550L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 16;

		Cells[0,0]  :='������ڵ�';
		Cells[1,0]  :='â���ȣ';
		Cells[2,0]  :='�𵨸�';
		Cells[3,0]  :='�ø���';
		Cells[4,0]  :='�԰�����';
		Cells[5,0]  :='�ܸ��ⱸ��';
		Cells[6,0]  :='�ܸ������';
		Cells[7,0]  :='�н��ڸ�';
		Cells[8,0]  :='�н����ֹι�ȣ';
 		Cells[9,0]  :='�����ȣ';
    Cells[10,0] :='�ּ�';
    Cells[11,0] :='����ڸ�';
    Cells[12,0] :='��ȭ��ȣ';
    Cells[13,0] :='�н��ڵ�����ȣ';
    Cells[14,0] :='��������ȭ��ȣ ';
    Cells[15,0] :='����';

    end;
end;


procedure Tfrm_LOSTA550L.CheckValue;
begin


  checked1   := ' ';
  checked2   := ' ';
  checked3   := ' ';
  checked4   := ' ';
  checked5   := ' ';
  checked6   := ' ';
  checked7   := ' ';
  checked8   := ' ';
  checked9   := ' ';
  checked10  := ' ';
  checked11  := ' ';

  if CheckBox1.Checked = true then begin
     checked1 := 'Y';
  end else begin
     checked1 := 'N';
  end;

  if CheckBox2.Checked = true then begin
     checked2 := 'Y';
  end else begin
     checked2 := 'N';
  end;

  if CheckBox3.Checked = true then begin
     checked3 := 'Y';
  end else begin
     checked3 := 'N';
  end;

  if CheckBox4.Checked = true then begin
     checked4 := 'Y';
  end else begin
     checked4 := 'N';
  end;

  if CheckBox5.Checked = true then begin
     checked5 := 'Y';
  end else begin
     checked5 := 'N';
  end;

  if CheckBox6.Checked = true then begin
     checked6 := 'Y';
  end else begin
     checked6 := 'N';
  end;

  if CheckBox7.Checked = true then begin
     checked7 := 'Y';
  end else begin
     checked7 := 'N';
  end;

  if CheckBox8.Checked = true then begin
     checked8 := 'Y';
  end else begin
     checked8 := 'N';
  end;

  if CheckBox9.Checked = true then begin
     checked9 := 'Y';
  end else begin
     checked9 := 'N';
  end;

  if CheckBox10.Checked = true then begin
     checked10 := 'Y';
  end else begin
     checked10 := 'N';
  end;

  if CheckBox11.Checked = true then begin
     checked11 := 'Y';
  end else begin
     checked11 := 'N';
  end;

end;

procedure Tfrm_LOSTA550L.setEdtKeyPress;
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

procedure Tfrm_LOSTA550L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA550L.FormCreate(Sender: TObject);
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
    {       }
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

  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', ' ',cmb_id_cd);
  btn_ResetClick(Sender);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA550L.btn_CloseClick(Sender: TObject);
begin
     close;

end;

procedure Tfrm_LOSTA550L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

procedure Tfrm_LOSTA550L.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA550L.FormShow(Sender: TObject);
begin
  //dte_from.SetFocus;
  cmb_id_cd.ItemIndex := 0;
  CheckBox1.Checked := true;
end;

procedure Tfrm_LOSTA550L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;

	STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;


  Label LIQUIDATION;
  Label INQUIRY;
begin
    pInitStrGrd(Self);
    CheckValue;

	//�׸��� ���÷���
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ

    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';


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
	if (TMAX.SendString('INF003','LOSTA550L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR004', checked1) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', checked2) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR006', checked3) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', checked4) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', checked5) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR009', checked6) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR010', checked7) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR011', checked8) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR012', checked9) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR013', checked10) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR014', checked11) < 0) then  goto LIQUIDATION;


  if (TMAX.SendString('STR015', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR016', STR005) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR017', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR018', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR019', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR020', delHyphen(STR009)) < 0) then  goto LIQUIDATION;




  //���� ȣ��
  if not TMAX.Call('LOSTA550L') then
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

  qryStr:= TMAX.RecvString('INF014',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    ShowMessage('����� �ڷᰡ �����ϴ�.');
    goto LIQUIDATION;
  end;    




    with grd_display do begin
    	for i:=0 to count1-1 do begin


        	Cells[0,RowPos]  := TMAX.RecvString('STR101',i);  //������ڵ�
        	Cells[1,RowPos]  := TMAX.RecvString('STR102',i);  //â���ȣ
        	Cells[2,RowPos]  := TMAX.RecvString('STR103',i);  //�𵨸�
        	Cells[3,RowPos]  := TMAX.RecvString('STR104',i);  //�ø���
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i);  //�԰�����
        	Cells[5,RowPos]  := TMAX.RecvString('STR106',i);  //�ܸ��ⱸ��
        	Cells[6,RowPos]  := TMAX.RecvString('STR107',i);  //�ܸ������
        	Cells[7,RowPos]  := TMAX.RecvString('STR108',i);  //�н��ڸ�
        	Cells[8,RowPos]  := TMAX.RecvString('STR109',i);  //�н����ֹι�ȣ
          Cells[9,RowPos]  := TMAX.RecvString('STR110',i);  //�����ȣ
          Cells[10,RowPos] := TMAX.RecvString('STR111',i);  //�ּ�
          Cells[11,RowPos] := TMAX.RecvString('STR112',i);  //����ڸ�
          Cells[12,RowPos] := TMAX.RecvString('STR113',i);  //��ȭ��ȣ
          Cells[13,RowPos] := TMAX.RecvString('STR114',i);  //�н��ڵ�����ȣ
          Cells[14,RowPos] := TMAX.RecvString('STR115',i);  //��������ȭ��ȣ
          Cells[15,RowPos] := TMAX.RecvString('STR116',i);  //����


          STR004 := Trim(TMAX.RecvString('STR101',i)); // ��ȸ���� �������
          STR005 := Trim(TMAX.RecvString('STR108',i)); // ��ȸ���� �н��ڸ�
          STR006 := Trim(TMAX.RecvString('STR102',i)); // ��ȸ���� â���ȣ
          STR007 := Trim(TMAX.RecvString('STR117',i)); // ��ȸ���� ���ڵ�
          STR008 := Trim(TMAX.RecvString('STR104',i)); // ��ȸ���� �Ϸù�ȣ
          STR009 := Trim(TMAX.RecvString('STR105',i)); // ��ȸ���� �԰�����

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
	Proc_gridtoexcel('�н��������Ȯ��LIST(LOSTA550L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA550L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;


procedure Tfrm_LOSTA550L.btn_ResetClick(Sender: TObject);
begin

  cmb_id_cd.ItemIndex := 0;
  CheckBox1.Checked := true;
	dte_from.Date := date-30;
	dte_to.Date := date;
  changeBtn(Self);

  CheckBox1.Checked   := False;
  CheckBox2.Checked   := False;
  CheckBox3.Checked   := False;
  CheckBox4.Checked   := False;
  CheckBox5.Checked   := False;
  CheckBox6.Checked   := False;
  CheckBox7.Checked   := False;
  CheckBox8.Checked   := False;
  CheckBox9.Checked   := False;
  CheckBox10.Checked  := False;
  CheckBox11.Checked  := False;

end;

procedure Tfrm_LOSTA550L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA560_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
