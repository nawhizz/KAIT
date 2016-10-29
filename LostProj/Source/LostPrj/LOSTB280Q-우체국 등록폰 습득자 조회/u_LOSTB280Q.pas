{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB280Q (��ü�� ����� ������ ��ȸ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011.09.29
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

unit u_LOSTB280Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  common_lib, WinSkinData, so_tmax,Func_Lib, ComObj;

type
  Tfrm_LOSTB280Q = class(TForm)
    pnl_Command:      TPanel;
    sts_Message:      TStatusBar;
    Panel2:           TPanel;
    Bevel2:           TBevel;
    Label2:           TLabel;
    Bevel1:           TBevel;
    pnl_Program_Name: TLabel;
    btn_Add:          TSpeedButton;
    btn_Update:       TSpeedButton;
    btn_Delete:       TSpeedButton;
    btn_Inquiry:      TSpeedButton;
    btn_Next_Inq:     TSpeedButton;
    btn_Print:        TSpeedButton;
    btn_Close:        TSpeedButton;
    SkinData1:        TSkinData;
    TMAX:             TTMAX;
    grd_display: TStringGrid;
    btn_Excel: TSpeedButton;
    edt_nm: TEdit;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);


    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);
    procedure edt_nmKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTB280Q: Tfrm_LOSTB280Q;


implementation

{$R *.DFM}

{*******************************************************************************
* procedure Name : initStrGrid
* �� �� �� �� : �׸��带 �ʱ�ȭ �ϰ� �ʵ� Ÿ��Ʋ ������ �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.initStrGrid;
var
  j : Integer;
begin
	with grd_display do begin
    j := 0;
    RowCount := 2;
    ColCount := 10;
    RowHeights[0] := 21;

    cells[fInc(j),0] := '����';
    cells[fInc(j),0] := '�������';
    cells[fInc(j),0] := '�����ڸ�';
    cells[fInc(j),0] := '�����ڵ�';
    cells[fInc(j),0] := '����';
    cells[fInc(j),0] := '���뿩��';
    cells[fInc(j),0] := '��������';
    cells[fInc(j),0] := '���ڵ�';
    cells[fInc(j),0] := '�𵨸�';
    cells[fInc(j),0] := '�Ϸù�ȣ';

    j := 0;

    colwidths[fInc(j)] :=  60;   //����
    colwidths[fInc(j)] := 100;   //�������
    colwidths[fInc(j)] := 140;   //�����ڸ�
    colwidths[fInc(j)] :=  -1;   //�����ڵ�
    colwidths[fInc(j)] := 140;   //����
    colwidths[fInc(j)] :=  80;   //���뿩��
    colwidths[fInc(j)] := 120;   //��������
    colwidths[fInc(j)] :=  -1;   //���ڵ�
    colwidths[fInc(j)] := 100;   //�𵨸�
    colwidths[fInc(j)] := 160;   //�Ϸù�ȣ

  end;

end;

procedure Tfrm_LOSTB280Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB280Q.FormCreate(Sender: TObject);
begin
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
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

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//  common_userid       := '0294'   ;  // ParamStr(2);
//  common_username     := '��ȣ��' ;  // ParamStr(3);
//  common_usergroup    := 'SYSM'   ;  // ParamStr(4);

    //��Ų �ʱ�ȭ
    initSkinForm(SkinData1);      // common_lib.pas�� �ִ�.

    // �׸��� �ʱ�ȭ
    initStrGrid;

    edt_nm.Clear;

    //��ư�̹��� �ʱ�ȭ
    changeBtn(Self);

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB280Q.btn_InquiryClick(Sender: TObject);
var
    i,j: Integer;

    Label LIQUIDATION;

begin

    grd_display.RowCount := 2;

    grd_display.Cursor := crSQLWait;	//�۾���....

    disableComponents;	//�۾��� �ٸ� ��� ��� ����.

    //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

	  TMAX.InitBuffer;

    //�����Է� �κ�
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LostB280Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', Trim(edt_nm.Text)) < 0) then  goto LIQUIDATION;

    // ����� ������ ���� �Ϸ�

    //���� ȣ��
    if not TMAX.Call('LOSTB280Q') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    end;

    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INF013',0);

    with grd_display do begin
        for i:=0 to TMAX.RecvInteger('INF013',0) -1 do
        begin

          Cells[ 0,i+1]   := IntToStr(i + 1);               //  ����
          Cells[ 1,i+1]   := InsHyphen( TMAX.RecvString('STR101',i));  //  �������
          Cells[ 2,i+1]   := TMAX.RecvString('STR102',i);  //  �����ڸ�
          Cells[ 3,i+1]   := TMAX.RecvString('STR103',i);  //  �����ڵ�
          Cells[ 4,i+1]   := TMAX.RecvString('STR104',i);  //  ����
          Cells[ 5,i+1]   := TMAX.RecvString('STR105',i);  //  ���뿩��
          Cells[ 6,i+1]   := TMAX.RecvString('STR106',i);  //  ��������
          Cells[ 7,i+1]   := TMAX.RecvString('STR107',i);  //  ���ڵ�
          Cells[ 8,i+1]   := TMAX.RecvString('STR108',i);  //  �𵨸�
          Cells[ 9,i+1]   := TMAX.RecvString('STR109',i);  //  �Ϸù�ȣ

        end;
    end;

    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + IntToStr(TMAX.RecvInteger('INF013',0)) + '���� ��ȸ �Ǿ����ϴ�.';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//�۾��Ϸ�
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

{*******************************************************************************
* procedure Name : disableComponents
* �� �� �� �� :��ư�� ������ ���ϰ� �Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.disableComponents;
begin
  edt_nm.Enabled    := false;

  btn_Inquiry.Enabled := False;

  btn_close.Enabled   := False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* �� �� �� �� :��ư�� ���� �ٸ� ����� �� �� �ְ��Ѵ�.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.enableComponents;
begin
  edt_nm.Enabled    := True;

  btn_Inquiry.Enabled := True;

  btn_close.Enabled   := True;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* �� �� �� �� : �׸��� Ÿ��Ʋ �κп� ���� ���ڷ��̼� ȿ���� �ش�.
*
*******************************************************************************}
procedure Tfrm_LOSTB280Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      2,3,6   : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      else        StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;
  end;

end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB280Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel('��ü�� ����� ������ ��ȸ(LOSTB280Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB280Q');
end;

procedure Tfrm_LOSTB280Q.edt_nmKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

end.
