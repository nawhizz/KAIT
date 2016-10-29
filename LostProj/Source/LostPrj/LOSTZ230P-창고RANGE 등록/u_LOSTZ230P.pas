{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ230P (창고 Range 등록)
프로그램 종류 : Online
작성자	      : hysys
작성일	      : 2011. 09. 14
완료일	      : ####. ##. ##
프로그램 개요 : 창고 range 자료를 등록, 수정, 삭제, 조회한다.

     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ230P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ230P_child, ComObj;

const
  TITLE   = '창고RANGE등록';
  PGM_ID  = 'LOSTZ230P';

type
  Tfrm_LOSTZ230P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    cmb_ph_Gb: TComboBox;
    pnl_Command: TPanel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    Label1: TLabel;
    Bevel1: TBevel;
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
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);

  private
    { Private declarations }
    qryStr : String;
    cmb_ph_gb_d: TZ0xxArray;
    procedure initStrGrid;
    procedure initString;

  public
    { Public declarations }
  end;

{ frmgcham001(코드구분 입력화면)과 공통사용}

var
  CG_SQ : String;
  CG_GB : String;
  FR_RN : String;
  TO_RN : String;

  frm_LOSTZ230P: Tfrm_LOSTZ230P;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ230P.initString;
begin
  CG_SQ := '';
  CG_GB := '';
  FR_RN := '';
  TO_RN := '';
end;

procedure Tfrm_LOSTZ230P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 7;
    	RowHeights[0] := 21;

    	ColWidths[0] := -1;
		Cells[0,0] :='창고RANG일련번호';

    	ColWidths[1] := -1;
		Cells[1,0] :='창고RANG구분코드';

    	ColWidths[2] := 145;
		Cells[2,0] :='창고RANG구분명';

    	ColWidths[3] := 120;
		Cells[3,0] :='FROM RANGE';

      ColWidths[4] := 120;
		Cells[4,0] :='TO RANGE';

      ColWidths[5] := 150;
		Cells[5,0] :='최종번호';

      ColWidths[6] := 150;
		Cells[6,0] :='공란수';

    end;
end;

procedure Tfrm_LOSTZ230P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ230P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ230P.FormCreate(Sender: TObject);
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

  initSkinForm(SkinData1);
  initStrGrid;	//그리드 초기화
  initComboBoxWithZ0xx('Z083.dat', cmb_ph_gb_d, '전체', '',cmb_ph_Gb);
  qryStr := '';

 
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;


procedure Tfrm_LOSTZ230P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ230P.btn_AddClick(Sender: TObject);
begin
  frm_LOSTZ230P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ230P.grd_displayDblClick(Sender: TObject);
begin

  initString;
  CG_SQ := grd_display.Cells[0, grd_display.Row];
  CG_GB := grd_display.Cells[1, grd_display.Row];
  FR_RN := grd_display.Cells[3, grd_display.Row];
  TO_RN := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ230P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ230P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

   btn_Update.Enabled := True;
   btn_Delete.Enabled := True;

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
	if (TMAX.SendString('INF003','LOSTZ230P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_ph_gb_d[cmb_ph_gb.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ230P') then
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

          Cells[0,RowPos]  := TMAX.RecvString('INT101',i); //창고 RANG 일련번호
          Cells[1,RowPos]  := TMAX.RecvString('STR101',i); //창고 RANG 구분코드
          Cells[2,RowPos]  := TMAX.RecvString('STR102',i); //창고 RANG 구분명
          Cells[3,RowPos]  := TMAX.RecvString('STR103',i); //FROM          
          Cells[4,RowPos]  := TMAX.RecvString('STR104',i); //TO
          Cells[5,RowPos]  := TMAX.RecvString('STR105',i); //차지 최정번호
          Cells[6,RowPos]  := TMAX.RecvString('STR106',i); //공란수

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

procedure Tfrm_LOSTZ230P.btn_UpdateClick(Sender: TObject);
begin
  CG_SQ := grd_display.Cells[0, grd_display.Row];
  CG_GB := grd_display.Cells[1, grd_display.Row];
  FR_RN := grd_display.Cells[3, grd_display.Row];
  TO_RN := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ230P_CHILD.FormShow(Sender);
end;



procedure Tfrm_LOSTZ230P.btn_DeleteClick(Sender: TObject);
begin
  CG_SQ := grd_display.Cells[0, grd_display.Row];
  CG_GB := grd_display.Cells[1, grd_display.Row];
  FR_RN := grd_display.Cells[3, grd_display.Row];
  TO_RN := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ230P_CHILD.FormShow(Sender);
  
end;

procedure Tfrm_LOSTZ230P.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('시스템관리(LOSTZ230Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTZ230Q');
end;

procedure Tfrm_LOSTZ230P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ230P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  cmb_ph_Gb.ItemIndex := 0;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;
   
end;

procedure Tfrm_LOSTZ230P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTZ230P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
  	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ230P.grd_displayDrawCell(Sender: TObject; ACol,
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
      2: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      3..6 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);


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
procedure Tfrm_LOSTZ230P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

end.
