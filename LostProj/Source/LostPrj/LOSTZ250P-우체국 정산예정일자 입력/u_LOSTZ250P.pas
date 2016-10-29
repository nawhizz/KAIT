{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ250P (��ü�� ���꿹������ �Է�)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 27
�Ϸ���	      : ####. ##. ##
���α׷� ���� : ���� �ڵ� �ڷḦ ���, ����, ����, ��ȸ�Ѵ�.
     * TYPE���� �Է�ȭ��� �������� ����ϹǷ� IMPLEMENTATION ���ʿ� ��ġ....
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ250P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, Menus,Clipbrd,u_LOSTZ250P_CHILD, ComObj;

const
  TITLE   = '��ü�����꿹������ �Է�';
  PGM_ID  = 'LOSTZ250P';

type
  Tfrm_LOSTZ250P = class(TForm)
    pnl_Command: TPanel;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    grd_display: TStringGrid;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    sts_Message: TStatusBar;
    cmb_year: TEdit;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure cmb_yearKeyPress(Sender: TObject; var Key: Char);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    qryStr:String;
    procedure initStrGrid;
    procedure initString;
  public
    { Public declarations }
  end;

var

  AC_YM : String;
  DU_DT : String;
  AC_DT : String;
  AC_GU : String;
  AC_NM : String;

  frm_LOSTZ250P: Tfrm_LOSTZ250P;

implementation

{$R *.dfm}

procedure Tfrm_LOSTZ250P.setEdtKeyPress;
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


procedure Tfrm_LOSTZ250P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTZ250P.initString;
begin
  AC_YM := '';
  DU_DT := '';
  AC_DT := '';
  AC_GU := '';
  AC_NM := '';
end;


procedure Tfrm_LOSTZ250P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 5;
    	RowHeights[0] := 21;

    	ColWidths[0] := 100;
		Cells[0,0] :='�����';

    	ColWidths[1] := 150;
		Cells[1,0] :='���꿹������';

      ColWidths[2] := 150;
		Cells[2,0] :='������������';

      ColWidths[3] := 100;
		Cells[3,0] :='���걸��';

      ColWidths[4] := 210;
		Cells[4,0] :='���걸�и�';

    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTZ250P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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


procedure Tfrm_LOSTZ250P.FormCreate(Sender: TObject);
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

  initSkinForm(SkinData1);
  initStrGrid;	//�׸��� �ʱ�ȭ
  
  qryStr := '';
  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ250P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTZ250P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ250P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;
    filePath:='..\Temp\LOSTZ250Z_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ250P.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('��ü�� ���� �������� �Է� (LOSTZ250P)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTZ250P');
end;

procedure Tfrm_LOSTZ250P.grd_displayDrawCell(Sender: TObject; ACol,
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
      0..3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
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


procedure Tfrm_LOSTZ250P.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTZ250P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;
    Label LIQUIDATION;
    Label INQUIRY;
begin
    btn_Add.Enabled := True;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;

    if Length(cmb_year.text) < 4 then begin
      ShowMessage('����⵵�� �Է����ֽʽÿ�.');
      exit;
    end;

 	  //�׸��� ���÷���
    seq:= 1; 	//����
    RowPos:= 1;	//�׸��� ���ڵ� ������
    grd_display.RowCount := 2;

    //���۽ú��� �ʱ�ȭ

    totalCount :=0;
    qryStr:= '';	//���� ��Ʈ����...'����'��ư�� Ŭ������ �� ������.
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
  goto INQUIRY;

INQUIRY:
	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ250P') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_year.Text) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTZ250P') then
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

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos] := TMAX.RecvString('STR101',i); // �����
          Cells[1,RowPos] := InsHyphen(TMAX.RecvString('STR102',i)); // ���꿹������
          Cells[2,RowPos] := InsHyphen(TMAX.RecvString('STR103',i)); // ������������
          Cells[3,RowPos] := TMAX.RecvString('STR104',i); // ���걸��    
          Cells[4,RowPos] := TMAX.RecvString('STR105',i); // ���걸�и�

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
    grd_display.RowCount := grd_display.RowCount -1;


end;

procedure Tfrm_LOSTZ250P.cmb_yearKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('���ڸ� �Է��ϼ���');
  end;
  
  if Key = #13 then begin
    btn_InquiryClick(Sender);
  end;
end;

procedure Tfrm_LOSTZ250P.btn_AddClick(Sender: TObject);
begin
  initString;

  AC_DT := grd_display.Cells[2, grd_display.Row];
  frm_LOSTZ250P_CHILD.FormShow(Sender);

end;



procedure Tfrm_LOSTZ250P.btn_UpdateClick(Sender: TObject);
begin
  initString;

  AC_YM := grd_display.Cells[0, grd_display.Row];
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := grd_display.Cells[2, grd_display.Row];
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];



  frm_LOSTZ250P_CHILD.FormShow(Sender);
end;


procedure Tfrm_LOSTZ250P.grd_displayDblClick(Sender: TObject);
begin
  AC_YM := grd_display.Cells[0, grd_display.Row];
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := grd_display.Cells[2, grd_display.Row];
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ250P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ250P.btn_DeleteClick(Sender: TObject);
begin
  AC_YM := delHyphen(grd_display.Cells[0, grd_display.Row]);
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := delHyphen(grd_display.Cells[2, grd_display.Row]);
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];
  if (AC_DT = '') then begin
    frm_LOSTZ250P_CHILD.FormShow(Sender);
  end else
    ShowMessage('�������ڰ� �����Ͽ� ����,�����Ҽ� �����ϴ�.');
    exit;
end;

procedure Tfrm_LOSTZ250P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;

  cmb_year.Text := Copy(DateToStr(Date),1,4);

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';     
end;

end.


