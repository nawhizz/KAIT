{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA870Q (�������� ó������ ��Ȳ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2013.10.29
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

unit u_LOSTA870Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  common_lib, WinSkinData, so_tmax,Func_Lib, monthEdit, ComObj;

const
  TITLE   = '�������� ó������ ��Ȳ';
  PGM_ID  = 'LOSTA870Q';

type
  Tfrm_LOSTA870Q = class(TForm)
    pnl_Command:      TPanel;
    sts_Message:      TStatusBar;
    Panel2:           TPanel;
    Bevel2:           TBevel;
    Label2:           TLabel;
    Bevel1:           TBevel;
    pnl_Program_Name: TLabel;
    SkinData1:        TSkinData;
    TMAX:             TTMAX;
    grd_display: TStringGrid;
    Mon_basic: TCalendarMonth;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);


    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTA870Q: Tfrm_LOSTA870Q;


implementation

{$R *.DFM}

procedure Tfrm_LOSTA870Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA870Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA870Q.initStrGrid;
var
  j : Integer;
begin
	with grd_display do begin
    j := 0;
    RowCount := 2;
    ColCount := 11;
    RowHeights[0] := 21;

    cells[fInc(j),0] := '�������û������̵�';
    cells[fInc(j),0] := '�������û��';
    cells[fInc(j),0] := '������������̵�';
    cells[fInc(j),0] := '��������';
    cells[fInc(j),0] := '����Ǽ�';
    cells[fInc(j),0] := '�԰�Ǽ�';
    cells[fInc(j),0] := '����߰Ǽ�';
    cells[fInc(j),0] := '����Ȯ�ΰǼ�';
    cells[fInc(j),0] := '���Ǽ�';
    cells[fInc(j),0] := '�����ͼӰǼ�';
    cells[fInc(j),0] := '�հ�';

    j := 0;

    colwidths[fInc(j)] :=  -1;   // �������û������̵�
    colwidths[fInc(j)] := 160;   // �������û��
    colwidths[fInc(j)] :=  -1;   // ������������̵�
    colwidths[fInc(j)] := 160;   // ��������
    colwidths[fInc(j)] := 100;   // ����Ǽ�
    colwidths[fInc(j)] := 100;   // �԰�Ǽ�
    colwidths[fInc(j)] := 100;   // ����߰Ǽ�
    colwidths[fInc(j)] := 100;   // ����Ȯ�ΰǼ�
    colwidths[fInc(j)] := 100;   // ���Ǽ�
    colwidths[fInc(j)] := 100;   // �����ͼӰǼ�
    colwidths[fInc(j)] := 100;   // �հ�

  end;

end;

procedure Tfrm_LOSTA870Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;


procedure Tfrm_LOSTA870Q.FormCreate(Sender: TObject);
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

  //��Ų �ʱ�ȭ
  initSkinForm(SkinData1);      // common_lib.pas�� �ִ�.

  // �׸��� �ʱ�ȭ
  initStrGrid;

  qryStr := '';

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA870Q.btn_InquiryClick(Sender: TObject);
var
    i,j,count1: Integer;

    Label LIQUIDATION;

begin

    //ũ���� �ʱ�ȭ
    pInitStrGrd(Self);

    grd_display.RowCount := 2;

    grd_display.Cursor := crSQLWait;	//�۾���....

    disableComponents;	//�۾��� �ٸ� ��� ��� ����.

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

	  TMAX.InitBuffer;

    //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTA870Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(Mon_basic.Text)) < 0) then  goto LIQUIDATION;

    // ����� ������ ���� �Ϸ�

    //���� ȣ��
    if not TMAX.Call('LOSTA870Q') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
    end;

    count1 := TMAX.RecvInteger('INF013',0);

    if count1 < 1 then begin
      for i := grd_display.fixedrows to grd_display.rowcount - 1 do
      grd_display.rows[i].Clear;
      grd_display.RowCount := 3;
      sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
      goto LIQUIDATION;
    end;

    qryStr:= TMAX.RecvString('INF014',0);


    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INF013',0);

    with grd_display do begin
        for i:=0 to TMAX.RecvInteger('INF013',0) -1 do
        begin
          if i <> TMAX.RecvInteger('INF013',0) -1 then
          //Cells[ 0,i+1]   := IntToStr(i + 1);

          Cells[ 0,i+1]   :=                   TMAX.RecvString('STR101',i);   // ������̵�(����û)
          Cells[ 1,i+1]   :=                   TMAX.RecvString('STR102',i);   // �������û��
          Cells[ 2,i+1]   :=                   TMAX.RecvString('STR103',i);   // ������̵�(������)
          Cells[ 3,i+1]   :=                   TMAX.RecvString('STR104',i);   // ��������
          Cells[ 4,i+1]   := convertWithCommer(TMAX.RecvString('INT105',i));  // ����Ǽ�
          Cells[ 5,i+1]   := convertWithCommer(TMAX.RecvString('INT106',i));  // �԰�Ǽ�
          Cells[ 6,i+1]   := convertWithCommer(TMAX.RecvString('INT107',i));  // ����߰Ǽ�
          Cells[ 7,i+1]   := convertWithCommer(TMAX.RecvString('INT108',i));  // ����Ȯ�ΰǼ�
          Cells[ 8,i+1]   := convertWithCommer(TMAX.RecvString('INT109',i));  // ���Ǽ�
          Cells[ 9,i+1]   := convertWithCommer(TMAX.RecvString('INT110',i));  // �����ͼӰǼ�
          Cells[10,i+1]   := convertWithCommer(TMAX.RecvString('INT111',i));  // �հ�

        end;
    end;

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + IntToStr(TMAX.RecvInteger('INF013',0) -1) + '���� ��ȸ �Ǿ����ϴ�.';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

{*******************************************************************************
* procedure Name : disableComponents
* �� �� �� �� :��ư�� ������ ���ϰ� �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA870Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : enableComponents
* �� �� �� �� :��ư�� ���� �ٸ� ����� �� �� �ְ��Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA870Q.enableComponents;
begin
  changeBtn(Self);

  Mon_basic.Enabled := True;


  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTA870Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];
  if (ARow = 0) then begin
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.Font.Color := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
    // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
    begin
    case ACol of
      0..3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      else  StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
    end;
  end;

end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTA870Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var
  LeftPos: Integer;
  TopPos : integer;
  CellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    CellStr := TStringGrid(Sender).Cells[ACol, ARow];
    TopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(CellStr)) div 2) + Rect.Bottom;
    case i_align of
      1 :  LeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) div 2) + Rect.Left;
      2 :  LeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) +
                        Rect.Left - 5;  
      else LeftPos := Rect.Left + 5;
    end;
    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;

procedure Tfrm_LOSTA870Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel('�������� ó������ ��Ȳ(LOSTA870Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB270Q');
end;

procedure Tfrm_LOSTA870Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  Mon_basic.Text := Copy(delHyphen(DateToStr(Date)),0,6);

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;  


end;

procedure Tfrm_LOSTA870Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA870Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA870Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

end.
