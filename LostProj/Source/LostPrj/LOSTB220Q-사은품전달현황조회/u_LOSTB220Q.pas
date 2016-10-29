{*---------------------------------------------------------------------------
프로그램ID    : LOSTA240Q ( 분실폰 상태별 현황 (일별))
프로그램 종류 : Online
작성자	      : 구내영
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

unit u_LOSTB220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
  TITLE   = '사은품전달현황조회';
  PGM_ID  = 'LOSTB220Q';

type
TZ001 = record
	name: String[20];
    code: String[10];
    Jcode1: String[10];
    Jcode2: String[10];
    JCode3: String[10];
    JCode4: String[10];
    Used: Char;
end;

type
  Tfrm_LOSTB220Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    grd_display: TStringGrid;
    Panel2: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_id_cd: TComboBox;
    SkinData1: TSkinData;
    SKT_pnl: TPanel;
    LGU_pnl: TPanel;
    KT_pnl: TPanel;
    TMAX: TTMAX;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    PCS_pnl: TPanel;
    Cell_pnl: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure cmb_id_cdChange(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btn_queryClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    z001Data:Array of TZ001;
    z001DataCount:Integer;
    qryStr:String;

	cmb_id_cd_d:TZ0xxArray;
    //콤보박스 초기화
    procedure initComboBox;
    //그리드 초기화
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTB220Q: Tfrm_LOSTB220Q;

implementation
{$R *.DFM}

procedure Tfrm_LOSTB220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTB220Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB220Q.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_id_cd.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

//그리드의 첫번째 라인(메목)을 이쁘게 튜닝한다.
procedure Tfrm_LOSTB220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    end;
{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;

//각 필드의 폭은 실제 실행, 확인 후 재 조정할 것.
procedure Tfrm_LOSTB220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 12;
    	RowHeights[0] := 21;

    	ColWidths[0] := 45;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 80;
		Cells[1,0] :='전달일자';

    	ColWidths[2] := 110;
		Cells[2,0] :='주민사업자번호';

    	ColWidths[3] := 100;
		Cells[3,0] :='성명(업체명)';

    	ColWidths[4] := 110;
		Cells[4,0] :='전환번호';

    	ColWidths[5] := 60;
		Cells[5,0] :='우편번호';

    	ColWidths[6] := 350;
		Cells[6,0] :='주소';

    	ColWidths[7] := 60;
		Cells[7,0] :='상품코드';

    	ColWidths[8] := 60;
		Cells[8,0] :='상품명';

    	ColWidths[9] := 60;
		Cells[9,0] :='모델코드';

    	ColWidths[10] := 75;
		Cells[10,0] :='모델명';

    	ColWidths[11] := 120;
		Cells[11,0] :='단말기일련번호';
    end;
end;

//콤보박스에 채워질 항목을 파일에서 읽어 들인다.
procedure Tfrm_LOSTB220Q.initComboBox;
begin
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', '불명단말기', cmb_id_cd);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB220Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;

procedure Tfrm_LOSTB220Q.FormCreate(Sender: TObject);
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
    	ShowMessage('로그인 후 실행 하세요');
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
	//common_username:= '정호영'; //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

	initSkinForm(SkinData1); //common_lib.pas에 있다.
  initComboBox;	//콤보박스 채움
  initStrGrid;	//그리드 초기화


	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

//조회버튼 클릭
procedure Tfrm_LOSTB220Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;
	STR004 : String;
	STR005 : String;
	STR006 : String;
	STR007 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    pInitStrGrd(Self);

    //시작시변수 초기화
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
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

	//분기점....
    if cmb_id_cd_d[cmb_id_cd.ItemIndex].name <> '전체' then
    	goto INQUIRY;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;

    KT_pnl.Caption := 'KT '+ TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU '+ TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '+ TMAX.RecvString('INT104',0);
    PCS_pnl.Caption := 'PCS불명 '+ TMAX.RecvString('INT105',0);
    CELL_pnl.Caption := 'CELL불명 '+ TMAX.RecvString('INT106',0);

    //PCS불명
    //CELL불명

//	Goto LIQUIDATION;

//내역조회
INQUIRY:
{
입력;
STR001 : 전달일자 FROM
STR002 : 전달일자 TO
STR003 : 사업자구분
STR004 : 조회시작전달 일자
STR005 : 조회시작 주민번호
STR006 : 조회시작 모델코드
STR007 : 조회시작 일련번호
}
	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;

    //서비스 호출
  //서비스 호출
  if not TMAX.Call('LOSTB220Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

//grd_display
{
SEQ
전달일자
주민사업자번호
성명(업체명)
전환번호
우편번호
주소
상품코드
상품명
모델코드
모델명
단말기일련번호

출력
STR101 : 전달일자
STR102 : 주민사업자번호
STR103 : 성명(업체명)
STR104 : 전환번호
STR105 : 우편번호
STR106 : 주소
STR107 : 상품코드
STR108 : 상품명
STR109 : 모델코드
STR110 : 모델명
STR111 : 단말기일련번호

INT100 : COUNT...약속값 ....읽기
INF013 : 실제 카운트 값 ...읽기

}
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
        	Cells[0,RowPos] := intToStr(seq);

          STR004 := delHyphen(Trim(TMAX.RecvString('STR101',i)));
        	Cells[1,RowPos] := TMAX.RecvString('STR101',i);

          seed_idno       := TMAX.RecvString('STR102',i);
          Cells[2,RowPos] := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
          STR005 := delHyphen(Cells[2,RowPos]);

          seed_name       := TMAX.RecvString('STR103',i);
        	Cells[3,RowPos] := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
        	seed_tlno       := TMAX.RecvString('STR104',i);
          Cells[4,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        	Cells[5,RowPos] := TMAX.RecvString('STR105',i);
        	Cells[6,RowPos] := TMAX.RecvString('STR106',i);
        	Cells[7,RowPos] := TMAX.RecvString('STR107',i);
        	Cells[8,RowPos] := TMAX.RecvString('STR108',i);

            STR006 := Trim(TMAX.RecvString('STR109',i));
        	Cells[9,RowPos] := STR006;

        	Cells[10,RowPos] := Trim(TMAX.RecvString('STR110',i));

            STR007:= TMAX.RecvString('STR111',i);
        	Cells[11,RowPos] := STR007;
{
STR004 : 조회시작전달 일자 <- STR101
STR005 : 조회시작 주민번호 <- STR102
STR006 : 조회시작 모델코드 <- STR109
STR007 : 조회시작 일련번호 <- STR111
}
            Inc(seq);
            Inc(RowPos);
        end;
    end;
    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    count2 := TMAX.RecvInteger('INT100',0);
    if count1 = count2 then
    	goto INQUIRY;

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

procedure Tfrm_LOSTB220Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);

end;

//OnExit --- dte_to
procedure Tfrm_LOSTB220Q.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then begin
		showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
		exit;
	end;
end;

//OnExit --- dte_from
procedure Tfrm_LOSTB220Q.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

//OnChange ---콤보박스
procedure Tfrm_LOSTB220Q.cmb_id_cdChange(Sender: TObject);
begin
	if cmb_id_cd.ItemIndex =0 then begin
    KT_pnl.Visible:= True;
    LGU_pnl.Visible:= True;
    SKT_pnl.Visible := True;
		PCS_pnl.Visible := True;
		CELL_pnl.Visible := True;
    end

	else begin
    KT_pnl.Visible:= false;
    LGU_pnl.Visible:= false;
    SKT_pnl.Visible := false;
		PCS_pnl.Visible := false;
		CELL_pnl.Visible := false;
    end;
end;

//'쿼리'버튼 클릭 -- 쿼리를 워드패드 창에 보여줌.(노트패드는 특수문자로 인해 제외)
procedure Tfrm_LOSTB220Q.btn_queryClick(Sender: TObject);
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

//팝업메뉴(마우스의 오른쪽버튼을 클릭) -- 그리드의 내용을 클립보드에 복사
procedure Tfrm_LOSTB220Q.Copy1Click(Sender: TObject);
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

//'엑셀'버튼 클릭 --- 그리드의 내용을 엑셀로 변경후 화면에 보여진다.
//'Proc_gridtoexcel' 프로시저는 Func_Lib.pas 에 있다.
procedure Tfrm_LOSTB220Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('조회관리(LOSTB220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB220Q');
end;

//CTRL+C 를 눌렀을 경우 그리드의 내용을 클립보드에 복사한다.
procedure Tfrm_LOSTB220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTB220Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  dte_from.Date := date - 30;
  dte_to.Date := date;
	dte_from.SetFocus;
  changeBtn(Self);

  cmb_id_cd.ItemIndex := 0;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  KT_pnl.Caption := 'KT '+ '0';
  LGU_pnl.Caption := 'LGU '+ '0';
  SKT_pnl.Caption := 'SKT '+ '0';
  PCS_pnl.Caption := 'PCS불명 '+ '0';
  CELL_pnl.Caption := 'CELL불명 '+ '0';

    

end;

end.
