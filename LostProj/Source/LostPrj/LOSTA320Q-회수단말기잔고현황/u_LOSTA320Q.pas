{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA320Q (ȸ���ܸ��� �ܰ� ��Ȳ)
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

unit u_LOSTA320Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg, printers,
  Menus, WinSkinData, so_tmax, common_lib, Clipbrd,LOSTA320Q_PRT_HEAD,Func_Lib, ComObj;

const
  TITLE   = 'ȸ���ܸ��� �ܰ� ��Ȳ';
  PGM_ID  = 'LOSTA320Q';

type
  Tfrm_LOSTA320Q = class(TForm)
    Bevel1     : TBevel;
    Bevel2     : TBevel;
    Bevel3     : TBevel;
    Bevel4     : TBevel;
    cmb_gubun  : TComboBox;
    cmb_id_cd  : TComboBox;
    dte_to     : TDateEdit;
    lbl_Program_Name: TLabel;
    Label3     : TLabel;
    Label1     : TLabel;
    Label2     : TLabel;
    Copy1      : TMenuItem;
    pnl_Command: TPanel;
    Panel2     : TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
    ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure btn_PrintClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
  procedure initStrGrid;
  procedure InitComponents;

  procedure disableComponents;
  procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTA320Q: Tfrm_LOSTA320Q;
  arrIdCd : TZ0xxArray;
  qryStr:String;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTA320Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA320Q.FormCreate(Sender: TObject);
begin

  if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    ShowMessage('�α��� �� ����ϼ���');
      PostMessage(self.Handle, WM_QUIT, 0,0);
      exit;
  end;

  // ���뺯�� ���� common_lib.pas ������ ��.
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

    // �׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
    // �ӽ÷� �α��� ������ ����
//    common_userid   := '0294';    //ParamStr(2);
//    common_username := '��ȣ��';  //ParamStr(3);
//    common_usergroup:= 'KAIT';    //ParamStr(4);

    {----------------------- ���� ���ø����̼� ���� ---------------------------}

    // ���α׷� ĸ�� ����
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // �׽�ũ�� ĸ�Ǽ���
    Application.Title := TITLE;

    // ���α׷� ���� ĸ�� ����
    lbl_Program_Name.Caption := TITLE;

    // ���α׷� ��� ������ ����
    fSetIcon(Application);

    // �޼��� �� ���� ����
    pSetStsWidth(sts_Message);

    // �ؽ�Ʈ ���ý� ��ü ���� ���
    pSetTxtSelAll(Self);

    // ���α׷� ���� ������ ����
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // ���α׷� ���� ��ġ ����
    Self.Position     := poScreenCenter;
    {--------------------------------------------------------------------------}

    //��Ų �ʱ�ȭ
    initSkinForm(SkinData1);      // common_lib.pas�� �ִ�.
    // �׸��� �ʱ�ȭ
    initStrGrid;
    initComboBoxWithZ0xx('Z001.dat',arrIdCd,'��ü','',cmb_id_cd);

    cmb_gubun.Items.add('�հ�                                    T');
    cmb_gubun.Items.add('����Ʈ��(�е�)                          S');

    InitComponents;      

    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA320Q.InitComponents;
begin
  //���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.
  qryStr              := '';
  dte_to.Date         := Date -1;
  cmb_gubun.ItemIndex := 0 ;
  cmb_id_cd.ItemIndex := 0 ;

  sts_Message.Panels[1].Text := '';

  pInitStrGrd(Self);
  changeBtn(Self);
  btn_Print.Enabled := True;

end;

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.initStrGrid;
begin
	with grd_display do begin
      RowCount := 2;
      ColCount := 7;
      RowHeights[0] := 21;

      cells[0,0] := '�����';
      cells[1,0] := '�԰�';
      cells[2,0] := '���';
      cells[3,0] := '���/�ͼ�';
      cells[4,0] := '�����Ű�(��ȸ)';
      cells[5,0] := '�ܰ�';
      cells[6,0] := '�����Ű�(����)';

      colwidths[0] := 120;
      colwidths[1] := 100;
      colwidths[2] := 100;
      colwidths[3] := 100;
      colwidths[4] := 120;
      colwidths[5] := 100;
      colwidths[6] := 120;
    end;

end;

procedure Tfrm_LOSTA320Q.btn_InquiryClick(Sender: TObject);
var
    i,RowPos,count : Integer;
    Label LIQUIDATION;
    Label INQUIRY;

begin
    initStrGrid;
    //�׸��� ���÷��� ����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    grd_display.Cursor := crSQLWait;	//�۾���....

    disableComponents;	//�۾��� �ٸ� ��� ��� ����.

    // ����׿� ���� ���� �ʱ�ȭ
    qryStr:= '';

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
    if (TMAX.SendString('INF003','LostA320Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', copy(cmb_gubun.Items.Strings[cmb_gubun.ItemIndex
			],41,1))    < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', arrIdCd[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
    // ����� ������ ���� �Ϸ�

    //���� ȣ��
    if not TMAX.Call('LOSTA320Q') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    end;

    qryStr:= TMAX.RecvString('INF014',0);
          
    // ��ȸ ��� DISPLAY
    count := TMAX.RecvInteger('INF013',0);
    
    grd_display.RowCount := grd_display.RowCount + count;

    with grd_display do begin
      for i:=0 to count-1 do
      begin
        Cells[0,RowPos]   := TMAX.RecvString('STR101',i); // �����
        Cells[1,RowPos]   := convertWithCommer(TMAX.RecvString('INT101',i)); // �԰�
        Cells[2,RowPos]   := convertWithCommer(TMAX.RecvString('INT102',i)); // ���
        Cells[3,RowPos]   := convertWithCommer(TMAX.RecvString('INT103',i)); // ���/�ͼ�
        Cells[4,RowPos]   := convertWithCommer(TMAX.RecvString('INT105',i)); // �����Ű�(��ȸ)
        Cells[5,RowPos]   := convertWithCommer(TMAX.RecvString('INT104',i)); // �ܰ�
        Cells[6,RowPos]   := convertWithCommer(TMAX.RecvString('INT106',i)); // �����Ű�(����)

        Inc(RowPos);
      end;
    end;

    if(count > 0) then Dec(count);

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + IntToStr(count)  + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;


LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  if ( count > 0 ) then
    grd_display.RowCount := grd_display.RowCount -1 ;

  enableComponents;
end;

procedure Tfrm_LOSTA320Q.FormShow(Sender: TObject);
begin
  dte_to.SetFocus;
end;

{*******************************************************************************
* procedure Name : btn_PrintClick
* �� �� �� �� : ��ȸ�� ����� ����Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.btn_PrintClick(Sender: TObject);
var
    head:TLOSTA320Q_PRT_HEAD;	//head ���
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
    	start := x - Canvas.TextWidth(text) div 2;
    	eend  := x + Canvas.TextWidth(text) div 2;
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
      len :Cardinal;
      str : String;
    begin
      centerPrint(prntWidth div 2,  	 'ȸ�� �ܸ��� �ܰ� ��Ȳ');
      //��� ���ڿ��� ���� ���� �߱�
      centerUnderLine(prntWidth div 2, 'ȸ�� �ܸ��� �ܰ� ��Ȳ');

      //�Ӹ��� ����------------------------------------
      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      str := 'PROG ID: LOSTA320Q';
      Canvas.TextOut(lineStart, curntYposi,str);

      str:= '��������: ' + dte_to.Text;
      Canvas.TextOut(lineStart, curntYposi - ygap -sheight, str);

      str:= '����� ���� : ' + arrIdCd[cmb_id_cd.ItemIndex].name;
      Canvas.TextOut(lineEnd div 2 - Canvas.TextWidth(str) div 2, curntYposi - ygap -sheight, str);

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

      for i:=0 to 6 do
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
    Canvas.Font.Name := '����ü';
    Canvas.Font.Height := 40;  // ����ü ���� 4mm
    //Canvas.Font.Style:= [fsBold];

    //��ġ �߿�
    head := TLOSTA320Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //����, ��ü��,...

    sheight     := Canvas.TextHeight('��'); //���ڳ��� ���, 4mm
    ygap        := 10;							        //1mm ��
    curntYposi  := -100;   				          //���ڿ��� ���ų� ������ ������ y-�� ������
    lineStart   := head.getRightPosition(0)- head.getLength(0) -20;	//���߱� x-�� ������
    lineEnd     := head.getRightPosition(6) +20;						//���߱� x-�� ����

    //Ÿ��Ʋ ����Ʈ
    printTitle(page);

    //���� ����Ʈ---������ ���� ���� ����Ʈ
    with grd_display do begin
    	for j:= 1 to RowCount-2 do
      begin
        for i:=0 to ColCount-1 do
            rightPrint(head.getRightPosition(i), Cells[i,j]);

			Inc(curntYposi, -sheight);	//������ �̵�
			Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�

			//��¹��� �������� �Ѿ��...
        if curntYposi >= prntHeight then begin
          Printer.NewPage;      	//�� ������ �߰�
            Inc(page);   			//������ ��ȣ ī��Ʈ ��
            curntYPosi := -100;     //y��  position�� ���� �����Ѵ�.

            //��Ÿ �ʱ�ȭ �ؾ� �� �׸��� ������ ���⼭...

            printTitle(page);		//Ÿ��Ʋ�� �ٽ� ����Ʈ...
        end;
      end;
    end;

    //������ ��(�Ѱ�) ����Ʈ

    //���α߱�...�׸��� �ȿ����� �ȵȴ�....Canvas�� ��ġ��..
    //�Ѱ� ���� ����..
    Canvas.MoveTo(lineStart , curntYposi);
    Canvas.LineTo(lineEnd   , curntYposi);

    Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�
    for i:= 0 to grd_display.ColCount-1 do
      rightPrint(head.getRightPosition(i), grd_display.Cells[i,grd_display.RowCount-1]);

    Inc(curntYposi, -sheight);	//������ �̵�
    Inc(curntYposi, -ygap);		//1mm �Ʒ��� �̵�
    //�Ѱ� �Ʒ��� ����..
    Canvas.MoveTo(lineStart, curntYposi);
    Canvas.LineTo(lineEnd, curntYposi);

    //����Ʈ ����
    Printer.EndDoc;

    head.Free; 	//��� ���� ����

    Showmessage('����� �� �Ǿ����ϴ�.');
end;

{*******************************************************************************
* procedure Name : disableComponents
* �� �� �� �� :��ư�� ������ ���ϰ� �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.disableComponents;
begin
  dte_to.Enabled := false;
  btn_Inquiry.Enabled := False;

  btn_close.Enabled:= False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* �� �� �� �� :��ư�� ���� �ٸ� ����� �� �� �ְ��Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.enableComponents;
begin
  dte_to.Enabled    := True;
  btn_Inquiry.Enabled := True;

  btn_close.Enabled:= True;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTA320Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1..6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
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
procedure Tfrm_LOSTA320Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

{*******************************************************************************
* procedure Name : Copy1Click
* �� �� �� �� : �׸��忡 ���õ� ������ Ŭ�����忡 �����ϴ� �������Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTA320Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTA320Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTA320Q.btn_queryClick(Sender: TObject);
var
  cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    exit;

  filePath  :='..\Temp\' + PGM_ID + '_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;
procedure Tfrm_LOSTA320Q.btn_resetClick(Sender: TObject);
begin
  InitComponents;
end;

end.
