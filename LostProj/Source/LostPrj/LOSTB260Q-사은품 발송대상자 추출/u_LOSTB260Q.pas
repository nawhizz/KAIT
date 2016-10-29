{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB260Q (����ǰ �߼۴���� ����)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011.09.29
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

unit u_LOSTB260Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  common_lib, WinSkinData, so_tmax,Func_Lib, Menus,Clipbrd, ComObj;

const
  TITLE   = '����ǰ�߼۴��������';
  PGM_ID  = 'LOSTB260Q';

type
  Tfrm_LOSTB260Q = class(TForm)
    pnl_Command:      TPanel;
    sts_Message:      TStatusBar;
    Panel2:           TPanel;
    Bevel2:           TBevel;
    Label2:           TLabel;
    Bevel1:           TBevel;
    pnl_Program_Name: TLabel;
    dte_to:           TDateEdit;
    Label1:           TLabel;
    dte_from:         TDateEdit;
    SkinData1:        TSkinData;
    TMAX:             TTMAX;
    grd_display:      TStringGrid;
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
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;

    procedure btn_CloseClick    (Sender: TObject);
    procedure FormCreate        (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure dte_fromExit      (Sender: TObject);
    procedure dte_toExit        (Sender: TObject);

    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click(Sender: TObject);

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
  frm_LOSTB260Q: Tfrm_LOSTB260Q;


implementation

{$R *.DFM}

procedure Tfrm_LOSTB260Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB260Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.initStrGrid;
var
  j : Integer;
begin
	with grd_display do begin
    j := 0;
    RowCount := 2;
    ColCount := 15;
    RowHeights[0] := 21;

    cells[fInc(j),0] := '����';
    cells[fInc(j),0] := '�����ڹ�ȣ';
    cells[fInc(j),0] := '�����ڸ�';
    cells[fInc(j),0] := '�����ȣ';
    cells[fInc(j),0] := '�ּ�';
    cells[fInc(j),0] := '��ȭ��ȣ';
    cells[fInc(j),0] := '�԰���';
    cells[fInc(j),0] := '��ǰ��1';
    cells[fInc(j),0] := '��ǰ��2';
    cells[fInc(j),0] := '����ϻ�ǰ��1';
    cells[fInc(j),0] := '��Ȱ��ǰ2';
    cells[fInc(j),0] := '����ϻ�ǰ��2';
    cells[fInc(j),0] := '��ü';
    cells[fInc(j),0] := '�ݾ�';
    cells[fInc(j),0] := '��ü����������';

    j := 0;

    colwidths[fInc(j)] :=  60;   //����
    colwidths[fInc(j)] := 100;   //�����ڹ�ȣ
    colwidths[fInc(j)] := 140;   //�����ڸ�
    colwidths[fInc(j)] :=  80;   //�����ȣ
    colwidths[fInc(j)] := 240;   //�ּ�
    colwidths[fInc(j)] := 120;   //��ȭ��ȣ
    colwidths[fInc(j)] := 100;   //�԰���
    colwidths[fInc(j)] :=  80;   //��ǰ��1
    colwidths[fInc(j)] :=  80;   //��ǰ��2
    colwidths[fInc(j)] := 120;   //����ϻ�ǰ��1
    colwidths[fInc(j)] := 0;   //��Ȱ��ǰ2
    colwidths[fInc(j)] := 120;   //����ϻ�ǰ��2
    colwidths[fInc(j)] := 100;   //��ü
    colwidths[fInc(j)] := 120;   //�ݾ�
    colwidths[fInc(j)] := 100;    //��ü����������
  end;

end;

procedure Tfrm_LOSTB260Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB260Q.FormCreate(Sender: TObject);
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

  // ���뺯�� ���� common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  // �׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  // �ӽ÷� �α��� ������ ����
  // common_userid     := '0294';    //ParamStr(2);
  // common_username   := '��ȣ��';  //ParamStr(3);
  // common_usergroup  := 'KAIT';    //ParamStr(4);

  //��Ų �ʱ�ȭ
  initSkinForm(SkinData1);      // common_lib.pas�� �ִ�.

  // �׸��� �ʱ�ȭ
  initStrGrid;

  qryStr := '';
  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB260Q.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno, seed_mtno : String;

    i,j,count1: Integer;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

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

//SEED KEY ��ȸ
SEEDKEY:

  //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //���� ȣ��
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ

//������ȸ
INQUIRY:
	  TMAX.InitBuffer;

    //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LostB260Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;

    // ����� ������ ���� �Ϸ�

    //���� ȣ��
    if not TMAX.Call('LOSTB260Q') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
    end;
    // ���� ���
    qryStr:= TMAX.RecvString('INF014',0);

    // ��ȸ����
    count1 := TMAX.RecvInteger('INF013',0);    

    if count1 < 1 then begin
      for i := grd_display.fixedrows to grd_display.rowcount - 1 do
      grd_display.rows[i].Clear;
      grd_display.RowCount := 3;
      sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
      goto LIQUIDATION;
    end;

    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INF013',0);

    with grd_display do begin
        for i:=0 to TMAX.RecvInteger('INF013',0) -1 do
        begin
          if i <> TMAX.RecvInteger('INF013',0) -1 then  Cells[ 0,i+1]   := IntToStr(i + 1);

          seed_idno       :=                   TMAX.RecvString('STR101',i);   // �����ڹ�ȣ
          Cells[ 1,i+1]   :=                   ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
          seed_name       :=                   TMAX.RecvString('STR102',i);   // �����ڸ�
          Cells[ 2,i+1]   :=                   ECPlazaSeed.Decrypt(seed_name, common_seedkey);
          Cells[ 3,i+1]   :=                   TMAX.RecvString('STR103',i);   // �����ȣ
          Cells[ 4,i+1]   := TMAX.RecvString('STR104',i) + TMAX.RecvString('STR105',i);   // �ּ�
          seed_tlno       :=                   TMAX.RecvString('STR106',i);   // ��ȭ��ȣ
          Cells[ 5,i+1]   := InsHyphen(ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
          Cells[ 6,i+1]   := InsHyphen(        TMAX.RecvString('STR107',i));  // �԰�����
          Cells[ 7,i+1]   := convertWithCommer(TMAX.RecvString('INT108',i));  // ��ǰ��1
          Cells[ 8,i+1]   := convertWithCommer(TMAX.RecvString('INT109',i));  // ��ǰ��2
          Cells[ 9,i+1]   := convertWithCommer(TMAX.RecvString('INT110',i));  // ����ϻ�ǰ��1
          Cells[10,i+1]   := convertWithCommer(TMAX.RecvString('INT111',i));  // ��Ȱ��ǰ2
          Cells[11,i+1]   := convertWithCommer(TMAX.RecvString('INT112',i));  // ����ϻ�ǰ��2
          Cells[12,i+1]   := convertWithCommer(TMAX.RecvString('INT113',i));  // ��ǰ�հ�
          Cells[13,i+1]   := convertWithCommer(TMAX.RecvString('INT114',i));  // ��ǰ�ݾ��հ�
          Cells[14,i+1]   := TMAX.RecvString('STR115',i);  // ��ü����������
        end;
    end;

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + IntToStr(TMAX.RecvInteger('INF013',0)) + '���� ��ȸ �Ǿ����ϴ�.';

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
* procedure Name : dte_fromExit
* �� �� �� �� : ��¥�Է� �� �Էµ� ��¥���� ��ȿ���� �����ϰ� �޼����� �����.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.dte_fromExit(Sender: TObject);
begin
 sts_Message.Panels[1].Text := '';

 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
     exit;
 end;

end;

{*******************************************************************************
* procedure Name : dte_toExit
* �� �� �� �� : ��¥�Է� �� �Էµ� ��¥���� ��ȿ���� �����ϰ� �޼����� �����.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.dte_toExit(Sender: TObject);
begin
 sts_Message.Panels[1].Text := '';
 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('�������ڴ� �������ں��� �۰� ������ �� �����ϴ�.');
     exit;
 end;

 if Trunc(dte_to.Date) > Trunc(date) then
 begin
     showmessage('�������ڴ� �������� ���ķ� ������ �� �����ϴ�.');
     exit;
 end;

end;

{*******************************************************************************
* procedure Name : disableComponents
* �� �� �� �� :��ư�� ������ ���ϰ� �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.disableComponents;
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
procedure Tfrm_LOSTB260Q.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTB260Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      2,4,5   : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,1,3,6,14 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);

      else      StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
    end;
  end;

end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB260Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel('����ǰ �߼۴���� ����(LOSTB260Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB260Q');
end;

procedure Tfrm_LOSTB260Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  //��ư�̹��� �ʱ�ȭ
  changeBtn(Self);

  // ��¥ �ʵ� ����
  dte_from.Date := date-30;
  dte_to.Date   := date;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;  

end;

procedure Tfrm_LOSTB260Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTB260Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB260Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTB260Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB260Q.Copy1Click(Sender: TObject);
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

end.
