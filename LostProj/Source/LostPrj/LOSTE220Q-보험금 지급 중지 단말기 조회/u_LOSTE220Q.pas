
unit u_LOSTE220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,printers, ComObj;

const
  TITLE   = '보험금 지급 중지 단말기 조회';
  PGM_ID  = 'LOSTE220Q';

type
  Tfrm_LOSTE220Q = class(TForm)
    Bevel1     : TBevel;
    Bevel2     : TBevel;
    dte_to     : TDateEdit;
    dte_from   : TDateEdit;
    Label1     : TLabel;
    pnl_Program_Name: TLabel;
    Label2     : TLabel;
    Copy1      : TMenuItem;
    pnl_Command: TPanel;
    Panel2     : TPanel;
    PopupMenu1 : TPopupMenu;
    SkinData1  : TSkinData;
    btn_Add    : TSpeedButton;
    btn_Update : TSpeedButton;
    btn_Delete : TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link   : TSpeedButton;
    btn_excel  : TSpeedButton;
    btn_Print  : TSpeedButton;
    btn_query  : TSpeedButton;
    btn_Close  : TSpeedButton;
    btn_reset  : TSpeedButton;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;
    Bevel3: TBevel;
    lbl1: TLabel;
    Bevel4: TBevel;
    Label3: TLabel;
    edt_nm: TEdit;
    bvl1: TBevel;
    lbl2: TLabel;
    mskEdt_cell_num: TMaskEdit;
    cmb_gbn_dt: TComboBox;
    cmb_insu_cmp: TComboBox;
    Label4: TLabel;
    Bevel5: TBevel;
    cmb_gbnSel: TComboBox;
    chk_out_yn: TCheckBox;
    Bevel16: TBevel;
    Label15: TLabel;
    md_cb1: TComboEdit;
    Label18: TLabel;
    Bevel18: TBevel;
    serial_edit: TEdit;
    md_grid1: TStringGrid;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure btn_LinkClick(Sender: TObject);
    procedure grd_displayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure md_grid1Click(Sender: TObject);

  private
    { Private declarations }
     qryStr:String;
    //그리드 초기화
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;

    procedure InitComponent;

  public
    { Public declarations }
  end;

var
  frm_LOSTE220Q : Tfrm_LOSTE220Q;
  cmb_insu_cmp_d : TZ0xxArray;
  md_grid1_d     :TZ0xxArray;


implementation
{$R *.DFM}

procedure Tfrm_LOSTE220Q.disableComponents;
begin
	  dte_from.Enabled    := false;
    dte_to.Enabled      := false;
    btn_query.Enabled   := False;
    btn_excel.Enabled   := False;
    btn_close.Enabled   := False;
    btn_Print.Enabled   := False;
    btn_Inquiry.Enabled := False;
end;

procedure Tfrm_LOSTE220Q.enableComponents;
begin
  	dte_from.Enabled     := True;
    dte_to.Enabled       := True;
    btn_query.Enabled    := True;
    btn_excel.Enabled    := True;
    btn_close.Enabled    := True;
    btn_Print.Enabled    := False;
    btn_Inquiry.Enabled  := True;
end;

procedure Tfrm_LOSTE220Q.Link_rtn (var Msg : TMessage);
begin
    //'조회' 버튼 클릭

    ShowWindow(Self.Handle , SW_SHOW);
    btn_InquiryClick(self);
end;

