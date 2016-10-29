{*---------------------------------------------------------------------------
프로그램ID    : LOSTC210Q ( 입고/정산 대행수량 비교 조회)
프로그램 종류 : Online
작성자	      : jung hong ryul
작성일	      : 2011. 09. 26
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
unit u_LOSTC210Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd, ComObj;

const
  TITLE   = '입고/정산 대행수량 비교 조회 ';
  PGM_ID  = 'LOSTC210Q';

type
  Tfrm_LOSTC210Q = class(TForm)
    pnl_Command: TPanel;
    Panel1: TPanel;
    lbl_Program_Name: TLabel;
    grd_display: TStringGrid;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    Bevel2: TBevel;
    dte_from: TDateEdit;
    Label3: TLabel;
    dte_to: TDateEdit;
    Label2: TLabel;
    Label1: TLabel;
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
    PO_cb1: TComboEdit;
    PO_Grid1: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure PO_cb1ButtonClick(Sender: TObject);
    procedure PO_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PO_Grid1Click(Sender: TObject);
  private
    { Private declarations }
    qryStr:String;
    procedure initStrGrid;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTC210Q: Tfrm_LOSTC210Q;

  PO_Grid1_d : TZ0xxArray;

implementation

uses DateUtils;

{$R *.dfm}

procedure Tfrm_LOSTC210Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC210Q.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;


procedure Tfrm_LOSTC210Q.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 7;
    	RowHeights[0] := 21;

    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 100;
		Cells[1,0] :='우체국코드';

    	ColWidths[2] := 150;
		Cells[2,0] :='우체국명';

      ColWidths[3] := 130;
		Cells[3,0] :='분실폰테이블 수량';

      ColWidths[4] := 130;
		Cells[4,0] :='정산테이블 수량';

      ColWidths[5] := 130;
		Cells[5,0] :='차이';

      ColWidths[6] := 160;
		Cells[6,0] :='조정금액';
    end;
end;

procedure Tfrm_LOSTC210Q.setEdtKeyPress;
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

procedure Tfrm_LOSTC210Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}

procedure Tfrm_LOSTC210Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
{-----------------------------------------------------------------------------}


procedure Tfrm_LOSTC210Q.FormCreate(Sender: TObject);
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
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

	initSkinForm(SkinData1); //common_lib.pas에 있다.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC210Q.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTC210Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTC210Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  //그리드 디스플레이
  pInitStrGrd(grd_display);

  seq:= 1; 	//순번
  RowPos:= 1;	//그리드 레코드 포지션
  grd_display.RowCount := 2;

  //시작시변수 초기화

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
  goto INQUIRY;

INQUIRY:

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostC210Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', PO_Grid1_d[PO_Grid1.Row].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTC210Q') then
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
    grd_display.RowCount := 2;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;

  totalCount:= totalCount + count1;
  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin

        Cells[0,RowPos] := IntToStr(seq);
        Cells[1,RowPos] := TMAX.RecvString('STR101',i); //우체국코드
        Cells[2,RowPos] := TMAX.RecvString('STR102',i); //우체국명
        Cells[3,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT103',i))); //분실폰테이블수량
        Cells[4,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i))); //정산테이블수량
        Cells[5,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT105',i))); //차이
        Cells[6,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i))); //조정금액

        Inc(seq);
        Inc(RowPos);
      end;
  end;
 //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
  qryStr:= TMAX.RecvString('INF014',0);

//빠져나오는곳
LIQUIDATION:

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료

  if totalCount > 0 then
    grd_display.RowCount := grd_display.RowCount -1;
  
  enableComponents;
end;

procedure Tfrm_LOSTC210Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC210Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);

end;

procedure Tfrm_LOSTC210Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('입고/정산 대행수량 비교 조회(LOSTC210Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC210Q');
end;

procedure Tfrm_LOSTC210Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3..6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

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

procedure Tfrm_LOSTC210Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTC210Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTC210Q.btn_resetClick(Sender: TObject);
var i : Integer;
begin
	dte_from.Date := StartOfTheMonth(IncMonth(now,-2));
	dte_to.Date := EndOfTheMonth(IncMonth(now,-2));

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  changeBtn(Self);

  pInitStrGrd(grd_display);

  initStrGrid;	//그리드 초기화

  initStrinGridWithZ0xx('Z042.dat', PO_Grid1_d , '전체', '',PO_Grid1  );

  PO_cb1.Text := PO_Grid1_d[0].name;

  sts_Message.Panels[1].Text := ' ';


end;

procedure Tfrm_LOSTC210Q.PO_cb1ButtonClick(Sender: TObject);
begin
   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   if not PO_Grid1.Visible then
   begin
     PO_Grid1.Visible := true;
   end else
     PO_Grid1.Visible := false;

   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;
end;

procedure Tfrm_LOSTC210Q.PO_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin

   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   // 엔터일경우
   if key = 13 then
   begin
      if po_grid1.Visible then
         po_grid1.Visible := false
      else
        po_grid1.Visible := true;

        po_cb1.Text := '';
        po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;

   // 방향키 위인 경우
   end else
   if (key = vk_up) and (po_grid1.Visible) then
   begin
      if po_grid1.row > 0 then
        po_grid1.Row  := po_grid1.Row - 1;

      po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
      po_cb1.SelectAll;
   end else if key = vk_escape then
   begin
      po_grid1.Visible := false;
   end else if (key = vk_down) and (po_grid1.Visible) then
   begin
      if po_grid1.row < po_grid1.RowCount-1 then
        po_grid1.Row  := po_grid1.Row + 1;
        po_cb1.Text   := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;
   end else if (trim(po_cb1.Text) <> '') and (key <> 229) then
   begin
      if not po_grid1.Visible then
         po_grid1.Visible := true;
      for i := 0 to po_grid1.RowCount-1 do
      if po_cb1.Text = copy(po_grid1.cells[0,i],1,length(po_cb1.text)) then
      begin
         po_grid1.Row := i;
         break;
      end;
   end;

   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;

end;

procedure Tfrm_LOSTC210Q.PO_Grid1Click(Sender: TObject);
begin
   po_cb1.text := po_grid1.Cells[0,po_grid1.row];
   po_cb1.SetFocus;
   po_grid1.Visible := false;
end;

end.
