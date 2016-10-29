
unit u_LOSTE220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,printers, ComObj;

const
  TITLE   = '����� ���� ���� �ܸ��� ��ȸ';
  PGM_ID  = 'LOSTE220Q';

type
  Tfrm_LOSTE220Q = class(TForm)
    Bevel1     : TBevel;
    Bevel2     : TBevel;
    dte_to     : TDateEdit;
    dte_from   : TDateEdit;
    Label1     : TLabel;
    pnl_Program_Name: TLabel;
    Label2     : TLabel;
    Copy1      : TMenuItem;
    pnl_Command: TPanel;
    Panel2     : TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    btn_Add    : TSpeedButton;
    btn_Update : TSpeedButton;
    btn_Delete : TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link   : TSpeedButton;
    btn_excel  : TSpeedButton;
    btn_Print  : TSpeedButton;
    btn_query  : TSpeedButton;
    btn_Close  : TSpeedButton;
    btn_reset  : TSpeedButton;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;
    Bevel3: TBevel;
    lbl1: TLabel;
    Bevel4: TBevel;
    Label3: TLabel;
    edt_nm: TEdit;
    bvl1: TBevel;
    lbl2: TLabel;
    mskEdt_cell_num: TMaskEdit;
    cmb_gbn_dt: TComboBox;
    cmb_insu_cmp: TComboBox;
    Label4: TLabel;
    Bevel5: TBevel;
    cmb_gbnSel: TComboBox;
    chk_out_yn: TCheckBox;
    Bevel16: TBevel;
    Label15: TLabel;
    md_cb1: TComboEdit;
    Label18: TLabel;
    Bevel18: TBevel;
    serial_edit: TEdit;
    md_grid1: TStringGrid;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure btn_LinkClick(Sender: TObject);
    procedure grd_displayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure md_grid1Click(Sender: TObject);

  private
    { Private declarations }
     qryStr:String;
    //�׸��� �ʱ�ȭ
    procedure initStrGrid;
    //������ ������Ʈ �������
    procedure disableComponents;
    //����Ϸ� �� ������Ʈ ��� �����ϰ�
    procedure enableComponents;

    procedure InitComponent;

  public
    { Public declarations }
  end;

var
  frm_LOSTE220Q : Tfrm_LOSTE220Q;
  cmb_insu_cmp_d : TZ0xxArray;
  md_grid1_d     :TZ0xxArray;


implementation
{$R *.DFM}

procedure Tfrm_LOSTE220Q.disableComponents;
begin
	  dte_from.Enabled    := false;
    dte_to.Enabled      := false;
    btn_query.Enabled   := False;
    btn_excel.Enabled   := False;
    btn_close.Enabled   := False;
    btn_Print.Enabled   := False;
    btn_Inquiry.Enabled := False;
end;

procedure Tfrm_LOSTE220Q.enableComponents;
begin
  	dte_from.Enabled     := True;
    dte_to.Enabled       := True;
    btn_query.Enabled    := True;
    btn_excel.Enabled    := True;
    btn_close.Enabled    := True;
    btn_Print.Enabled    := False;
    btn_Inquiry.Enabled  := True;
end;

procedure Tfrm_LOSTE220Q.Link_rtn (var Msg : TMessage);
begin
    //'��ȸ' ��ư Ŭ��

    ShowWindow(Self.Handle , SW_SHOW);
    btn_InquiryClick(self);
end;

