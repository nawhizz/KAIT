unit u_LOSTA220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
   TITLE   = '�н��� �ݼ� ���� ��ȸ';
   PGM_ID  = 'LOSTA220Q';

type
  Tfrm_LOSTA220Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_id_cd: TComboBox;
    grd_display: TStringGrid;
    KT_pnl: TPanel;
    LGU_pnl: TPanel;
    SKT_pnl: TPanel;
    PCS_pnl: TPanel;
    CELL_pnl: TPanel;
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
    btn_reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmb_id_cdChange(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);

    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click(Sender: TObject);
    procedure dte_fromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dte_toKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
  private
    { Private declarations }
  cmb_id_cd_d: TZ0xxArray;

  qryStr:String;
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
  frm_LOSTA220Q: Tfrm_LOSTA220Q;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA220Q.disableComponents;
begin
  dte_from.Enabled := false;
  dte_to.Enabled := false;
  cmb_id_cd.Enabled:= false;
  btn_Inquiry.Enabled := False;
  btn_excel.Enabled:= False;
  btn_close.Enabled:= False;
end;

procedure Tfrm_LOSTA220Q.enableComponents;
begin
  dte_from.Enabled := True;;
  dte_to.Enabled := True;;
  cmb_id_cd.Enabled:= True;;
  btn_Inquiry.Enabled := True;;
  btn_excel.Enabled:= True;;
  btn_close.Enabled:= True;;
end;

procedure Tfrm_LOSTA220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2; 
        ColCount := 19;
    	RowHeights[0] := 21;                

    	ColWidths[0] := 45;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 110;
		Cells[1,0] :='�ݼ�����';
                                            
    	ColWidths[2] := 110;                
		Cells[2,0] :='�������';            
                                            
    	ColWidths[3] := 120;
		Cells[3,0] :='�������ֹι�ȣ';
                                            
    	ColWidths[4] := 200;
		Cells[4,0] :='�����ڼ���';          
                                            
    	ColWidths[5] := 130;
		Cells[5,0] :='�����ڿ���ó';        
                                            
    	ColWidths[6] := 60;                      
		Cells[6,0] :='�����ȣ';                 
                                                 
    	ColWidths[7] := 400;
		Cells[7,0] :='�ּ�';

    	ColWidths[8] := 110;
		Cells[8,0] :='�԰�����';

    	ColWidths[9] := 110;
		Cells[9,0] :='����Ȯ������';

    	ColWidths[10] := -1;
		Cells[10,0] :='���ڵ�';

    	ColWidths[11] := 120;
		Cells[11,0] :='�𵨸�';

      ColWidths[12] := 100;
		Cells[12,0] :='�ܸ����Ϸù�ȣ';

      ColWidths[13] := -1;
		Cells[13,0] :='�ݼۻ����ڵ�';

      ColWidths[14] := 100;
		Cells[14,0] :='�ݼۻ���';

      ColWidths[15] := 100;
		Cells[15,0] :='�ݼ۹�ȣ';

      ColWidths[16] := 100;
		Cells[16,0] :='���������';

      ColWidths[17] := -1;
		Cells[17,0] :='ó�������ڵ�';

      ColWidths[18] := 100;
		Cells[18,0] :='ó�����и�';

    end;
end;

