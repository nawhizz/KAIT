{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ240P (감독국정보 등록)
프로그램 종류 : Online
작성자	      : jung hong ryul
작성일	      : 2011. 09. 08
완료일	      : ####. ##. ##
프로그램 개요 : 감독국정보 자료를 등록, 수정, 삭제, 조회한다.

     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ240P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,printers,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ240P_child, LOSTZ240P_PRT_HEAD, ComObj;

const
  TITLE   = '총괄국정보 등록';
  PGM_ID  = 'LOSTZ240P';


type
  Tfrm_LOSTZ240P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    cmb_Inq_Gu: TComboBox;
    edt_Inq_Str: TEdit;
    pnl_Command: TPanel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
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
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var
  PL_CD : String;
  GM_YN : String;

  frm_LOSTZ240P: Tfrm_LOSTZ240P;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ240P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ240P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTZ240P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 17;
    	RowHeights[0] := 21;

    	ColWidths[0] := -1;
		Cells[0,0] :='총괄국코드';

    	ColWidths[1] := 90;
		Cells[1,0] :='총괄국명';

      ColWidths[2] := -1;
		Cells[2,0] :='체신청코드';

      ColWidths[3] := 90;
		Cells[3,0] :='체신청국명';

      ColWidths[4] := 150;
		Cells[4,0] :='계좌번호';

      ColWidths[5] := 100;
		Cells[5,0] :='담당자부서명';

      ColWidths[6] := 100;
		Cells[6,0] :='담당자직급';

      ColWidths[7] := 100;
		Cells[7,0] :='담당자명';

      ColWidths[8] := 150;
		Cells[8,0] :='담당자전화번호';

      ColWidths[9] := 150;
		Cells[9,0] :='담당자핸드폰번호';

      ColWidths[10] := 150;
		Cells[10,0] :='담당자이메일';

      ColWidths[11] := 100;
		Cells[11,0] :='담당자우편번호';

      ColWidths[12] := -1;
		Cells[12,0] :='담당자기본주소';

      ColWidths[13] := -1;
		Cells[13,0] :='담당자상세주소';

      ColWidths[14] := -1;
		Cells[14,0] :='비고';

      ColWidths[15] := -1;
		Cells[15,0] :='총괄국여부';

      ColWidths[16] := 300;
		Cells[16,0] :='주소';

    end;
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ240P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ240P.FormCreate(Sender: TObject);
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
  {     }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

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

  initSkinForm(SkinData1);
  initStrGrid;	//그리드 초기화
  qryStr := '';

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ240P.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '총괄국코드';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 6;
   end
   else
   begin
      lbl_inq_str.Caption := '총괄국명';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 20;
   end;
end;

procedure Tfrm_LOSTZ240P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ240P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;
    btn_query.Enabled := True;

	  //그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

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
	if (TMAX.SendString('INF003','LOSTZ240P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Inq_Str.Text ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', ' ' ) < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTZ240P') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end;
    
    //쿼리 얻기
    qryStr:= TMAX.RecvString('INF014',0);
    
    //조회된 갯수
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

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i); //총괄국코드
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i); //총괄국명
          Cells[2,RowPos]  := TMAX.RecvString('STR103',i); //체신청코드
          Cells[3,RowPos]  := TMAX.RecvString('STR104',i); //체신청명
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i); //계좌번호
          Cells[5,RowPos]  := TMAX.RecvString('STR106',i); //담당자부서명
          Cells[6,RowPos]  := TMAX.RecvString('STR107',i); //담당자직급
          Cells[7,RowPos]  := TMAX.RecvString('STR108',i); //담당자명
          Cells[8,RowPos]  := TMAX.RecvString('STR109',i); //담당자전화번호
          Cells[9,RowPos]  := TMAX.RecvString('STR110',i); //담당자핸드폰번호
          Cells[10,RowPos] := TMAX.RecvString('STR111',i); //담당자이메일
          Cells[11,RowPos] := TMAX.RecvString('STR112',i); //담당자우편번호
          Cells[12,RowPos] := TMAX.RecvString('STR113',i); //담당자기본주소
          Cells[13,RowPos] := TMAX.RecvString('STR114',i); //담당자상세주소
          Cells[14,RowPos] := TMAX.RecvString('STR115',i); //비고
          Cells[15,RowPos] := TMAX.RecvString('STR116',i); //충괄국여부
          Cells[16,RowPos] := TMAX.RecvString('STR117',i); //기본+상세주소

          Inc(RowPos);
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
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
end;