procedure Tfrm_LOSTE220Q.initStrGrid;
begin
	with grd_display do
  begin
    RowCount      :=  2;
    ColCount      := 24;
    RowHeights[0] := 21;

    ColWidths[ 0] := 40;   // SEQ
    ColWidths[ 1] := 120;  // 입고상태
    ColWidths[ 2] := 110;  // 단말기처리상태
    ColWidths[ 3] := 80;   // 보험사
    ColWidths[ 4] := 80;   // 이통사
    ColWidths[ 5] := 100;  // 모델명
    ColWidths[ 6] := 140;  // 일련번호
    ColWidths[ 7] := 140;  // 통신가입자
    ColWidths[ 8] := 105;  // 보험가입자
    ColWidths[ 9] := 110;  // 가입자생년월일
    ColWidths[10] := 110;  // 이동전화번호
    ColWidths[11] := 110;  // 가입자연락처
    ColWidths[12] := 110;  // 보험금신청일자
    ColWidths[13] := 115;  // 지급중지일자
    ColWidths[14] := 115;  // 승인일자
    ColWidths[15] := 150;  // 보험금지급액
    ColWidths[16] := 110;  // 입출고구분
    ColWidths[17] := 110;  // 입고일자
    ColWidths[18] := 115;  // 출고일자
    ColWidths[19] := 110;  // 접수우체국
    ColWidths[20] := 110;  // 출고처리구분
    ColWidths[21] := -1;   // 우체국코드
    ColWidths[22] := -1;   // 접수일련번호
    ColWidths[23] := 100;   // 경찰서습득단말기여부

    Cells[ 0,0]    := 'SEQ';
    Cells[ 1,0]    := '입고상태';
    Cells[ 2,0]    := '단말기처리상태';
    Cells[ 3,0]    := '보험사';
    Cells[ 4,0]    := '이통사';
    Cells[ 5,0]    := '모델명';
    Cells[ 6,0]    := '일련번호';
    Cells[ 7,0]    := '통신가입자';
    Cells[ 8,0]    := '보험가입자';
    Cells[ 9,0]    := '가입자생년월일';
    Cells[10,0]    := '이동전화번호';
    Cells[11,0]    := '가입자연락처';
    Cells[12,0]    := '보험금신청일자';
    Cells[13,0]    := '지급중지일자';
    Cells[14,0]    := '승인일자';
    Cells[15,0]    := '보험금지급액';
    Cells[16,0]    := '입출고구분';
    Cells[17,0]    := '입고일자';
    Cells[18,0]    := '출고일자';
    Cells[19,0]    := '접수우체국';
    Cells[20,0]    := '출고처리구분';
    Cells[21,0]    := '우체국코드';
    Cells[22,0]    := '접수일련번호';
    Cells[23,0]    := '경찰서접수';

  end;
end;

procedure Tfrm_LOSTE220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTE220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE220Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTE220Q.FormCreate(Sender: TObject);
begin
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

    if ParamCount <> 6 then //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    begin
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

    btn_resetClick(Sender);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

    initSkinForm(SkinData1); //common_lib.pas에 있다.

    initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1  );
    initComboBoxWithZ0xx('Z085.dat',cmb_insu_cmp_d,'전체','',cmb_insu_cmp);

    initStrGrid;	//그리드 초기화

    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  end;
end;