procedure Tfrm_LOSTA220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
 begin
   if (key = #13) then
     SelectNext( ActiveControl as TEdit , true, True);
 end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA220Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA220Q.FormCreate(Sender: TObject);
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

  {
  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  common_userid:= '0294'; //ParamStr(2);
  common_username:= '��ȣ��';
  ParamStr(3);
  common_usergroup:= 'SYSM'; //ParamStr(4);
  }

  btn_resetClick(Sender);

  frm_LOSTA220Q.Position := poScreenCenter;

	initSkinForm(SkinData1); //common_lib.pas�� �ִ�.
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', '�Ҹ�ܸ���',cmb_id_cd);

  initStrGrid;	//�׸��� �ʱ�ȭ

	qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA220Q.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;
  seq,RowPos:Integer;
  STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;

  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;
  seed_name, seed_idno, seed_tlno:String;

  Label LIQUIDATION;
  Label INQUIRY;
begin
    // ��ȣȭ ���
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

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
    STR008 :=' ';
    STR009 :=' ';

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';

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
	if (TMAX.SendString('INF003','LostA220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTA220Q') then goto LIQUIDATION;

    KT_pnl.Caption := 'KT '+ TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU+ '+ TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '+ TMAX.RecvString('INT104',0);
    PCS_pnl.Caption := '�Ҹ�PCS '+ TMAX.RecvString('INT105',0);
    CELL_pnl.Caption := '�Ҹ�CELL '+ TMAX.RecvString('INT106',0);

//	Goto LIQUIDATION;

//������ȸ
INQUIRY:
{
�Է�;
STR001 : �������� FROM
STR002 : �������� TO
STR003 : ����ڱ���
STR004 : ��ǰ��
STR005 : ��ȸ�������� ����
STR006 : ��ȸ���� �ֹι�ȣ
STR007 : ��ȸ���� ���ڵ�
STR008 : ��ȸ���� �Ϸù�ȣ
}
	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostA220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d [cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR004', delHyphen(STR004)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(STR005)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTA220Q') then
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

STR101 : �ݼ�����            
STR102 : ������ �ֹι�ȣ     
STR103 : ������ ���� (��ü��)
STR104 : ������ ��ȭ��ȣ     
STR105 : ������ �����ȣ     
STR106 : ������ �⺻�ּ�     
STR107 : ������ ���ּ�     
STR108 : ����ǰ��ǰ�����ڵ�  
STR109 : ����ǰ ��           
STR110 : ���ڵ��          
STR111 : �ܸ����Ϸù�ȣ      
STR112 : �ݼۻ���            
STR113 : �԰�����            
STR114 : ����ǰ �߼�����


INT100 : COUNT...��Ӱ� ....�б�
INF013 : ���� ī��Ʈ �� ...�б�

}
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := intToStr(seq);

          STR004 := delHyphen(Trim(TMAX.RecvString('STR101',i)));
          STR005 := delHyphen(Trim(TMAX.RecvString('STR102',i)));
          STR006 := delHyphen(Trim(TMAX.RecvString('STR103',i)));
          STR007 := Trim(TMAX.RecvString('STR110',i));
          STR008 := TMAX.RecvString('STR111',i);
          STR009 := delHyphen(Trim(TMAX.RecvString('STR108',i)));

        	Cells[1,RowPos] := TMAX.RecvString('STR101',i);
        	Cells[2,RowPos] := TMAX.RecvString('STR102',i);
        //Cells[3,RowPos] := InsHyphen(TMAX.RecvString('STR103',i));
          seed_idno       := InsHyphen(TMAX.RecvString('STR103',i));    // �������ֹι�ȣ
          Cells[3,RowPos] := InsHyphen(ECPlazaSeed.Decrypt(seed_idno, common_seedkey));
        //Cells[4,RowPos] := TMAX.RecvString('STR104',i);
          seed_name       := TMAX.RecvString('STR104',i);     // �����ڼ���
          Cells[4,RowPos] := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
        //Cells[5,RowPos] := TMAX.RecvString('STR105',i);
          seed_tlno       := TMAX.RecvString('STR105',i);		  // �����ڿ���ó
          Cells[5,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        	Cells[6,RowPos] := TMAX.RecvString('STR106',i);
        	Cells[7,RowPos] := TMAX.RecvString('STR107',i);
        	Cells[8,RowPos] := TMAX.RecvString('STR108',i);
          Cells[9,RowPos] := TMAX.RecvString('STR109',i);
        	Cells[10,RowPos] := STR007;
        	Cells[11,RowPos] := STR008;
          Cells[12,RowPos] := TMAX.RecvString('STR112',i);
          Cells[13,RowPos] := TMAX.RecvString('STR113',i);
          Cells[14,RowPos] := TMAX.RecvString('STR114',i);
          Cells[15,RowPos] := TMAX.RecvString('STR115',i);
          Cells[16,RowPos] := TMAX.RecvString('STR116',i);
          Cells[17,RowPos] := TMAX.RecvString('STR117',i);
          Cells[18,RowPos] := TMAX.RecvString('STR118',i);

{
STR005 : ��ȸ�������� ���� <- STR101
STR006 : ��ȸ���� �ֹι�ȣ <- STR102
STR007 : ��ȸ���� ���ڵ� <- STR109
STR008 : ��ȸ���� �Ϸù�ȣ <- STR111
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

procedure Tfrm_LOSTA220Q.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA220Q.FormShow(Sender: TObject);
begin
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Link.Enabled := False;
  btn_Print.Enabled := False;
  dte_from.SetFocus;

  if common_usergroup = 'SYSM' then begin
    btn_query.Enabled := True;
  end else begin btn_query.Enabled := False;
  end;

  cmb_id_cdChange(Sender);
  
end;

procedure Tfrm_LOSTA220Q.cmb_id_cdChange(Sender: TObject);
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

procedure Tfrm_LOSTA220Q.btn_queryClick(Sender: TObject);

var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA220Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA220Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('�н����ݼ۳�����ȸ(LOSTA220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA220Q');
end;

procedure Tfrm_LOSTA220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1..3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      5..6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8..10 :StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      11 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      13 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      14 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      15..16 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      17 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      18 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
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

procedure Tfrm_LOSTA220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTA220Q.Copy1Click(Sender: TObject);
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

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTA220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA220Q.dte_fromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
    dte_to.SetFocus;
end;

procedure Tfrm_LOSTA220Q.dte_toKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cmb_id_cd.SetFocus;
end;

procedure Tfrm_LOSTA220Q.cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA220Q.btn_resetClick(Sender: TObject);
begin
	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;

  KT_pnl.Caption := 'KT '+ '0';
  LGU_pnl.Caption := 'LGU+ '+ '0';
  SKT_pnl.Caption := 'SKT '+ '0';
  PCS_pnl.Caption := '�Ҹ�PCS '+ '0';
  CELL_pnl.Caption := '�Ҹ�CELL '+ '0';

  changeBtn(Self);
end;

end.
