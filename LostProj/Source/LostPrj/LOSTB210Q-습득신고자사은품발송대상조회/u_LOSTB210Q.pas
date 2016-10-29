{*---------------------------------------------------------------------------
프로그램ID    : LOSTB210Q (습득신고자 사은품 발송 대상 조회)
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
unit u_LOSTB210Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg,
  common_lib, Menus, WinSkinData, so_tmax, Clipbrd,Func_Lib, ComObj;

const
  TITLE   = '습득신고자 사은품 발송 대상 조회';
  PGM_ID  = 'LOSTB210Q';

type
  Tfrm_LOSTB210Q = class(TForm)
    Bevel2     : TBevel;
    Bevel1     : TBevel;
    Bevel3     : TBevel;
    Bevel4     : TBevel;
    cmb_id_cd  : TComboBox;
    cmb_sp_cd  : TComboBox;
    dte_to     : TDateEdit;
    dte_from   : TDateEdit;
    Label3     : TLabel;
    Label1     : TLabel;
    lbl_Program_Name: TLabel;
    Label4     : TLabel;
    Label2     : TLabel;
    Copy1      : TMenuItem;
    pnl_Command: TPanel;
    KT_pnl     : TPanel;
    LGU_pnl    : TPanel;
    SKT_pnl    : TPanel;
    Panel2     : TPanel;
    pnl_cell   : TPanel;
    pnl_pcs    : TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    btn_Close  : TSpeedButton;
    btn_Add    : TSpeedButton;
    btn_Update : TSpeedButton;
    btn_Delete : TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link   : TSpeedButton;
    btn_Print  : TSpeedButton;
    btn_query  : TSpeedButton;
    btn_excel  : TSpeedButton;
    btn_reset  : TSpeedButton;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_queryClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure cmb_id_cdChange(Sender: TObject);


  private
    { Private declarations }
    qryStr:String;
    z001Data:Array of TZ001;

    cmb_id_cd_d:TZ0xxArray;
    cmb_sp_cd_d:TZ0xxArray;

    //실행중 콤포넌트 사용중지
    procedure disableComponents;

    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;

    procedure initStrGrid;
    //procedure cmb_id_cdChange;
    procedure InitComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTB210Q: Tfrm_LOSTB210Q;
  qryStr:String;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTB210Q.setEdtKeyPress;
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

procedure Tfrm_LOSTB210Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTB210Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB210Q.FormShow(Sender: TObject);
begin
  InitComponents;
	dte_from.SetFocus;
end;

procedure Tfrm_LOSTB210Q.FormCreate(Sender: TObject);
var arrIdCd , arrSpcd : TZ0xxArray;
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
	//common_userid   := '0294';    //ParamStr(2);
	//common_username := '정호영';  //ParamStr(3);
	//common_usergroup:= 'KAIT';    //ParamStr(4);

  //스킨 초기화
	initSkinForm(SkinData1);      // common_lib.pas에 있다.

  // 콤보 박스 초기화 : 사업자 구분

  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', '불명단말기', cmb_id_cd);
  initComboBoxWithZ0xx('Z035.dat', cmb_sp_cd_d, '전체', '', cmb_sp_cd);


  // 그리드 초기화
  initStrGrid;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

{*****************************************************************************
* 조회버튼 실행
******************************************************************************}
procedure Tfrm_LOSTB210Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_name, seed_idno, seed_tlno, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    STR005 : String;
    STR006 : String;
    STR007 : String;
    STR008 : String;

    Label LIQUIDATION;
    Label INQUIRY;
  begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

    //그리드 디스플레이 설정
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    pInitStrGrd(Self);
    //시작시변수 초기화

    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    totalCount :=0;

    // 디버그용 쿼리 변수 초기화
    qryStr:= '';

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

    // 조회 조건이 전체아닌 경우에는 쿼리를 진행하고 전체인 경우 통신사별 조회건
    // 계산을 위해 아래 내역을 조회
    if trim(copy(cmb_id_cd.Text,0,40)) <> '전체' then
    goto INQUIRY;

    //공통입력 부분
    // User Id 검증
    if (TMAX.SendString('INF002',common_userid) < 0)    then  goto LIQUIDATION;
    // User Name 검증
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    // User 그룹 검증
    if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
    // 서비스명 설정
    if (TMAX.SendString('INF003','LostB210Q') < 0)      then  goto LIQUIDATION;

    // 서비스 구분자 설정
    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    // 사용자 데이터 설정 시작
    if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

    // 사용자 데이터 설정 완료

    //서비스 호출
    if not TMAX.Call('LOSTB210Q') then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;

    //cmb_id_cdChange;

    KT_pnl.Caption  := 'KT '      + TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU+ '    + TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '     + TMAX.RecvString('INT104',0);
    pnl_pcs.Caption := '불명PCS ' + TMAX.RecvString('INT105',0);
    pnl_cell.Caption:= '불명CELL '+ TMAX.RecvString('INT106',0);

    // 쿼리를 담는다.
    qryStr:= TMAX.RecvString('INF014',0);

//	Goto LIQUIDATION;

//내역조회
INQUIRY:
	TMAX.InitBuffer;

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0)    then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB210Q') < 0)      then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0)        then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0)          then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTB210Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

    //grd_display

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

          STR005 := delHyphen(Trim(TMAX.RecvString('STR101',i)));
          STR006 := delHyphen(Trim(TMAX.RecvString('STR102',i)));
          STR007 :=           Trim(TMAX.RecvString('STR110',i));
          STR008 :=                TMAX.RecvString('STR111',i);

          Cells[0,RowPos] := intToStr(seq);
          Cells[1,RowPos] := InsHyphen(TMAX.RecvString('STR101',i));  // 입고일자
          seed_idno       :=           TMAX.RecvString('STR102',i);   // 습득자주민사업자번호
          Cells[2,RowPos] := InsHyphen(ECPlazaSeed.Decrypt(seed_idno, common_seedkey));
          seed_name       :=           TMAX.RecvString('STR103',i);   // 습득자성명업체명
          Cells[3,RowPos] :=           ECPlazaSeed.Decrypt(seed_name, common_seedkey);
          seed_tlno       :=           TMAX.RecvString('STR104',i);   // 습득자전화번호
          Cells[4,RowPos] := InsHyphen(ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
          Cells[5,RowPos] :=           TMAX.RecvString('STR107',i);   // 우편번호
          Cells[6,RowPos] :=           TMAX.RecvString('STR105',i)
                               + ' ' + TMAX.RecvString('STR106',i);
          Cells[7,RowPos] :=           TMAX.RecvString('STR108',i);   // 사은품물품구분코드|Z049
          Cells[8,RowPos] :=           TMAX.RecvString('STR109',i);   // 사은품상품코드|Z035
          Cells[9,RowPos] :=           TMAX.RecvString('STR110',i);   // 모델코드|Z008
          Cells[10,RowPos]:=           TMAX.RecvString('STR111',i);   // 단말기일련번호

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

procedure Tfrm_LOSTB210Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//   Capiend;
end;

{*******************************************************************************
* procedure Name : dte_fromExit
* 기 능 설 명 : 날짜입력 후 입력된 날짜들의 유효성을 검증하고 메세지를 출력함.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.dte_fromExit(Sender: TObject);
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
procedure Tfrm_LOSTB210Q.dte_toExit(Sender: TObject);
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
procedure Tfrm_LOSTB210Q.disableComponents;
begin
  dte_from.Enabled := false;
  dte_to.Enabled := false;
  cmb_id_cd.Enabled:= false;
  btn_Inquiry.Enabled := False;
  btn_query.Enabled:= False;
  btn_close.Enabled:= False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* 기 능 설 명 :버튼을 눌러 다른 기능을 할 수 있게한다.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.enableComponents;
begin
  dte_from.Enabled  := True;
  dte_to.Enabled    := True;
  cmb_id_cd.Enabled := True;
  btn_Inquiry.Enabled := True;
  btn_query.Enabled:= True;
  btn_close.Enabled:= True;
end;

{*******************************************************************************
* procedure Name : initStrGrid
* 기 능 설 명 : 그리드를 초기화 하고 필드 타이틀 설정을 한다.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.initStrGrid;

begin
	with grd_display do begin
      RowCount :=2;
      ColCount := 11;
      RowHeights[0] := 21;

      ColWidths[0] := 30;
      ColWidths[1] := 80;
      ColWidths[2] := 165;
      ColWidths[3] := 160;
      ColWidths[4] := 105;
      ColWidths[5] := 70;
      ColWidths[6] := 330;
      ColWidths[7] := 110;
      ColWidths[8] := 65;
      ColWidths[9] := 65;
      ColWidths[10] := 130;

      Cells[0,0] := 'SEQ';
      Cells[1,0] := '입고일자';
      Cells[2,0] := '주민/외국인/사업자번호';
      Cells[3,0] := '성명(업체명)';
      Cells[4,0] := '연락전화번호';
      Cells[5,0] := '우편번호';
      Cells[6,0] := '주소';
      Cells[7,0] := '사은품물품구분';
      Cells[8,0] := '상품명';
      Cells[9,0] := '모델코드';
      Cells[10,0]:= 'Serial';
    end;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* 기 능 설 명 : 그리드 타이틀 부분에 대한 데코레이션 효과를 준다.
*
*******************************************************************************}
procedure Tfrm_LOSTB210Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    begin
    case ACol of
      0,1,2,4,5,7..10 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      3,6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
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
procedure Tfrm_LOSTB210Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

{*******************************************************************************
* procedure Name : Copy1Click
* 기 능 설 명 : 그리드에 선택된 내역을 클릭보드에 복사하는 역할을한다.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.Copy1Click(Sender: TObject);
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

{*******************************************************************************
* procedure Name : cmb_id_cdChange
* 기 능 설 명 : 전체 조회 시 통신사 별 조회 건 수를 패널을 활성화 시켜보여줌
*******************************************************************************}

{
procedure Tfrm_LOSTB210Q.cmb_id_cdChange;
begin
	if cmb_id_cd.ItemIndex =0 then begin
    	KT_pnl.Visible:= True;
      LGU_pnl.Visible:= True;
      SKT_pnl.Visible := True;
		  pnl_cell.Visible := True;
		  pnl_cell.Visible := True;
    end

	else begin
    	KT_pnl.Visible:= false;
        LGU_pnl.Visible:= false;
        SKT_pnl.Visible := false;
		pnl_pcs.Visible := false;
		pnl_cell.Visible := false;
    end;
end;

}

{*******************************************************************************
* procedure Name : btn_queryClick
* 기 능 설 명 : 조회 후 조회 쿼리를 변수에 담아 노트패드로 보여주는 역할을 한다.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f         :TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + 'QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTB210Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB210Q.btn_resetClick(Sender: TObject);
begin
  self.InitComponents
end;

procedure Tfrm_LOSTB210Q.InitComponents;
var i : Integer;
begin
  // 날짜 필드 셋팅
	dte_from.Date := date-30;
	dte_to.Date   := date;
  cmb_id_cd.ItemIndex := 0;
  cmb_sp_cd.ItemIndex := 0;

  // 쿼리 데이터 초기화
	qryStr := '';

  // 버튼 초기화
  changeBtn(Self);

  for i := grd_display.FixedRows to grd_display.RowCount -1 do
    grd_display.Rows[i].Clear;

  // 스트링 그리드 초기화
  initStrGrid;

  KT_pnl.Caption    := 'KT 0';
  LGU_pnl.Caption   := 'LGU+ 0';
  SKT_pnl.Caption   := 'SKT 0';
  pnl_pcs.Caption   := '불명PCS';
  pnl_cell.Caption  := '불명CELL';

  sts_Message.Panels[1].Text := ' ';

  

end;

procedure Tfrm_LOSTB210Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTB210Q.cmb_id_cdChange(Sender: TObject);
begin
	if cmb_id_cd.ItemIndex =0 then begin
    	KT_pnl.Visible:= True;
      LGU_pnl.Visible:= True;
      SKT_pnl.Visible := True;
		  pnl_pcs.Visible := True;
		  pnl_cell.Visible := True;
    end

	else begin
    	KT_pnl.Visible:= false;
      LGU_pnl.Visible:= false;
      SKT_pnl.Visible := false;
		  pnl_pcs.Visible := false;
		  pnl_cell.Visible := false;
    end;
end;

end.