procedure Tfrm_LOSTZ240P.btn_AddClick(Sender: TObject);
begin

    frm_LOSTZ240P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ240P.grd_displayDblClick(Sender: TObject);
begin
  PL_CD := grd_display.Cells[2, grd_display.Row];
  GM_YN := grd_display.Cells[15, grd_display.Row];

  frm_LOSTZ240P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ240P.btn_UpdateClick(Sender: TObject);
begin
  PL_CD := grd_display.Cells[2, grd_display.Row];
  GM_YN := grd_display.Cells[15, grd_display.Row];

  frm_LOSTZ240P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ240P.btn_DeleteClick(Sender: TObject);
begin
  PL_CD := grd_display.Cells[2, grd_display.Row];
  GM_YN := grd_display.Cells[15, grd_display.Row];

  frm_LOSTZ240P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ240P.btn_excelClick(Sender: TObject);
begin
Proc_gridtoexcel('시스템관리(LOSTZ240Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTZ240Q');
end;




{
procedure Tfrm_LOSTZ240P.btn_PrintClick(Sender: TObject);
var
	head:TLOSTZ240P_PRT_HEAD;	//head 계산
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
    	start:= x - Canvas.TextWidth(text) div 2;
    	eend:= x + Canvas.TextWidth(text) div 2;
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
        str:String;
        len:Cardinal;
	begin
    	centerPrint(prntWidth div 2,  	 '사은품 발송 현황 (일별)');
        //상기 문자열에 대한 밑줄 긋기
        centerUnderLine(prntWidth div 2, '사은품 발송 현황 (일별)');

        //머릿말 시작------------------------------------
        Inc(curntYposi, -sheight);
        Inc(curntYposi, -ygap);

        str := 'PROG ID: LOSTB250Q';
        Canvas.TextOut(lineStart, curntYposi,str);

       // str:= '발송일자: '+ dte_from.Text +' ~ '+ dte_to.Text;
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
        for i:=0 to 12 do
        	rightPrint(head.getRightPosition(i), titles[i]);

        Inc(curntYposi, -sheight);
        Inc(curntYposi, -ygap);
        //타이틀 아래쪽에 줄 긋기
        Canvas.MoveTo(lineStart, curntYposi);
        Canvas.LineTo(lineEnd, curntYposi);

        Inc(curntYPosi, -ygap);	//다음줄 준비...
	end;
begin
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


    prntMargin:= 200;	//left, right margin = 20mm

    //본 단위를 바꾸면 글자 숫자 계산을 다시해야 함.
	SetMapMode(Canvas.Handle, MM_LOMETRIC);	//0.1mm 단위
	Canvas.Font.Name := '굴림체';
	Canvas.Font.Height := 40;  // 글자체 높이 4mm
    //Canvas.Font.Style:= [fsBold];
   //위치 중요
	head := TLOSTZ240P_PRT_HEAD.Create(prntMargin, prntWidth, Canvas);  //마진, 전체폭,...

    sheight := Canvas.TextHeight('가'); //문자높이 계산, 4mm
    ygap:= 10;							//1mm 갭
    curntYposi := -100;   				//문자열을 쓰거나 라인을 그을때 y-축 기준점
    lineStart := head.getRightPosition(0)- head.getLength(0) -20;	//선긋기 x-축 시작점
    lineEnd:=  head.getRightPosition(4) +20;						//선긋기 x-축 끝점

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
  //  Canvas.MoveTo(lineStart, curntYposi);
  //	Canvas.LineTo(lineEnd, curntYposi);

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
}





procedure Tfrm_LOSTZ240P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      2: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      5: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      7: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      9: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      10: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;

end;

procedure Tfrm_LOSTZ240P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  cmb_Inq_Gu.ItemIndex := 0;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_query.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' '; 

end;

procedure Tfrm_LOSTZ240P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA210Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ240P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

end.
