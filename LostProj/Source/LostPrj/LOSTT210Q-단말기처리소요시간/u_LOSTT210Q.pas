{*---------------------------------------------------------------------------
프로그램ID    : LOSTT210Q (단말기 처리 소요 시간 )
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 26
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
unit u_LOSTT210Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit, ComObj;

const
  TITLE   = '단말기처리소요시간 ';
  PGM_ID  = 'LOSTT210Q';

type
  Tfrm_LOSTT210Q = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Link: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    CalendarMonth1: TCalendarMonth;
    grd_display: TStringGrid;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    sts_Message: TStatusBar;
    cmb_Inq_Gu: TComboBox;
    cmb_Gu_day: TComboBox;
    btn_Reset: TSpeedButton;
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_excelClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
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
  frm_LOSTT210Q: Tfrm_LOSTT210Q;


implementation

{$R *.dfm}
procedure Tfrm_LOSTT210Q.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTT210Q.enableComponents;
begin
  changeBtn(Self);

	cmb_Inq_Gu.Enabled := True;
  CalendarMonth1.Enabled := True;
  cmb_Gu_day.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTT210Q.setEdtKeyPress;
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

procedure Tfrm_LOSTT210Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTT210Q.initStrGrid;
begin
 if (cmb_Inq_Gu.ItemIndex = 2) then begin
 with grd_display do begin
    	RowCount :=2;
      ColCount := 1;
    	RowHeights[0] := 21;

    	ColWidths[0] := 250;
		Cells[0,0] :='입출고 소요일 ';
    end;
 end else begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 5;
    	RowHeights[0] := 21;

    	ColWidths[0] := -1;
		Cells[0,0] :='총괄국명(우청정명)코드';

    	ColWidths[1] := 250;
		Cells[1,0] :='총괄국(우정청)명';

      ColWidths[2] := 150;
		Cells[2,0] :='습득-등록 소요일';

      ColWidths[3] := 150;
		Cells[3,0] :='등록-입고 소요일';

      ColWidths[4] := 150;
		Cells[4,0] :='총 소요일';
    end;
  end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}

procedure Tfrm_LOSTT210Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

{------------------------------------------------------------------------------}
procedure Tfrm_LOSTT210Q.FormCreate(Sender: TObject);
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
  { }
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
  initStrGrid;	//그리드 초기화
	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTT210Q.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTT210Q.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTT210Q.cmb_Inq_GuChange(Sender: TObject);
var
    i:Integer;
begin
  initStrGrid;
  if ( cmb_Inq_Gu.ItemIndex = 2 ) then begin
    cmb_Gu_day.Items.ADD('출고일기준');
    cmb_Gu_day.ItemIndex := 3;
    cmb_Gu_day.Enabled := False;
  end else  begin
    cmb_Gu_day.Enabled := True;
    cmb_Gu_day.Items.Delete(3);
    cmb_Gu_day.ItemIndex := 0;
  end;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
  grd_display.rows[i].Clear;
  grd_display.RowCount := 2;
end;

procedure Tfrm_LOSTT210Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
 	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //크리드 초기화
    pInitStrGrd(Self);    

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
	if (TMAX.SendString('INF003','LostT210Q') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', IntToStr(cmb_Gu_day.ItemIndex)) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTT210Q') then
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

  if (cmb_Inq_Gu.ItemIndex = 2) then begin
    with grd_display do begin
        for i:=0 to count1-1 do begin
            Cells[0,RowPos] := FloatToStr(TMAX.RecvDouble('DBL101',i)); //우체국코드
            Inc(seq);
            Inc(RowPos);
          end;
      end;
  end else begin
      with grd_display do begin
        for i:=0 to count1-1 do begin

            Cells[0,RowPos] := TMAX.RecvString('STR101',i); //총괄국(우정청)코드
            Cells[1,RowPos] := TMAX.RecvString('STR102',i); //총괄국(우정청)이름
            Cells[2,RowPos] := FloatToStr(TMAX.RecvDouble('DBL103',i)); //습득-등록 소요일
            Cells[3,RowPos] := FloatToStr(TMAX.RecvDouble('DBL104',i)); //등록-입고 소용일
            Cells[4,RowPos] := FloatToStr(TMAX.RecvDouble('DBL105',i)); //총 소요일
            Inc(seq);
            Inc(RowPos);
          end;
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
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;


procedure Tfrm_LOSTT210Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      2..4: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);


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

procedure Tfrm_LOSTT210Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('단말기 처리 소요시간(LOSTT220Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTT220Q');
end;

procedure Tfrm_LOSTT210Q.btn_ResetClick(Sender: TObject);
var i : Integer;
begin
  cmb_Inq_Gu.ItemIndex := 0;
  cmb_Gu_day.ItemIndex := 0;

  changeBtn(Self);

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;  
end;

procedure Tfrm_LOSTT210Q.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTT210Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
