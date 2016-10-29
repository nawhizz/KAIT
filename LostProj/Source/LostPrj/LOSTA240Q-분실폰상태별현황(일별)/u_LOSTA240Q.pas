{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA240Q ( �н��� ���º� ��Ȳ (�Ϻ�))
���α׷� ���� : Online
�ۼ���	      : jung hong ryul
�ۼ���	      : 2011. 09. 08
�Ϸ���	      : ####. ##. ##
���α׷� ���� : ���������� �ڷḦ ���, ����, ����, ��ȸ�Ѵ�.

     * TYPE���� �Է�ȭ��� �������� ����ϹǷ� IMPLEMENTATION ���ʿ� ��ġ....
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTA240Q;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  printers, LOSTA240Q_PRT_HEAD, ComObj;

const
  TITLE   = ' �н��� ���º� ��Ȳ (�Ϻ�)';
  PGM_ID  = 'LOSTA240Q';

type
  Tfrm_LOSTA240Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    Label3: TLabel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    grd_display: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure dte_fromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dte_toKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);

  private
  { Private declarations }
  cmb_id_cd_d: TZ0xxArray;
  qryStr : String;
  //�׸��� �ʱ�ȭ
  procedure initStrGrid;
  //������ ������Ʈ �������
  procedure disableComponents;
  //����Ϸ� �� ������Ʈ ��� �����ϰ�
  procedure enableComponents;
  public
  { Public declarations }
  end;

var
  frm_LOSTA240Q: Tfrm_LOSTA240Q;

implementation

procedure Tfrm_LOSTA240Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA240Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{$R *.DFM}
procedure Tfrm_LOSTA240Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA240Q.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_id_cd.Enabled := True;
  btn_Print.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA240Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 12;
    	RowHeights[0] := 21;

      ColWidths[0] := 120;
		Cells[0,0] :='�԰�����';

    	ColWidths[1] := 170;
		Cells[1,0] :='';

    	ColWidths[2] := 100;
		Cells[2,0] :='����ܸ���';

    	ColWidths[3] := 100;
		Cells[3,0] :='���͸���';

    	ColWidths[4] := 100;
		Cells[4,0] :='���׳���';

     	ColWidths[5] := 150;
		Cells[5,0] :='���͸�+���׳���';

    	ColWidths[6] := 100;
		Cells[6,0] :='�ø���';

      ColWidths[7] := 100;
		Cells[7,0] :='���͸�+�ø���';

    	ColWidths[8] := 100;
		Cells[8,0] :='���׳�+�ø���';

     	ColWidths[9] := 130;
		Cells[9,0] :='���͸�+���׳�+�ø�';

      ColWidths[10] := 100;
		Cells[10,0] :='�۵��Ұ�';

      ColWidths[11] := 100;
		Cells[11,0] :='��';
 end;
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA240Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA240Q.FormCreate(Sender: TObject);
begin
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
	//common_username:= '��ȣ��';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);


	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', ' ',cmb_id_cd);
  initStrGrid;	//�׸��� �ʱ�ȭ

	qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  end;

end;


