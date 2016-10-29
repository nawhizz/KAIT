{*---------------------------------------------------------------------------
프로그램ID    : LOSTC220Q (우체국정산 조정내역 조회)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 26
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTC220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit, ComObj;

const
  TITLE   = '우체국정산 조정내역 조회';
  PGM_ID  = 'LOSTC220Q';

type
  Tfrm_LOSTC220Q = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label2: TLabel;
    dte_from_01: TDateEdit;
    dte_to_01: TDateEdit;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    CalendarMonth1: TCalendarMonth;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    Label1: TLabel;
    Bevel3: TBevel;
    dte_from_02: TDateEdit;
    Label5: TLabel;
    dte_to_02: TDateEdit;
    Label4: TLabel;
    btn_Link: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_reset: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure CalendarMonth1Change(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure CalendarMonth1KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    qryStr:String;
    procedure SetDate;
    procedure initStrGrid;
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTC220Q: Tfrm_LOSTC220Q;

implementation

{$R *.dfm}


procedure Tfrm_LOSTC220Q.SetDate;
var
  FT_DT_01 : String;
  TO_DT_01 : String;
  FT_DT_02 : String;
  TO_DT_02 : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin

  FT_DT_01 := '';
  TO_DT_01 := '';
  FT_DT_02 := '';
  TO_DT_02 := '';

    grd_display.Cursor := crSQLWait;	//작업중....

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

//반복 조회
INQUIRY:
    TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC220Q') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    goto LIQUIDATION;
  end;

    FT_DT_01 := TMAX.RecvString('STR101',0);  //인수증지연조정일자
    TO_DT_01 := TMAX.RecvString('STR102',0);  //인수증지연조정일자
    FT_DT_02 := TMAX.RecvString('STR103',0);  //핸드폰지연조정일자
    TO_DT_02 := TMAX.RecvString('STR104',0);  //핸드폰지연조정일자

    sts_Message.Panels[1].Text := ' 조회 완료';


LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

    grd_display.Cursor := crDefault;	//작업완료

    dte_from_01.Text := InsHyphen(Trim(FT_DT_01));
    dte_to_01.text   := InsHyphen(Trim(TO_DT_01));
    dte_from_02.Text := InsHyphen(Trim(FT_DT_02));
    dte_to_02.text   := InsHyphen(Trim(TO_DT_02));
end;

procedure Tfrm_LOSTC220Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTC220Q.enableComponents;
begin
  changeBtn(Self);

  CalendarMonth1.Enabled := True;
	dte_from_01.Enabled := True;
  dte_to_01.Enabled := True;
	dte_from_02.Enabled := True;
  dte_to_02.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTC220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTC220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 11;
    	RowHeights[0] := 21;


    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='총괄국코드';

    	ColWidths[2] := 150;
		Cells[2,0] :='총괄국명';

      ColWidths[3] := 200;
		Cells[3,0] :='조정내역';

      ColWidths[4] := 80;
		Cells[4,0] :='대행건수';

      ColWidths[5] := 100;
		Cells[5,0] :='대행금액';

      ColWidths[6] := 80;
		Cells[6,0] :='출고건수';

      ColWidths[7] := 100;
		Cells[7,0] :='출고금액';

      ColWidths[8] := 80;
		Cells[8,0] :='등록건수';

      ColWidths[9] := 100;
		Cells[9,0] :='등록금액';

      ColWidths[10] := 160;
		Cells[10,0] :='금액합계';

    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}

procedure Tfrm_LOSTC220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTC220Q.FormCreate(Sender: TObject);
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
  {    }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

	initSkinForm(SkinData1); //common_lib.pas에 있다.

  initStrGrid;	//그리드 초기화

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;



procedure Tfrm_LOSTC220Q.FormShow(Sender: TObject);
begin
 btn_resetClick(Sender);
end;

procedure Tfrm_LOSTC220Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTC220Q.CalendarMonth1Change(Sender: TObject);
begin
  SetDate;
end;

procedure Tfrm_LOSTC220Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC220Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTC220Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('우체국정산 조정내역 조회(LOSTC220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC220Q');
end;

procedure Tfrm_LOSTC220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4..10: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

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

procedure Tfrm_LOSTC220Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTC220Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
 	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //크리드 초기화
    pInitStrGrd(Self);

    //시작시변수 초기화

    totalCount :=0;
    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.
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
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostC220Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_from_01.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', delHyphen(dte_to_01.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', delHyphen(dte_from_02.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(dte_to_02.Text)) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTC220Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

	count1 := TMAX.RecvInteger('INF013',0);


  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;


    totalCount := totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[ 0,RowPos] := IntToStr(seq);
          Cells[ 1,RowPos] := TMAX.RecvString('STR101',i); //총괄국코드
          Cells[ 2,RowPos] := TMAX.RecvString('STR102',i); //총괄국명
          Cells[ 3,RowPos] := TMAX.RecvString('STR103',i); //조정내역
          Cells[ 4,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); //대행건수
          Cells[ 5,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); //대행금액
          Cells[ 6,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); //출고건수
          Cells[ 7,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); //출고금액
          Cells[ 8,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); //등록건수
          Cells[ 9,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT109',i))); //등록금액
          Cells[10,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT110',i))); //등록금액

          Inc(seq);
          Inc(RowPos);
        end;
    end;
   //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
    qryStr:= TMAX.RecvString('INF014',0);

//빠져나오는곳
LIQUIDATION:

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//작업완료

  if totalCount > 0 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;

end;

procedure Tfrm_LOSTC220Q.btn_resetClick(Sender: TObject);
var
  i : Integer;
begin
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Print.Enabled := False;
  btn_Link.Enabled := False;
  dte_from_01.Enabled := False;
  dte_to_01.Enabled := False;
  dte_from_02.Enabled := False;
  dte_from_02.Enabled := False;
  dte_to_02.Enabled := False;

  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
  SetDate;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := '';

  changeBtn(Self);

end;

procedure Tfrm_LOSTC220Q.CalendarMonth1KeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;  
end;

end.
