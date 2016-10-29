unit u_LOSTT250Q_CHILD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, so_tmax, StdCtrls, ComCtrls, Mask, ToolEdit, Buttons, ExtCtrls,
  common_lib,Grids, WinSkinData,u_LOSTT250Q, ComObj;

const
  TITLE   = '������������ȸ(����)';
  PGM_ID  = 'LOSTT250Q_CHILD';

type
  Tfm_LOSTT250Q_CHILD = class(TForm)
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    Panel1: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cmb_dt_gbn: TComboBox;
    cmb_prog_sts: TComboBox;
    dte_dt_st: TDateEdit;
    dte_dt_ed: TDateEdit;
    TMAX: TTMAX;
    pnl_Command: TPanel;
    pnl_Program_Name: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; i_align : integer);
    procedure btn_queryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure InitComponent;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);


  private
    { Private declarations }
    isData:Boolean;	            
    grdFocousEnable:Boolean;
    qryStr:String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;


  end;

var
  fm_LOSTT250Q_CHILD: Tfm_LOSTT250Q_CHILD;

implementation

{$R *.dfm}

procedure Tfm_LOSTT250Q_CHILD.FormCreate(Sender: TObject);
begin
{   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;
}
    //���뺯�� ����--common_lib.pas ������ ��.
  common_kait         := ParamStr(1);
	common_caller       := ParamStr(2);
  common_handle       := intToStr(self.Handle);
	common_userid     := ParamStr(3);
	common_username   := ParamStr(4);
	common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//  common_userid       := '0294'   ;  // ParamStr(2);
//  common_username     := '��ȣ��' ;  // ParamStr(3);
//  common_usergroup    := 'SYSM'   ;  // ParamStr(4);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ĸ�� ����
  pnl_Program_Name.Caption := TITLE;

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

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTT250Q_CHILD.InitComponent;
begin
  dte_dt_st.Date  := date-30;
  dte_dt_ed.Date  := date;
  grdFocousEnable := True;

  // ��ư �̹��� �ʱ�ȭ
  changeBtn(Self);

  btn_Delete.Enabled  := False;
  btn_Add.Enabled     := False;
  btn_Update.Enabled  := False;
  btn_Print.Enabled   := False;

  cmb_prog_sts.ItemIndex := 0;
  cmb_dt_gbn.ItemIndex   := 0;

  pInitStrGrd(self);

  // �׸��� �ʱ�ȭ
  initStrGrid;

  sts_Message.Panels[1].Text := '';
end;

procedure Tfm_LOSTT250Q_CHILD.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  totalCount:Integer;
  STR001,STR002,STR003,STR004:String;

  Label LIQUIDATION;
begin

  pInitStrGrd(Self);

  qryStr := '';
	//�׸��� ���÷���

  grd_display.RowCount  := 2;
  grd_display.FixedRows := 1;
  isData                := False; //��Ʈ�� �׸��忡 �����Ͱ� ����.

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

	TMAX.InitBuffer;

	(* 	��ȸ���ڱ��� *)  STR001  := IntToStr(cmb_dt_gbn.itemIndex);
	(* 	��ȸ�������� *)  STR002  := delHyphen(dte_dt_st.Text);
	(* 	��ȸ�������� *)  STR003  := delHyphen(dte_dt_ed.text);
	(* 	���࿩��	   *)  STR004  := Trim(Copy(cmb_prog_sts.Items.Strings[cmb_prog_sts.itemIndex],41,10));

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004            ) < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTT100P') then goto LIQUIDATION;

	totalCount := TMAX.RecvInteger('INT100',0);

  if totalCount > 0 then
    isData:= True;	//��Ʈ���׸��忡 �����Ͱ� �ִ�.

  grd_display.RowCount := grd_display.RowCount + totalCount;

  with grd_display do begin
    for i:=0 to totalCount-1 do
      begin
        (* SEQ            *) Cells[ 0,i+1] := intToStr(i+1);    //����
        (* �۾�����       *) Cells[ 1,i+1] :=                 TMAX.RecvString ('STR101',i);
        (* �۾��Ϸù�ȣ   *) Cells[ 2,i+1] := IntToStr(       TMAX.RecvInteger('INT102',i));
        (* ���ڱ����ڵ�   *) Cells[ 3,i+1] :=                 TMAX.RecvString ('STR103',i);
        (* ���ڱ����ڵ�� *) Cells[ 4,i+1] :=                 TMAX.RecvString ('STR104',i);
        (* ��������       *) Cells[ 5,i+1] := InsHyphen(      TMAX.RecvString ('STR105',i));
        (* ��������       *) Cells[ 6,i+1] := InsHyphen(      TMAX.RecvString ('STR106',i));
        (* �������       *) Cells[ 7,i+1] := Trim(           TMAX.RecvString ('STR107',i));
        (* ��������       *) Cells[ 8,i+1] := Trim(           TMAX.RecvString ('STR108',i));
      end;
  end;

  //�����ͽ��ٿ� �޼��� �Ѹ���
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
  Application.ProcessMessages;

  //'����'��ư�� Ŭ�� ���� �� ������ ��Ʈ��
  qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor    := crDefault;	//�۾��Ϸ�

  if isData then
    grd_display.RowCount  := grd_display.RowCount -1;

  if grdFocousEnable then
    grd_display.SetFocus;	//��Ʈ�� �׸���� ��Ŀ�� �̵�

  enableComponents;
