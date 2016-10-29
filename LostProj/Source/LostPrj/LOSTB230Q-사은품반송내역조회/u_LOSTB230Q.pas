unit u_LOSTB230Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
  TITLE   = '사은품반송내역조회';
  PGM_ID  = 'LOSTB230Q';

type
TZ001 = record
	name: String[20];
    code: String[10];
    Jcode1: Char;
    Jcode2: Char;
    JCode3: Char;
    Used: Char;
end;


type
  Tfm_LOSTB230Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    grd_display: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel2: TPanel;
    Bevel4: TBevel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_id_cd: TComboBox;
    cmb_sp_cd: TComboBox;
    KT_pnl: TPanel;
    LGU_pnl: TPanel;
    SKT_pnl: TPanel;
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
    blpcs_pnl: TPanel;
    blcell_pnl: TPanel;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmb_id_cdChange(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
  private
    { Private declarations }
    cmb_id_cd_d: TZ0xxArray;
    cmb_sp_cd_d: TZ0xxArray;
    qryStr:String;

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
  fm_LOSTB230Q: Tfm_LOSTB230Q;

implementation
{$R *.DFM}

procedure Tfm_LOSTB230Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfm_LOSTB230Q.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_id_cd.Enabled := True;
  cmb_sp_cd.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;


procedure Tfm_LOSTB230Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 14;
    	RowHeights[0] := 21;

    	ColWidths[0] := 45;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='반송일자';

    	ColWidths[2] := 110;
		Cells[2,0] :='주민사업자번호';

    	ColWidths[3] := 150;
		Cells[3,0] :='성명(업체명)';

    	ColWidths[4] := 110;
		Cells[4,0] :='전화번호';

    	ColWidths[5] := 60;
		Cells[5,0] :='우편번호';

    	ColWidths[6] := 350;
		Cells[6,0] :='주소';

    	ColWidths[7] := 60;
		Cells[7,0] :='상품명';

    	ColWidths[8] := -1;
		Cells[8,0] :='모델코드';

    	ColWidths[9] := 75;
		Cells[9,0] :='모델명';

    	ColWidths[10] := 120;
		Cells[10,0] :='단말기일련번호';

      ColWidths[11] := 120;
		Cells[11,0] :='반송사유';

      ColWidths[12] := 120;
		Cells[12,0] :='입고일자';

      ColWidths[13] := -1;
		Cells[13,0] :='반송일자';

    end;
end;

procedure Tfm_LOSTB230Q.setEdtKeyPress;
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

procedure Tfm_LOSTB230Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfm_LOSTB230Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfm_LOSTB230Q.FormCreate(Sender: TObject);
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
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', '불명단말기',cmb_id_cd);
  initComboBoxWithZ0xx('Z035.dat', cmb_sp_cd_d, '전체', '',cmb_sp_cd);


  initStrGrid;	//그리드 초기화

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.


    //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTB230Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;


//OnChange ---콤보박스
procedure Tfm_LOSTB230Q.cmb_id_cdChange(Sender: TObject);
begin
	if cmb_id_cd.ItemIndex =0 then begin
    	KT_pnl.Visible:= True;
        LGU_pnl.Visible:= True;
        SKT_pnl.Visible := True;
        blpcs_pnl.Visible := True;
        blcell_pnl.Visible := True;
    end

	else begin
    	KT_pnl.Visible:= false;
        LGU_pnl.Visible:= false;
        SKT_pnl.Visible := false;
        blpcs_pnl.Visible := false;
        blcell_pnl.Visible := false;
    end;
end;

procedure Tfm_LOSTB230Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB230Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;






procedure Tfm_LOSTB230Q.Copy1Click(Sender: TObject);
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

procedure Tfm_LOSTB230Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfm_LOSTB230Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      0..2: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4..5: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      8 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      9 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      10 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      11 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      13 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      14..15 :StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
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
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfm_LOSTB230Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfm_LOSTB230Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin

  cmb_id_cdChange(Sender);
  dte_from.Date := date-30;
	dte_to.Date := date;
  changeBtn(Self);
  cmb_id_cd.ItemIndex := 0;
  cmb_sp_cd.ItemIndex := 0;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  KT_pnl.Caption := 'KT '+ '0';
  LGU_pnl.Caption := 'LGU '+ '0';
  SKT_pnl.Caption := 'SKT '+ '0';
  blpcs_pnl.Caption := 'PCS불명 '+ '0';
  blcell_pnl.Caption := 'CELL불명 '+ '0';

  sts_Message.Panels[1].Text := ' ';

  dte_from.SetFocus;
end;

procedure Tfm_LOSTB230Q.btn_InquiryClick(Sender: TObject);
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
  STR008 : String;
  STR009 : String;
  STR010 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

    pInitStrGrd(Self);

	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';
    STR010 :=' ';

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
	if (TMAX.SendString('INF003','LostB230Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTB230Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

    KT_pnl.Caption := 'KT '+ TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU+ '+ TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '+ TMAX.RecvString('INT104',0);
    blpcs_pnl.Caption := '불명PCS ' + TMAX.RecvString('INT105',0);
    blcell_pnl.Caption := '불명CELL ' + TMAX.RecvString('INT106',0);

//	Goto LIQUIDATION;

//내역조회
INQUIRY:
{
입력;
STR001 : 전달일자 FROM
STR002 : 전달일자 TO
STR003 : 사업자구분
STR004 : 상품명
STR005 : 조회시작전달 일자
STR006 : 조회시작 주민번호
STR007 : 조회시작 모델코드
STR008 : 조회시작 일련번호
}
	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostB230Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR004', cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(STR005)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', delHyphen(STR009)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', STR010) < 0) then  goto LIQUIDATION;


  //서비스 호출
  if not TMAX.Call('LOSTB230Q') then
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

STR101 : 반송일자
STR102 : 습득자 주민번호
STR103 : 습득자 성명 (업체명)
STR104 : 습득자 전화번호
STR105 : 습득자 우편번호
STR106 : 습득자 기본주소
STR107 : 습득자 상세주소
STR108 : 사은품물품구분코드
STR109 : 사은품 명
STR110 : 모델코드명
STR111 : 단말기일련번호
STR112 : 반송사유
STR113 : 입고일자
STR114 : 사은품 발송일자


INT100 : COUNT...약속값 ....읽기
INF013 : 실제 카운트 값 ...읽기

}
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    goto LIQUIDATION;
  end;



    with grd_display do begin
    	for i:=0 to count1-1 do begin

         seed_idno       := TMAX.RecvString('STR102',i);

         STR005 := delHyphen(Trim(TMAX.RecvString('STR101',i))); // 조회시작반송일자
         STR006 := delHyphen(Trim(ECPlazaSeed.Decrypt(seed_idno, common_seedkey))); // 조회시작주민번호
         STR007 := Trim(TMAX.RecvString('STR110',i));            // 조회시작모델코드
         STR008 := TMAX.RecvString('STR112',i);                  // 조회시작일련번호
         STR009 := delHyphen(TMAX.RecvString('STR114',i));       // 조회시작입고일자
         STR010 := TMAX.RecvString('STR116',i);                  // 조회시작사업자코드

         Cells[0,RowPos]  := intToStr(seq);
         Cells[1,RowPos]  := InsHyphen(TMAX.RecvString('STR101',i)); //  반송일자
         Cells[2,RowPos]  := InsHyphen(ECPlazaSeed.Decrypt(seed_idno, common_seedkey)); //  주민사업자번호
         seed_name        := TMAX.RecvString('STR103',i);            //  성명(업체명)
         Cells[3,RowPos]  := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
         seed_tlno        := TMAX.RecvString('STR104',i);            //  전화번호
         Cells[4,RowPos]  := InsHyphen(ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
         Cells[5,RowPos]  := TMAX.RecvString('STR105',i);            //  우편번호
         Cells[6,RowPos]  := TMAX.RecvString('STR106',i);            //  주소
         Cells[7,RowPos]  := TMAX.RecvString('STR108',i);            //  상품명
         Cells[8,RowPos]  := Trim(TMAX.RecvString('STR110',i));      //  모델코드
         Cells[9,RowPos] := Trim(TMAX.RecvString('STR109',i));      //  모델명
         Cells[10,RowPos] := TMAX.RecvString('STR112',i);            //  단말기일련번호
         Cells[11,RowPos] := TMAX.RecvString('STR113',i);            //  반송사유
         Cells[12,RowPos] := InsHyphen(TMAX.RecvString('STR114',i)); //  입고일자
         Cells[13,RowPos] := InsHyphen(TMAX.RecvString('STR115',i)); //  반송일자

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

procedure Tfm_LOSTB230Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('조회관리(LOSTB230Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB220Q');
end;

end.
