
unit u_LOSTE200Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,printers, ComObj;

const
  TITLE   = '보험금신청 집중등록 현황';
  PGM_ID  = 'LOSTE200Q';

type
  Tfrm_LOSTE200Q = class(TForm)
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

  private
    { Private declarations }
     qryStr:String;
    //그리드 초기화
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;

    procedure InitComponent;

  public
    { Public declarations }
  end;

Const
     MAXRECCNT = 24 ;
var
  frm_LOSTE200Q : Tfrm_LOSTE200Q;


implementation
{$R *.DFM}

procedure Tfrm_LOSTE200Q.disableComponents;
begin
	  dte_from.Enabled    := false;
    dte_to.Enabled      := false;
    btn_query.Enabled   := False;
    btn_excel.Enabled   := False;
    btn_close.Enabled   := False;
    btn_Print.Enabled   := False;
    btn_Inquiry.Enabled := False;
end;

procedure Tfrm_LOSTE200Q.enableComponents;
begin
  	dte_from.Enabled     := True;
    dte_to.Enabled       := True;
    btn_query.Enabled    := True;
    btn_excel.Enabled    := True;
    btn_close.Enabled    := True;
    btn_Print.Enabled    := False;
    btn_Inquiry.Enabled  := True;
end;

procedure Tfrm_LOSTE200Q.initStrGrid;
begin
	with grd_display do
  begin
    RowCount      :=  2;
    ColCount      := 12;
    RowHeights[0] := 21;

    ColWidths[ 0] := 110;
    ColWidths[ 1] := 110;
    ColWidths[ 2] := 110;
    ColWidths[ 3] := 110;
    ColWidths[ 4] := 110;
    ColWidths[ 5] := 110;
    ColWidths[ 6] := 115;
    ColWidths[ 7] := 110;
    ColWidths[ 8] := 110;
    ColWidths[ 9] := 110;
    ColWidths[10] := 115;
    ColWidths[11] := 115;

    Cells[0,0]    := '사업자식별명';
    Cells[1,0]    := '전일누계신청건수';
    Cells[2,0]    := '전일누계삭제건수';
    Cells[3,0]    := '전일누계지급중지건수';
    Cells[4,0]    := '전일누계승인건수';
    Cells[5,0]    := '기간신청건수';
    Cells[6,0]    := '기간삭제건수';
    Cells[7,0]    := '기간지급중지건수';
    Cells[8,0]    := '기간승인건수';
    Cells[9,0]    := '현재신청건수';
    Cells[10,0]   := '현재지급중지건수';
    Cells[11,0]   := '현재승인건수';
  end;
end;

procedure Tfrm_LOSTE200Q.setEdtKeyPress;
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

procedure Tfrm_LOSTE200Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE200Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTE200Q.FormCreate(Sender: TObject);
begin
  begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
     setEdtKeyPress;
     Self.Caption := '[' + PGM_ID + ']' + TITLE;

     Application.Title := TITLE;
     fSetIcon(Application);
     pSetStsWidth(sts_Message);
     pSetTxtSelAll(Self);

     Self.BorderIcons  := [biSystemMenu,biMinimize];
     Self.Position     := poScreenCenter;
   {--------------------------------------------------------------------------}

    if ParamCount <> 6 then //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    begin
      ShowMessage('로그인 후 사용하세요');
      PostMessage(self.Handle, WM_QUIT, 0,0);
      exit;
    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);
    common_seedkey    := ParamStr(6);

    btn_resetClick(Sender);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

    initSkinForm(SkinData1); //common_lib.pas에 있다.

    initStrGrid;	//그리드 초기화

    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  end;
end;

procedure Tfrm_LOSTE200Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    RowPos:Integer;

    count1, totalCount:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  RowPos                := 1;	//그리드 레코드 포지션
  grd_display.RowCount  := 2;

  pInitStrGrd(Self);

  totalCount  :=  0;
  qryStr      := '';
  grd_display.Cursor := crSQLWait;	//작업중....
  disableComponents;	//작업중 다른 기능 잠시 중지.


  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
    ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
    goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
    ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
    goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
    ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
    goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

	if not TMAX.Start then begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
    goto LIQUIDATION;
	end;

goto INQUIRY;

INQUIRY:

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostE200Q'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)  ) < 0) then  goto LIQUIDATION;


   //서비스 호출
   if not TMAX.Call('LOSTE200Q') then
   begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

     goto LIQUIDATION;
   end;

  count1                := TMAX.RecvInteger('INF013',0);
  totalCount            := totalCount + count1;
  grd_display.RowCount  := grd_display.RowCount + count1;

  with grd_display do
  begin
    for i:=0 to count1-1 do
    begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);
      Cells[1,RowPos] := convertWithCommer(TMAX.RecvString('INT101',i));
      Cells[2,RowPos] := convertWithCommer(TMAX.RecvString('INT102',i));
      Cells[3,RowPos] := convertWithCommer(TMAX.RecvString('INT103',i));
      Cells[4,RowPos] := convertWithCommer(TMAX.RecvString('INT104',i));
      Cells[5,RowPos] := convertWithCommer(TMAX.RecvString('INT105',i));
      Cells[6,RowPos] := convertWithCommer(TMAX.RecvString('INT106',i));
      Cells[7,RowPos] := convertWithCommer(TMAX.RecvString('INT107',i));
      Cells[8,RowPos] := convertWithCommer(TMAX.RecvString('INT108',i));
      Cells[9,RowPos] := convertWithCommer(TMAX.RecvString('INT109',i));
      Cells[10,RowPos] := convertWithCommer(TMAX.RecvString('INT110',i));
      Cells[11,RowPos] := convertWithCommer(TMAX.RecvString('INT111',i));

      Inc(RowPos);
    end;
  end;

  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  qryStr:= TMAX.RecvString('INF014',0);

//빠져나오는곳
LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor   := crDefault;	//작업완료

  if totalCount >= 1 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTE200Q.FormShow(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE200Q.btn_queryClick(Sender: TObject);
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

procedure Tfrm_LOSTE200Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTE200Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTE200Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTE200Q.grd_displayDrawCell(Sender: TObject; ACol,
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
  // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
  begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1..11 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

    end;
  end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTE200Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTE200Q.btn_resetClick(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE200Q.InitComponent;
var i : Integer;
begin
  dte_from.Date := date-30;
	dte_to.Date   := date;

  changeBtn(Self);

  btn_Print.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';

  //dte_from.SetFocus;
end;

end.
