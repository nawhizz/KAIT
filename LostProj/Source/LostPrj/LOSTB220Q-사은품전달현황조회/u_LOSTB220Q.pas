{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA240Q ( �н��� ���º� ��Ȳ (�Ϻ�))
���α׷� ���� : Online
�ۼ���	      : ������
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

unit u_LOSTB220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
  TITLE   = '����ǰ������Ȳ��ȸ';
  PGM_ID  = 'LOSTB220Q';

type
TZ001 = record
	name: String[20];
    code: String[10];
    Jcode1: String[10];
    Jcode2: String[10];
    JCode3: String[10];
    JCode4: String[10];
    Used: Char;
end;

type
  Tfrm_LOSTB220Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    grd_display: TStringGrid;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_id_cd: TComboBox;
    SkinData1: TSkinData;
    SKT_pnl: TPanel;
    LGU_pnl: TPanel;
    KT_pnl: TPanel;
    TMAX: TTMAX;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    PCS_pnl: TPanel;
    Cell_pnl: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure cmb_id_cdChange(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btn_queryClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    z001Data:Array of TZ001;
    z001DataCount:Integer;
    qryStr:String;

	cmb_id_cd_d:TZ0xxArray;
    //�޺��ڽ� �ʱ�ȭ
    procedure initComboBox;
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
  frm_LOSTB220Q: Tfrm_LOSTB220Q;

implementation
{$R *.DFM}

procedure Tfrm_LOSTB220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTB220Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB220Q.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_id_cd.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

//�׸����� ù��° ����(�޸�)�� �̻ڰ� Ʃ���Ѵ�.
procedure Tfrm_LOSTB220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    end;
{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

//�� �ʵ��� ���� ���� ����, Ȯ�� �� �� ������ ��.
procedure Tfrm_LOSTB220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 12;
    	RowHeights[0] := 21;

    	ColWidths[0] := 45;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 80;
		Cells[1,0] :='��������';

    	ColWidths[2] := 110;
		Cells[2,0] :='�ֹλ���ڹ�ȣ';

    	ColWidths[3] := 100;
		Cells[3,0] :='����(��ü��)';

    	ColWidths[4] := 110;
		Cells[4,0] :='��ȯ��ȣ';

    	ColWidths[5] := 60;
		Cells[5,0] :='�����ȣ';

    	ColWidths[6] := 350;
		Cells[6,0] :='�ּ�';

    	ColWidths[7] := 60;
		Cells[7,0] :='��ǰ�ڵ�';

    	ColWidths[8] := 60;
		Cells[8,0] :='��ǰ��';

    	ColWidths[9] := 60;
		Cells[9,0] :='���ڵ�';

    	ColWidths[10] := 75;
		Cells[10,0] :='�𵨸�';

    	ColWidths[11] := 120;
		Cells[11,0] :='�ܸ����Ϸù�ȣ';
    end;
end;

//�޺��ڽ��� ä���� �׸��� ���Ͽ��� �о� ���δ�.
procedure Tfrm_LOSTB220Q.initComboBox;
begin
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', '�Ҹ�ܸ���', cmb_id_cd);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB220Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;

procedure Tfrm_LOSTB220Q.FormCreate(Sender: TObject);
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
    	ShowMessage('�α��� �� ���� �ϼ���');
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

	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.
  initComboBox;	//�޺��ڽ� ä��
  initStrGrid;	//�׸��� �ʱ�ȭ


	qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

//��ȸ��ư Ŭ��
procedure Tfrm_LOSTB220Q.btn_InquiryClick(Sender: TObject);
var
    // ��ȣȭ ���� ����
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;
	STR004 : String;
	STR005 : String;
	STR006 : String;
	STR007 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

	//�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    pInitStrGrd(Self);

    //���۽ú��� �ʱ�ȭ
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
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

	//�б���....
    if cmb_id_cd_d[cmb_id_cd.ItemIndex].name <> '��ü' then
    	goto INQUIRY;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;

    KT_pnl.Caption := 'KT '+ TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU '+ TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '+ TMAX.RecvString('INT104',0);
    PCS_pnl.Caption := 'PCS�Ҹ� '+ TMAX.RecvString('INT105',0);
    CELL_pnl.Caption := 'CELL�Ҹ� '+ TMAX.RecvString('INT106',0);

    //PCS�Ҹ�
    //CELL�Ҹ�

//	Goto LIQUIDATION;

//������ȸ
INQUIRY:
{
�Է�;
STR001 : �������� FROM
STR002 : �������� TO
STR003 : ����ڱ���
STR004 : ��ȸ�������� ����
STR005 : ��ȸ���� �ֹι�ȣ
STR006 : ��ȸ���� ���ڵ�
STR007 : ��ȸ���� �Ϸù�ȣ
}
	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;

    //���� ȣ��
  //���� ȣ��
  if not TMAX.Call('LOSTB220Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;

//grd_display
{
SEQ
��������
�ֹλ���ڹ�ȣ
����(��ü��)
��ȯ��ȣ
�����ȣ
�ּ�
��ǰ�ڵ�
��ǰ��
���ڵ�
�𵨸�
�ܸ����Ϸù�ȣ

���
STR101 : ��������
STR102 : �ֹλ���ڹ�ȣ
STR103 : ����(��ü��)
STR104 : ��ȯ��ȣ
STR105 : �����ȣ
STR106 : �ּ�
STR107 : ��ǰ�ڵ�
STR108 : ��ǰ��
STR109 : ���ڵ�
STR110 : �𵨸�
STR111 : �ܸ����Ϸù�ȣ

INT100 : COUNT...��Ӱ� ....�б�
INF013 : ���� ī��Ʈ �� ...�б�

}
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
    goto LIQUIDATION;
  end;
    
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := intToStr(seq);

          STR004 := delHyphen(Trim(TMAX.RecvString('STR101',i)));
        	Cells[1,RowPos] := TMAX.RecvString('STR101',i);

          seed_idno       := TMAX.RecvString('STR102',i);
          Cells[2,RowPos] := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
          STR005 := delHyphen(Cells[2,RowPos]);

          seed_name       := TMAX.RecvString('STR103',i);
        	Cells[3,RowPos] := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
        	seed_tlno       := TMAX.RecvString('STR104',i);
          Cells[4,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        	Cells[5,RowPos] := TMAX.RecvString('STR105',i);
        	Cells[6,RowPos] := TMAX.RecvString('STR106',i);
        	Cells[7,RowPos] := TMAX.RecvString('STR107',i);
        	Cells[8,RowPos] := TMAX.RecvString('STR108',i);

            STR006 := Trim(TMAX.RecvString('STR109',i));
        	Cells[9,RowPos] := STR006;

        	Cells[10,RowPos] := Trim(TMAX.RecvString('STR110',i));

            STR007:= TMAX.RecvString('STR111',i);
        	Cells[11,RowPos] := STR007;
{
STR004 : ��ȸ�������� ���� <- STR101
STR005 : ��ȸ���� �ֹι�ȣ <- STR102
STR006 : ��ȸ���� ���ڵ� <- STR109
STR007 : ��ȸ���� �Ϸù�ȣ <- STR111
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

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;
end;

procedure Tfrm_LOSTB220Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);

end;

//OnExit --- dte_to
procedure Tfrm_LOSTB220Q.dte_toExit(Sender: TObject);
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

//OnExit --- dte_from
procedure Tfrm_LOSTB220Q.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

//OnChange ---�޺��ڽ�
procedure Tfrm_LOSTB220Q.cmb_id_cdChange(Sender: TObject);
begin
	if cmb_id_cd.ItemIndex =0 then begin
    KT_pnl.Visible:= True;
    LGU_pnl.Visible:= True;
    SKT_pnl.Visible := True;
		PCS_pnl.Visible := True;
		CELL_pnl.Visible := True;
    end

	else begin
    KT_pnl.Visible:= false;
    LGU_pnl.Visible:= false;
    SKT_pnl.Visible := false;
		PCS_pnl.Visible := false;
		CELL_pnl.Visible := false;
    end;
end;

//'����'��ư Ŭ�� -- ������ �����е� â�� ������.(��Ʈ�е�� Ư�����ڷ� ���� ����)
procedure Tfrm_LOSTB220Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB220Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

//�˾��޴�(���콺�� �����ʹ�ư�� Ŭ��) -- �׸����� ������ Ŭ�����忡 ����
procedure Tfrm_LOSTB220Q.Copy1Click(Sender: TObject);
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

//'����'��ư Ŭ�� --- �׸����� ������ ������ ������ ȭ�鿡 ��������.
//'Proc_gridtoexcel' ���ν����� Func_Lib.pas �� �ִ�.
procedure Tfrm_LOSTB220Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('��ȸ����(LOSTB220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB220Q');
end;

//CTRL+C �� ������ ��� �׸����� ������ Ŭ�����忡 �����Ѵ�.
procedure Tfrm_LOSTB220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB220Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  dte_from.Date := date - 30;
  dte_to.Date := date;
	dte_from.SetFocus;
  changeBtn(Self);

  cmb_id_cd.ItemIndex := 0;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  KT_pnl.Caption := 'KT '+ '0';
  LGU_pnl.Caption := 'LGU '+ '0';
  SKT_pnl.Caption := 'SKT '+ '0';
  PCS_pnl.Caption := 'PCS�Ҹ� '+ '0';
  CELL_pnl.Caption := 'CELL�Ҹ� '+ '0';

    

end;

end.