procedure Tfrm_LOSTE220Q.initStrGrid;
begin
	with grd_display do
  begin
    RowCount      :=  2;
    ColCount      := 24;
    RowHeights[0] := 21;

    ColWidths[ 0] := 40;   // SEQ
    ColWidths[ 1] := 120;  // �԰����
    ColWidths[ 2] := 110;  // �ܸ���ó������
    ColWidths[ 3] := 80;   // �����
    ColWidths[ 4] := 80;   // �����
    ColWidths[ 5] := 100;  // �𵨸�
    ColWidths[ 6] := 140;  // �Ϸù�ȣ
    ColWidths[ 7] := 140;  // ��Ű�����
    ColWidths[ 8] := 105;  // ���谡����
    ColWidths[ 9] := 110;  // �����ڻ������
    ColWidths[10] := 110;  // �̵���ȭ��ȣ
    ColWidths[11] := 110;  // �����ڿ���ó
    ColWidths[12] := 110;  // ����ݽ�û����
    ColWidths[13] := 115;  // ������������
    ColWidths[14] := 115;  // ��������
    ColWidths[15] := 150;  // ��������޾�
    ColWidths[16] := 110;  // �������
    ColWidths[17] := 110;  // �԰�����
    ColWidths[18] := 115;  // �������
    ColWidths[19] := 110;  // ������ü��
    ColWidths[20] := 110;  // ���ó������
    ColWidths[21] := -1;   // ��ü���ڵ�
    ColWidths[22] := -1;   // �����Ϸù�ȣ
    ColWidths[23] := 100;   // ����������ܸ��⿩��

    Cells[ 0,0]    := 'SEQ';
    Cells[ 1,0]    := '�԰����';
    Cells[ 2,0]    := '�ܸ���ó������';
    Cells[ 3,0]    := '�����';
    Cells[ 4,0]    := '�����';
    Cells[ 5,0]    := '�𵨸�';
    Cells[ 6,0]    := '�Ϸù�ȣ';
    Cells[ 7,0]    := '��Ű�����';
    Cells[ 8,0]    := '���谡����';
    Cells[ 9,0]    := '�����ڻ������';
    Cells[10,0]    := '�̵���ȭ��ȣ';
    Cells[11,0]    := '�����ڿ���ó';
    Cells[12,0]    := '����ݽ�û����';
    Cells[13,0]    := '������������';
    Cells[14,0]    := '��������';
    Cells[15,0]    := '��������޾�';
    Cells[16,0]    := '�������';
    Cells[17,0]    := '�԰�����';
    Cells[18,0]    := '�������';
    Cells[19,0]    := '������ü��';
    Cells[20,0]    := '���ó������';
    Cells[21,0]    := '��ü���ڵ�';
    Cells[22,0]    := '�����Ϸù�ȣ';
    Cells[23,0]    := '����������';

  end;
end;

procedure Tfrm_LOSTE220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTE220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE220Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTE220Q.FormCreate(Sender: TObject);
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

    if ParamCount <> 6 then //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    begin
      ShowMessage('�α��� �� ����ϼ���');
      PostMessage(self.Handle, WM_QUIT, 0,0);
      exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);
    common_seedkey    := ParamStr(6);

    btn_resetClick(Sender);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '��ȣ��';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

    initSkinForm(SkinData1); //common_lib.pas�� �ִ�.

    initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1  );
    initComboBoxWithZ0xx('Z085.dat',cmb_insu_cmp_d,'��ü','',cmb_insu_cmp);

    initStrGrid;	//�׸��� �ʱ�ȭ

    qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  end;
end;

