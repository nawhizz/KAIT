{*---------------------------------------------------------------------------
프로그램ID    : LOSTA830Q (경찰서습득단말기 오류입력 조회)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10. 21
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	          :
-----------------------------------------------------------------------------*}
unit u_LOSTA830Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
  TITLE   = '경찰서습득단말기오류입력조회';
  PGM_ID  = 'LOSTA830Q';

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
  Tfrm_LOSTA830Q = class(TForm)
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
    SkinData1: TSkinData;
    TMAX: TTMAX;
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
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure Copy1Click(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
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

    //z001Data:Array of TZ001;
    //z001DataCount:Integer;
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
  frm_LOSTA830Q: Tfrm_LOSTA830Q;


implementation
{$R *.DFM}

procedure Tfrm_LOSTA830Q.disableComponents;
begin
  	dte_from.Enabled := false;
    dte_to.Enabled := false;
	  cmb_id_cd.Enabled:= false;
    btn_Inquiry.Enabled := False;
    btn_query.Enabled:= False;
    btn_excel.Enabled:= False;
    btn_close.Enabled:= False;
end;

procedure Tfrm_LOSTA830Q.enableComponents;
begin
	dte_from.Enabled := True;;
    dte_to.Enabled := True;;
	cmb_id_cd.Enabled:= True;;
    btn_Inquiry.Enabled := True;;
    btn_query.Enabled:= True;;
    btn_excel.Enabled:= True;;
    btn_close.Enabled:= True;;
end;

procedure Tfrm_LOSTA830Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 22;
    	RowHeights[0] := 21;                      
                                                  
    	ColWidths[0] := 40;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 80;
		Cells[1,0] :='입고일자';                

    	ColWidths[2] := -1;
		Cells[2,0] :='경찰서아이디';

    	ColWidths[3] := 130;
		Cells[3,0] :='경찰서명';

    	ColWidths[4] := 115;
		Cells[4,0] :='관리번호';

      ColWidths[5] := 80;
		Cells[5,0] :='획득순번';

    	ColWidths[6] := -1;
		Cells[6,0] :='모델코드(C)';

    	ColWidths[7] := 110;
		Cells[7,0] :='모델명(C)';

    	ColWidths[8] := 100;
		Cells[8,0] :='일련번호(C)';

      ColWidths[9] := -1;
		Cells[9,0] :='모델코드(P)';

    	ColWidths[10] := 110;
		Cells[10,0] :='모델명(P)';

    	ColWidths[11] := 100;
		Cells[11,0] :='일련번호(P)';
                                           
    	ColWidths[12] := 60;
		Cells[12,0] :='창고번호';

    	ColWidths[13] := -1;
		Cells[13,0] :='사업자식별번호';

      ColWidths[14] := 70;
		Cells[14,0] :='사업자명';

      ColWidths[15] := -1;
		Cells[15,0] :='단말기구분코드';

      ColWidths[16] := 100;
		Cells[16,0] :='단말기구분명';

    	ColWidths[17] := 100;
		Cells[17,0] :='가입자성명';

    	ColWidths[18] := 140;
		Cells[18,0] :='가입자주민번호';

    	ColWidths[19] := 100;
		Cells[19,0] :='가입자연락처';

    	ColWidths[20] := 140;
		Cells[20,0] :='분실핸드폰번호';

    	ColWidths[21] := 400;
		Cells[21,0] :='주소';

    end;
end;

procedure Tfrm_LOSTA830Q.setEdtKeyPress;
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

procedure Tfrm_LOSTA830Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA830Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA830Q.FormCreate(Sender: TObject);
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

 
  
  frm_LOSTA830Q.Position := poScreenCenter;

	initSkinForm(SkinData1); //common_lib.pas에 있다.
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체','불명단말기',cmb_id_cd);


  initStrGrid;	//그리드 초기화

	dte_from.Date := date-30;
	dte_to.Date := date;

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

    //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA830Q.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;

  seq,RowPos:Integer;

 	STR004 : String;
	STR005 : String;
	STR006 : String;
	STR007 : String;
  STR008 : String;

  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_ganm, seed_gano, seed_gatl, seed_mtno : String;

  Label LIQUIDATION;
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

  seed_ganm := '';
  seed_gano := '';
  seed_gatl := '';
  seed_mtno := '';

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA830Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTA830Q') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

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

          STR004 := delHyphen((TMAX.RecvString('STR101',i)));
          STR005 := Trim(TMAX.RecvString('STR114',i));
          STR006 := Trim(TMAX.RecvString('STR105',i));
          STR007 := Trim(TMAX.RecvString('STR106',i));

          Cells[0,RowPos]  := intToStr(seq);
          Cells[1,RowPos]  := TMAX.RecvString('STR101',i);
          Cells[2,RowPos]  := TMAX.RecvString('STR102',i);
          Cells[3,RowPos]  := TMAX.RecvString('STR103',i);
          Cells[4,RowPos]  := TMAX.RecvString('STR104',i);
          Cells[5,RowPos]  := TMAX.RecvString('STR105',i);
          Cells[6,RowPos]  := TMAX.RecvString('STR106',i);
          Cells[7,RowPos]  := TMAX.RecvString('STR107',i);
          Cells[8,RowPos]  := TMAX.RecvString('STR108',i);
          Cells[9,RowPos]  := TMAX.RecvString('STR109',i);
          Cells[10,RowPos] := TMAX.RecvString('STR110',i);
          Cells[11,RowPos] := TMAX.RecvString('STR111',i);
          Cells[12,RowPos] := TMAX.RecvString('STR112',i);
          Cells[13,RowPos] := TMAX.RecvString('STR113',i);
          Cells[14,RowPos] := TMAX.RecvString('STR114',i);
          Cells[15,RowPos] := TMAX.RecvString('STR115',i);
          Cells[16,RowPos] := TMAX.RecvString('STR116',i);
        //Cells[17,RowPos] := TMAX.RecvString('STR117',i);
          seed_ganm        := TMAX.RecvString('STR117',i);     // 가입자성명
          Cells[17,RowPos] := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
        //Cells[18,RowPos] := InsHyphen(TMAX.RecvString('STR118',i));
          seed_gano        := TMAX.RecvString('STR118',i);     // 가입자주민번호
          Cells[18,RowPos] := InsHyphen(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
        //Cells[19,RowPos] := TMAX.RecvString('STR119',i);
          seed_gatl        := TMAX.RecvString('STR119',i);     // 가입자연락처
          Cells[19,RowPos] := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
        //Cells[20,RowPos] := TMAX.RecvString('STR120',i);
          seed_mtno        := TMAX.RecvString('STR120',i);     // 분실핸드폰번호
          Cells[20,RowPos] := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
          Cells[21,RowPos] := TMAX.RecvString('STR121',i);

          Inc(seq);
          Inc(RowPos);
        end;
    end;
    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    count2 := TMAX.RecvInteger('INT100',0);

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


procedure Tfrm_LOSTA830Q.dte_fromExit(Sender: TObject);
begin
     sts_Message.Panels[1].Text := '';
 if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
 begin
     showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
 end;
end;

procedure Tfrm_LOSTA830Q.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA830Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTA830Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      5 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8..10 :StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      11 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      13 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
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

procedure Tfrm_LOSTA830Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTA830Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTA830Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA830Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA830Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('경찰서습득단말기오류입력조회(LOSTA830Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA830Q');
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTA830Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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


procedure Tfrm_LOSTA830Q.dte_fromKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      dte_to.SetFocus;
end;

procedure Tfrm_LOSTA830Q.dte_toKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      cmb_id_cd.SetFocus;
end;

procedure Tfrm_LOSTA830Q.cmb_id_cdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTA830Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex := 0;
  changeBtn(Self);

end;

end.
