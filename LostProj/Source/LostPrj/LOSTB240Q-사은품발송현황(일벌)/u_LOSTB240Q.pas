{*---------------------------------------------------------------------------
프로그램ID    : LOSTB240Q (사은품 발송 현황 (일별))
프로그램 종류 : Online
작성자	      : 최대성
작성일	      : 2011. 08. 10
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
unit u_LOSTB240Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, printers,
  WinSkinData, so_tmax, Menus, common_lib, Func_Lib, Clipbrd, LOSTB240Q_PRT_HEAD, ComObj;

const
  TITLE   = '사은품 발송 현황 (일별)';
  PGM_ID  = 'LOSTB240Q';

type
  Tfrm_LOSTB240Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    dte_to: TDateEdit;
    Label1: TLabel;
    dte_from: TDateEdit;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
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
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure initComponent;

  public
    { Public declarations }
  end;

var
  frm_LOSTB240Q: Tfrm_LOSTB240Q;

implementation
{$R *.DFM}
procedure Tfrm_LOSTB240Q.disableComponents;
begin
	dte_from.Enabled := false;
    dte_to.Enabled := false;
    btn_Inquiry.Enabled := False;
    btn_query.Enabled:= False;
    btn_excel.Enabled:= False;
    btn_close.Enabled:= False;
end;

procedure Tfrm_LOSTB240Q.enableComponents;
begin
	dte_from.Enabled := True;
    dte_to.Enabled := True;
    btn_Inquiry.Enabled := True;;
    btn_query.Enabled:= True;
    btn_excel.Enabled:= True;
    btn_close.Enabled:= True;
end;

//각 필드의 폭은 실제 실행, 확인 후 재 조정할 것.
procedure Tfrm_LOSTB240Q.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 9;
    RowHeights[0] := 21;

    ColWidths[0] := 75;
    Cells[0,0] :='발송일자';

    ColWidths[1] := 65;
    Cells[1,0] :='KT';

    ColWidths[2] := 75;
    Cells[2,0] :='LGU+';

    ColWidths[3] := 100;
    Cells[3,0] :='불명PCS';

    ColWidths[4] := 95;
    Cells[4,0] :='PCS건수';

    ColWidths[5] := 65;
    Cells[5,0] :='SKT';

    ColWidths[6] := 120;
    Cells[6,0] :='불명CELL  ';

    ColWidths[7] := 105;
    Cells[7,0] :='CELL건수';

    ColWidths[8] := 80;
    Cells[8,0] :='총건수';
    end;
end;

//'닫기'버튼 클릭
procedure Tfrm_LOSTB240Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

//폼 크레이트 이벤트
procedure Tfrm_LOSTB240Q.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
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
//	common_username:= '정호영'; //ParamStr(3);
//	common_usergroup:= 'KAIT'; //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 내부 캡션 설정
  pnl_Program_Name.Caption := TITLE;

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

	initSkinForm(SkinData1); //common_lib.pas에 있다.


  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

//'조회' 버튼 클릭
procedure Tfrm_LOSTB240Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//   Capiend;
end;

//OnExit -- dte_from
procedure Tfrm_LOSTB240Q.dte_fromExit(Sender: TObject);
begin
     sts_Message.Panels[1].Text := '';
 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
 end;
end;

//OnExit -- dte_to
procedure Tfrm_LOSTB240Q.dte_toExit(Sender: TObject);
begin
     sts_Message.Panels[1].Text := '';
 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
     exit;
 end;
 if Trunc(dte_to.Date) > Trunc(date) then
 begin
     showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
     exit;
 end;

end;

//'출력' 버튼 클릭
procedure Tfrm_LOSTB240Q.btn_PrintClick(Sender: TObject);
var
	head:TLOSTB240Q_PRT_HEAD;	//head 계산
	Canvas: TCanvas;
	i, j, page : integer;

  datetime : string;

  curntYposi:Integer;  //현재 y측 포인트
  prntWidth:Cardinal;	 //프린터 폭(297mm)
  prntHeight:Cardinal; //프린터 높이(210mm)
  prntMargin:Cardinal; //오른쪽, 왼쪽 마진(20mm);
  swidth, sheight:Cardinal;	//문자열 높이

  lineStart:Cardinal;	//줄긋기 시작점;
  lineEnd:Cardinal;
  ygap:Cardinal;		//y축 -갭

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
    start       := x - Canvas.TextWidth(text) div 2;
    eend        := x + Canvas.TextWidth(text) div 2;
    curntYposi  := curntYposi-sheight - 10;
    Canvas.MoveTo(start, curntYposi);
    Canvas.LineTo(eend, curntYposi);

    //다음을 위해서...
    Inc(curntYposi, -ygap);  //다음줄로 이동
  end;

  //타이틀 프린트
	procedure printTitle(page:integer);
  var
    i   :Integer;
    str :String;
    len :Cardinal;
	begin
    centerPrint(prntWidth div 2,  	 '사은품 발송 현황 (일별)');
    //상기 문자열에 대한 밑줄 긋기
    centerUnderLine(prntWidth div 2, '사은품 발송 현황 (일별)');

    //머릿말 시작------------------------------------
    Inc(curntYposi, -sheight);
    Inc(curntYposi, -ygap);

    str := 'PROG ID: LOSTB240Q';
    Canvas.TextOut(lineStart, curntYposi,str);

    str:= '발송일자: '+ dte_from.Text +' ~ '+ dte_to.Text;
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
    for i:=0 to 8 do
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
  Canvas    := Printer.Canvas;
	datetime  := Formatdatetime('yyyymmdd',date)+'/'+Formatdatetime('hhnnss',time);

	i     := 0;
	j     := 1;
	page  := 1;

	Printer.Orientation := poLandscape;

  //프린트 시작
	Printer.BeginDoc;	//이부분을 위것 보다 먼저실행하면 에러발생...

  prntWidth := 2960;	//A4 = 297mm
  prntHeight:= 2090;	//A4 = 210mm
  prntMargin:= 200;	//left, right margin = 20mm

  //본 단위를 바꾸면 글자 숫자 계산을 다시해야 함.
	SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm 단위
	Canvas.Font.Name := '굴림체';
	Canvas.Font.Height := 32;  // 글자체 높이 4mm

  //Canvas.Font.Style:= [fsBold];

  //위치 중요
	head := TLOSTB240Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //마진, 전체폭,...

  sheight := Canvas.TextHeight('가'); //문자높이 계산, 4mm
  ygap:= 14;							//1mm 갭
  curntYposi := -100;   				//문자열을 쓰거나 라인을 그을때 y-축 기준점
  lineStart := head.getRightPosition(0)- head.getLength(0) -20;	//선긋기 x-축 시작점
  lineEnd:=  head.getRightPosition(8) +20;						//선긋기 x-축 끝점

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
          if -(curntYposi) + prntMargin >= prntHeight then begin
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
  Canvas.MoveTo(lineStart, curntYposi);
  Canvas.LineTo(lineEnd, curntYposi);

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

//팝업메뉴/Copy 클릭
procedure Tfrm_LOSTB240Q.Copy1Click(Sender: TObject);
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
    Clipboard.AsText := str;end;

//'조회' 버튼 클릭
procedure Tfrm_LOSTB240Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1:Integer;

    RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
  //그리드 디스플레이
  RowPos:= 1;	//그리드 레코드 포지션
  grd_display.RowCount := 2;

  //시작시변수 초기화
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

INQUIRY:
{
입력;
STR001 : 발송일자 FROM
STR002 : 발송일자 TO
}
	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostB240Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTB240Q') then goto LIQUIDATION;

	count1 := TMAX.RecvInteger('INT100',0);
  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);
      Cells[1,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL102',i), '.'));
      Cells[2,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL103',i), '.'));
      Cells[3,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL104',i), '.'));
      Cells[4,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL105',i), '.'));
      Cells[5,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL106',i), '.'));
      Cells[6,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL107',i), '.'));
      Cells[7,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL108',i), '.'));
      Cells[8,RowPos] := convertWithCommer(firstString(TMAX.RecvString('DBL109',i), '.'));
      Inc(RowPos);
      end;
  end;
  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(count1) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
  qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

//'엑셀' 버튼 클릭
procedure Tfrm_LOSTB240Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('조회관리(LOSTB220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB220Q');
end;

//'쿼리' 버튼 클릭
procedure Tfrm_LOSTB240Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

  filePath:='..\Temp\LOSTB220Q_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

//그리드 드로우
procedure Tfrm_LOSTB240Q.grd_displayDrawCell(Sender: TObject; ACol,
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

	else begin // ARow >= 1
    SettextAlign( grid.canvas.handle, ta_right );
    grid.canvas.TextRect( rect, rect.right-2, rect.top+4, S);
 	end;

{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}end;

//폼 쇼 이벤트
procedure Tfrm_LOSTB240Q.FormShow(Sender: TObject);
begin
  initComponent;
end;

procedure Tfrm_LOSTB240Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB240Q.initComponent;
begin
  pInitStrGrd(Self);
  // 버튼이미지 초기화
  changeBtn(Self);
  btn_Print.Enabled := True;

  initStrGrid;	//그리드 초기화

	dte_from.Date := date-30;
	dte_to.Date   := date;

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

	dte_from.SetFocus;
end;

procedure Tfrm_LOSTB240Q.btn_resetClick(Sender: TObject);
begin
  initComponent;
end;

end.
