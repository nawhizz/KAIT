{*---------------------------------------------------------------------------
���α׷�ID    : LOSTC220Q (��ü������ �������� ��ȸ)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 26
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

unit u_LOSTC220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit, ComObj;

const
  TITLE   = '��ü������ �������� ��ȸ';
  PGM_ID  = 'LOSTC220Q';

type
  Tfrm_LOSTC220Q = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label2: TLabel;
    dte_from_01: TDateEdit;
    dte_to_01: TDateEdit;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    CalendarMonth1: TCalendarMonth;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    Label1: TLabel;
    Bevel3: TBevel;
    dte_from_02: TDateEdit;
    Label5: TLabel;
    dte_to_02: TDateEdit;
    Label4: TLabel;
    btn_Link: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_reset: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure CalendarMonth1Change(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure CalendarMonth1KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    qryStr:String;
    procedure SetDate;
    procedure initStrGrid;
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTC220Q: Tfrm_LOSTC220Q;

implementation

{$R *.dfm}


procedure Tfrm_LOSTC220Q.SetDate;
var
  FT_DT_01 : String;
  TO_DT_01 : String;
  FT_DT_02 : String;
  TO_DT_02 : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin

  FT_DT_01 := '';
  TO_DT_01 := '';
  FT_DT_02 := '';
  TO_DT_02 := '';

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
	if (TMAX.SendString('INF003','LOSTC220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTC220Q') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    goto LIQUIDATION;
  end;

    FT_DT_01 := TMAX.RecvString('STR101',0);  //�μ���������������
    TO_DT_01 := TMAX.RecvString('STR102',0);  //�μ���������������
    FT_DT_02 := TMAX.RecvString('STR103',0);  //�ڵ���������������
    TO_DT_02 := TMAX.RecvString('STR104',0);  //�ڵ���������������

    sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';


LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

    grd_display.Cursor := crDefault;	//�۾��Ϸ�

    dte_from_01.Text := InsHyphen(Trim(FT_DT_01));
    dte_to_01.text   := InsHyphen(Trim(TO_DT_01));
    dte_from_02.Text := InsHyphen(Trim(FT_DT_02));
    dte_to_02.text   := InsHyphen(Trim(TO_DT_02));
end;

procedure Tfrm_LOSTC220Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTC220Q.enableComponents;
begin
  changeBtn(Self);

  CalendarMonth1.Enabled := True;
	dte_from_01.Enabled := True;
  dte_to_01.Enabled := True;
	dte_from_02.Enabled := True;
  dte_to_02.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTC220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTC220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 11;
    	RowHeights[0] := 21;


    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='�Ѱ����ڵ�';

    	ColWidths[2] := 150;
		Cells[2,0] :='�Ѱ�����';

      ColWidths[3] := 200;
		Cells[3,0] :='��������';

      ColWidths[4] := 80;
		Cells[4,0] :='����Ǽ�';

      ColWidths[5] := 100;
		Cells[5,0] :='����ݾ�';

      ColWidths[6] := 80;
		Cells[6,0] :='���Ǽ�';

      ColWidths[7] := 100;
		Cells[7,0] :='���ݾ�';

      ColWidths[8] := 80;
		Cells[8,0] :='��ϰǼ�';

      ColWidths[9] := 100;
		Cells[9,0] :='��ϱݾ�';

      ColWidths[10] := 160;
		Cells[10,0] :='�ݾ��հ�';

    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}

procedure Tfrm_LOSTC220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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


{-----------------------------------------------------------------------------}

procedure Tfrm_LOSTC220Q.FormCreate(Sender: TObject);
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
	//common_username:= '��ȣ��';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.

  initStrGrid;	//�׸��� �ʱ�ȭ

	qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;



procedure Tfrm_LOSTC220Q.FormShow(Sender: TObject);
begin
 btn_resetClick(Sender);
end;

procedure Tfrm_LOSTC220Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTC220Q.CalendarMonth1Change(Sender: TObject);
begin
  SetDate;
end;

procedure Tfrm_LOSTC220Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC220Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTC220Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('��ü������ �������� ��ȸ(LOSTC220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC220Q');
end;

procedure Tfrm_LOSTC220Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
    grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];
    if (ARow =0) then begin
    	grid.Canvas.Brush.Color := clBtnFace;
        grid.Canvas.Font.Color := clBlack;
    	grid.Canvas.FillRect(Rect);
    	DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
    end
    else
    // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
    begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4..10: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

    end;
  end;
{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

procedure Tfrm_LOSTC220Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_display.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_display.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

procedure Tfrm_LOSTC220Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
 	//�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //ũ���� �ʱ�ȭ
    pInitStrGrd(Self);

    //���۽ú��� �ʱ�ȭ

    totalCount :=0;
    qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.
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
  goto INQUIRY;

INQUIRY:
	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostC220Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_from_01.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', delHyphen(dte_to_01.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', delHyphen(dte_from_02.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(dte_to_02.Text)) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTC220Q') then
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


    totalCount := totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[ 0,RowPos] := IntToStr(seq);
          Cells[ 1,RowPos] := TMAX.RecvString('STR101',i); //�Ѱ����ڵ�
          Cells[ 2,RowPos] := TMAX.RecvString('STR102',i); //�Ѱ�����
          Cells[ 3,RowPos] := TMAX.RecvString('STR103',i); //��������
          Cells[ 4,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); //����Ǽ�
          Cells[ 5,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); //����ݾ�
          Cells[ 6,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); //���Ǽ�
          Cells[ 7,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); //���ݾ�
          Cells[ 8,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); //��ϰǼ�
          Cells[ 9,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT109',i))); //��ϱݾ�
          Cells[10,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT110',i))); //��ϱݾ�

          Inc(seq);
          Inc(RowPos);
        end;
    end;
   //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

    //'����'��ư�� Ŭ�� ���� �� ������ ��Ʈ��
    qryStr:= TMAX.RecvString('INF014',0);

//���������°�
LIQUIDATION:

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  if totalCount > 0 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;

end;

procedure Tfrm_LOSTC220Q.btn_resetClick(Sender: TObject);
var
  i : Integer;
begin
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Print.Enabled := False;
  btn_Link.Enabled := False;
  dte_from_01.Enabled := False;
  dte_to_01.Enabled := False;
  dte_from_02.Enabled := False;
  dte_from_02.Enabled := False;
  dte_to_02.Enabled := False;

  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
  SetDate;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := '';

  changeBtn(Self);

end;

procedure Tfrm_LOSTC220Q.CalendarMonth1KeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;  
end;

end.
