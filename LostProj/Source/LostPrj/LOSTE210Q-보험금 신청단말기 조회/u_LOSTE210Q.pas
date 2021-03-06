
unit u_LOSTE210Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,printers, ComObj
  ;

const
  TITLE   = '보험금 신청 단말기 조회';
  PGM_ID  = 'LOSTE210Q';

type
  Tfrm_LOSTE210Q = class(TForm)
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
    Bevel5: TBevel;
    Label4: TLabel;
    Bevel6: TBevel;
    Label5: TLabel;
    Bevel7: TBevel;
    Label6: TLabel;
    cmb_gbn_inout: TComboBox;
    cmb_out_gbn: TComboBox;
    cmb_allow_in: TComboBox;
    Bevel8: TBevel;
    Label7: TLabel;
    Bevel9: TBevel;
    Label8: TLabel;
    cmb_in_sts: TComboBox;
    cmb_insu_gbn: TComboBox;

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
  frm_LOSTE210Q       : Tfrm_LOSTE210Q;
  cmb_insu_cmp_d      : TZ0xxArray;
  cmb_gbn_inout_d     : TZ0xxArray;
  cmb_in_sts_d        : TZ0xxArray;
  cmb_out_gbn_d       : TZ0xxArray;
  cmb_insu_gbn_d      : TZ0xxArray;

implementation
{$R *.DFM}

procedure Tfrm_LOSTE210Q.disableComponents;
begin
	  dte_from.Enabled    := false;
    dte_to.Enabled      := false;
    btn_query.Enabled   := False;
    btn_excel.Enabled   := False;
    btn_close.Enabled   := False;
    btn_Print.Enabled   := False;
    btn_Inquiry.Enabled := False;
end;

procedure Tfrm_LOSTE210Q.enableComponents;
begin
  	dte_from.Enabled     := True;
    dte_to.Enabled       := True;
    btn_query.Enabled    := True;
    btn_excel.Enabled    := True;
    btn_close.Enabled    := True;
    btn_Print.Enabled    := False;
    btn_Inquiry.Enabled  := True;
end;

procedure Tfrm_LOSTE210Q.initStrGrid;
begin
	with grd_display do
  begin
    RowCount      :=  2;
    ColCount      := 20;
    RowHeights[0] := 21;

    ColWidths[ 0] := 50;   // SEQ
    ColWidths[ 1] := 100;  // 보험사
    ColWidths[ 2] := 100;  // 이통사
    ColWidths[ 3] := 100;  // 모델명 
    ColWidths[ 4] := 160;  // 일련번호
    ColWidths[ 5] := 110;  // 이동전화번호
    ColWidths[ 6] := 115;  // 가입자성명
    ColWidths[ 7] := 110;  // 가입자생년월일
    ColWidths[ 8] := 110;  // 가입자연락처
    ColWidths[ 9] := 110;  // 보험금신청일자
    ColWidths[10] := 115;  // 지급중지일자
    ColWidths[11] := 115;  // 승인일자
    ColWidths[12] := 150;  // 보험금지급액
    ColWidths[13] := 110;  // 입출고구분
    ColWidths[14] := 110;  // 입고일자
    ColWidths[15] := 110;  // 입고상태
    ColWidths[16] := 110;  // 접수우체국
    ColWidths[17] := 110;  // 출고처리구분
    ColWidths[18] := 110;  // 승인후입고여부
    ColWidths[19] := 110;  // 단말기처리상태

    Cells[0,0]    := 'SEQ';
    Cells[1,0]    := '보험사';
    Cells[2,0]    := '이통사';
    Cells[3,0]    := '모델명 ';
    Cells[4,0]    := '일련번호';
    Cells[5,0]    := '이동전화번호';
    Cells[6,0]    := '가입자성명';
    Cells[7,0]    := '가입자생년월일';
    Cells[8,0]    := '가입자연락처';
    Cells[9,0]    := '보험금신청일자';
    Cells[10,0]   := '지급중지일자';
    Cells[11,0]   := '승인일자';
    Cells[12,0]   := '보험금지급액';
    Cells[13,0]   := '입출고구분';
    Cells[14,0]   := '입고일자';
    Cells[15,0]   := '입고상태';
    Cells[16,0]   := '접수우체국';
    Cells[17,0]   := '출고처리구분';
    Cells[18,0]   := '승인후입고여부';
    Cells[19,0]   := '단말기처리상태';
  end;
end;

procedure Tfrm_LOSTE210Q.setEdtKeyPress;
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

