unit u_LOSTA220Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
   TITLE   = '분실폰 반송 내역 조회';
   PGM_ID  = 'LOSTA220Q';

type
  Tfrm_LOSTA220Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_id_cd: TComboBox;
    grd_display: TStringGrid;
    KT_pnl: TPanel;
    LGU_pnl: TPanel;
    SKT_pnl: TPanel;
    PCS_pnl: TPanel;
    CELL_pnl: TPanel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
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
    procedure dte_toExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmb_id_cdChange(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);

    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Copy1Click(Sender: TObject);
    procedure dte_fromKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dte_toKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
  private
    { Private declarations }
  cmb_id_cd_d: TZ0xxArray;

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
  frm_LOSTA220Q: Tfrm_LOSTA220Q;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA220Q.disableComponents;
begin
  dte_from.Enabled := false;
  dte_to.Enabled := false;
  cmb_id_cd.Enabled:= false;
  btn_Inquiry.Enabled := False;
  btn_excel.Enabled:= False;
  btn_close.Enabled:= False;
end;

procedure Tfrm_LOSTA220Q.enableComponents;
begin
  dte_from.Enabled := True;;
  dte_to.Enabled := True;;
  cmb_id_cd.Enabled:= True;;
  btn_Inquiry.Enabled := True;;
  btn_excel.Enabled:= True;;
  btn_close.Enabled:= True;;
end;

procedure Tfrm_LOSTA220Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2; 
        ColCount := 19;
    	RowHeights[0] := 21;                

    	ColWidths[0] := 45;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 110;
		Cells[1,0] :='반송일자';
                                            
    	ColWidths[2] := 110;                
		Cells[2,0] :='출고일자';            
                                            
    	ColWidths[3] := 120;
		Cells[3,0] :='가입자주민번호';
                                            
    	ColWidths[4] := 200;
		Cells[4,0] :='가입자성명';          
                                            
    	ColWidths[5] := 130;
		Cells[5,0] :='가입자연락처';        
                                            
    	ColWidths[6] := 60;                      
		Cells[6,0] :='우편번호';                 
                                                 
    	ColWidths[7] := 400;
		Cells[7,0] :='주소';

    	ColWidths[8] := 110;
		Cells[8,0] :='입고일자';

    	ColWidths[9] := 110;
		Cells[9,0] :='수취확인일자';

    	ColWidths[10] := -1;
		Cells[10,0] :='모델코드';

    	ColWidths[11] := 120;
		Cells[11,0] :='모델명';

      ColWidths[12] := 100;
		Cells[12,0] :='단말기일련번호';

      ColWidths[13] := -1;
		Cells[13,0] :='반송사유코드';

      ColWidths[14] := 100;
		Cells[14,0] :='반송사유';

      ColWidths[15] := 100;
		Cells[15,0] :='반송번호';

      ColWidths[16] := 100;
		Cells[16,0] :='재출고일자';

      ColWidths[17] := -1;
		Cells[17,0] :='처리구분코드';

      ColWidths[18] := 100;
		Cells[18,0] :='처리구분명';

    end;
end;

