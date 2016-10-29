unit u_LOSTA360Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg, printers,
  Menus, common_lib, Clipbrd, WinSkinData, so_tmax, LOSTA360Q_PRT_HEAD, ComObj;

const
  TITLE   = '입고대비작업처리실적';
  PGM_ID  = 'LOSTA360Q';

type
  Tfrm_LOSTA360Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    dte_from: TDateEdit;
    grd_display: TStringGrid;
    dte_to: TDateEdit;
    Label1: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
    ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure Copy1Click(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;

    procedure disableComponents;
    procedure enableComponents;
  public
    { Public declarations }
  end;

var
  frm_LOSTA360Q: Tfrm_LOSTA360Q;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTA360Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA360Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA360Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA360Q.FormCreate(Sender: TObject);
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

  // 공통변수 설정 common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  // 테스트 후에는 이 부분을 삭제할 것.
  // 임시롤 로그인 데이터 삽입
  // common_userid   := '0294';    //ParamStr(2);
  // common_username := '정호영';  //ParamStr(3);
  // common_usergroup:= 'KAIT';    //ParamStr(4);

  //스킨 초기화
  initSkinForm(SkinData1);      // common_lib.pas에 있다.

  // 그리드 초기화
  initStrGrid;

  qryStr := '';
  
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;


{*******************************************************************************
* procedure Name : initStrGrid
* 기 능 설 명 : 그리드를 초기화 하고 필드 타이틀 설정을 한다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.initStrGrid;
begin
	with grd_display do begin
      RowCount := 2;
      ColCount := 9;
      RowHeights[0] := 21;

      cells[0,0] := '사업자';
      cells[1,0] := '입고';
      cells[2,0] := '수취확인';
      cells[3,0] := '수취거부';
      cells[4,0] := '접촉진행중';
      cells[5,0] := '연락불가';
      cells[6,0] := '출고';
      cells[7,0] := '반송';
      cells[8,0] := '장기/귀속';

      colwidths[0] := 120;
      colwidths[1] := 75;
      colwidths[2] := 75;
      colwidths[3] := 75;
      colwidths[4] := 75;
      colwidths[5] := 75;
      colwidths[6] := 75;
      colwidths[7] := 75;
      colwidths[8] := 75;
    end;
end;

procedure Tfrm_LOSTA360Q.btn_InquiryClick(Sender: TObject);
var
    i,RowPos,count : Integer;
    Label LIQUIDATION;
    Label INQUIRY;

begin
    initStrGrid;
    pInitStrGrd(Self);
    //그리드 디스플레이 설정
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

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

INQUIRY:
	TMAX.InitBuffer;

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LostA360Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;
    // 사용자 데이터 설정 완료

    //서비스 호출
    if not TMAX.Call('LOSTA360Q') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end;

    // 조회 결과 DISPLAY
    count := TMAX.RecvInteger('INF013',0);

    if count < 1 then begin
      for i := grd_display.fixedrows to grd_display.rowcount - 1 do
      grd_display.rows[i].Clear;
      grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
    end;

    //쿼리 얻기
    qryStr:= TMAX.RecvString('INF014',0);
    
    grd_display.RowCount := grd_display.RowCount + count;
    with grd_display do begin
        for i:=0 to count-1 do
        begin
          Cells[0,RowPos]   := TMAX.RecvString('STR101',i);                    // 사업자명
          Cells[1,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT101',i))); // 입고일자
          Cells[2,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT102',i))); // 수취확인
          Cells[3,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); // 수취거부
          Cells[4,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); // 접촉진행
          Cells[5,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); // 연락불가
          Cells[6,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); // 출고건수
          Cells[7,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); // 반송
          Cells[8,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); // 장기/귀속건수

          Inc(RowPos);
        end;
    end;

    if(count > 0) then Dec(count);

    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + IntToStr(count)  + '건이 조회 되었습니다.';
    Application.ProcessMessages;


LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1 ;
  
  enableComponents;
end;

procedure Tfrm_LOSTA360Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

{*******************************************************************************
* procedure Name : btn_PrintClick
* 기 능 설 명 : 조회된 결과를 출력한다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.btn_PrintClick(Sender: TObject);
var
    head:TLOSTA360Q_PRT_HEAD;	//head 계산
    Canvas: TCanvas;
    i, j, page : integer;

    datetime : string;

    curntYposi      :Integer;         //현재 y측 포인트
    prntWidth       :Cardinal;	      //프린터 폭(297mm)
    prntHeight      :Cardinal;        //프린터 높이(210mm)
    prntMargin      :Cardinal;        //오른쪽, 왼쪽 마진(20mm);
    swidth, sheight :Cardinal;	      //문자열 높이

    lineStart       :Cardinal;	      //줄긋기 시작점;
    lineEnd         :Cardinal;
    ygap            :Cardinal;		    //y축 -갭

    //오른쪽 기준 문자열 출력
    procedure rightPrint( x:Integer; text:String);
    begin
 		  Canvas.TextOut(x - Canvas.TextWidth(text), curntYposi, text);
    end;

    //가운데 기준 문자열 출력
    procedure centerPrint(x:Integer; text:String);
    begin
        Canvas.TextOut(x - Canvas.TextWidth(text) div 2, curntYposi, text);
    end;

    //문자열에 밑줄 긋기
    procedure centerUnderLine(x:Integer; text:String);
    var
    	start, eend:Cardinal;
    begin
    	start := x - Canvas.TextWidth(text) div 2;
    	eend  := x + Canvas.TextWidth(text) div 2;
      curntYposi := curntYposi-sheight - 10;
      Canvas.MoveTo(start, curntYposi);
      Canvas.LineTo(eend, curntYposi);

      //다음을 위해서...
      Inc(curntYposi, -ygap);  //다음줄로 이동
    end;

    //타이틀 프린트
    procedure printTitle(page:integer);
    var
      i:Integer;
      len :Cardinal;
      str : String;
    begin
      centerPrint(prntWidth div 2,  	 '입고 대비 작업처리 실적');
      //상기 문자열에 대한 밑줄 긋기
      centerUnderLine(prntWidth div 2, '입고 대비 작업처리 실적');

      //머릿말 시작------------------------------------
      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      str := 'PROG ID: LOSTA360Q';
      Canvas.TextOut(lineStart, curntYposi,str);

      str:= '기준일자: ' + dte_to.Text;
      Canvas.TextOut(lineStart, curntYposi - ygap -sheight, str);

      str:= '현재시각(' + datetime + ')';
      len:= Canvas.TextWidth(str);
      Canvas.TextOut(lineEnd-len, curntYposi - ygap -sheight, str);

      str:= 'Page: '+ intToStr(page);
      Canvas.TextOut(lineEnd-len, curntYposi , str);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);

      //머릿말 끝------------------------------------
      Inc(curntYposi, -ygap);
      //타이틀 윗쪽에 줄 긋기
      Canvas.MoveTo(lineStart, curntYposi);
      Canvas.LineTo(lineEnd, curntYposi);

      //타이틀을 출력한다.
      Inc(curntYposi, -ygap);

      for i:=0 to 6 do
        rightPrint(head.getRightPosition(i), titles[i]);

      Inc(curntYposi, -sheight);
      Inc(curntYposi, -ygap);
      //타이틀 아래쪽에 줄 긋기
      Canvas.MoveTo(lineStart, curntYposi);
      Canvas.LineTo(lineEnd, curntYposi);

      Inc(curntYPosi, -ygap);	//다음줄 준비...
    end;

begin
    //프린팅 캔바스...
    Canvas := Printer.Canvas;
    datetime := Formatdatetime('yyyymmdd',date)+'/'+Formatdatetime('hhnnss',time);
    i := 0;
    j := 1;
    page := 1;

    Printer.Orientation := poLandscape;
    //프린트 시작
    Printer.BeginDoc;	//이부분을 위것 보다 먼저실행하면 에러발생...

    prntWidth := 2960;	//A4 = 297mm
    prntHeight:= 2090;	//A4 = 210mm
    prntMargin:= 200;	  //left, right margin = 20mm

    //본 단위를 바꾸면 글자 숫자 계산을 다시해야 함.
    SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm 단위
    Canvas.Font.Name := '굴림체';
    Canvas.Font.Height := 40;  // 글자체 높이 4mm
    //Canvas.Font.Style:= [fsBold];

    //위치 중요
    head := TLOSTA360Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //마진, 전체폭,...

    sheight     := Canvas.TextHeight('가'); //문자높이 계산, 4mm
    ygap        := 10;							        //1mm 갭
    curntYposi  := -100;   				          //문자열을 쓰거나 라인을 그을때 y-축 기준점
    lineStart   := head.getRightPosition(0)- head.getLength(0) -20;	//선긋기 x-축 시작점
    lineEnd     := head.getRightPosition(6) +20;						//선긋기 x-축 끝점

    //타이틀 프린트
    printTitle(page);

    //내용 프린트---마지막 줄은 따로 프린트
    with grd_display do begin
    	for j:= 1 to RowCount-2 do begin
        	for i:=0 to ColCount-1 do
            	rightPrint(head.getRightPosition(i), Cells[i,j]);

			Inc(curntYposi, -sheight);	//다음줄 이동
			Inc(curntYposi, -ygap);		//1mm 아래로 이동

			//출력물이 페이지를 넘어가면...
            if curntYposi >= prntHeight then begin
            	Printer.NewPage;      	//새 페이지 추가
                Inc(page);   			//페이지 번호 카운트 업
                curntYPosi := -100;     //y축  position을 새로 시작한다.

                //기타 초기화 해야 할 항목이 있으면 여기서...

                printTitle(page);		//타이틀을 다시 프린트...
            end;
        end;
    end;

    //마지막 줄(총계) 프린트

    //라인긋기...그리드 안에서는 안된다....Canvas가 겹치서..
    //총계 윗줄 라인..
    Canvas.MoveTo(lineStart , curntYposi);
    Canvas.LineTo(lineEnd   , curntYposi);

    Inc(curntYposi, -ygap);		//1mm 아래로 이동
    for i:= 0 to grd_display.ColCount-1 do
      rightPrint(head.getRightPosition(i), grd_display.Cells[i,grd_display.RowCount-1]);

    Inc(curntYposi, -sheight);	//다음줄 이동
    Inc(curntYposi, -ygap);		//1mm 아래로 이동
    //총계 아랫쪽 라인..
    Canvas.MoveTo(lineStart, curntYposi);
    Canvas.LineTo(lineEnd, curntYposi);

    //프린트 종료
    Printer.EndDoc;

    head.Free; 	//헤드 정보 삭제

    Showmessage('출력이 잘 되었습니다.');
end;

{*******************************************************************************
* procedure Name : disableComponents
* 기 능 설 명 :버튼을 누르지 못하게 한다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : enableComponents
* 기 능 설 명 :버튼을 눌러 다른 기능을 할 수 있게한다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  btn_Print.Enabled := True;
  btn_excel.Enabled := False;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* 기 능 설 명 : 그리드 타이틀 부분에 대한 데코레이션 효과를 준다.
*
*******************************************************************************}
procedure Tfrm_LOSTA360Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      1..8: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
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

{*******************************************************************************
* procedure Name : grd_displayKeyDown
* 기 능 설 명 : 키다운에 해당하는 역할을 한다.(Ctrl + C)에 대한 기능 수행
*******************************************************************************}
procedure Tfrm_LOSTA360Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
* 기 능 설 명 : 그리드에 선택된 내역을 클릭보드에 복사하는 역할을한다.
*******************************************************************************}
procedure Tfrm_LOSTA360Q.Copy1Click(Sender: TObject);
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


procedure Tfrm_LOSTA360Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  dte_from.Date   := strtoDate(copy(formatdatetime('yyyy/mm/dd', Date),1,8) + '01');;
  dte_to.Date     := date - 1;
  btn_excel.Enabled := False;
  dte_to.SetFocus;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;
end;

procedure Tfrm_LOSTA360Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA360Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
