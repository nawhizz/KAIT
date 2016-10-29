{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA230Q (�н��� ��/��� ��Ȳ (�Ϻ�))
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 09. 11
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
unit u_LOSTA230Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  cpakmsg, printers, common_lib, WinSkinData, so_tmax, LOSTA230Q_PRT_HEAD,
  Menus, Clipbrd,Func_Lib, ComObj;

const
  PGM_NM   = '�н��� ��/��� ��Ȳ (�Ϻ�)';
  PGM_ID  = 'LOSTA230Q';

type
  Tfrm_LOSTA230Q = class(TForm)
    Bevel2     : TBevel;
    Bevel1     : TBevel;
    dte_to     : TDateEdit;
    dte_from   : TDateEdit;
    Label2     : TLabel;
    Label1     : TLabel;
    pnl_Program_Name: TLabel;
    Copy1      : TMenuItem;
    PageControl1: TPageControl;
    Panel2     : TPanel;
    pnl_Command: TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    sts_Message: TStatusBar;
    grd_display2: TStringGrid;
    grd_display1: TStringGrid;
    TMAX       : TTMAX;
    TabSheet1  : TTabSheet;
    TabSheet2  : TTabSheet;
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

    procedure btn_CloseClick    (Sender: TObject);
    procedure FormCreate        (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure FormClose         (Sender: TObject; var Action: TCloseAction);
    procedure FormShow          (Sender: TObject);
    procedure btn_PrintClick    (Sender: TObject);
    procedure dte_fromExit      (Sender: TObject);
    procedure dte_toExit        (Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click        (Sender: TObject);

    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure PageControl1Change(Sender: TObject);
    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);

    procedure dte_fromKeyPress(Sender: TObject; var Key: Char);

    procedure dte_toKeyPress(Sender: TObject; var Key: Char);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
    procedure InitComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTA230Q: Tfrm_LOSTA230Q;
  qryStr:String;
  cnt : integer;

Const
     MAXRECCNT = 11;

implementation
uses cpaklibm;
{$R *.DFM}

procedure ButtonInit; forward;

procedure ButtonInit;
begin
//
end;

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.initStrGrid;
begin
	with grd_display1 do begin
    RowCount := 2;
    ColCount := 9;
    RowHeights[0] := 21;

    cells[0,0] := '����';
    cells[1,0] := 'KT';
    cells[2,0] := 'LGU+';
    cells[3,0] := '�Ҹ�PCS';
    cells[4,0] := 'PCS ��';
    cells[5,0] := 'SKT';
    cells[6,0] := '�Ҹ�CELL';
    cells[7,0] := 'CELL��';
    cells[8,0] := '��';

    colwidths[0] := 89;
    colwidths[1] := 85;
    colwidths[2] := 85;
    colwidths[3] := 85;
    colwidths[4] := 85;
    colwidths[5] := 85;
    colwidths[6] := 85;
    colwidths[7] := 85;
    colwidths[8] := 80;
    end;

	with grd_display2 do begin
    RowCount := 2;
    ColCount := 9;
    RowHeights[0] := 21;

    cells[0,0] := '����';
    cells[1,0] := 'KT';
    cells[2,0] := 'LGU+';
    cells[3,0] := '�Ҹ�PCS';
    cells[4,0] := 'PCS ��';
    cells[5,0] := 'SKT';
    cells[6,0] := '�Ҹ�CELL';
    cells[7,0] := 'CELL��';
    cells[8,0] := '��';

    colwidths[0] := 89;
    colwidths[1] := 85;
    colwidths[2] := 85;
    colwidths[3] := 85;
    colwidths[4] := 85;
    colwidths[5] := 85;
    colwidths[6] := 85;
    colwidths[7] := 85;
    colwidths[8] := 80;

    end;
end;

procedure Tfrm_LOSTA230Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA230Q.FormCreate(Sender: TObject);
begin
{  }
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
  // common_userid   := '0294';    //ParamStr(2);
  // common_username := '��ȣ��';  //ParamStr(3);
  // common_usergroup:= 'KAIT';    //ParamStr(4);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}
  setEdtKeyPress;
  Self.Caption := '[' + PGM_ID + ']' + PGM_NM;

  Application.Title := PGM_NM;
  fSetIcon(Application);
  pSetStsWidth(sts_Message);
  pSetTxtSelAll(Self);

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  //��Ų �ʱ�ȭ
  initSkinForm(SkinData1);      // common_lib.pas�� �ִ�.

  // �ʱ�ȭ
  InitComponents;

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA230Q.btn_InquiryClick(Sender: TObject);
var
    tot : Array of Integer;
    i,j,RowPos,count1,count2 : Integer;
    Label LIQUIDATION;
    Label INQUIRY;

begin
    if cnt = 0 then
      pInitStrGrd(grd_display1)
    else
      pInitStrGrd(grd_display2);

    // ����׿� ���� ���� �ʱ�ȭ
    qryStr:= '';
    //grd_display1.RowCount := 2;
    //grd_display2.RowCount := 2;

    RowPos := 1;

    SetLength(tot,grd_display1.ColCount - 1);
    FillChar((@tot[0])^,Length(tot)*sizeof(Integer),0);

    // �� �ε��� �� �۾�

    grd_display1.Cursor := crSQLWait;	//�۾���....
    grd_display2.Cursor := crSQLWait;	//�۾���....

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

INQUIRY:
	TMAX.InitBuffer;

  //�����Է� �κ�
  if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
  if (TMAX.SendString('INF003','LostA230Q')     < 0)  then  goto LIQUIDATION;

  if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;

  if cnt = 1 then begin
    if (TMAX.SendString('STR003', IntToStr(2)) < 0) then  goto LIQUIDATION;
  end else begin
    if (TMAX.SendString('STR003', IntToStr(1)) < 0) then  goto LIQUIDATION;
  end;
  // ����� ������ ���� �Ϸ�

  //���� ȣ��
  if not TMAX.Call('LOSTA230Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
  end;
  ;

  // ��ȸ ��� DISPLAY
  count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    if cnt = 0 then begin
      for i := grd_display1.fixedrows to grd_display1.rowcount - 1 do
        grd_display1.rows[i].Clear;

      grd_display1.RowCount := 2;

    end else
    begin
      for i := grd_display2.fixedrows to grd_display2.rowcount - 1 do
        grd_display2.rows[i].Clear;

      grd_display2.RowCount := 2;

    end;

    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
  end else
  begin

    qryStr:= TMAX.RecvString('INF014',0);

    case cnt of
    0:
      begin
        grd_display1.RowCount := grd_display1.RowCount + count1;

        with grd_display1 do begin
          for i:=0 to count1-1 do
          begin
            Cells[0,RowPos]   := InsHyphen(TMAX.RecvString('STR101',i)); // ����
            Cells[1,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT101',i))); // KT������
            Cells[2,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT102',i))); // LG�ڷ���
            Cells[3,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); // �Ҹ�PCS
            Cells[4,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); // PCS ��
            Cells[5,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); // SK�ڷ���
            Cells[6,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); // �Ҹ��귯
            Cells[7,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); // ���귯��
            Cells[8,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); // ��

            // �Ѱ� ���
            for j:=0 to ColCount - 2 do
                tot[j] := tot[j] + StrToInt(Cells[j+1,RowPos]);

            Inc(RowPos);
          end;

          // �Ѱ� ���
          Cells[0,RowPos]   := '�Ѱ�';

           for j:=0 to ColCount - 2 do
              Cells[j+1,RowPos] := convertWithCommer(IntToStr(tot[j]));
        end;
      end;
    1 :
      begin
        grd_display2.RowCount := grd_display2.RowCount + count1;

        with grd_display2 do begin
          for i:=0 to count1-1 do
          begin
            Cells[0,RowPos]   := InsHyphen(TMAX.RecvString('STR101',i)); // ����
            Cells[1,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT101',i))); // KT������
            Cells[2,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT102',i))); // LG�ڷ���
            Cells[3,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); // �Ҹ�PCS
            Cells[4,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); // PCS ��
            Cells[5,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); // SK�ڷ���
            Cells[6,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); // �Ҹ��귯
            Cells[7,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); // ���귯��
            Cells[8,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); // ��

            // �Ѱ� ���
            for j:=0 to ColCount - 2 do
                tot[j] := tot[j] + StrToInt(Cells[j+1,RowPos]);

            Inc(RowPos);
          end;

          // �Ѱ� ���
          Cells[0,RowPos]   := '�Ѱ�';

           for j:=0 to ColCount - 2 do
              Cells[j+1,RowPos] := convertWithCommer(IntToStr(tot[j]));
        end;
      end;
    end;

  end;

  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + IntToStr(count1) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

  count2 := TMAX.RecvInteger('INT100',0);

  if count1 = count2 then
    goto INQUIRY;

  cnt := cnt +1;


LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if cnt = 1 then
  begin
    btn_InquiryClick(sender);
    exit;
  end;

  grd_display1.Cursor := crDefault;	//�۾��Ϸ�
  grd_display2.Cursor := crDefault;	//�۾��Ϸ�

  cnt := 0;

  enableComponents;
end;

procedure Tfrm_LOSTA230Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    //Capiend;
end;

procedure Tfrm_LOSTA230Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

{*******************************************************************************
* procedure Name : btn_PrintClick
* �� �� �� �� : ��ȸ�� ����� ����Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.btn_PrintClick(Sender: TObject);
var
  head:TLOSTA230Q_PRT_HEAD;	//head ���
  Canvas: TCanvas;
  i, j, page : integer;

  datetime : string;

  curntYposi      :Integer;         //���� y�� ����Ʈ
  prntWidth       :Cardinal;	      //������ ��(297mm)
  prntHeight      :Cardinal;        //������ ����(210mm)
  prntMargin      :Cardinal;        //������, ���� ����(20mm);
  swidth, sheight :Cardinal;	      //���ڿ� ����

  lineStart       :Cardinal;	      //�ٱ߱� ������;
  lineEnd         :Cardinal;
  ygap            :Cardinal;		    //y�� -��

  //������ ���� ���ڿ� ���
  procedure rightPrint( x:Integer; text:String);
  begin
    Canvas.TextOut(x - Canvas.TextWidth(text), curntYposi, text);
  end;

  //��� ���� ���ڿ� ���
  procedure centerPrint(x:Integer; text:String);
  begin
      Canvas.TextOut(x - Canvas.TextWidth(text) div 2, curntYposi, text);
  end;

  //���ڿ��� ���� �߱�
  procedure centerUnderLine(x:Integer; text:String);
  var
    start, eend:Cardinal;
  begin
    start       := x - Canvas.TextWidth(text) div 2;
    eend        := x + Canvas.TextWidth(text) div 2;
    curntYposi  := curntYposi-sheight - 10;
    Canvas.MoveTo(start, curntYposi);
    Canvas.LineTo(eend, curntYposi);

    //������ ���ؼ�...
    Inc(curntYposi, -ygap);  //�����ٷ� �̵�
  end;

  //Ÿ��Ʋ ����Ʈ
  procedure printPGM_NM(page:integer);
  var
    i:Integer;
    start:Cardinal;
  begin
    centerPrint(prntWidth div 2,  	 '�н��� ����� ��Ȳ (�Ϻ�)');
    //��� ���ڿ��� ���� ���� �߱�
    centerUnderLine(prntWidth div 2, '�н��� ����� ��Ȳ (�Ϻ�)');

    Inc(curntYposi, -ygap);
    //Ÿ��Ʋ ���ʿ� �� �߱�
    Canvas.MoveTo(lineStart, curntYposi);
    Canvas.LineTo(lineEnd, curntYposi);

    //Ÿ��Ʋ�� ����Ѵ�.
    Inc(curntYposi, -ygap);

    for i:=0 to 10 do
      rightPrint(head.getRightPosition(i), titles[i]);

    Inc(curntYposi, -sheight);
    Inc(curntYposi, -ygap);
    //Ÿ��Ʋ �Ʒ��ʿ� �� �߱�
    Canvas.MoveTo(lineStart, curntYposi);
    Canvas.LineTo(lineEnd, curntYposi);

    Inc(curntYPosi, -ygap);	//������ �غ�...
  end;

begin
  //������ ĵ�ٽ�...
  Canvas := Printer.Canvas;
  datetime := Formatdatetime('yyyymmdd',date)+'/'+Formatdatetime('hhnnss',time);
  i := 0;
  j := 1;
  page := 1;

  Printer.Orientation := poLandscape;
  //����Ʈ ����
  Printer.BeginDoc;	//�̺κ��� ���� ���� ���������ϸ� �����߻�...

  prntWidth := 2960;	//A4 = 297mm
  prntHeight:= 2090;	//A4 = 210mm
  prntMargin:= 200;	  //left, right margin = 20mm

  //�� ������ �ٲٸ� ���� ���� ����� �ٽ��ؾ� ��.
  SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm ����
  Canvas.Font.Name    := '����ü';
  Canvas.Font.Height  := 32;  // ����ü ���� 4mm
  //Canvas.Font.Style:= [fsBold];

  //��ġ �߿�
  head := TLOSTA230Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //����, ��ü��,...

  sheight     := Canvas.TextHeight('��'); //���ڳ��� ���, 4mm
  ygap        := 18;							        //1mm ��
  curntYposi  := -100;   				          //���ڿ��� ���ų� ������ ������ y-�� ������
  lineStart   := 80 ;	//���߱� x-�� ������
  lineEnd     := head.getRightPosition(10) +20;						//���߱� x-�� ����

  //Ÿ��Ʋ ����Ʈ
  printPGM_NM(page);

  //���� ����Ʈ---������ ���� ���� ����Ʈ
  with grd_display1 do begin
    for j:= 1 to RowCount-1 do begin
      for i:=0 to ColCount-1 do
        rightPrint(head.getRightPosition(i), Cells[i,j]);

      Inc(curntYposi, -sheight);	//������ �̵�
      Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�

      //��¹��� �������� �Ѿ��...
      if -(curntYposi) + prntMargin >= prntHeight then
      begin
        Printer.NewPage;      	//�� ������ �߰�
        Inc(page);   			//������ ��ȣ ī��Ʈ ��
        curntYPosi := -100;     //y��  position�� ���� �����Ѵ�.

        //��Ÿ �ʱ�ȭ �ؾ� �� �׸��� ������ ���⼭...

        printPGM_NM(page);		//Ÿ��Ʋ�� �ٽ� ����Ʈ...
      end;
      end;
  end;
  {
  //������ ��(�Ѱ�) ����Ʈ

  //���α߱�...�׸��� �ȿ����� �ȵȴ�....Canvas�� ��ġ��..
  //�Ѱ� ���� ����..
  Canvas.MoveTo(lineStart , curntYposi);
  Canvas.LineTo(lineEnd   , curntYposi);

  Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�
  for i:= 0 to grd_display1.ColCount-1 do
    rightPrint(head.getRightPosition(i), grd_display1.Cells[i,grd_display1.RowCount-1]);

  Inc(curntYposi, -sheight);	//������ �̵�
  Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�
  //�Ѱ� �Ʒ��� ����..
  Canvas.MoveTo(lineStart, curntYposi);
  Canvas.LineTo(lineEnd, curntYposi);
  }
  //����Ʈ ����
  Printer.EndDoc;

  head.Free; 	//��� ���� ����

  Showmessage('����� �� �Ǿ����ϴ�.');
end;

{*******************************************************************************
* procedure Name : dte_fromExit
* �� �� �� �� : ��¥�Է� �� �Էµ� ��¥���� ��ȿ���� �����ϰ� �޼����� �����.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.dte_fromExit(Sender: TObject);
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
procedure Tfrm_LOSTA230Q.dte_toExit(Sender: TObject);
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
procedure Tfrm_LOSTA230Q.disableComponents;
begin
  dte_from.Enabled := false;
  dte_to.Enabled := false;
  btn_Inquiry.Enabled := False;

  btn_close.Enabled:= False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* �� �� �� �� :��ư�� ���� �ٸ� ����� �� �� �ְ��Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.enableComponents;
begin
  dte_from.Enabled  := True;
  dte_to.Enabled    := True;
  btn_Inquiry.Enabled := True;

  btn_close.Enabled:= True;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTA230Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1..11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
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

{*******************************************************************************
* procedure Name : grd_displayKeyDown
* �� �� �� �� : Ű�ٿ �ش��ϴ� ������ �Ѵ�.(Ctrl + C)�� ���� ��� ����
*******************************************************************************}
procedure Tfrm_LOSTA230Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

{*******************************************************************************
* procedure Name : Copy1Click
* �� �� �� �� : �׸��忡 ���õ� ������ Ŭ�����忡 �����ϴ� �������Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display1.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_display1.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_display1.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA230Q.PageControl1Change(Sender: TObject);
begin
  //initStrGrid;
  //pInitStrGrd(Self);
  if (PageControl1.ActivePageIndex = 0) then Label2.Caption := '�԰�����'
  else Label2.Caption := '�������';
end;


procedure Tfrm_LOSTA230Q.setEdtKeyPress;
var i : Integer;
    edt : TEdit;
begin
  for i := 0 to componentCount -1 do
  begin
    if (Components[i] is TEdit) then
    begin
      (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
    end;
  end;
end;

procedure Tfrm_LOSTA230Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA230Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  //btn_Print.Enabled := True;

  cnt := 0;

  if frm_LOSTA230Q.tag = 1 then
    dte_from.SetFocus;

  frm_LOSTA230Q.Tag := 0;
  self.InitComponents;

  for i := grd_display1.fixedrows to grd_display1.rowcount - 1 do
    grd_display1.rows[i].Clear;
    grd_display1.RowCount := 2;

  for i := grd_display2.fixedrows to grd_display2.rowcount - 1 do
    grd_display2.rows[i].Clear;
    grd_display2.RowCount := 2;

end;

procedure Tfrm_LOSTA230Q.InitComponents;
var
  i : Integer;
begin
  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
     else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';
  end;

  changeBtn(Self);

  for i := grd_display1.FixedRows to grd_display1.RowCount -1 do
    grd_display1.Rows[i].Clear;

  for i := grd_display2.FixedRows to grd_display2.RowCount -1 do
    grd_display2.Rows[i].Clear;

  // �׸��� �ʱ�ȭ
  initStrGrid;

  // ������ ��Ʈ�� �ʱⰪ ����
  PageControl1.ActivePageIndex := 0;

  // ��¥ �ʵ� ����
  dte_from.Date := date-30;
  dte_to.Date   := date-1;

  //���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.
  qryStr:= '';

  //��ư�̹��� �ʱ�ȭ
  changeBtn(Self);

  sts_Message.Panels[1].Text := '';
end;

procedure Tfrm_LOSTA230Q.btn_ExcelClick(Sender: TObject);
begin
  if (PageControl1.ActivePageIndex = 0) then
	  Proc_gridtoexcel(PGM_NM + '(' + PGM_ID + ')',grd_display1.RowCount, grd_display1.ColCount, grd_display1, PGM_ID)
  else
	  Proc_gridtoexcel(PGM_NM + '(' + PGM_ID + ')',grd_display2.RowCount, grd_display2.ColCount, grd_display2, PGM_ID);
end;

procedure Tfrm_LOSTA230Q.dte_fromKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then SelectNext(sender as TWinControl, true, True);
end;


procedure Tfrm_LOSTA230Q.dte_toKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA230Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA230Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