end;

procedure Tfm_LOSTT250Q_CHILD.disableComponents;
begin
  btn_Inquiry.enabled  := False;
  btn_Link.enabled     := False;
  btn_Close.enabled    := False;

end;

procedure Tfm_LOSTT250Q_CHILD.enableComponents;
begin
  btn_Inquiry.enabled  := True;
  btn_Link.enabled     := True;
  btn_Close.enabled    := True;
end;

procedure Tfm_LOSTT250Q_CHILD.initStrGrid;
begin
  with grd_display do begin
    RowCount      :=  2;
    ColCount      :=  9;
    RowHeights[0] := 21;

    ColWidths[ 0] := 50;   // SEQ
    ColWidths[ 1] := -1;   // �۾�����
    ColWidths[ 2] := -1;   // �۾��Ϸù�ȣ
    ColWidths[ 3] := -1;   // ���ڱ����ڵ�
    ColWidths[ 4] := 180;  // ���ڱ����ڵ��
    ColWidths[ 5] := 100;  // ��������
    ColWidths[ 6] := 100;  // ��������
    ColWidths[ 7] := 120;  // �������
    ColWidths[ 8] := 240;  // ��������

    Cells[ 0,0]   :=  'SEQ';
    Cells[ 1,0]   :=  '�۾�����';
    Cells[ 2,0]   :=  '�۾��Ϸù�ȣ';
    Cells[ 3,0]   :=  '���ڱ����ڵ�';
    Cells[ 4,0]   :=  '���ڱ����ڵ��';
    Cells[ 5,0]   :=  '��������';
    Cells[ 6,0]   :=  '��������';
    Cells[ 7,0]   :=  '�������';
    Cells[ 8,0]   :=  '��������';

  end;
end;
procedure Tfm_LOSTT250Q_CHILD.grd_displayDblClick(Sender: TObject);
var i : integer;

  function CfillChar(src : string; fchar : Char;size : Integer) : string;
  var idx : Integer;
      dest : string;
  begin
    for idx := Length(Trim(src)) to Size - 1 do
     dest := dest + fchar;

    result := src + dest;
  end;

begin
  fm_LOSTT250Q.cmb_topic.Clear;
  fm_LOSTT250Q.cmb_topic.Items.Add(   CfillChar(grd_display.Cells[8,grd_display.Row] ,' ',100)
                                    + CfillChar(grd_display.Cells[1,grd_display.Row] ,' ', 10)
                                    + CfillChar(grd_display.Cells[2,grd_display.Row] ,' ',  3)
                                  );

  self.Hide;
  fm_LOSTT250Q.Show;
end;



procedure Tfm_LOSTT250Q_CHILD.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfm_LOSTT250Q_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Self.Hide;
  fm_LOSTT250Q.Show;
end;

procedure Tfm_LOSTT250Q_CHILD.grd_displayDrawCell(Sender: TObject; ACol,
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
      8: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0..7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;
  end;
end;

procedure Tfm_LOSTT250Q_CHILD.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfm_LOSTT250Q_CHILD.btn_queryClick(Sender: TObject);
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

procedure Tfm_LOSTT250Q_CHILD.FormShow(Sender: TObject);
begin
  self.InitComponent;
end;

procedure Tfm_LOSTT250Q_CHILD.btn_resetClick(Sender: TObject);
begin
  Self.InitComponent;
end;

procedure Tfm_LOSTT250Q_CHILD.btn_LinkClick(Sender: TObject);
begin
  if Trim(grd_display.Cells[1,grd_display.Row]) <> '' then
    grd_displayDblClick(Sender);
end;

end.
