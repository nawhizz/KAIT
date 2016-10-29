unit u_LOSTC120P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTC120P_CHILD, monthEdit, ComObj;

const
  TITLE   = '��ü����������ݾ��Է� ';
  PGM_ID  = 'LOSTC120P';

type
  Tfrm_LOSTC120P = class(TForm)
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
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    Label3: TLabel;
    CalendarMonth1: TCalendarMonth;
    btn_reset: TSpeedButton;
    btn_query: TSpeedButton;
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure ct_ymKeyPress(Sender: TObject; var Key: Char);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure CalendarMonth1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_resetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_queryClick(Sender: TObject);
    procedure CalendarMonth1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure SetDate;
    
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  CNT : Integer;
  // �׸��� �� ����
  GM_CD : String;
  GM_NM : String;
  CL_SU : Integer;
  CT_AM : Integer;
  BI_GO : String;

  frm_LOSTC120P: Tfrm_LOSTC120P;

implementation

{$R *.dfm}

procedure Tfrm_LOSTC120P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 6;
    	RowHeights[0] := 21;

    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='�Ѱ����ڵ�';

    	ColWidths[2] := 150;
		Cells[2,0] :='�Ѱ�����';

      ColWidths[3] := 110;
		Cells[3,0] :='�μ��������Ǽ�';

      ColWidths[4] := 100;
		Cells[4,0] :='�����ݾ�';

      ColWidths[5] := 250;
		Cells[5,0] :='��������';

    end;
end;

