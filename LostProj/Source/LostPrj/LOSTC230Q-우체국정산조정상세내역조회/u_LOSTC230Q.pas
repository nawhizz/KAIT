{*---------------------------------------------------------------------------
프로그램ID    : LOSTC230Q (우체국정산 조정 상세내역 조회(인수증지연도착))
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
unit u_LOSTC230Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit, ComObj;

const
  TITLE   = '우체국출고 조정내역 리스트';
  PGM_ID  = 'LOSTC230Q';

type
  Tfrm_LOSTC230Q = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Link: TSpeedButton;
    lbl_Program_Name: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    CalendarMonth1: TCalendarMonth;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_reset: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure CalendarMonth1Change(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
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
  frm_LOSTC230Q: Tfrm_LOSTC230Q;

implementation
{$R *.dfm}

procedure Tfrm_LOSTC230Q.SetDate;
var
  FT_DT : String;
  TO_DT : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin

  FT_DT := '';
  TO_DT := '';

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
	if (TMAX.SendString('INF003','LOSTC230Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC230Q') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    goto LIQUIDATION;
  end;
    FT_DT := TMAX.RecvString('STR101',0);  //인수증지연조정일자
    TO_DT := TMAX.RecvString('STR102',0);  //인수증지연조정일자

    sts_Message.Panels[1].Text := ' 조회 완료';

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

    grd_display.Cursor := crDefault;	//작업완료

    dte_from.Text := InsHyphen(Trim(FT_DT));
    dte_to.text   := InsHyphen(Trim(TO_DT));
end;

procedure Tfrm_LOSTC230Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC230Q.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  CalendarMonth1.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC230Q.setEdtKeyPress;
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

procedure Tfrm_LOSTC230Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTC230Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 11;
    	RowHeights[0] := 21;

    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='우체국코드';

    	ColWidths[2] := 150;
		Cells[2,0] :='우체국명';

      ColWidths[3] := 100;
		Cells[3,0] :='출고일자';

      ColWidths[4] := 100;
		Cells[4,0] :='습득일자';

      ColWidths[5] := 150;
		Cells[5,0] :='모델명';

      ColWidths[6] := 100;
		Cells[6,0] :='일련번호';

      ColWidths[7] := 150;
		Cells[7,0] :='가입자성명';

      ColWidths[8] := 100;
		Cells[8,0] :='가입자생년월일';

      ColWidths[9] := 150;
		Cells[9,0] :='습득자성명';

      ColWidths[10] := 100;
		Cells[10,0] :='습득자생년월일';
    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}

procedure Tfrm_LOSTC230Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTC230Q.FormCreate(Sender: TObject);
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
  {   }
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

procedure Tfrm_LOSTC230Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;


procedure Tfrm_LOSTC230Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTC230Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC230Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);

end;

procedure Tfrm_LOSTC230Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('우체국정산 조정 상세내역 조회(인수증지연도착)(LOSTC230Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC230Q');
end;



procedure Tfrm_LOSTC230Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      3..4: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      5 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      9 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      10 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);

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



procedure Tfrm_LOSTC230Q.Copy1Click(Sender: TObject);
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



procedure Tfrm_LOSTC230Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gtnm, seed_gtno : String;

    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_ganm := '';
    seed_gano := '';
    seed_gtnm := '';
    seed_gtno := '';

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
	if (TMAX.SendString('INF003','LostC230Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTC230Q') then
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

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

        Cells[0,RowPos] := IntToStr(seq);
        Cells[1,RowPos] := TMAX.RecvString('STR101',i); //우체국코드
        Cells[2,RowPos] := TMAX.RecvString('STR102',i); //우체국명
        Cells[3,RowPos] := InsHyphen(TMAX.RecvString('STR103',i)); //출고일자
        Cells[4,RowPos] := InsHyphen(TMAX.RecvString('STR104',i)); //습득일자
        Cells[5,RowPos] := TMAX.RecvString('STR106',i); //모델명
        Cells[6,RowPos] := TMAX.RecvString('STR107',i); //단말기일련번호
        seed_ganm       := TMAX.RecvString('STR108',i); //가입자성명
        Cells[7,RowPos] := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
        seed_gano       := TMAX.RecvString('STR109',i); //가입자생년월일
        Cells[8,RowPos] := ECPlazaSeed.Decrypt(seed_gano, common_seedkey);
        seed_gtnm       := TMAX.RecvString('STR110',i); //습득자성명
        Cells[9,RowPos] := ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey);
        seed_gtno       := TMAX.RecvString('STR111',i); //습득자생년월일
        Cells[10,RowPos]:= ECPlazaSeed.Decrypt(seed_gtno, common_seedkey);

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
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;

procedure Tfrm_LOSTC230Q.CalendarMonth1Change(Sender: TObject);
begin
 SetDate;
end;

procedure Tfrm_LOSTC230Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Print.Enabled := False;
  btn_Link.Enabled := False;

  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
  SetDate;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
  grd_display.rows[i].Clear;
  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := '';

  changeBtn(Self);
end;

procedure Tfrm_LOSTC230Q.CalendarMonth1KeyPress(Sender: TObject;
  var Key: Char);
begin
  key := #0;
end;

end.
