{*---------------------------------------------------------------------------
���α׷�ID    : LOSTE100P (��������޴ܸ��� �Ű� ���)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 09. 02
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
unit u_LOSTE100P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls,
  Grids, so_tmax, WinSkinData, common_lib, Menus,Clipbrd, ComObj;

const
  TITLE   = '��������޴ܸ��� �Ű� ���';
  PGM_ID  = 'LOSTE100P';

type
  Tfrm_LOSTE100P = class(TForm)
    Bevel2          : TBevel;
    Bevel12         : TBevel;
    Bevel1          : TBevel;
    cmb_in_su: TComboBox;
    dte_Ip_Dt       : TDateEdit;
    lbl_Program_Name: TLabel;
    Label1          : TLabel;
    Label6          : TLabel;
    Panel1          : TPanel;
    pnl_Command     : TPanel;
    PopupMenu1      : TPopupMenu;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    grd_display     : TStringGrid;
    TMAX            : TTMAX;
    btn_Close: TSpeedButton;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);

{========== �׸��� �Լ� =======================================================}
    procedure initStrGrid;

    procedure grd_displayDrawCell(Sender: TObject; ACol,
    ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);

    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);

    procedure Copy1Click(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

{========== End of �׸��� �Լ� =================================================}    
  private
    { Private declarations }
    cmb_in_su_d :TZ0xxArray;

     procedure InitComponents;
     procedure disableComponents;
     procedure enableComponents;

  public
    { Public declarations }
  end;

  (* PGM_STS : ���α׷� ����  *)
  (* 0 : ��ȸ��               *)
  (* 1 : ��ȸ��               *)
  (* 2,3 : ������             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTE100P: Tfrm_LOSTE100P;

  pgm_sts1   : PGM_STS;

  qryStr:String;

implementation
uses cpaklibm;
{$R *.DFM}

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE100P.FormCreate(Sender: TObject);
begin

   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then begin
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
   end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle   := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '��ȣ��';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

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

    //common_lib.pas�� �ִ�.
    initSkinForm(SkinData1);
    initComboBoxWithZ0xx ('Z085.dat', cmb_in_su_d, '��ü', '',cmb_in_su );

    initStrGrid;

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTE100P.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTE100P.InitComponents;
begin

  // ��ȸ ���� ���۳�Ʈ UnLock
  dte_Ip_Dt.Enabled   := True;
  cmb_in_su.Enabled   := True;

  dte_Ip_Dt.Date      := date;

  cmb_in_su.ItemIndex := 0;

  // ��ư �ʱ�ȭ
  changeBtn(Self);



  pgm_sts1 := [0];

  btn_Update.Enabled := false;
  btn_Delete.Enabled := false;
  btn_query.Enabled  := True;

  qryStr := '';



end;

{*******************************************************************************
* procedure Name : disableComponents
* �� �� �� �� :��ư�� ������ ���ϰ� �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTE100P.disableComponents;
begin
  dte_Ip_Dt.Enabled := false;
  btn_Inquiry.Enabled := False;

  btn_close.Enabled:= False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* �� �� �� �� :��ư�� ���� �ٸ� ����� �� �� �ְ��Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTE100P.enableComponents;
begin
  dte_Ip_Dt.Enabled    := True;
  btn_Inquiry.Enabled := True;

  btn_close.Enabled:= True;
end;

{==============================================================================}
{ Section : �׸��� �ʱ�ȭ �� ���� �Լ�                                         }
{==============================================================================}

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTE100P.initStrGrid;
var i : integer;
  procedure rowInit;
  var
     i,j : Integer;
  begin
    for i := 0 to grd_display.RowCount + 1 do
      for j := 0 to grd_display.ColCount + 1 do
        grd_display.cells[i,j] := '';
  end;

begin

  rowInit;

	with grd_display do
  begin
    rowInit;

    RowCount      := cmb_in_su.Items.Count;
    ColCount      := 7;
    RowHeights[0] := 21;

    Cols[0].Add('������');
    Cols[1].Add('KT');
    Cols[2].Add('LGU+');
    Cols[3].Add('SKT');
    Cols[4].Add('�Ҹ�');
    Cols[5].Add('����');
    Cols[6].Add('������');

    for i := 0 to cmb_in_su.Items.Count do
      Rows[i+1].Add(cmb_in_su.Items.Strings[i+1]);

    end;


end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTE100P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];
  if (ARow = 0) then
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
        0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
        1..6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      end;
    end;

end;

{*******************************************************************************
* procedure Name : grd_displayKeyDown
* �� �� �� �� : Ű�ٿ �ش��ϴ� ������ �Ѵ�.(Ctrl + C)�� ���� ��� ����
*******************************************************************************}
procedure Tfrm_LOSTE100P.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTE100P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
procedure Tfrm_LOSTE100P.Copy1Click(Sender: TObject);
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
{==============================================================================}
{  End of �׸��� ���� ����                                                     }
{==============================================================================}

procedure Tfrm_LOSTE100P.btn_InquiryClick(Sender: TObject);
var
    i,j : Integer;

    Label LIQUIDATION;

begin
  initStrGrid;

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

  //�����Է� �κ�
  if (TMAX.SendString('INF002',common_userid                          ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_username                        ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_usergroup                       ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF003',PGM_ID                                 ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('INF001','S01'                                  ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', delHyphen(dte_Ip_Dt.Text)             ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', cmb_in_su_d[cmb_in_su.itemIndex].code ) < 0) then  goto LIQUIDATION;

  // ����� ������ ���� �Ϸ�

  //���� ȣ��
  if not TMAX.Call(PGM_ID) then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  if TMAX.RecvInteger('INF013',0) = 0 then
  begin
    ShowMessage('��ȸ �Ǽ��� �����ϴ�.');
    goto LIQUIDATION;
  end;

  qryStr := '';

  with grd_display do
  begin
    for i:=0 to RowCount -2 do
    begin
      for j := 1 to RowCount - 1 do
      if ( Trim(TMAX.RecvString('STR102',i)) = Trim(Cells[0,j])) then
      begin
        Cells[1,j]   := convertWithCommer(TMAX.RecvString('INT103',i));
        Cells[2,j]   := convertWithCommer(TMAX.RecvString('INT104',i));
        Cells[3,j]   := convertWithCommer(TMAX.RecvString('INT105',i));
        Cells[4,j]   := convertWithCommer(TMAX.RecvString('INT106',i));
        Cells[5,j]   := convertWithCommer(TMAX.RecvString('INT107',i));
        Cells[6,j]   := convertWithCommer(TMAX.RecvString('INT108',i));
      end;
    end;
  end;

  pgm_sts1 := [1];

  // ��ȸ ���� ���۳�Ʈ Lock
  dte_Ip_Dt.Enabled := False;
  cmb_in_su.Enabled := False;

  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + TMAX.RecvString('INF012',0);

  qryStr:= TMAX.RecvString('INF014',0);  


LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  enableComponents;
end;

procedure Tfrm_LOSTE100P.btn_AddClick(Sender: TObject);
var
    i : Integer;

    Label LIQUIDATION;

begin
    if pgm_sts1 = [0] then
    begin
      ShowMessage('��ȸ �� �����Ͻ� �� �ֽ��ϴ�.');
      Exit;
    end;

    sts_Message.Panels[1].Text := '';

    initStrGrid;

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

    //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid                          ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username                        ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup                       ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003',PGM_ID                                 ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','I01'                                  ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(dte_Ip_Dt.Text)             ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', cmb_in_su_d[cmb_in_su.itemIndex].code ) < 0) then  goto LIQUIDATION;

    // ����� ������ ���� �Ϸ�

    //���� ȣ��
    if not TMAX.Call(PGM_ID) then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���

    ShowMessage(ADD_SUCCESS);

    InitComponents;

    sts_Message.Panels[1].Text := TMAX.RecvString('INF012',0);

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�

  enableComponents;
end;

procedure Tfrm_LOSTE100P.btn_resetClick(Sender: TObject);
begin
  Self.InitComponents
end;

procedure Tfrm_LOSTE100P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
  InitComponents;
end;

procedure Tfrm_LOSTE100P.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f         :TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + 'QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
