{*---------------------------------------------------------------------------
프로그램ID    : LOSTA230Q (분실폰 입/출고 현황 (일별))
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011. 09. 11
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
unit u_LOSTA230Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  cpakmsg, printers, common_lib, WinSkinData, so_tmax, LOSTA230Q_PRT_HEAD,
  Menus, Clipbrd,Func_Lib, ComObj;

const
  PGM_NM   = '분실폰 입/출고 현황 (일별)';
  PGM_ID  = 'LOSTA230Q';

type
  Tfrm_LOSTA230Q = class(TForm)
    Bevel2     : TBevel;
    Bevel1     : TBevel;
    dte_to     : TDateEdit;
    dte_from   : TDateEdit;
    Label2     : TLabel;
    Label1     : TLabel;
    pnl_Program_Name: TLabel;
    Copy1      : TMenuItem;
    PageControl1: TPageControl;
    Panel2     : TPanel;
    pnl_Command: TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    sts_Message: TStatusBar;
    grd_display2: TStringGrid;
    grd_display1: TStringGrid;
    TMAX       : TTMAX;
    TabSheet1  : TTabSheet;
    TabSheet2  : TTabSheet;
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

    procedure btn_CloseClick    (Sender: TObject);
    procedure FormCreate        (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure FormClose         (Sender: TObject; var Action: TCloseAction);
    procedure FormShow          (Sender: TObject);
    procedure btn_PrintClick    (Sender: TObject);
    procedure dte_fromExit      (Sender: TObject);
    procedure dte_toExit        (Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click        (Sender: TObject);

    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure PageControl1Change(Sender: TObject);
    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);

    procedure dte_fromKeyPress(Sender: TObject; var Key: Char);

    procedure dte_toKeyPress(Sender: TObject; var Key: Char);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
    procedure InitComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTA230Q: Tfrm_LOSTA230Q;
  qryStr:String;
  cnt : integer;

Const
     MAXRECCNT = 11;

implementation
uses cpaklibm;
{$R *.DFM}

procedure ButtonInit; forward;

procedure ButtonInit;
begin
//
end;

{*******************************************************************************
* procedure Name : initStrGrid
* 기 능 설 명 : 그리드를 초기화 하고 필드 타이틀 설정을 한다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.initStrGrid;
begin
	with grd_display1 do begin
    RowCount := 2;
    ColCount := 9;
    RowHeights[0] := 21;

    cells[0,0] := '일자';
    cells[1,0] := 'KT';
    cells[2,0] := 'LGU+';
    cells[3,0] := '불명PCS';
    cells[4,0] := 'PCS 계';
    cells[5,0] := 'SKT';
    cells[6,0] := '불명CELL';
    cells[7,0] := 'CELL계';
    cells[8,0] := '계';

    colwidths[0] := 89;
    colwidths[1] := 85;
    colwidths[2] := 85;
    colwidths[3] := 85;
    colwidths[4] := 85;
    colwidths[5] := 85;
    colwidths[6] := 85;
    colwidths[7] := 85;
    colwidths[8] := 80;
    end;

	with grd_display2 do begin
    RowCount := 2;
    ColCount := 9;
    RowHeights[0] := 21;

    cells[0,0] := '일자';
    cells[1,0] := 'KT';
    cells[2,0] := 'LGU+';
    cells[3,0] := '불명PCS';
    cells[4,0] := 'PCS 계';
    cells[5,0] := 'SKT';
    cells[6,0] := '불명CELL';
    cells[7,0] := 'CELL계';
    cells[8,0] := '계';

    colwidths[0] := 89;
    colwidths[1] := 85;
    colwidths[2] := 85;
    colwidths[3] := 85;
    colwidths[4] := 85;
    colwidths[5] := 85;
    colwidths[6] := 85;
    colwidths[7] := 85;
    colwidths[8] := 80;

    end;
end;

procedure Tfrm_LOSTA230Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA230Q.FormCreate(Sender: TObject);
begin
{  }
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

  {----------------------- 공통 어플리케이션 설정 ---------------------------}
  setEdtKeyPress;
  Self.Caption := '[' + PGM_ID + ']' + PGM_NM;

  Application.Title := PGM_NM;
  fSetIcon(Application);
  pSetStsWidth(sts_Message);
  pSetTxtSelAll(Self);

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  //스킨 초기화
  initSkinForm(SkinData1);      // common_lib.pas에 있다.

  // 초기화
  InitComponents;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA230Q.btn_InquiryClick(Sender: TObject);
var
    tot : Array of Integer;
    i,j,RowPos,count1,count2 : Integer;
    Label LIQUIDATION;
    Label INQUIRY;

begin
    if cnt = 0 then
      pInitStrGrd(grd_display1)
    else
      pInitStrGrd(grd_display2);

    // 디버그용 쿼리 변수 초기화
    qryStr:= '';
    //grd_display1.RowCount := 2;
    //grd_display2.RowCount := 2;

    RowPos := 1;

    SetLength(tot,grd_display1.ColCount - 1);
    FillChar((@tot[0])^,Length(tot)*sizeof(Integer),0);

    // 탭 인덱스 별 작업

    grd_display1.Cursor := crSQLWait;	//작업중....
    grd_display2.Cursor := crSQLWait;	//작업중....

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
  if (TMAX.SendString('INF003','LostA230Q')     < 0)  then  goto LIQUIDATION;

  if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;

  if cnt = 1 then begin
    if (TMAX.SendString('STR003', IntToStr(2)) < 0) then  goto LIQUIDATION;
  end else begin
    if (TMAX.SendString('STR003', IntToStr(1)) < 0) then  goto LIQUIDATION;
  end;
  // 사용자 데이터 설정 완료

  //서비스 호출
  if not TMAX.Call('LOSTA230Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
  end;
  ;

  // 조회 결과 DISPLAY
  count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    if cnt = 0 then begin
      for i := grd_display1.fixedrows to grd_display1.rowcount - 1 do
        grd_display1.rows[i].Clear;

      grd_display1.RowCount := 2;

    end else
    begin
      for i := grd_display2.fixedrows to grd_display2.rowcount - 1 do
        grd_display2.rows[i].Clear;

      grd_display2.RowCount := 2;

    end;

    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
  end else
  begin

    qryStr:= TMAX.RecvString('INF014',0);

    case cnt of
    0:
      begin
        grd_display1.RowCount := grd_display1.RowCount + count1;

        with grd_display1 do begin
          for i:=0 to count1-1 do
          begin
            Cells[0,RowPos]   := InsHyphen(TMAX.RecvString('STR101',i)); // 일자
            Cells[1,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT101',i))); // KT프리텔
            Cells[2,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT102',i))); // LG텔레콤
            Cells[3,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); // 불명PCS
            Cells[4,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); // PCS 계
            Cells[5,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); // SK텔레콤
            Cells[6,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); // 불명셀룰러
            Cells[7,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); // 셀룰러계
            Cells[8,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); // 계

            // 총계 계산
            for j:=0 to ColCount - 2 do
                tot[j] := tot[j] + StrToInt(Cells[j+1,RowPos]);

            Inc(RowPos);
          end;

          // 총계 출력
          Cells[0,RowPos]   := '총계';

           for j:=0 to ColCount - 2 do
              Cells[j+1,RowPos] := convertWithCommer(IntToStr(tot[j]));
        end;
      end;
    1 :
      begin
        grd_display2.RowCount := grd_display2.RowCount + count1;

        with grd_display2 do begin
          for i:=0 to count1-1 do
          begin
            Cells[0,RowPos]   := InsHyphen(TMAX.RecvString('STR101',i)); // 일자
            Cells[1,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT101',i))); // KT프리텔
            Cells[2,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT102',i))); // LG텔레콤
            Cells[3,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); // 불명PCS
            Cells[4,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); // PCS 계
            Cells[5,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); // SK텔레콤
            Cells[6,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); // 불명셀룰러
            Cells[7,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT107',i))); // 셀룰러계
            Cells[8,RowPos]   := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i))); // 계

            // 총계 계산
            for j:=0 to ColCount - 2 do
                tot[j] := tot[j] + StrToInt(Cells[j+1,RowPos]);

            Inc(RowPos);
          end;

          // 총계 출력
          Cells[0,RowPos]   := '총계';

           for j:=0 to ColCount - 2 do
              Cells[j+1,RowPos] := convertWithCommer(IntToStr(tot[j]));
        end;
      end;
    end;

  end;

  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + IntToStr(count1) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  count2 := TMAX.RecvInteger('INT100',0);

  if count1 = count2 then
    goto INQUIRY;

  cnt := cnt +1;


LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if cnt = 1 then
  begin
    btn_InquiryClick(sender);
    exit;
  end;

  grd_display1.Cursor := crDefault;	//작업완료
  grd_display2.Cursor := crDefault;	//작업완료

  cnt := 0;

  enableComponents;
end;

procedure Tfrm_LOSTA230Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    //Capiend;
end;

procedure Tfrm_LOSTA230Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

{*******************************************************************************
* procedure Name : btn_PrintClick
* 기 능 설 명 : 조회된 결과를 출력한다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.btn_PrintClick(Sender: TObject);
var
  head:TLOSTA230Q_PRT_HEAD;	//head 계산
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
    start       := x - Canvas.TextWidth(text) div 2;
    eend        := x + Canvas.TextWidth(text) div 2;
    curntYposi  := curntYposi-sheight - 10;
    Canvas.MoveTo(start, curntYposi);
    Canvas.LineTo(eend, curntYposi);

    //다음을 위해서...
    Inc(curntYposi, -ygap);  //다음줄로 이동
  end;

  //타이틀 프린트
  procedure printPGM_NM(page:integer);
  var
    i:Integer;
    start:Cardinal;
  begin
    centerPrint(prntWidth div 2,  	 '분실폰 입출고 현황 (일별)');
    //상기 문자열에 대한 밑줄 긋기
    centerUnderLine(prntWidth div 2, '분실폰 입출고 현황 (일별)');

    Inc(curntYposi, -ygap);
    //타이틀 윗쪽에 줄 긋기
    Canvas.MoveTo(lineStart, curntYposi);
    Canvas.LineTo(lineEnd, curntYposi);

    //타이틀을 출력한다.
    Inc(curntYposi, -ygap);

    for i:=0 to 10 do
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
  Canvas.Font.Name    := '굴림체';
  Canvas.Font.Height  := 32;  // 글자체 높이 4mm
  //Canvas.Font.Style:= [fsBold];

  //위치 중요
  head := TLOSTA230Q_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //마진, 전체폭,...

  sheight     := Canvas.TextHeight('가'); //문자높이 계산, 4mm
  ygap        := 18;							        //1mm 갭
  curntYposi  := -100;   				          //문자열을 쓰거나 라인을 그을때 y-축 기준점
  lineStart   := 80 ;	//선긋기 x-축 시작점
  lineEnd     := head.getRightPosition(10) +20;						//선긋기 x-축 끝점

  //타이틀 프린트
  printPGM_NM(page);

  //내용 프린트---마지막 줄은 따로 프린트
  with grd_display1 do begin
    for j:= 1 to RowCount-1 do begin
      for i:=0 to ColCount-1 do
        rightPrint(head.getRightPosition(i), Cells[i,j]);

      Inc(curntYposi, -sheight);	//다음줄 이동
      Inc(curntYposi, -ygap);		//1mm 아래로 이동

      //출력물이 페이지를 넘어가면...
      if -(curntYposi) + prntMargin >= prntHeight then
      begin
        Printer.NewPage;      	//새 페이지 추가
        Inc(page);   			//페이지 번호 카운트 업
        curntYPosi := -100;     //y축  position을 새로 시작한다.

        //기타 초기화 해야 할 항목이 있으면 여기서...

        printPGM_NM(page);		//타이틀을 다시 프린트...
      end;
      end;
  end;
  {
  //마지막 줄(총계) 프린트

  //라인긋기...그리드 안에서는 안된다....Canvas가 겹치서..
  //총계 윗줄 라인..
  Canvas.MoveTo(lineStart , curntYposi);
  Canvas.LineTo(lineEnd   , curntYposi);

  Inc(curntYposi, -ygap);		//1mm 아래로 이동
  for i:= 0 to grd_display1.ColCount-1 do
    rightPrint(head.getRightPosition(i), grd_display1.Cells[i,grd_display1.RowCount-1]);

  Inc(curntYposi, -sheight);	//다음줄 이동
  Inc(curntYposi, -ygap);		//1mm 아래로 이동
  //총계 아랫쪽 라인..
  Canvas.MoveTo(lineStart, curntYposi);
  Canvas.LineTo(lineEnd, curntYposi);
  }
  //프린트 종료
  Printer.EndDoc;

  head.Free; 	//헤드 정보 삭제

  Showmessage('출력이 잘 되었습니다.');
end;

{*******************************************************************************
* procedure Name : dte_fromExit
* 기 능 설 명 : 날짜입력 후 입력된 날짜들의 유효성을 검증하고 메세지를 출력함.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.dte_fromExit(Sender: TObject);
begin
 sts_Message.Panels[1].Text := '';

 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
     exit;
 end;

end;

{*******************************************************************************
* procedure Name : dte_toExit
* 기 능 설 명 : 날짜입력 후 입력된 날짜들의 유효성을 검증하고 메세지를 출력함.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.dte_toExit(Sender: TObject);
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

{*******************************************************************************
* procedure Name : disableComponents
* 기 능 설 명 :버튼을 누르지 못하게 한다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.disableComponents;
begin
  dte_from.Enabled := false;
  dte_to.Enabled := false;
  btn_Inquiry.Enabled := False;

  btn_close.Enabled:= False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* 기 능 설 명 :버튼을 눌러 다른 기능을 할 수 있게한다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.enableComponents;
begin
  dte_from.Enabled  := True;
  dte_to.Enabled    := True;
  btn_Inquiry.Enabled := True;

  btn_close.Enabled:= True;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* 기 능 설 명 : 그리드 타이틀 부분에 대한 데코레이션 효과를 준다.
*
*******************************************************************************}
procedure Tfrm_LOSTA230Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1..11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
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
procedure Tfrm_LOSTA230Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

{*******************************************************************************
* procedure Name : Copy1Click
* 기 능 설 명 : 그리드에 선택된 내역을 클릭보드에 복사하는 역할을한다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display1.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_display1.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_display1.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTA230Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA230Q.PageControl1Change(Sender: TObject);
begin
  //initStrGrid;
  //pInitStrGrd(Self);
  if (PageControl1.ActivePageIndex = 0) then Label2.Caption := '입고일자'
  else Label2.Caption := '출고일자';
end;


procedure Tfrm_LOSTA230Q.setEdtKeyPress;
var i : Integer;
    edt : TEdit;
begin
  for i := 0 to componentCount -1 do
  begin
    if (Components[i] is TEdit) then
    begin
      (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
    end;
  end;
end;

procedure Tfrm_LOSTA230Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA230Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  //btn_Print.Enabled := True;

  cnt := 0;

  if frm_LOSTA230Q.tag = 1 then
    dte_from.SetFocus;

  frm_LOSTA230Q.Tag := 0;
  self.InitComponents;

  for i := grd_display1.fixedrows to grd_display1.rowcount - 1 do
    grd_display1.rows[i].Clear;
    grd_display1.RowCount := 2;

  for i := grd_display2.fixedrows to grd_display2.rowcount - 1 do
    grd_display2.rows[i].Clear;
    grd_display2.RowCount := 2;

end;

procedure Tfrm_LOSTA230Q.InitComponents;
var
  i : Integer;
begin
  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
     else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';
  end;

  changeBtn(Self);

  for i := grd_display1.FixedRows to grd_display1.RowCount -1 do
    grd_display1.Rows[i].Clear;

  for i := grd_display2.FixedRows to grd_display2.RowCount -1 do
    grd_display2.Rows[i].Clear;

  // 그리드 초기화
  initStrGrid;

  // 페이지 컨트롤 초기값 설정
  PageControl1.ActivePageIndex := 0;

  // 날짜 필드 셋팅
  dte_from.Date := date-30;
  dte_to.Date   := date-1;

  //쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.
  qryStr:= '';

  //버튼이미지 초기화
  changeBtn(Self);

  sts_Message.Panels[1].Text := '';
end;

procedure Tfrm_LOSTA230Q.btn_ExcelClick(Sender: TObject);
begin
  if (PageControl1.ActivePageIndex = 0) then
	  Proc_gridtoexcel(PGM_NM + '(' + PGM_ID + ')',grd_display1.RowCount, grd_display1.ColCount, grd_display1, PGM_ID)
  else
	  Proc_gridtoexcel(PGM_NM + '(' + PGM_ID + ')',grd_display2.RowCount, grd_display2.ColCount, grd_display2, PGM_ID);
end;

procedure Tfrm_LOSTA230Q.dte_fromKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then SelectNext(sender as TWinControl, true, True);
end;


procedure Tfrm_LOSTA230Q.dte_toKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA230Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA230Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