procedure Tfrm_LOSTA240Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    STR003 : String;
    STR004 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
  pInitStrGrd(Self);
  //�׸��� ���÷���
  seq     := 1; 	//����
  RowPos  := 1;	//�׸��� ���ڵ� ������

  //���۽ú��� �ʱ�ȭ
  STR003 :=' ';
  STR004 :=' ';

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
	if (TMAX.SendString('INF002',common_userid                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                       ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostA240Q'                            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01'                                  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR003                                ) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTA240Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

//grd_display
{
�԰�����
�󺧾���
������
���͸�
�Ƴ��α�
��


���

STR101  ���������
INT101  �ܸ���κ�ǰ���� (�󺧾���)
INT102  �ܸ���κ�ǰ���� (������)
INT103  �ܸ���κ�ǰ���� (���͸�)
INT104  �ܸ���κ�ǰ���� (�Ƴ��α�)
INT105  �� �������� (��)


INT100 : COUNT...��Ӱ� ....�б�
INF013 : ���� ī��Ʈ �� ...�б�

}
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

    grd_display.RowCount := 2;

    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';

    goto LIQUIDATION;
  end;

  totalCount:= totalCount + count1;
  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin

      STR003 := delHyphen(Trim(TMAX.RecvString('STR101',i)));

      if STR003 = STR004 then
      begin
         Cells[0,RowPos] := ' ';
      end else
      begin
        Cells[0,RowPos] := TMAX.RecvString('STR101',i);
        STR004 := STR003;
      end;

      Cells[1,RowPos]  := TMAX.RecvString('STR102',i);
      Cells[2,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT101',i)));
      Cells[3,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT102',i)));
      Cells[4,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT103',i)));
      Cells[5,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT104',i)));
      Cells[6,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT105',i)));
      Cells[7,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT106',i)));
      Cells[8,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT107',i)));
      Cells[9,RowPos]  := convertWithCommer(InttoStr(TMAX.RecvInteger('INT108',i)));
      Cells[10,RowPos] := convertWithCommer(InttoStr(TMAX.RecvInteger('INT109',i)));
      Cells[11,RowPos] := convertWithCommer(InttoStr(TMAX.RecvInteger('INT110',i)));

      Inc(seq);
      Inc(RowPos);
    end;
  end;
 //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

  count2 := TMAX.RecvInteger('INT100',0);

  if count1 = count2 then
    goto INQUIRY;

  //'����'��ư�� Ŭ�� ���� �� ������ ��Ʈ��
  qryStr:= TMAX.RecvString('INF014',0);


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

procedure Tfrm_LOSTA240Q.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA240Q.dte_fromExit(Sender: TObject);
begin
     sts_Message.Panels[1].Text := '';

 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
 end;

end;

procedure Tfrm_LOSTA240Q.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTA240Q.btn_PrintClick(Sender: TObject);
var
	head:TLOSTA240Q_PRT_HEAD;	//head ���
	Canvas: TCanvas;
	i, j, page : integer;

    datetime : string;

    curntYposi:Integer;  //���� y�� ����Ʈ
    prntWidth:Cardinal;	 //������ ��(297mm)
    prntHeight:Cardinal; //������ ����(210mm)
    prntMargin:Cardinal; //������, ���� ����(20mm);
    swidth, sheight:Cardinal;	//���ڿ� ����

    lineStart:Cardinal;	//�ٱ߱� ������;
    lineEnd:Cardinal;
    ygap:Cardinal;		//y�� -��

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
    	start:= x - Canvas.TextWidth(text) div 2;
    	eend:= x + Canvas.TextWidth(text) div 2;
        curntYposi := curntYposi-sheight - 10;
        Canvas.MoveTo(start, curntYposi);
        Canvas.LineTo(eend, curntYposi);

        //������ ���ؼ�...
        Inc(curntYposi, -ygap);  //�����ٷ� �̵�
    end;

    //Ÿ��Ʋ ����Ʈ
	procedure printTitle(page:integer);
    var
    	i:Integer;
        str:String;
        len:Cardinal;
	begin
    	centerPrint(prntWidth div 2,  	 '�н��� ���º� ��Ȳ (�Ϻ�)');
      //��� ���ڿ��� ���� ���� �߱�
      centerUnderLine(prntWidth div 2, '�н��� ���º� ��Ȳ (�Ϻ�)');

      //�Ӹ��� ����------------------------------------
      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      str := 'PROG ID: LOSTA240Q';
      Canvas.TextOut(lineStart, curntYposi,str);

      str:= '�԰�����: '+ dte_from.Text +' ~ '+ dte_to.Text;
      Canvas.TextOut(lineStart, curntYposi - ygap -sheight, str);

      str:= '����ð�(' + datetime + ')';
      len:= Canvas.TextWidth(str);
      Canvas.TextOut(lineEnd-len, curntYposi - ygap -sheight, str);

      str:= 'Page: '+ intToStr(page);
      Canvas.TextOut(lineEnd-len, curntYposi , str);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      //�Ӹ��� ��------------------------------------


      Inc(curntYposi, -ygap);
      //Ÿ��Ʋ ���ʿ� �� �߱�
      Canvas.MoveTo(lineStart, curntYposi);
      Canvas.LineTo(lineEnd, curntYposi);

      //Ÿ��Ʋ�� ����Ѵ�.
      Inc(curntYposi, -ygap);
      for i:=0 to 11 do
        rightPrint(head.getRightPosition(i), titles[i]);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);
      //Ÿ��Ʋ �Ʒ��ʿ� �� �߱�
      Canvas.MoveTo(lineStart, curntYposi);
      Canvas.LineTo(lineEnd, curntYposi);

      Inc(curntYPosi, -ygap);	//������ �غ�...
	end;
begin
  Canvas := Printer.Canvas;
  datetime := Formatdatetime('yyyymmdd',date)+'/'+Formatdatetime('hhnnss',time);

  i     := 0;
  j     := 1;
  page  := 1;

  Printer.Orientation := poLandscape;

  //����Ʈ ����
  Printer.BeginDoc;	//�̺κ��� ���� ���� ���������ϸ� �����߻�...

  prntWidth := 2960;	//A4 = 297mm
  prntHeight:= 2090;	//A4 = 210mm
  prntMargin:= 200;	  //left, right margin = 20mm

  //�� ������ �ٲٸ� ���� ���� ����� �ٽ��ؾ� ��.
  SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm ����
  Canvas.Font.Name    := '����ü';
  Canvas.Font.Height  := 40;              // ����ü ���� 4mm

  //Canvas.Font.Style:= [fsBold];
  //��ġ �߿�
  head := TLOSTA240Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //����, ��ü��,...

  sheight     := Canvas.TextHeight('��');                 //���ڳ��� ���, 4mm
  ygap        := 10;							                        //1mm ��
  curntYposi  := -100;   				                          //���ڿ��� ���ų� ������ ������ y-�� ������
  lineStart   := head.getRightPosition(0)- head.getLength(0) -20;	//���߱� x-�� ������
  lineEnd     := head.getRightPosition(11) +20;						//���߱� x-�� ����

  //Ÿ��Ʋ ����Ʈ
  printTitle(page);

  //���� ����Ʈ---������ ���� ���� ����Ʈ
  with grd_display do begin
    for j:= 1 to RowCount-2 do begin
      for i:=0 to ColCount-1 do
        rightPrint(head.getRightPosition(i), Cells[i,j]);

      Inc(curntYposi, -sheight);	//������ �̵�
      Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�

      //��¹��� �������� �Ѿ��...

      if -(curntYposi) >= prntHeight then
      begin
        Printer.NewPage;      	//�� ������ �߰�
        Inc(page);   			      //������ ��ȣ ī��Ʈ ��
        curntYPosi := -100;     //y��  position�� ���� �����Ѵ�.

        //��Ÿ �ʱ�ȭ �ؾ� �� �׸��� ������ ���⼭...

        printTitle(page);		  //Ÿ��Ʋ�� �ٽ� ����Ʈ...
      end;
    end;
  end;

  //������ ��(�Ѱ�) ����Ʈ

  //���α߱�...�׸��� �ȿ����� �ȵȴ�....Canvas�� ��ġ��..
  //�Ѱ� ���� ����..
  //  Canvas.MoveTo(lineStart, curntYposi);
  //	Canvas.LineTo(lineEnd, curntYposi);

  Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�

  for i:= 0 to grd_display.ColCount-1 do
    rightPrint(head.getRightPosition(i), grd_display.Cells[i,grd_display.RowCount-1]);

  Inc(curntYposi, -sheight);	//������ �̵�
  Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�

  //�Ѱ� �Ʒ��� ����..
  Canvas.MoveTo(lineStart, curntYposi);
  Canvas.LineTo(lineEnd  , curntYposi);

  //����Ʈ ����
  Printer.EndDoc;

  head.Free; 	//��� ���� ����

  Showmessage('����� �� �Ǿ����ϴ�.');

end;





procedure Tfrm_LOSTA240Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
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

procedure Tfrm_LOSTA240Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('�н������º���Ȳ(LOSTA240Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA240Q');
end;

procedure Tfrm_LOSTA240Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTA240Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];

  if (ARow =0) then
  begin
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.Font.Color  := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
  // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
  begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      2..11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
    end;
  end;

end;

procedure Tfrm_LOSTA240Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}

procedure Tfrm_LOSTA240Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA240Q.dte_fromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
    dte_to.SetFocus;
end;

procedure Tfrm_LOSTA240Q.dte_toKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
    cmb_id_cd.SetFocus;
end;

procedure Tfrm_LOSTA240Q.cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
    btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA240Q.btn_ResetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;

  dte_from.SetFocus;
  
  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;
end;

end.