procedure Tfrm_LOSTE210Q.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE210Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTE210Q.FormCreate(Sender: TObject);
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
//    common_userid:= '0294';     //ParamStr(2);
//    common_username:= '정호영'; //ParamStr(3);
//    common_usergroup:= 'KAIT';  //ParamStr(4);

    initSkinForm(SkinData1); //common_lib.pas에 있다.

    initComboBoxWithZ0xx('Z085.dat',cmb_insu_cmp_d ,'전체','',cmb_insu_cmp     );
    initComboBoxWithZ0xx('Z086.dat',cmb_gbn_inout_d,'전체','',cmb_gbn_inout    );
    initComboBoxWithZ0xx('Z087.dat',cmb_in_sts_d   ,'전체','',cmb_in_sts       );
    initComboBoxWithZ0xx('Z041.dat',cmb_out_gbn_d  ,'전체','',cmb_out_gbn      );
    initComboBoxWithZ0xx('Z088.dat',cmb_insu_gbn_d ,'전체','',cmb_insu_gbn     );

    initStrGrid;	//그리드 초기화

    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
  end;
end;

procedure Tfrm_LOSTE210Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno : String;

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

  RowPos                := 1;	//그리드 레코드 포지션
  grd_display.RowCount  := 2;

  pInitStrGrd(Self);

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
	if (TMAX.SendString('INF002',common_userid                                  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                                ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                               ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003',PGM_ID                                         ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)                      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)                        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_insu_cmp_d[cmb_insu_cmp.itemIndex].code   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', IntToStr(cmb_gbn_dt.itemIndex)                ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', Trim(edt_nm.Text)                             ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', Trim(delHyphen(mskEdt_cell_num.Text))         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', cmb_gbn_inout_d[cmb_gbn_inout.itemIndex].code ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', cmb_in_sts_d[cmb_in_sts.itemIndex].code       ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', cmb_out_gbn_d[cmb_out_gbn.itemIndex].code     ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', cmb_insu_gbn_d[cmb_insu_gbn.itemIndex].code   ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR011', Copy(cmb_allow_in.Items.Strings[cmb_allow_in.itemIndex],21,1)) < 0) then  goto LIQUIDATION;

   //서비스 호출
   if not TMAX.Call(PGM_ID) then
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
      Cells[0  ,RowPos]   := IntToStr(i+1);
      Cells[1  ,RowPos]   := TMAX.RecvString('STR101',i);
      Cells[2  ,RowPos]   := TMAX.RecvString('STR102',i);
      Cells[3  ,RowPos]   := TMAX.RecvString('STR103',i);
      Cells[4  ,RowPos]   := TMAX.RecvString('STR104',i);
      seed_mtno           := TMAX.RecvString('STR105',i);
      Cells[5  ,RowPos]   := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
      seed_ganm           := TMAX.RecvString('STR106',i);
      Cells[6  ,RowPos]   := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
      seed_gano           := TMAX.RecvString('STR107',i);
      Cells[7  ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gano, common_seedkey),'2-2-2');
      seed_gatl           := TMAX.RecvString('STR108',i);
      Cells[8  ,RowPos]   := InsHyphen(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
      Cells[9  ,RowPos]   := InsHyphen(TMAX.RecvString('STR109',i));
      Cells[10 ,RowPos]   := InsHyphen(TMAX.RecvString('STR110',i));
      Cells[11 ,RowPos]   := InsHyphen(TMAX.RecvString('STR111',i));
      Cells[12 ,RowPos]   := convertWithCommer(IntToStr(Round(TMAX.RecvDouble('DBL112',i))));
      Cells[13 ,RowPos]   := TMAX.RecvString('STR113',i);
      Cells[14 ,RowPos]   := InsHyphen(TMAX.RecvString('STR114',i));
      Cells[15 ,RowPos]   := TMAX.RecvString('STR116',i);
      Cells[16 ,RowPos]   := TMAX.RecvString('STR117',i);
      Cells[17 ,RowPos]   := TMAX.RecvString('STR118',i);
      Cells[18 ,RowPos]   := TMAX.RecvString('STR119',i);
      Cells[19 ,RowPos]   := TMAX.RecvString('STR120',i);

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

procedure Tfrm_LOSTE210Q.FormShow(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE210Q.btn_queryClick(Sender: TObject);
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

procedure Tfrm_LOSTE210Q.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfrm_LOSTE210Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTE210Q.Copy1Click(Sender: TObject);
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

procedure Tfrm_LOSTE210Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      1,2,3,6,8,13,17: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,4,5,7,9,10,11,14,15,16,18,19: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);

    end;
  end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTE210Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTE210Q.btn_resetClick(Sender: TObject);
begin
  InitComponent;
end;

procedure Tfrm_LOSTE210Q.InitComponent;
var i : Integer;
begin
  dte_from.Date := date-30;
	dte_to.Date   := date;

  changeBtn(Self);

  btn_Print.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';

  //dte_from.SetFocus;
end;

end.
