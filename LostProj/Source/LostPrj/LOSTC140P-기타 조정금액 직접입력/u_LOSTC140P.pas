unit u_LOSTC140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit,u_LOSTC140P_CHILD, ComObj;

const
  TITLE   = '기타조정금액입력';
  PGM_ID  = 'LOSTC140P';

type
  Tfrm_LOSTC140P = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    Panel1: TPanel;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    lbl_Program_Name: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    CalendarMonth1: TCalendarMonth;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure CalendarMonth1Change(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure setEdtKeyPress;
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_queryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CalendarMonth1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure initString;
    procedure SetDate;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  //그리드값 담을 변수
  GM_CD : String;
  GM_NM : String;
  CT_AM : Integer;
  BI_GO : String;


  RG_SU : String;
  CL_SU : String;
  AG_SU : String;

  frm_LOSTC140P: Tfrm_LOSTC140P;

implementation

uses u_LOSTC140P_POP;

{$R *.dfm}
procedure Tfrm_LOSTC140P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 8;
    	RowHeights[0] := 21;

    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 200;
		Cells[1,0] :='총괄국코드';

    	ColWidths[2] := 250;
		Cells[2,0] :='총괄국명';

      ColWidths[3] := 100;
		Cells[3,0] :='조정금액';

      ColWidths[4] := 160;
		Cells[4,0] :='조정내역';

      ColWidths[5] := -1;
		Cells[5,0] :='등록건수';

      ColWidths[6] := -1;
		Cells[6,0] :='출고건수';

      ColWidths[7] := -1;
		Cells[7,0] :='대행건수';

    end;
end;

procedure Tfrm_LOSTC140P.initString;
begin
  GM_CD := '';
  GM_NM := '';
  CT_AM := 0;
  BI_GO := '';

end;

procedure Tfrm_LOSTC140P.SetDate;
var
  STR001 : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin
    btn_Add.Enabled := True;

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
	if (TMAX.SendString('INF003','LOSTC140P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      btn_Add.Enabled := False;
      goto LIQUIDATION;
    end
  else
    begin
    STR001 := TMAX.RecvString('STR104',0);
    end;
 if STR001 = 'Y' then begin
  btn_Add.Enabled := True;
 end else begin
  btn_Add.Enabled := False;
 end;

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTC140P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTC140P.setEdtKeyPress;
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

procedure Tfrm_LOSTC140P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTC140P.disableComponents;
begin
  btn_Inquiry.Enabled := False;
  btn_reset.Enabled := False;
  CalendarMonth1.Enabled := False;

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC140P.enableComponents;
begin
  btn_Inquiry.Enabled := True;
  btn_reset.Enabled := True;
  CalendarMonth1.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;


{-----------------------------------------------------------------------------}
procedure Tfrm_LOSTC140P.FormCreate(Sender: TObject);
begin

	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
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

  //테스트 후에는 이 부분을 삭제할 것.
//	common_userid:= '0294'; //ParamStr(2);
//	common_username:= '정호영';
//   ParamStr(3);
//  	common_usergroup:= 'KAIT'; //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 내부 캡션 설정
  lbl_Program_Name.Caption := TITLE;

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 메세지 바 넓이 설정
  pSetStsWidth(sts_Message);

  // 텍스트 선택시 전체 선택 기능
  pSetTxtSelAll(Self);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  initSkinForm(SkinData1);
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  qryStr := '';

end;

procedure Tfrm_LOSTC140P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTC140P.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;
  seq,RowPos:Integer;

  Label LIQUIDATION;
  Label INQUIRY;
begin

  pInitStrGrd(Self);

  self.disableComponents;

  btn_Add.Enabled     := True;
  btn_Delete.Enabled  := True;
  btn_query.Enabled   := True;

  //시작시변수 초기화
  totalCount :=0;
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
	if (TMAX.SendString('INF003','LOSTC140P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text ) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTC140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  // 쿼리 받기
  qryStr:= TMAX.RecvString('INF014',0);

  //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';

    goto LIQUIDATION;
  end;

  totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  if ( count1 = 0 ) then begin
    ShowMessage('조회된 내용이 없습니다.');
    goto LIQUIDATION;
  end;

  with grd_display do begin
    for i := 0 to count1 - 1 do
    begin
      Cells[0,i+1] := IntToStr(i+1);
      Cells[1,i+1] := TMAX.RecvString('STR101',i);             // 총괄국코드
      Cells[2,i+1] := TMAX.RecvString('STR102',i);             // 총괄국명
      Cells[3,i+1] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i)));  // 조정금액
      Cells[4,i+1] := TMAX.RecvString('STR104',i);             // 조정내역
      Cells[5,i+1] := IntToStr(TMAX.RecvInteger('INT105',i));  // 등록건수
      Cells[6,i+1] := IntToStr(TMAX.RecvInteger('INT106',i));  // 출고건수
      Cells[7,i+1] := IntToStr(TMAX.RecvInteger('INT107',i));  // 대행건수
    end;
  end;


  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  self.enableComponents;

  grd_display.Cursor := crDefault;	//작업완료

  if totalCount > 0 then
    grd_display.RowCount := grd_display.RowCount -1;

end;

procedure Tfrm_LOSTC140P.btn_AddClick(Sender: TObject);
begin
 frm_LOSTC140P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTC140P.grd_displayDblClick(Sender: TObject);
begin
  RG_SU  := '';
  CL_SU  := '';
  AG_SU  := '';

 // CT_AM  := StrToInt(delDelimiter(grd_display.Cells[2, grd_display.Row],','));
  RG_SU  := grd_display.Cells[5, grd_display.Row];
  CL_SU  := grd_display.Cells[6, grd_display.Row];
  AG_SU  := grd_display.Cells[7, grd_display.Row];

  frm_LOSTC140P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTC140P.btn_UpdateClick(Sender: TObject);
begin

  RG_SU  := '';
  CL_SU  := '';
  AG_SU  := '';

  RG_SU  := grd_display.Cells[5, grd_display.Row];
  CL_SU  := grd_display.Cells[6, grd_display.Row];
  AG_SU  := grd_display.Cells[7, grd_display.Row];


  frm_LOSTC140P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTC140P.btn_DeleteClick(Sender: TObject);
begin
  frm_LOSTC140P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTC140P.CalendarMonth1Change(Sender: TObject);
begin
  sts_Message.Panels[1].Text := '';
  SetDate;

end;

procedure Tfrm_LOSTC140P.btn_ResetClick(Sender: TObject);
var
  i : Integer;
begin
  changeBtn(Self);
  btn_Add.Enabled     := False;
  btn_Update.Enabled  := False;
  btn_Delete.Enabled  := False;  

  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);

  pInitStrGrd(Self);

  initStrGrid;	//그리드 초기화

  sts_Message.Panels[1].Text := ' ';
end;

procedure Tfrm_LOSTC140P.grd_displayDrawCell(Sender: TObject; ACol,
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
      0 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      5 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);

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

procedure Tfrm_LOSTC140P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC140_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;
procedure Tfrm_LOSTC140P.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTC140P.CalendarMonth1KeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;
end;

end.
