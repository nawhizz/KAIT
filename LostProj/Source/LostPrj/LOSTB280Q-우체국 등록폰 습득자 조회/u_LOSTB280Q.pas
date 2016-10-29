{*---------------------------------------------------------------------------
프로그램ID    : LOSTB280Q (우체국 등록폰 습득자 조회)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011.09.29
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

unit u_LOSTB280Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst,
  common_lib, WinSkinData, so_tmax,Func_Lib, ComObj;

type
  Tfrm_LOSTB280Q = class(TForm)
    pnl_Command:      TPanel;
    sts_Message:      TStatusBar;
    Panel2:           TPanel;
    Bevel2:           TBevel;
    Label2:           TLabel;
    Bevel1:           TBevel;
    pnl_Program_Name: TLabel;
    btn_Add:          TSpeedButton;
    btn_Update:       TSpeedButton;
    btn_Delete:       TSpeedButton;
    btn_Inquiry:      TSpeedButton;
    btn_Next_Inq:     TSpeedButton;
    btn_Print:        TSpeedButton;
    btn_Close:        TSpeedButton;
    SkinData1:        TSkinData;
    TMAX:             TTMAX;
    grd_display: TStringGrid;
    btn_Excel: TSpeedButton;
    edt_nm: TEdit;

    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);


    procedure grd_displayDrawCell(Sender: TObject; ACol,ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);
    procedure edt_nmKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;

  public
    { Public declarations }
  end;

var
  frm_LOSTB280Q: Tfrm_LOSTB280Q;


implementation

{$R *.DFM}

{*******************************************************************************
* procedure Name : initStrGrid
* 기 능 설 명 : 그리드를 초기화 하고 필드 타이틀 설정을 한다.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.initStrGrid;
var
  j : Integer;
begin
	with grd_display do begin
    j := 0;
    RowCount := 2;
    ColCount := 10;
    RowHeights[0] := 21;

    cells[fInc(j),0] := '순번';
    cells[fInc(j),0] := '등록일자';
    cells[fInc(j),0] := '습득자명';
    cells[fInc(j),0] := '상태코드';
    cells[fInc(j),0] := '상태';
    cells[fInc(j),0] := '수취여부';
    cells[fInc(j),0] := '접수국명';
    cells[fInc(j),0] := '모델코드';
    cells[fInc(j),0] := '모델명';
    cells[fInc(j),0] := '일련번호';

    j := 0;

    colwidths[fInc(j)] :=  60;   //순번
    colwidths[fInc(j)] := 100;   //등록일자
    colwidths[fInc(j)] := 140;   //습득자명
    colwidths[fInc(j)] :=  -1;   //상태코드
    colwidths[fInc(j)] := 140;   //상태
    colwidths[fInc(j)] :=  80;   //수취여부
    colwidths[fInc(j)] := 120;   //접수국명
    colwidths[fInc(j)] :=  -1;   //모델코드
    colwidths[fInc(j)] := 100;   //모델명
    colwidths[fInc(j)] := 160;   //일련번호

  end;

end;

procedure Tfrm_LOSTB280Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB280Q.FormCreate(Sender: TObject);
begin
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
//  common_userid       := '0294'   ;  // ParamStr(2);
//  common_username     := '정호영' ;  // ParamStr(3);
//  common_usergroup    := 'SYSM'   ;  // ParamStr(4);

    //스킨 초기화
    initSkinForm(SkinData1);      // common_lib.pas에 있다.

    // 그리드 초기화
    initStrGrid;

    edt_nm.Clear;

    //버튼이미지 초기화
    changeBtn(Self);

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB280Q.btn_InquiryClick(Sender: TObject);
var
    i,j: Integer;

    Label LIQUIDATION;

begin

    grd_display.RowCount := 2;

    grd_display.Cursor := crSQLWait;	//작업중....

    disableComponents;	//작업중 다른 기능 잠시 중지.

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

	  TMAX.InitBuffer;

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid)   < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username) < 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup)< 0)  then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LostB280Q')     < 0)  then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('STR001', Trim(edt_nm.Text)) < 0) then  goto LIQUIDATION;

    // 사용자 데이터 설정 완료

    //서비스 호출
    if not TMAX.Call('LOSTB280Q') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    end;

    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INF013',0);

    with grd_display do begin
        for i:=0 to TMAX.RecvInteger('INF013',0) -1 do
        begin

          Cells[ 0,i+1]   := IntToStr(i + 1);               //  순번
          Cells[ 1,i+1]   := InsHyphen( TMAX.RecvString('STR101',i));  //  등록일자
          Cells[ 2,i+1]   := TMAX.RecvString('STR102',i);  //  습득자명
          Cells[ 3,i+1]   := TMAX.RecvString('STR103',i);  //  상태코드
          Cells[ 4,i+1]   := TMAX.RecvString('STR104',i);  //  상태
          Cells[ 5,i+1]   := TMAX.RecvString('STR105',i);  //  수취여부
          Cells[ 6,i+1]   := TMAX.RecvString('STR106',i);  //  접수국명
          Cells[ 7,i+1]   := TMAX.RecvString('STR107',i);  //  모델코드
          Cells[ 8,i+1]   := TMAX.RecvString('STR108',i);  //  모델명
          Cells[ 9,i+1]   := TMAX.RecvString('STR109',i);  //  일련번호

        end;
    end;

    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + IntToStr(TMAX.RecvInteger('INF013',0)) + '건이 조회 되었습니다.';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

{*******************************************************************************
* procedure Name : disableComponents
* 기 능 설 명 :버튼을 누르지 못하게 한다.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.disableComponents;
begin
  edt_nm.Enabled    := false;

  btn_Inquiry.Enabled := False;

  btn_close.Enabled   := False;
end;

{*******************************************************************************
* procedure Name : enableComponents
* 기 능 설 명 :버튼을 눌러 다른 기능을 할 수 있게한다.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.enableComponents;
begin
  edt_nm.Enabled    := True;

  btn_Inquiry.Enabled := True;

  btn_close.Enabled   := True;
end;

{*******************************************************************************
* procedure Name : grd_displayDrawCell
* 기 능 설 명 : 그리드 타이틀 부분에 대한 데코레이션 효과를 준다.
*
*******************************************************************************}
procedure Tfrm_LOSTB280Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
    case ACol of
      2,3,6   : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      else        StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;
  end;

end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTB280Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTB280Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel('우체국 등록폰 습득자 조회(LOSTB280Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTB280Q');
end;

procedure Tfrm_LOSTB280Q.edt_nmKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

end.
