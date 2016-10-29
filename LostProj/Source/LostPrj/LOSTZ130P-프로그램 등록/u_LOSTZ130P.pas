{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ130P (프로그램 등록)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 16
완료일	      : ####. ##. ##
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTZ130P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ130_CHILD, ComObj;

const
  TITLE   = '프로그램등록';
  PGM_ID  = 'LOSTZ130P';

type
  Tfrm_LOSTZ130P = class(TForm)
    pnl_Command: TPanel;
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    lbl_Inq_Str: TLabel;
    edt_pg_id: TEdit;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    TMAX: TTMAX;
    SkinData1: TSkinData;
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
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
    procedure initString;

  public
    { Public declarations }
  end;

var
  PG_ID  : String;
  PG_NM  : String;
  PG_SM  : String;
  PG_GU  : String;
  PG_TY  : String;
  PG_ST  : String;
  US_YN  : String;

  frm_LOSTZ130P: Tfrm_LOSTZ130P;

implementation
uses cpaklibm;
{$R *.dfm}


procedure Tfrm_LOSTZ130P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 9;
    	RowHeights[0] := 21;

    	ColWidths[0] := 50;
		Cells[0,0] :='SEQ';

    	ColWidths[1] := 150;
		Cells[1,0] :='프로그램ID';

      ColWidths[2] := 260;
		Cells[2,0] :='프로그램명';

      ColWidths[3] := -1;
		Cells[3,0] :='프로그램약어';

      ColWidths[4] := -1;
		Cells[4,0] :='프로그램구분';

      ColWidths[5] := -1;
		Cells[5,0] :='프로그램형태';

      ColWidths[6] := 120;
		Cells[6,0] :='프로그램상태';

      ColWidths[7] := 120;
		Cells[7,0] :='사용여부';

      ColWidths[8] := -1;
		Cells[8,0] :='프로그램상태(코드)';

    end;
end;

procedure Tfrm_LOSTZ130P.initString;
begin
  PG_ID  := '';       
  PG_NM  := '';      
  PG_SM  := '';      
  PG_GU  := '';      
  PG_TY  := '';      
  PG_ST  := '';
  US_YN  := '';
end;
{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ130P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTZ130P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ130P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{-----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ130P.FormCreate(Sender: TObject);
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

  initStrGrid;	//그리드 초기화
  qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.
  initSkinForm(SkinData1);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ130P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTZ130P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
	  //그리드 디스플레이
    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;
    btn_query.Enabled := True; 

    seq:= 1; 	//순번
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
	if (TMAX.SendString('INF003','LOSTZ130P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', edt_pg_id.Text) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ130P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

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

        Cells[0,RowPos] := intToStr(seq);
        Cells[1,RowPos] := TMAX.RecvString('STR101',i); //프로그램ID
        Cells[2,RowPos] := TMAX.RecvString('STR102',i); //프로그램명
        Cells[3,RowPos] := TMAX.RecvString('STR103',i); //프로그램약어
        Cells[4,RowPos] := TMAX.RecvString('STR104',i); //프로그램구분
        Cells[5,RowPos] := TMAX.RecvString('STR105',i); //프로그램형태
        Cells[6,RowPos] := TMAX.RecvString('STR106',i); //프로그램상태
        Cells[7,RowPos] := TMAX.RecvString('STR107',i); //사용여부
        Cells[8,RowPos] := TMAX.RecvString('STR108',i); //프로그램상태코드

        Inc(seq);
        Inc(RowPos);
      end;
  end;
  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
  Application.ProcessMessages;

  qryStr:= TMAX.RecvString('INF014',0);
LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;

end;

procedure Tfrm_LOSTZ130P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    begin
    case ACol of
      0..1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      2..3 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);

    end;
  end;

end;

procedure Tfrm_LOSTZ130P.btn_AddClick(Sender: TObject);
begin
  initString;

  frm_LOSTZ130P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ130P.grd_displayDblClick(Sender: TObject);
begin

    initString;
    PG_ID:= grd_display.Cells[1, grd_display.Row];
    PG_NM:= grd_display.Cells[2, grd_display.Row];
    PG_SM:= grd_display.Cells[3, grd_display.Row];
    PG_GU:= grd_display.Cells[4, grd_display.Row];
    PG_TY:= grd_display.Cells[5, grd_display.Row];
    PG_ST:= grd_display.Cells[8, grd_display.Row];
    US_YN:= grd_display.Cells[7, grd_display.Row];

    frm_LOSTZ130P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ130P.btn_UpdateClick(Sender: TObject);
begin

    initString;
    PG_ID:= grd_display.Cells[1, grd_display.Row];
    PG_NM:= grd_display.Cells[2, grd_display.Row];
    PG_SM:= grd_display.Cells[3, grd_display.Row];
    PG_GU:= grd_display.Cells[4, grd_display.Row];
    PG_TY:= grd_display.Cells[5, grd_display.Row];
    PG_ST:= grd_display.Cells[8, grd_display.Row];
    US_YN:= grd_display.Cells[7, grd_display.Row];

    frm_LOSTZ130P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ130P.btn_DeleteClick(Sender: TObject);
begin

    initString;
    PG_ID:= grd_display.Cells[1, grd_display.Row];
    PG_NM:= grd_display.Cells[2, grd_display.Row];
    PG_SM:= grd_display.Cells[3, grd_display.Row];
    PG_GU:= grd_display.Cells[4, grd_display.Row];
    PG_TY:= grd_display.Cells[5, grd_display.Row];
    PG_ST:= grd_display.Cells[8, grd_display.Row];
    US_YN:= grd_display.Cells[7, grd_display.Row];

    frm_LOSTZ130P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ130P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);

end;



procedure Tfrm_LOSTZ130P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;
    filePath:='..\Temp\LOSTZ130P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ130P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_query.Enabled := False;  

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;
end;

end.