procedure Tfrm_LOSTA220Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA220Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
 begin
   if (key = #13) then
     SelectNext( ActiveControl as TEdit , true, True);
 end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA220Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA220Q.FormCreate(Sender: TObject);
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

    //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  {
  //테스트 후에는 이 부분을 삭제할 것.
  common_userid:= '0294'; //ParamStr(2);
  common_username:= '정호영';
  ParamStr(3);
  common_usergroup:= 'SYSM'; //ParamStr(4);
  }

  btn_resetClick(Sender);

  frm_LOSTA220Q.Position := poScreenCenter;

	initSkinForm(SkinData1); //common_lib.pas에 있다.
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', '불명단말기',cmb_id_cd);

  initStrGrid;	//그리드 초기화

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA220Q.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;
  seq,RowPos:Integer;
  STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;

  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_name, seed_idno, seed_tlno:String;

  Label LIQUIDATION;
  Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

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
    STR008 :=' ';
    STR009 :=' ';

    seed_name := '';
    seed_idno := '';
    seed_tlno := '';

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
	if (TMAX.SendString('INF003','LostA220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTA220Q') then goto LIQUIDATION;

    KT_pnl.Caption := 'KT '+ TMAX.RecvString('INT102',0);
    LGU_pnl.Caption := 'LGU+ '+ TMAX.RecvString('INT103',0);
    SKT_pnl.Caption := 'SKT '+ TMAX.RecvString('INT104',0);
    PCS_pnl.Caption := '불명PCS '+ TMAX.RecvString('INT105',0);
    CELL_pnl.Caption := '불명CELL '+ TMAX.RecvString('INT106',0);

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
	if (TMAX.SendString('INF003','LostA220Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d [cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR004', delHyphen(STR004)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(STR005)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTA220Q') then
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

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := intToStr(seq);

          STR004 := delHyphen(Trim(TMAX.RecvString('STR101',i)));
          STR005 := delHyphen(Trim(TMAX.RecvString('STR102',i)));
          STR006 := delHyphen(Trim(TMAX.RecvString('STR103',i)));
          STR007 := Trim(TMAX.RecvString('STR110',i));
          STR008 := TMAX.RecvString('STR111',i);
          STR009 := delHyphen(Trim(TMAX.RecvString('STR108',i)));

        	Cells[1,RowPos] := TMAX.RecvString('STR101',i);
        	Cells[2,RowPos] := TMAX.RecvString('STR102',i);
        //Cells[3,RowPos] := InsHyphen(TMAX.RecvString('STR103',i));
          seed_idno       := InsHyphen(TMAX.RecvString('STR103',i));    // 가입자주민번호
          Cells[3,RowPos] := InsHyphen(ECPlazaSeed.Decrypt(seed_idno, common_seedkey));
        //Cells[4,RowPos] := TMAX.RecvString('STR104',i);
          seed_name       := TMAX.RecvString('STR104',i);     // 가입자성명
          Cells[4,RowPos] := ECPlazaSeed.Decrypt(seed_name, common_seedkey);
        //Cells[5,RowPos] := TMAX.RecvString('STR105',i);
          seed_tlno       := TMAX.RecvString('STR105',i);		  // 가입자연락처
          Cells[5,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        	Cells[6,RowPos] := TMAX.RecvString('STR106',i);
        	Cells[7,RowPos] := TMAX.RecvString('STR107',i);
        	Cells[8,RowPos] := TMAX.RecvString('STR108',i);
          Cells[9,RowPos] := TMAX.RecvString('STR109',i);
        	Cells[10,RowPos] := STR007;
        	Cells[11,RowPos] := STR008;
          Cells[12,RowPos] := TMAX.RecvString('STR112',i);
          Cells[13,RowPos] := TMAX.RecvString('STR113',i);
          Cells[14,RowPos] := TMAX.RecvString('STR114',i);
          Cells[15,RowPos] := TMAX.RecvString('STR115',i);
          Cells[16,RowPos] := TMAX.RecvString('STR116',i);
          Cells[17,RowPos] := TMAX.RecvString('STR117',i);
          Cells[18,RowPos] := TMAX.RecvString('STR118',i);

{
STR005 : 조회시작전달 일자 <- STR101
STR006 : 조회시작 주민번호 <- STR102
STR007 : 조회시작 모델코드 <- STR109
STR008 : 조회시작 일련번호 <- STR111
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

procedure Tfrm_LOSTA220Q.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA220Q.FormShow(Sender: TObject);
begin
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Link.Enabled := False;
  btn_Print.Enabled := False;
  dte_from.SetFocus;

  if common_usergroup = 'SYSM' then begin
    btn_query.Enabled := True;
  end else begin btn_query.Enabled := False;
  end;

  cmb_id_cdChange(Sender);
  
end;

procedure Tfrm_LOSTA220Q.cmb_id_cdChange(Sender: TObject);
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

procedure Tfrm_LOSTA220Q.btn_queryClick(Sender: TObject);

var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA220Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA220Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('분실폰반송내역조회(LOSTA220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA220Q');
end;

procedure Tfrm_LOSTA220Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1..3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      5..6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8..10 :StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      11 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      13 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      14 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      15..16 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      17 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      18 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
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

procedure Tfrm_LOSTA220Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTA220Q.Copy1Click(Sender: TObject);
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
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTA220Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA220Q.dte_fromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
    dte_to.SetFocus;
end;

procedure Tfrm_LOSTA220Q.dte_toKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    cmb_id_cd.SetFocus;
end;

procedure Tfrm_LOSTA220Q.cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA220Q.btn_resetClick(Sender: TObject);
begin
	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;

  KT_pnl.Caption := 'KT '+ '0';
  LGU_pnl.Caption := 'LGU+ '+ '0';
  SKT_pnl.Caption := 'SKT '+ '0';
  PCS_pnl.Caption := '불명PCS '+ '0';
  CELL_pnl.Caption := '불명CELL '+ '0';

  changeBtn(Self);
end;

end.