procedure Tfrm_LOSTC120P.SetDate;
var
  // ���񽺿��� �߰��� �޴� ���� ����
  DU_DT : String;
  AC_DT : String;
  CT_01 : String;
  AC_GU : String;
  FT_DT : String;
  TO_DT : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin
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
	if (TMAX.SendString('INF003','LOSTC120P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTC120P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

     // MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
       // sts_Message.Panels[1].Text := ' ���� �Ϸ�';
      //   ShowMessage('���������� ���� �Ǿ����ϴ�.')
    end;

    DU_DT := TMAX.RecvString('STR101',0); //�޴����и�
    AC_DT := TMAX.RecvString('STR102',0); //�޴����и�
    CT_01 := TMAX.RecvString('STR103',0); //�޴����и�
    AC_GU := TMAX.RecvString('STR104',0); //�޴����и�
    FT_DT := TMAX.RecvString('STR105',0); //�޴����и�
    TO_DT := TMAX.RecvString('STR106',0); //�޴����и�




LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

    dte_from.Text := InsHyphen(Trim(FT_DT));
    dte_to.text   := InsHyphen(Trim(TO_DT));
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* �� �� �� �� : ������ ������ ���� Grid�� ������ �ȴ�.
*******************************************************************************}
procedure Tfrm_LOSTC120P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTC120P.setEdtKeyPress;
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

procedure Tfrm_LOSTC120P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTC120P.disableComponents;
begin
  btn_Inquiry.Enabled := False;
  btn_reset.Enabled := False;
  CalendarMonth1.Enabled := False;
  dte_from.Enabled := False;
  dte_to.Enabled := False;

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC120P.enableComponents;
begin
  btn_Inquiry.Enabled := True;
  btn_reset.Enabled := True;
  CalendarMonth1.Enabled := True;
  dte_from.Enabled := True;
  dte_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTC120P.FormCreate(Sender: TObject);
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
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '��ȣ��';
  // ParamStr(3);
  //	common_usergroup:= 'KAIT'; //ParamStr(4);

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


  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  qryStr := '';

end;

procedure Tfrm_LOSTC120P.btn_CloseClick(Sender: TObject);
begin
  
  close;
end;

procedure Tfrm_LOSTC120P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;
    seq,RowPos:Integer;

    CT_01     : String;
    I_FEE_01  : Integer;
    I_FEE_02  : Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    self.disableComponents;

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
	if (TMAX.SendString('INF003','LOSTC120P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  if not TMAX.Call('LOSTC120P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
    goto LIQUIDATION;
  end;

  // ���� �ޱ�
  qryStr:= TMAX.RecvString('INF014',0);

  //��ȸ�� ����
	count1 := TMAX.RecvInteger('INF013',0);


  if count1 < 1 then begin
    sts_Message.Panels[1].Text := '��ȸ�� ������ �����ϴ�.';
     for i := grd_display.fixedrows to grd_display.rowcount - 1 do
      grd_display.rows[i].Clear;
     grd_display.RowCount := 3;

    goto LIQUIDATION;
  end;

  CNT :=   count1;
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;


    with grd_display do begin
    	for i:=0 to count1-1 do begin
          Cells[0,RowPos]  := intToStr(seq);
          Cells[1,RowPos] := TMAX.RecvString('STR101',i); //
          Cells[2,RowPos] := TMAX.RecvString('STR102',i); //
          Cells[3,RowPos] := TMAX.RecvString('INT103',i); //
          Cells[4,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i)));  //�����ݾ�
          Cells[5,RowPos] := TMAX.RecvString('STR105',i); //

          Inc(seq);
          Inc(RowPos);
        end;
    end;
    //�����ͽ��ٿ� �޼��� �Ѹ���
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '���� ��ȸ �Ǿ����ϴ�.';
    Application.ProcessMessages;

    CT_01     := TMAX.RecvString('STR001',0);
    I_FEE_01  := TMAX.RecvInteger('INT001',0);
    I_FEE_02  := TMAX.RecvInteger('INT002',0);

    if ( CT_01 = 'N') then begin
       btn_Add.Enabled := True;
       btn_Update.Enabled := False;
       btn_Delete.Enabled := False;
       dte_from.Enabled := True;
       dte_to.Enabled := True;
    end else begin
       btn_Add.Enabled := False;
       btn_Update.Enabled := True;
       dte_from.Enabled := False;
       dte_to.Enabled := False;
    end;

    

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
  self.enableComponents;

    grd_display.Cursor := crDefault;	//�۾��Ϸ�
    grd_display.RowCount := grd_display.RowCount -1;


end;

procedure Tfrm_LOSTC120P.btn_DeleteClick(Sender: TObject);

LABEL LIQUIDATION;
begin
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

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC120P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text     )   < 0) then  goto LIQUIDATION;

	if not TMAX.Call('LOSTC120P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ���� �Ϸ�';
         ShowMessage('���������� ���� �Ǿ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  btn_InquiryClick(Sender);

end;

procedure Tfrm_LOSTC120P.grd_displayDblClick(Sender: TObject);
begin

  GM_CD := grd_display.Cells[1, grd_display.Row];
  GM_NM := grd_display.Cells[2, grd_display.Row];
  CL_SU := StrToInt(grd_display.Cells[3, grd_display.Row]);
 // CT_AM := StrToInt(delDelimiter(grd_display.Cells[3, grd_display.Row],','));
  BI_GO := grd_display.Cells[5, grd_display.Row];



  frm_LOSTC120P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTC120P.ct_ymKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then begin
   SetDate;
   end;
end;

procedure Tfrm_LOSTC120P.btn_AddClick(Sender: TObject);
var
  i,seq,RowPos:Integer;
LABEL LIQUIDATION;
begin

  RowPos:= 1;	//�׸��� ���ڵ� ������

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

	TMAX.AllocBuffer(1024*1024);
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
	if (TMAX.SendString('INF002',common_userid              )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC120P'                )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'                     )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text       )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', delHyphen(dte_from.Text)  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', delHyphen(dte_to.Text)    )   < 0) then  goto LIQUIDATION;

  with grd_display do begin
    for i:=0 to CNT-1 do begin
      if (TMAX.SendString ('STR011', Cells[1,RowPos]                              )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendInteger('INT012', StrToInt(Trim(Cells[3,RowPos]))              )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendInteger('INT013', StrToInt(delDelimiter(Cells[4,RowPos],','))  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString ('STR014', Cells[5,RowPos]                              )   < 0) then  goto LIQUIDATION;
      Inc(RowPos);
    end;
  end;

	if not TMAX.Call('LOSTC120P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' ��� �Ϸ�';
         ShowMessage('���������� ��ϵǾ����ϴ�.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTC120P.btn_UpdateClick(Sender: TObject);
var
  i,seq,RowPos:Integer;
LABEL LIQUIDATION;
begin

  RowPos:= 1;	//�׸��� ���ڵ� ������

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

	TMAX.AllocBuffer(1024*1024);
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
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC120P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text     )   < 0) then  goto LIQUIDATION;

  with grd_display do begin
    for i:=0 to CNT-1 do begin
      if (TMAX.SendString('STR011', Cells[0,RowPos]  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendInteger('INT012', StrToInt(Trim(Cells[2,RowPos]))  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendInteger('INT013', StrToInt(delDelimiter(Cells[3,RowPos],','))  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR014', Cells[4,RowPos]  )   < 0) then  goto LIQUIDATION;
      Inc(RowPos);
    end;
  end;

	if not TMAX.Call('LOSTC120P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end
  else
  begin
      sts_Message.Panels[1].Text := ' ���� �Ϸ�';
       ShowMessage('���������� ���� �Ǿ����ϴ�.')
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTC120P.CalendarMonth1Change(Sender: TObject);
begin
 sts_Message.Panels[1].Text := '';
 SetDate;
end;

procedure Tfrm_LOSTC120P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTC120P.grd_displayDrawCell(Sender: TObject; ACol,
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
    grid.Canvas.Font.Color  := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
  // Ÿ��Ʋ�� ù���� ������ �÷����� ������ ����Ѵ�.
  begin
    case ACol of
      0 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      5 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
    end;
  end;

end;

procedure Tfrm_LOSTC120P.btn_resetClick(Sender: TObject);
var
  i : integer;
begin
    changeBtn(Self);

    CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
    btn_Add.Enabled     := False;
    btn_Update.Enabled  := False;
    btn_Delete.Enabled  := False;

    sts_Message.Panels[1].Text := '';

    pInitStrGrd(Self);
    initStrGrid;

end;

procedure Tfrm_LOSTC120P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\LOSTC120_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTC120P.CalendarMonth1KeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;
end;

end.



