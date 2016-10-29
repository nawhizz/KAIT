{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ150P (�޴� ���)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 19
�Ϸ���	      : ####. ##. ##
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTZ150P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ150P_CHILD, ComObj;

const
  TITLE   = '�޴� ���';
  PGM_ID  = 'LOSTZ150P';

type
  Tfrm_LOSTZ150P = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    cmb_mu_gu: TComboBox;
    sts_Message: TStatusBar;
    btn_query: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    cmb_mu_gu_d: TZ0xxArray;
    procedure initStrGrid;
    procedure initString;

  public
    { Public declarations }
  end;

var

  MU_GU_NM : String;
  MU_MV    : String;
  MU_SV    : String;
  MU_NM    : String;
  MU_TY_NM : String;
  PG_ID1   : String;
  MU_SQ    : String;
  US_YN    : String;
  MU_GU    : String;
  MU_TY    : String;
  PG_NM    : String;

  frm_LOSTZ150P: Tfrm_LOSTZ150P;

implementation

{$R *.dfm}

procedure Tfrm_LOSTZ150P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ150P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTZ150P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 11;
    	RowHeights[0] := 21;

    	ColWidths[0] := 150;
		Cells[0,0] :='�޴�����';

    	ColWidths[1] := 70;
		Cells[1,0] :='�߷���';

      ColWidths[2] := 70;
		Cells[2,0] :='�ҷ���';

      ColWidths[3] := 180;
		Cells[3,0] :='�޴���';

      ColWidths[4] := 85;
		Cells[4,0] :='�޴����¸�';

      ColWidths[5] := -1;
		Cells[5,0] :='���α׷�ID';

      ColWidths[6] := 95;
		Cells[6,0] :='�޴�����';

      ColWidths[7] := 85;
		Cells[7,0] :='��뿩��';

      ColWidths[8] := -1;
		Cells[8,0] :='�޴�����';

      ColWidths[9] := -1;
		Cells[9,0] :='�޴�����';

      ColWidths[10] := -1;
		Cells[10,0] :='���α׷���';
    end;
end;

procedure  Tfrm_LOSTZ150P.initString;
begin
  MU_GU_NM := '';
  MU_MV    := '';
  MU_SV    := '';
  MU_NM    := '';
  MU_TY_NM := '';
  PG_ID    := '';
  MU_SQ    := '';
  US_YN    := '';
  MU_GU    := '';
  MU_TY    := '';
  PG_NM    := '';
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTZ150P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
{------------------------------------------------------------------------------}
procedure Tfrm_LOSTZ150P.FormCreate(Sender: TObject);
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
  { }
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

  initSkinForm(SkinData1);
  initStrGrid;	//�׸��� �ʱ�ȭ
  initComboBoxWithZ0xx('Z094.dat', cmb_mu_gu_d, '��ü', ' ',cmb_mu_gu);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  qryStr := '';
  
end;

procedure Tfrm_LOSTZ150P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTZ150P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;
    btn_query.Enabled := True;
    
	  //�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ
    totalCount :=0;
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
	if (TMAX.SendString('INF003','LOSTZ150P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', cmb_mu_gu_d[cmb_mu_Gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTZ150P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;
  // ���� ��������
  qryStr:= TMAX.RecvString('INF014',0);
  //��ȸ�� ����
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

        Cells[0,RowPos] := TMAX.RecvString('STR101',i); //�޴����и� 
        Cells[1,RowPos] := TMAX.RecvString('INT101',i); //�޴��߷���
        Cells[2,RowPos] := TMAX.RecvString('INT102',i); //�޴��ҷ���
        Cells[3,RowPos] := TMAX.RecvString('STR104',i); //�޴���
        Cells[4,RowPos] := TMAX.RecvString('STR105',i); //�޴����¸�
        Cells[5,RowPos] := TMAX.RecvString('STR106',i); //���α׷�ID
        Cells[6,RowPos] := TMAX.RecvString('INT103',i); //�޴�����
        Cells[7,RowPos] := TMAX.RecvString('STR107',i); //��뿩��
        Cells[8,RowPos] := TMAX.RecvString('STR108',i); //�޴�����
        Cells[9,RowPos] := TMAX.RecvString('STR109',i); //�޴�����
        Cells[10,RowPos] := TMAX.RecvString('STR110',i); //���α׷� ��

        Inc(RowPos);
      end;
  end;
  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;

end;

procedure Tfrm_LOSTZ150P.grd_displayDrawCell(Sender: TObject; ACol,
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
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      1..2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      9 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
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

procedure Tfrm_LOSTZ150P.btn_AddClick(Sender: TObject);
begin
  initString;
  frm_LOSTZ150P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ150P.grd_displayDblClick(Sender: TObject);
begin

  initString;
  MU_GU_NM := grd_display.Cells[0, grd_display.Row]; //�޴����и�
  MU_MV    := grd_display.Cells[1, grd_display.Row]; //�޴��߷���
  MU_SV    := grd_display.Cells[2, grd_display.Row]; //�޴��ҷ���
  MU_NM    := grd_display.Cells[3, grd_display.Row]; //�޴���
  MU_TY_NM := grd_display.Cells[4, grd_display.Row]; //�޴����¸�
  PG_ID1   := grd_display.Cells[5, grd_display.Row]; //���α׷�ID
  MU_SQ    := grd_display.Cells[6, grd_display.Row]; //�޴�����
  US_YN    := grd_display.Cells[7, grd_display.Row]; //��뿩��
  MU_GU    := grd_display.Cells[8, grd_display.Row]; //�޴�����
  MU_TY    := grd_display.Cells[9, grd_display.Row]; //�޴�����
  PG_NM    := grd_display.Cells[10, grd_display.Row]; //���α׷� ��

  frm_LOSTZ150P_child.FormShow(Sender);



end;

procedure Tfrm_LOSTZ150P.btn_UpdateClick(Sender: TObject);
begin

  initString;
  MU_GU_NM := grd_display.Cells[0, grd_display.Row]; //�޴����и�
  MU_MV    := grd_display.Cells[1, grd_display.Row]; //�޴��߷���
  MU_SV    := grd_display.Cells[2, grd_display.Row]; //�޴��ҷ���
  MU_NM    := grd_display.Cells[3, grd_display.Row]; //�޴���
  MU_TY_NM := grd_display.Cells[4, grd_display.Row]; //�޴����¸�
  PG_ID1   := grd_display.Cells[5, grd_display.Row]; //���α׷�ID
  MU_SQ    := grd_display.Cells[6, grd_display.Row]; //�޴�����
  US_YN    := grd_display.Cells[7, grd_display.Row]; //��뿩��
  MU_GU    := grd_display.Cells[8, grd_display.Row]; //�޴�����
  MU_TY    := grd_display.Cells[9, grd_display.Row]; //�޴�����
  PG_NM    := grd_display.Cells[10, grd_display.Row]; //���α׷� ��

  frm_LOSTZ150P_child.FormShow(Sender);
end;

procedure Tfrm_LOSTZ150P.btn_DeleteClick(Sender: TObject);
begin
  initString;
  MU_GU_NM := grd_display.Cells[0, grd_display.Row]; //�޴����и�
  MU_MV    := grd_display.Cells[1, grd_display.Row]; //�޴��߷���
  MU_SV    := grd_display.Cells[2, grd_display.Row]; //�޴��ҷ���
  MU_NM    := grd_display.Cells[3, grd_display.Row]; //�޴���
  MU_TY_NM := grd_display.Cells[4, grd_display.Row]; //�޴����¸�
  PG_ID1   := grd_display.Cells[5, grd_display.Row]; //���α׷�ID
  MU_SQ    := grd_display.Cells[6, grd_display.Row]; //�޴�����
  US_YN    := grd_display.Cells[7, grd_display.Row]; //��뿩��
  MU_GU    := grd_display.Cells[8, grd_display.Row]; //�޴�����
  MU_TY    := grd_display.Cells[9, grd_display.Row]; //�޴�����
  PG_NM    := grd_display.Cells[10, grd_display.Row]; //���α׷� ��

  frm_LOSTZ150P_child.FormShow(Sender);
end;

procedure Tfrm_LOSTZ150P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ150P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_query.Enabled := False;


  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

end;

procedure Tfrm_LOSTZ150P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTZ150P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