procedure Tfrm_LOSTE220Q.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_kait_ganm : String;

    i:Integer;
    RowPos:Integer;

    count1, totalCount:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_ganm := '';
    seed_gano := '';
    seed_gatl := '';
    seed_mtno := '';
    seed_kait_ganm := '';

  RowPos                := 1;	//�׸��� ���ڵ� ������
  grd_display.RowCount  := 2;

  pInitStrGrd(grd_display);

  totalCount  :=  0;
  qryStr      := '';
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
	if (TMAX.SendString('INF002',common_userid                      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTE220Q'                        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'S01'                             ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_insu_cmp_d[cmb_insu_cmp.itemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', IntToStr(cmb_gbn_dt.itemIndex)    ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', Trim(edt_nm.Text)                 ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', Trim(delHyphen(mskEdt_cell_num.Text))  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', IntToStr(cmb_gbnSel.itemIndex)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', IntToStr(StrToInt(BoolToStr(chk_out_yn.checked))*-1)) < 0) then  goto LIQUIDATION;

  if (Length(Trim(md_cb1.Text)) <> 0 ) then
  begin
	  if (TMAX.SendString('STR009', md_grid1_d[md_grid1.Row].code    ) < 0) then  goto LIQUIDATION
  end
  else
  begin
    if (TMAX.SendString('STR009', '    '                           ) < 0) then  goto LIQUIDATION;
  end;

	if (TMAX.SendString('STR010', Trim(serial_edit.Text)             ) < 0) then  goto LIQUIDATION;

   //���� ȣ��
   if not TMAX.Call('LOSTE220Q') then
   begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

     goto LIQUIDATION;
   end;

  count1                := TMAX.RecvInteger('INF013',0);
  totalCount            := totalCount + count1;
  grd_display.RowCount  := grd_display.RowCount + count1;

  with grd_display do
  begin
    for i:=0 to count1-1 do
    begin
    {* SEQ            *} Cells[0  ,RowPos]   := IntToStr(i+1);
    {* �԰����       *} Cells[1  ,RowPos]   := TMAX.RecvString('STR116',i);
    {* �ܸ���ó������ *} Cells[2  ,RowPos]   := TMAX.RecvString('STR119',i);
    {* �����         *} Cells[3  ,RowPos]   := TMAX.RecvString('STR101',i);
    {* �����         *} Cells[4  ,RowPos]   := TMAX.RecvString('STR102',i);
    {* �𵨸�         *} Cells[5  ,RowPos]   := TMAX.RecvString('STR103',i);
    {* �Ϸù�ȣ       *} Cells[6  ,RowPos]   := TMAX.RecvString('STR104',i);
    {* ��Ű�����     *} seed_kait_ganm      := TMAX.RecvString('STR106',i);
                         Cells[7  ,RowPos]   := ECPlazaSeed.Decrypt(seed_kait_ganm, common_seedkey);
    {* ���谡����     *} seed_ganm           := TMAX.RecvString('STR122',i);
    {* ���谡����     *} Cells[8  ,RowPos]   := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
    {* �����ڻ������ *} seed_gano           := TMAX.RecvString('STR107',i);
                         Cells[9  ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gano, common_seedkey),'2-2-2');
    {* �̵���ȭ��ȣ   *} seed_mtno           := TMAX.RecvString('STR105',i);
                         Cells[10 ,RowPos]   := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
    {* �����ڿ���ó   *} seed_gatl           := TMAX.RecvString('STR108',i);
                         Cells[11 ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
    {* ����ݽ�û���� *} Cells[12 ,RowPos]   := InsHyphen(TMAX.RecvString('STR109',i));
    {* ������������   *} Cells[13 ,RowPos]   := InsHyphen(TMAX.RecvString('STR110',i));
    {* ��������       *} Cells[14 ,RowPos]   := InsHyphen(TMAX.RecvString('STR111',i));
    {* ��������޾�   *} Cells[15 ,RowPos]   := convertWithCommer(IntToStr(Round(TMAX.RecvDouble('DBL112',i))));
    {* �������     *} Cells[16 ,RowPos]   := TMAX.RecvString('STR113',i);
    {* �԰�����       *} Cells[17 ,RowPos]   := InsHyphen(TMAX.RecvString('STR114',i));
    {* �������       *} Cells[18 ,RowPos]   := InsHyphen(TMAX.RecvString('STR115',i));
    {* ������ü��     *} Cells[19 ,RowPos]   := TMAX.RecvString('STR117',i);
    {* ���ó������   *} Cells[20 ,RowPos]   := TMAX.RecvString('STR118',i);
    {* ��ü���ڵ�     *} Cells[21 ,RowPos]   := TMAX.RecvString('STR120',i);
    {* �����Ϸù�ȣ   *} Cells[22 ,RowPos]   := TMAX.RecvString('STR121',i);
    {* ����������     *} Cells[23 ,RowPos]   := TMAX.RecvString('STR123',i);

      Inc(RowPos);
    end;
  end;

  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

  qryStr:= TMAX.RecvString('INF014',0);

//���������°�
LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor   := crDefault;	//�۾��Ϸ�

  if totalCount >= 1 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTE220Q.FormShow(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE220Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
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

procedure Tfrm_LOSTE220Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTE220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTE220Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display.Selection;

  with select do
  begin
    str:='';

    if (Left = Right) and (Top = Bottom) then
        str := grd_display.Cells[Left,Top]
    else
    begin
      for j:= Top to Bottom do
      begin
        for i:= Left to Right do
            str := str + grd_display.Cells[i,j] + '|';

        str:= str +#13#10;
      end;
    end;
  end;

  Clipboard.AsText := str;
end;



procedure Tfrm_LOSTE220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    grid.Canvas.Font.Color := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
  // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
  begin
    case ACol of
      3,4,5,6,7,8,10,16: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,1,2,9,12,13,14,17,18,19,20,21,22: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      15 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

    end;
  end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTE220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTE220Q.btn_resetClick(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE220Q.InitComponent;
var i : Integer;
begin
  dte_from.Date := date-30;
	dte_to.Date   := date;

  changeBtn(Self);
  btn_Link.Enabled := True;

  btn_Print.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';

  md_cb1.Text := '';

//  md_grid1.Row    := 0;
//  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

  //dte_from.SetFocus;
end;

procedure Tfrm_LOSTE220Q.grd_displayDblClick(Sender: TObject);
var
  Value       : array of string;
  commandStr  : String;
  progID      : String;
	ret         : Integer;
begin
  if (grd_display.Row < 0) then exit;

  if (Trim(grd_display.Cells[0,grd_display.Row]) = '') then Exit
  else
  begin
    if ( Trim(grd_display.Cells[1,grd_display.Row]) = '��ȸ�԰�') then
    begin
      progID := 'LOSTA110P';

      SetLength(Value, 5 );

      Value[0] := grd_display.Cells[ 8,grd_display.Row]; // ����
      Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]); // �������
      Value[2] := grd_display.Cells[ 5,grd_display.Row]; // �𵨸�
      Value[3] := grd_display.Cells[ 6,grd_display.Row]; // �ø����ȣ
      Value[4] := grd_display.Cells[17,grd_display.Row]; // �԰�����

      (****************************************************************************)
      (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
                    (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
          ;
    end
    else if ( Trim(grd_display.Cells[1,grd_display.Row]) = '��ȸ�԰�(����)') then
    begin
      progID := 'LOSTA710P';

      SetLength(Value, 5 );

      Value[0] := grd_display.Cells[ 8,grd_display.Row]; // ����
      Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]); // �������
      Value[2] := grd_display.Cells[ 5,grd_display.Row]; // �𵨸�
      Value[3] := grd_display.Cells[ 6,grd_display.Row]; // �ø����ȣ
      Value[4] := grd_display.Cells[17,grd_display.Row]; // �԰�����

      (****************************************************************************)
      (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
                    (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
          ;
    end
    else if ( Trim(grd_display.Cells[1,grd_display.Row]) = '��ü������') then
    begin
      progID := 'LOSTC100P';
      SetLength(Value, 9 );

      (* ����         *) Value[0] := grd_display.Cells[ 8,grd_display.Row];
      (* �������     *) Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]);
      (* �𵨸�       *) Value[2] := grd_display.Cells[ 5,grd_display.Row];
      (* �ø����ȣ   *) Value[3] := grd_display.Cells[ 6,grd_display.Row];
      (* �԰�����     *) if (Trim(DelHyphen(grd_display.Cells[17,grd_display.Row])) = '') then Value[4] := '-'
                         else Value[4] := Trim(DelHyphen(grd_display.Cells[17,grd_display.Row]));
      (* ��ü���ڵ�   *) Value[5] := grd_display.Cells[21,grd_display.Row];
      (* �������     *) if (Trim(DelHyphen(grd_display.Cells[17,grd_display.Row])) = '') then Value[6] := '-'
                         else Value[6] := Trim(DelHyphen(grd_display.Cells[17,grd_display.Row]));
      (* �����Ϸù�ȣ *) Value[7] := grd_display.Cells[22,grd_display.Row];
      (* �ֹε�Ϲ�ȣ *) Value[8] := delHyphen(grd_display.Cells[10,grd_display.Row]);


      (****************************************************************************)
      (* ���� ��ȸ Prog ���ϸ� �� �Ķ���� ����                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - ���ϸ�            *)         progID +'.exe'
                    (* paramstr(1) - �̿��� PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - �̿��� ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - �̿��� ��         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0] )
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1] )
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2] )
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3] )
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4] )
                    (* paramstr(11) -                  *)+ ' ' +  fNVL(Value[5] )
                    (* paramstr(12) -                  *)+ ' ' +  fNVL(Value[6] )
                    (* paramstr(13) -                  *)+ ' ' +  fNVL(Value[7] )
                    (* paramstr(14) -                  *)+ ' ' +  fNVL(Value[8] )
      ;
    end;
  end;

  ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

  if ret <= 31 then
  begin

    MessageBeep (0);

		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '�� ã�� �� �����ϴ�')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' ����� ���� �߻�');

    ShowWindow(Self.Handle, SW_SHOW);
  end;
  