procedure Tfrm_LOSTE220Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_kait_ganm : String;

    i:Integer;
    RowPos:Integer;

    count1, totalCount:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_ganm := '';
    seed_gano := '';
    seed_gatl := '';
    seed_mtno := '';
    seed_kait_ganm := '';

  RowPos                := 1;	//그리드 레코드 포지션
  grd_display.RowCount  := 2;

  pInitStrGrd(grd_display);

  totalCount  :=  0;
  qryStr      := '';
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
	if (TMAX.SendString('INF002',common_userid                      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTE220Q'                        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'S01'                             ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_insu_cmp_d[cmb_insu_cmp.itemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', IntToStr(cmb_gbn_dt.itemIndex)    ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', Trim(edt_nm.Text)                 ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', Trim(delHyphen(mskEdt_cell_num.Text))  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', IntToStr(cmb_gbnSel.itemIndex)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', IntToStr(StrToInt(BoolToStr(chk_out_yn.checked))*-1)) < 0) then  goto LIQUIDATION;

  if (Length(Trim(md_cb1.Text)) <> 0 ) then
  begin
	  if (TMAX.SendString('STR009', md_grid1_d[md_grid1.Row].code    ) < 0) then  goto LIQUIDATION
  end
  else
  begin
    if (TMAX.SendString('STR009', '    '                           ) < 0) then  goto LIQUIDATION;
  end;

	if (TMAX.SendString('STR010', Trim(serial_edit.Text)             ) < 0) then  goto LIQUIDATION;

   //서비스 호출
   if not TMAX.Call('LOSTE220Q') then
   begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

     goto LIQUIDATION;
   end;

  count1                := TMAX.RecvInteger('INF013',0);
  totalCount            := totalCount + count1;
  grd_display.RowCount  := grd_display.RowCount + count1;

  with grd_display do
  begin
    for i:=0 to count1-1 do
    begin
    {* SEQ            *} Cells[0  ,RowPos]   := IntToStr(i+1);
    {* 입고상태       *} Cells[1  ,RowPos]   := TMAX.RecvString('STR116',i);
    {* 단말기처리상태 *} Cells[2  ,RowPos]   := TMAX.RecvString('STR119',i);
    {* 보험사         *} Cells[3  ,RowPos]   := TMAX.RecvString('STR101',i);
    {* 이통사         *} Cells[4  ,RowPos]   := TMAX.RecvString('STR102',i);
    {* 모델명         *} Cells[5  ,RowPos]   := TMAX.RecvString('STR103',i);
    {* 일련번호       *} Cells[6  ,RowPos]   := TMAX.RecvString('STR104',i);
    {* 통신가입자     *} seed_kait_ganm      := TMAX.RecvString('STR106',i);
                         Cells[7  ,RowPos]   := ECPlazaSeed.Decrypt(seed_kait_ganm, common_seedkey);
    {* 보험가입자     *} seed_ganm           := TMAX.RecvString('STR122',i);
    {* 보험가입자     *} Cells[8  ,RowPos]   := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
    {* 가입자생년월일 *} seed_gano           := TMAX.RecvString('STR107',i);
                         Cells[9  ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gano, common_seedkey),'2-2-2');
    {* 이동전화번호   *} seed_mtno           := TMAX.RecvString('STR105',i);
                         Cells[10 ,RowPos]   := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
    {* 가입자연락처   *} seed_gatl           := TMAX.RecvString('STR108',i);
                         Cells[11 ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
    {* 보험금신청일자 *} Cells[12 ,RowPos]   := InsHyphen(TMAX.RecvString('STR109',i));
    {* 지급중지일자   *} Cells[13 ,RowPos]   := InsHyphen(TMAX.RecvString('STR110',i));
    {* 승인일자       *} Cells[14 ,RowPos]   := InsHyphen(TMAX.RecvString('STR111',i));
    {* 보험금지급액   *} Cells[15 ,RowPos]   := convertWithCommer(IntToStr(Round(TMAX.RecvDouble('DBL112',i))));
    {* 입출고구분     *} Cells[16 ,RowPos]   := TMAX.RecvString('STR113',i);
    {* 입고일자       *} Cells[17 ,RowPos]   := InsHyphen(TMAX.RecvString('STR114',i));
    {* 출고일자       *} Cells[18 ,RowPos]   := InsHyphen(TMAX.RecvString('STR115',i));
    {* 접수우체국     *} Cells[19 ,RowPos]   := TMAX.RecvString('STR117',i);
    {* 출고처리구분   *} Cells[20 ,RowPos]   := TMAX.RecvString('STR118',i);
    {* 우체국코드     *} Cells[21 ,RowPos]   := TMAX.RecvString('STR120',i);
    {* 접수일련번호   *} Cells[22 ,RowPos]   := TMAX.RecvString('STR121',i);
    {* 경찰서습득     *} Cells[23 ,RowPos]   := TMAX.RecvString('STR123',i);

      Inc(RowPos);
    end;
  end;

  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  qryStr:= TMAX.RecvString('INF014',0);

//빠져나오는곳
LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor   := crDefault;	//작업완료

  if totalCount >= 1 then
    grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTE220Q.FormShow(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE220Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f:TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + '_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTE220Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTE220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTE220Q.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display.Selection;

  with select do
  begin
    str:='';

    if (Left = Right) and (Top = Bottom) then
        str := grd_display.Cells[Left,Top]
    else
    begin
      for j:= Top to Bottom do
      begin
        for i:= Left to Right do
            str := str + grd_display.Cells[i,j] + '|';

        str:= str +#13#10;
      end;
    end;
  end;

  Clipboard.AsText := str;
end;



procedure Tfrm_LOSTE220Q.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;

  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];

  if (ARow =0) then
  begin
    grid.Canvas.Brush.Color := clBtnFace;
    grid.Canvas.Font.Color := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
  // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
  begin
    case ACol of
      3,4,5,6,7,8,10,16: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,1,2,9,12,13,14,17,18,19,20,21,22: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      15 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

    end;
  end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTE220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTE220Q.btn_resetClick(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE220Q.InitComponent;
var i : Integer;
begin
  dte_from.Date := date-30;
	dte_to.Date   := date;

  changeBtn(Self);
  btn_Link.Enabled := True;

  btn_Print.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';

  md_cb1.Text := '';

//  md_grid1.Row    := 0;
//  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

  //dte_from.SetFocus;
end;

procedure Tfrm_LOSTE220Q.grd_displayDblClick(Sender: TObject);
var
  Value       : array of string;
  commandStr  : String;
  progID      : String;
	ret         : Integer;
begin
  if (grd_display.Row < 0) then exit;

  if (Trim(grd_display.Cells[0,grd_display.Row]) = '') then Exit
  else
  begin
    if ( Trim(grd_display.Cells[1,grd_display.Row]) = '협회입고') then
    begin
      progID := 'LOSTA110P';

      SetLength(Value, 5 );

      Value[0] := grd_display.Cells[ 8,grd_display.Row]; // 성명
      Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]); // 생년월일
      Value[2] := grd_display.Cells[ 5,grd_display.Row]; // 모델명
      Value[3] := grd_display.Cells[ 6,grd_display.Row]; // 시리얼번호
      Value[4] := grd_display.Cells[17,grd_display.Row]; // 입고일자

      (****************************************************************************)
      (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
                    (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
          ;
    end
    else if ( Trim(grd_display.Cells[1,grd_display.Row]) = '협회입고(경찰)') then
    begin
      progID := 'LOSTA710P';

      SetLength(Value, 5 );

      Value[0] := grd_display.Cells[ 8,grd_display.Row]; // 성명
      Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]); // 생년월일
      Value[2] := grd_display.Cells[ 5,grd_display.Row]; // 모델명
      Value[3] := grd_display.Cells[ 6,grd_display.Row]; // 시리얼번호
      Value[4] := grd_display.Cells[17,grd_display.Row]; // 입고일자

      (****************************************************************************)
      (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
                    (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
          ;
    end
    else if ( Trim(grd_display.Cells[1,grd_display.Row]) = '우체국접수') then
    begin
      progID := 'LOSTC100P';
      SetLength(Value, 9 );

      (* 성명         *) Value[0] := grd_display.Cells[ 8,grd_display.Row];
      (* 생년월일     *) Value[1] := delHyphen(grd_display.Cells[ 9,grd_display.Row]);
      (* 모델명       *) Value[2] := grd_display.Cells[ 5,grd_display.Row];
      (* 시리얼번호   *) Value[3] := grd_display.Cells[ 6,grd_display.Row];
      (* 입고일자     *) if (Trim(DelHyphen(grd_display.Cells[17,grd_display.Row])) = '') then Value[4] := '-'
                         else Value[4] := Trim(DelHyphen(grd_display.Cells[17,grd_display.Row]));
      (* 우체국코드   *) Value[5] := grd_display.Cells[21,grd_display.Row];
      (* 등록일자     *) if (Trim(DelHyphen(grd_display.Cells[17,grd_display.Row])) = '') then Value[6] := '-'
                         else Value[6] := Trim(DelHyphen(grd_display.Cells[17,grd_display.Row]));
      (* 접수일련번호 *) Value[7] := grd_display.Cells[22,grd_display.Row];
      (* 주민등록번호 *) Value[8] := delHyphen(grd_display.Cells[10,grd_display.Row]);


      (****************************************************************************)
      (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
      (****************************************************************************)
      commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
                    (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
                    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                    (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                    (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                    (* paramstr(5)                     *)+ ' ' +  common_usergroup
                    (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0] )
                    (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1] )
                    (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2] )
                    (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3] )
                    (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4] )
                    (* paramstr(11) -                  *)+ ' ' +  fNVL(Value[5] )
                    (* paramstr(12) -                  *)+ ' ' +  fNVL(Value[6] )
                    (* paramstr(13) -                  *)+ ' ' +  fNVL(Value[7] )
                    (* paramstr(14) -                  *)+ ' ' +  fNVL(Value[8] )
      ;
    end;
  end;

  ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

  if ret <= 31 then
  begin

    MessageBeep (0);

		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

    ShowWindow(Self.Handle, SW_SHOW);
  end;
  
end;

procedure Tfrm_LOSTE220Q.btn_LinkClick(Sender: TObject);
begin
  grd_displayDblClick(Sender);
end;

procedure Tfrm_LOSTE220Q.grd_displayMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  lnRow, lnCel: Integer;
  GR : TGridRect;
begin
  GR.Left   := -1;
  GR.Top    := -1;
  GR.Right  := -1;
  GR.Bottom := -1;

  grd_display.MouseToCell( x, y, lnRow, lnCel );

  if ( lnRow = -1) then
      grd_display.Selection := GR;


end;

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTE220Q.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick  := nil;
   md_cb1.OnKeyUp        := nil;
   md_grid1.OnClick      := nil;

   if not md_Grid1.Visible then md_Grid1.Visible  := true
   else md_Grid1.Visible  := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 모델 콤보 KeyUp 이벤트
procedure Tfrm_LOSTE220Q.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   // 엔터 누를 시
   if key = 13 then
   begin
      if md_grid1.Visible then
         md_grid1.Visible := false
      else
         md_grid1.Visible := true;

      md_cb1.Text := '';
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else

   //방향키 위로 누를 시
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
         md_grid1.Row := md_grid1.Row - 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else

   // 방향키 아래로 누를 시
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
         md_grid1.Row := md_grid1.Row + 1;
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then
         md_grid1.Visible := true;
      for i := 0 to md_grid1.RowCount-1 do
      if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
      begin
         md_grid1.Row := i;
         break;
      end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 모델 그리드 클릭시
procedure Tfrm_LOSTE220Q.md_grid1Click(Sender: TObject);
begin
   md_cb1.text        := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible   := false;
end;

end.
