{*---------------------------------------------------------------------------
프로그램ID    : LOSTB260Q (사은품 발송대상자 추출)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011.09.29
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

unit u_LOSTB260Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  common_lib, WinSkinData, so_tmax,Func_Lib, Menus,Clipbrd, ComObj;

const
  TITLE   = '사은품발송대상자추출';
  PGM_ID  = 'LOSTB260Q';

type
  Tfrm_LOSTB260Q = class(TForm)
    pnl_Command:      TPanel;
    sts_Message:      TStatusBar;
    Panel2:           TPanel;
    Bevel2:           TBevel;
    Label2:           TLabel;
    Bevel1:           TBevel;
    pnl_Program_Name: TLabel;
    dte_to:           TDateEdit;
    Label1:           TLabel;
    dte_from:         TDateEdit;
    SkinData1:        TSkinData;
    TMAX:             TTMAX;
    grd_display:      TStringGrid;
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
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;

    procedure btn_CloseClick    (Sender: TObject);
    procedure FormCreate        (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure dte_fromExit      (Sender: TObject);
    procedure dte_toExit        (Sender: TObject);

    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click(Sender: TObject);

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
  frm_LOSTB260Q: Tfrm_LOSTB260Q;


implementation

{$R *.DFM}

procedure Tfrm_LOSTB260Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB260Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{*******************************************************************************
* procedure Name : initStrGrid
* 기 능 설 명 : 그리드를 초기화 하고 필드 타이틀 설정을 한다.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.initStrGrid;
var
  j : Integer;
begin
	with grd_display do begin
    j := 0;
    RowCount := 2;
    ColCount := 15;
    RowHeights[0] := 21;

    cells[fInc(j),0] := '순번';
    cells[fInc(j),0] := '습득자번호';
    cells[fInc(j),0] := '습득자명';
    cells[fInc(j),0] := '우편번호';
    cells[fInc(j),0] := '주소';
    cells[fInc(j),0] := '전화번호';
    cells[fInc(j),0] := '입고일';
    cells[fInc(j),0] := '상품권1';
    cells[fInc(j),0] := '상품권2';
    cells[fInc(j),0] := '모바일상품권1';
    cells[fInc(j),0] := '생활용품2';
    cells[fInc(j),0] := '모바일상품권2';
    cells[fInc(j),0] := '전체';
    cells[fInc(j),0] := '금액';
    cells[fInc(j),0] := '우체국직원여부';

    j := 0;

    colwidths[fInc(j)] :=  60;   //순번
    colwidths[fInc(j)] := 100;   //습득자번호
    colwidths[fInc(j)] := 140;   //습득자명
    colwidths[fInc(j)] :=  80;   //우편번호
    colwidths[fInc(j)] := 240;   //주소
    colwidths[fInc(j)] := 120;   //전화번호
    colwidths[fInc(j)] := 100;   //입고일
    colwidths[fInc(j)] :=  80;   //상품권1
    colwidths[fInc(j)] :=  80;   //상품권2
    colwidths[fInc(j)] := 120;   //모바일상품권1
    colwidths[fInc(j)] := 0;   //생활용품2
    colwidths[fInc(j)] := 120;   //모바일상품권2
    colwidths[fInc(j)] := 100;   //전체
    colwidths[fInc(j)] := 120;   //금액
    colwidths[fInc(j)] := 100;    //우체국직원여부
  end;

end;

procedure Tfrm_LOSTB260Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB260Q.FormCreate(Sender: TObject);
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
  // common_userid     := '0294';    //ParamStr(2);
  // common_username   := '정호영';  //ParamStr(3);
  // common_usergroup  := 'KAIT';    //ParamStr(4);

  //스킨 초기화
  initSkinForm(SkinData1);      // common_lib.pas에 있다.

  // 그리드 초기화
  initStrGrid;

  qryStr := '';
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB260Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno, seed_mtno : String;

    i,j,count1: Integer;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

    pInitStrGrd(Self);
    grd_display.RowCount := 2;

    grd_display.Cursor := crSQLWait;	//작업중....

    disableComponents;	//작업중 다른 기능 잠시 중지.

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

//SEED KEY 조회
SEEDKEY:

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //서비스 호출
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키

//내역조회
INQUIRY:
	  TMAX.InitBuffer;

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LostB260Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;

    // 사용자 데이터 설정 완료

    //서비스 호출
    if not TMAX.Call('LOSTB260Q') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end;
    // 쿼리 얻기
    qryStr:= TMAX.RecvString('INF014',0);

    // 조회갯수
    count1 := TMAX.RecvInteger('INF013',0);    

    if count1 < 1 then begin
      for i := grd_display.fixedrows to grd_display.rowcount - 1 do
      grd_display.rows[i].Clear;
      grd_display.RowCount := 3;
      sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
      goto LIQUIDATION;
    end;

    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INF013',0);

    with grd_display do begin
        for i:=0 to TMAX.RecvInteger('INF013',0) -1 do
        begin
          if i <> TMAX.RecvInteger('INF013',0) -1 then  Cells[ 0,i+1]   := IntToStr(i + 1);

          seed_idno       :=                   TMAX.RecvString('STR101',i);   // 습득자번호
          Cells[ 1,i+1]   :=                   ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
          seed_name       :=                   TMAX.RecvString('STR102',i);   // 습득자명
          Cells[ 2,i+1]   :=                   ECPlazaSeed.Decrypt(seed_name, common_seedkey);
          Cells[ 3,i+1]   :=                   TMAX.RecvString('STR103',i);   // 우편번호
          Cells[ 4,i+1]   := TMAX.RecvString('STR104',i) + TMAX.RecvString('STR105',i);   // 주소
          seed_tlno       :=                   TMAX.RecvString('STR106',i);   // 전화번호
          Cells[ 5,i+1]   := InsHyphen(ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
          Cells[ 6,i+1]   := InsHyphen(        TMAX.RecvString('STR107',i));  // 입고일자
          Cells[ 7,i+1]   := convertWithCommer(TMAX.RecvString('INT108',i));  // 상품권1
          Cells[ 8,i+1]   := convertWithCommer(TMAX.RecvString('INT109',i));  // 상품권2
          Cells[ 9,i+1]   := convertWithCommer(TMAX.RecvString('INT110',i));  // 모바일상품권1
          Cells[10,i+1]   := convertWithCommer(TMAX.RecvString('INT111',i));  // 생활용품2
          Cells[11,i+1]   := convertWithCommer(TMAX.RecvString('INT112',i));  // 모바일상품권2
          Cells[12,i+1]   := convertWithCommer(TMAX.RecvString('INT113',i));  // 상품합계
          Cells[13,i+1]   := convertWithCommer(TMAX.RecvString('INT114',i));  // 상품금액합계
          Cells[14,i+1]   := TMAX.RecvString('STR115',i);  // 우체국직원여부
        end;
    end;

    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + IntToStr(TMAX.RecvInteger('INF013',0)) + '건이 조회 되었습니다.';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

{*******************************************************************************
* procedure Name : dte_fromExit
* 기 능 설 명 : 날짜입력 후 입력된 날짜들의 유효성을 검증하고 메세지를 출력함.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.dte_fromExit(Sender: TObject);
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
procedure Tfrm_LOSTB260Q.dte_toExit(Sender: TObject);
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
procedure Tfrm_LOSTB260Q.disableComponents;
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
procedure Tfrm_LOSTB260Q.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* 기 능 설 명 : 그리드 타이틀 부분에 대한 데코레이션 효과를 준다.
*
*******************************************************************************}
procedure Tfrm_LOSTB260Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      2,4,5   : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,1,3,6,14 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);

      else      StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
    end;
  end;

end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTB260Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB260Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel('사은품 발송대상자 추출(LOSTB260Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB260Q');
end;

procedure Tfrm_LOSTB260Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  //버튼이미지 초기화
  changeBtn(Self);

  // 날짜 필드 셋팅
  dte_from.Date := date-30;
  dte_to.Date   := date;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;  

end;

procedure Tfrm_LOSTB260Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTB260Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB260Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTB260Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB260Q.Copy1Click(Sender: TObject);
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

end.