end;

procedure Tfrm_LOSTE220Q.btn_LinkClick(Sender: TObject);
begin
  grd_displayDblClick(Sender);
end;

procedure Tfrm_LOSTE220Q.grd_displayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lnRow, lnCel: Integer;
  GR : TGridRect;
begin
  GR.Left   := -1;
  GR.Top    := -1;
  GR.Right  := -1;
  GR.Bottom := -1;

  grd_display.MouseToCell( x, y, lnRow, lnCel );

  if ( lnRow = -1) then
      grd_display.Selection := GR;


end;

// ���޺� Ŭ���� �̺�Ʈ
procedure Tfrm_LOSTE220Q.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick  := nil;
   md_cb1.OnKeyUp        := nil;
   md_grid1.OnClick      := nil;

   if not md_Grid1.Visible then md_Grid1.Visible  := true
   else md_Grid1.Visible  := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// �� �޺� KeyUp �̺�Ʈ
procedure Tfrm_LOSTE220Q.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   // ���� ���� ��
   if key = 13 then
   begin
      if md_grid1.Visible then
         md_grid1.Visible := false
      else
         md_grid1.Visible := true;

      md_cb1.Text := '';
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else

   //����Ű ���� ���� ��
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
         md_grid1.Row := md_grid1.Row - 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else

   // ����Ű �Ʒ��� ���� ��
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
         md_grid1.Row := md_grid1.Row + 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then
         md_grid1.Visible := true;
      for i := 0 to md_grid1.RowCount-1 do
      if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
      begin
         md_grid1.Row := i;
         break;
      end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// �� �׸��� Ŭ����
procedure Tfrm_LOSTE220Q.md_grid1Click(Sender: TObject);
begin
   md_cb1.text        := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible   := false;
end;

end.
