{*---------------------------------------------------------------------------
프로그램ID    : LOSTT100P (상 담 원   설 문 내 용   등 록)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011.09.22
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
unit u_LOSTT100P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, WinSkinData, so_tmax, Grids, Buttons,
  ExtCtrls, common_lib, Mask, ToolEdit, ComObj;

const
  TITLE   = '상담원 설문내용 등록';
  PGM_ID  = 'LOSTT100P';

type
  Tfm_LOSTT100P = class(TForm)
    Bevel1: TBevel;
    pnl_Program_Name: TLabel;
    pnl_Command: TPanel;
    grd_display: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    sts_Message: TStatusBar;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    cmb_dt_gbn: TComboBox;
    Label2: TLabel;
    Bevel3: TBevel;
    cmb_prog_sts: TComboBox;
    Label3: TLabel;
    dte_dt_st: TDateEdit;
    dte_dt_ed: TDateEdit;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell(Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; i_align : integer);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    isData:Boolean;	            
    grdFocousEnable:Boolean;	  
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
    procedure initComponents;

  end;

var
  fm_LOSTT100P: Tfm_LOSTT100P;

implementation
uses u_LOSTT100P_CHILD ;
{$R *.dfm}

procedure Tfm_LOSTT100P.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
	if ParamCount <> 6 then begin
    ShowMessage('로그인 후 사용하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
   end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle   := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 내부 캡션 설정
  pnl_Program_Name.Caption := TITLE;

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 메세지 바 넓이 설정
  pSetStsWidth(sts_Message);

  // 텍스트 선택시 전체 선택 기능
  pSetTxtSelAll(Self);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  // 스킨 초기화
  initSkinForm(SkinData1);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTT100P.initStrGrid;
begin
  with grd_display do begin
    RowCount      :=  2;
    ColCount      :=  9;
    RowHeights[0] := 21;

    ColWidths[ 0] := 50;   // SEQ
    ColWidths[ 1] := -1;   // 작업일자
    ColWidths[ 2] := -1;   // 작업일련번호
    ColWidths[ 3] := -1;   // 일자기준코드
    ColWidths[ 4] := 180;  // 일자기준코드명
    ColWidths[ 5] := 100;  // 시작일자
    ColWidths[ 6] := 100;  // 종료일자
    ColWidths[ 7] := 120;  // 진행상태
    ColWidths[ 8] := 240;  // 설문주제

    Cells[ 0,0]   :=  'SEQ';
    Cells[ 1,0]   :=  '작업일자';
    Cells[ 2,0]   :=  '작업일련번호';
    Cells[ 3,0]   :=  '일자기준코드';
    Cells[ 4,0]   :=  '일자기준코드명';
    Cells[ 5,0]   :=  '시작일자';
    Cells[ 6,0]   :=  '종료일자';
    Cells[ 7,0]   :=  '진행상태';
    Cells[ 8,0]   :=  '설문주제';


  end;
end;

procedure Tfm_LOSTT100P.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tfm_LOSTT100P.grd_displayDrawCell(Sender: TObject; ACol,
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
      8: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0..7 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;
  end;
end;

procedure Tfm_LOSTT100P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfm_LOSTT100P.btn_InquiryClick(Sender: TObject);
var
  i:Integer;
  totalCount:Integer;
  STR001,STR002,STR003,STR004:String;

  Label LIQUIDATION;
begin
	//그리드 디스플레이

  grd_display.RowCount  := 2;
  grd_display.FixedRows := 1;
  isData                := False; //스트링 그리드에 데이터가 없다.

  totalCount := 0;

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

	TMAX.InitBuffer;

	(* 	조회일자구분 *)  STR001  := IntToStr(cmb_dt_gbn.itemIndex);
	(* 	조회시작일자 *)  STR002  := delHyphen(dte_dt_st.Text);
	(* 	조회종료일자 *)  STR003  := delHyphen(dte_dt_ed.text);
	(* 	진행여부	   *)  STR004  := Trim(Copy(cmb_prog_sts.Items.Strings[cmb_prog_sts.itemIndex],41,10));

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004            ) < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTT100P') then goto LIQUIDATION;

	totalCount := TMAX.RecvInteger('INT100',0);

  if totalCount > 0 then
    isData:= True;	//스트링그리드에 데이터가 있다.

  grd_display.RowCount := grd_display.RowCount + totalCount;

  with grd_display do begin
    for i:=0 to totalCount-1 do
      begin
        (* SEQ            *) Cells[ 0,i+1] := intToStr(i+1);    //순번
        (* 작업일자       *) Cells[ 1,i+1] :=                 TMAX.RecvString ('STR101',i);
        (* 작업일련번호   *) Cells[ 2,i+1] := IntToStr(       TMAX.RecvInteger('INT102',i));
        (* 일자기준코드   *) Cells[ 3,i+1] :=                 TMAX.RecvString ('STR103',i);
        (* 일자기준코드명 *) Cells[ 4,i+1] :=                 TMAX.RecvString ('STR104',i);
        (* 시작일자       *) Cells[ 5,i+1] := InsHyphen(      TMAX.RecvString ('STR105',i));
        (* 종료일자       *) Cells[ 6,i+1] := InsHyphen(      TMAX.RecvString ('STR106',i));
        (* 진행상태       *) Cells[ 7,i+1] := Trim(           TMAX.RecvString ('STR107',i));
        (* 설문주제       *) Cells[ 8,i+1] := Trim(           TMAX.RecvString ('STR108',i));
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
  grd_display.Cursor    := crDefault;	//작업완료

  if totalCount > 0 then
    grd_display.RowCount  := grd_display.RowCount -1;

  if grdFocousEnable then
  begin
    if not (sender is TSpeedButton) then
    begin
        grd_display.SetFocus;	//스트링 그리드로 포커스 이동

    end else if (Sender as TSpeedButton).Name = 'btn_Inquiry' then
        grd_display.OnDblClick := self.grd_displayDblClick;

  end;

  enableComponents;  
end;

procedure Tfm_LOSTT100P.disableComponents;
begin
  btn_Inquiry.enabled  := False;
  btn_Link.enabled     := False;
  btn_Close.enabled    := False;

end;

procedure Tfm_LOSTT100P.enableComponents;
begin
  btn_Inquiry.enabled  := True;
  btn_Link.enabled     := True;
  btn_Close.enabled    := True;
end;

procedure Tfm_LOSTT100P.grd_displayDblClick(Sender: TObject);
begin
  fm_LOSTT100P_CHILD.FormShow(Sender);
  Self.Enabled := False;
  Self.Hide;
end;

procedure Tfm_LOSTT100P.btn_AddClick(Sender: TObject);
begin
  fm_LOSTT100P_CHILD.FormShow(Sender);
  Self.Hide;
  Self.Enabled := False;
end;

procedure Tfm_LOSTT100P.btn_LinkClick(Sender: TObject);
begin
  fm_LOSTT100P_CHILD.FormShow(Sender);
  Self.Enabled := False;
  Self.Hide;
end;

procedure Tfm_LOSTT100P.initComponents;
begin
  pInitStrGrd(Self);

  initStrGrid;
  dte_dt_st.Date  := date-30;
  dte_dt_ed.Date  := date;
  grdFocousEnable := True;

  // 버튼 이미지 초기화
  changeBtn(Self);

  btn_Update.Enabled := false;
  btn_Delete.Enabled := false;

  cmb_prog_sts.ItemIndex := 0;
  cmb_dt_gbn.ItemIndex   := 0;
end;

procedure Tfm_LOSTT100P.btn_resetClick(Sender: TObject);
begin
  initComponents;
end;

procedure Tfm_LOSTT100P.FormShow(Sender: TObject);
begin
  Self.initComponents;
end;

end.
