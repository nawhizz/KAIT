unit u_LOSTB250Q;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  printers, LOSTB250Q_PRT_HEAD, ComObj;

const
  TITLE   = '����ǰ�߼۴����Ȳ(�Ϻ�)';
  PGM_ID  = 'LOSTB250Q';

type
TZ001 = record
	name: String[20];
    code: String[10];
    Jcode1: Char;
    Jcode2: Char;
    JCode3: Char;
    Used: Char;
end;

type
  Tfrm_LOSTB250Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    grd_display: TStringGrid;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
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
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure Copy1Click(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_resetClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
  private
    { Private declarations }
    qryStr:String;
    cmb_id_cd_d: TZ0xxArray;
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
  frm_LOSTB250Q: Tfrm_LOSTB250Q;

implementation

{$R *.DFM}
procedure Tfrm_LOSTB250Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTB250Q.enableComponents;
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

procedure Tfrm_LOSTB250Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 5;
    	RowHeights[0] := 21;

      ColWidths[0] := 120;
		Cells[0,0] :='�԰�����';

    	ColWidths[1] := 170;
		Cells[1,0] :='';

    	ColWidths[2] := 150;
		Cells[2,0] :='����ܸ���';

    	ColWidths[3] := 150;
		Cells[3,0] :='����ǰ����';

    	ColWidths[4] := 150;
		Cells[4,0] :='����ǰ���';
 end;

end;

procedure Tfrm_LOSTB250Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB250Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB250Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB250Q.FormCreate(Sender: TObject);
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
  initComboBoxWithZ0xx('Z001_1.dat', cmb_id_cd_d, '��ü', ' ',cmb_id_cd);
  initStrGrid;	//�׸��� �ʱ�ȭ



	qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;


  end;
end;

procedure Tfrm_LOSTB250Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;


    STR003 : String;
    STR004 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
 	//�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    pInitStrGrd(Self);

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
{
�Է�;
STR001 : �������� FROM
STR002 : �������� TO

STR003 : ���� ����
STR004 : ��¥ �� ����


}
	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostB250Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d [cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;


  //���� ȣ��
  if not TMAX.Call('LOSTB250Q') then
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
    grd_display.RowCount := 3;
   goto LIQUIDATION;
  end;

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

            STR003 := delHyphen(Trim(TMAX.RecvString('STR101',i)));

            if STR003 = STR004 then begin
               Cells[0,RowPos] := ' ';
            end else begin
               Cells[0,RowPos] := TMAX.RecvString('STR101',i);
                STR004 := STR003;
            end ;

         // Cells[0,RowPos] := InsHyphen(TMAX.RecvString('STR101',i));
          Cells[1,RowPos] := TMAX.RecvString('STR102',i);
          Cells[2,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i)));
          Cells[3,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i)));
          Cells[4,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i)));


{
STR003 : : ��ȸ�������� ���� <- STR101

}
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

//���������°�
LIQUIDATION:

	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;
end;

procedure Tfrm_LOSTB250Q.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTB250Q.dte_fromExit(Sender: TObject);
begin
     sts_Message.Panels[1].Text := '';

 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
 end;

end;

procedure Tfrm_LOSTB250Q.FormShow(Sender: TObject);
begin
	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;
  //dte_from.SetFocus;

  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTB250Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB250Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTB250Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB250Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTB250Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('��ȸ����(LOSTB250Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB250Q');
end;

procedure Tfrm_LOSTB250Q.btn_PrintClick(Sender: TObject);
var
	head:TLOSTB250Q_PRT_HEAD;	//head ���
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
    	centerPrint(prntWidth div 2,  	 '����ǰ �߼� ��Ȳ (�Ϻ�)');
        //��� ���ڿ��� ���� ���� �߱�
        centerUnderLine(prntWidth div 2, '����ǰ �߼� ��Ȳ (�Ϻ�)');

        //�Ӹ��� ����------------------------------------
        Inc(curntYposi, -sheight);
        Inc(curntYposi, -ygap);

        str := 'PROG ID: LOSTB250Q';
        Canvas.TextOut(lineStart, curntYposi,str);

        str:= '�߼�����: '+ dte_from.Text +' ~ '+ dte_to.Text;
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
        for i:=0 to 4 do
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
	i := 0;
	j := 1;
	page := 1;

	Printer.Orientation := poLandscape;
    //����Ʈ ����
	Printer.BeginDoc;	//�̺κ��� ���� ���� ���������ϸ� �����߻�...

  prntWidth := 2960;	//A4 = 297mm
  prntHeight:= 2090;	//A4 = 210mm
  prntMargin:= 200;	//left, right margin = 20mm

  //�� ������ �ٲٸ� ���� ���� ����� �ٽ��ؾ� ��.
  SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm ����
  Canvas.Font.Name    := '����ü';
  Canvas.Font.Height  := 32;  // ����ü ���� 4mm
  //Canvas.Font.Style:= [fsBold];
  //��ġ �߿�
  head        := TLOSTB250Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //����, ��ü��,...

  sheight     := Canvas.TextHeight('��');                         // ���ڳ��� ���, 4mm
  ygap        := 16;							                                // 1mm ��
  curntYposi  := -100;   				                                  // y-�� ������
  lineStart   := head.getRightPosition(0)- head.getLength(0) -20;	// ���߱� x-�� ������
  lineEnd     := head.getRightPosition(4) +20;						        // ���߱� x-�� ����

  //Ÿ��Ʋ ����Ʈ
  printTitle(page);

  //���� ����Ʈ---������ ���� ���� ����Ʈ
  with grd_display do
  begin
    for j:= 1 to RowCount-2 do begin
      for i:=0 to ColCount-1 do
        rightPrint(head.getRightPosition(i), Cells[i,j]);

      Inc(curntYposi, -sheight);	          //������ �̵�
      Inc(curntYposi, -ygap);		            //1mm �Ʒ��� �̵�

      //��¹��� �������� �Ѿ��...
      if -(curntYposi) + prntMargin >= prntHeight then
      begin
        Printer.NewPage;      	            //�� ������ �߰�
        Inc(page);   		        	          //������ ��ȣ ī��Ʈ ��
        curntYPosi := -100;                 //y��  position�� ���� �����Ѵ�.

        //��Ÿ �ʱ�ȭ �ؾ� �� �׸��� ������ ���⼭...

        printTitle(page);		//Ÿ��Ʋ�� �ٽ� ����Ʈ...
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
  Canvas.MoveTo(lineStart , curntYposi);
  Canvas.LineTo(lineEnd   , curntYposi);

  //����Ʈ ����
	Printer.EndDoc;

	head.Free; 	//��� ���� ����

	Showmessage('����� �� �Ǿ����ϴ�.');
end;

procedure Tfrm_LOSTB250Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      2..4: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

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
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTB250Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB250Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin

	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;
  changeBtn(Self);

  if dte_from.CanFocus then
    dte_from.SetFocus;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';


end;

end.
