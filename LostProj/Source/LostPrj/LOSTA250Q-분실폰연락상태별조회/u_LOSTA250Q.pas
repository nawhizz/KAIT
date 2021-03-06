unit u_LOSTA250Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg,
  so_tmax, WinSkinData,common_lib, Menus, Clipbrd, Func_Lib, ComObj;

const
  TITLE   = '연락결과 상태별 조회';
  PGM_ID  = 'LOSTA250Q';

type
  Tfrm_LOSTA250Q = class(TForm)
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
    Bevel1: TBevel;
    Panel2: TPanel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    dte_to: TDateEdit;
    dte_from: TDateEdit;
    cmb_can: TComboBox;
    grd_display: TStringGrid;
    Bevel4: TBevel;
    Label5: TLabel;
    cmb_ph_yn: TComboBox;
    Label7: TLabel;
    Bevel5: TBevel;
    cmb_bl_gu: TComboBox;
    Label4: TLabel;
    lbl_kt: TLabel;
    Label8: TLabel;
    lbl_lg: TLabel;
    Bevel6: TBevel;
    Bevel8: TBevel;
    Label9: TLabel;
    lbl_nk_cell: TLabel;
    Bevel9: TBevel;
    Bevel11: TBevel;
    Label12: TLabel;
    lbl_sk: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    PopupMenu1: TPopupMenu;
    Label6: TLabel;
    Label10: TLabel;
    Bevel7: TBevel;
    lbl_total: TLabel;
    Label13: TLabel;
    Bevel10: TBevel;
    lbl_nk_pcs: TLabel;
    Label15: TLabel;
    Bevel12: TBevel;
    cOPY1: TMenuItem;
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
    lbl_Program_Name: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cmb_ph_ynChange(Sender: TObject);
    procedure cmb_canChange(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grd_displayDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure btn_InquiryClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
    procedure InitComponents();
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
  private
    { Private declarations }
    //그리드 초기화
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;
  public
    { Public declarations }
  end;

procedure ButtonInit; forward;

var
  frm_LOSTA250Q: Tfrm_LOSTA250Q;
  cmb_bl_gu_d : TZ0xxArray;
  qryStr:String;

implementation
{$R *.DFM}

procedure Tfrm_LOSTA250Q.InitComponents;
var
  i : Integer;
  component : TComponent;

begin

  qryStr:= '';
  
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if((Pos('lbl_',(component as TLabel).Name) > 0) AND (Pos('lbl_Prog',(component as TLabel).Name) = 0)) then (component as TLabel).Caption := '';
  end;

  //버튼 이미지 초기화
  changeBtn(Self);

  if common_usergroup = 'SYSM' then
    btn_query.Enabled := True;

  for i:= grd_display.FixedRows to grd_display.RowCount -1 do
    grd_display.Rows[i].Clear;

  //그리드 초기화
  initStrGrid;

  dte_from.Date := date-30;
  dte_to.Date   := date;

  cmb_ph_yn.ItemIndex := 0;
  cmb_can.ItemIndex   := 0;
  cmb_bl_gu.ItemIndex := 0;
  cmb_ph_yn.Enabled   := false;
  cmb_bl_gu.Enabled   := false;

  sts_Message.Panels[1].Text := ' ';
end;

procedure Tfrm_LOSTA250Q.disableComponents;
begin
	  dte_from.Enabled  := false;
    dte_to.Enabled    := false;
    btn_excel.Enabled := False;
    btn_close.Enabled := False;
end;

procedure Tfrm_LOSTA250Q.enableComponents;
begin
	  dte_from.Enabled  := True;;
    dte_to.Enabled    := True;;
    btn_excel.Enabled := True;;
    btn_close.Enabled := True;;
end;

//OnExit --- dte_to
procedure Tfrm_LOSTA250Q.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then begin
		showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
		exit;
	end;
end;

//OnExit --- dte_from
procedure Tfrm_LOSTA250Q.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
  begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
  end;
end;

//그리드의 첫번째 라인(메목)을 이쁘게 튜닝한다.
procedure Tfrm_LOSTA250Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    grid.Canvas.Font.Color  := clBlack;
    grid.Canvas.FillRect(Rect);
    DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
  end
  else
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
      case ACol of
        2..6,8..12: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
        0,1,7: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      end;
    end;
end;


//각 필드의 폭은 실제 실행, 확인 후 재 조정할 것.
procedure Tfrm_LOSTA250Q.initStrGrid;
begin
	with grd_display do begin
    RowCount      :=  2;
    ColCount      := 15;
    RowHeights[0] := 21;

    Cells[0,0] := 'SEQ';
    Cells[1,0] := '입고일자';
    Cells[2,0] := '성명(업체명)';
    Cells[3,0] := '사업자명';
    Cells[4,0] := '주민/외국인/사업자번호';
    Cells[5,0] := '연락상태';
    Cells[6,0] := '처리구분';
    Cells[7,0] := '연락전화번호';
    Cells[8,0] := '우편번호';
    Cells[9,0] := '주소';
    Cells[10,0] := '모델';
    Cells[11,0] := 'serial';
    Cells[12,0] := '분실핸드폰번호';
    Cells[13,0] := '적요';
    Cells[14,0] := '보험금상태';

    ColWidths[0] := 45;
    ColWidths[1] := 80;
    ColWidths[2] := 80;
    ColWidths[3] := 85;
    ColWidths[4] := 160;
    ColWidths[5] := 75;
    ColWidths[6] := 70;
    ColWidths[7] := 105;
    ColWidths[8] := 60;
    ColWidths[9] := 300;
    ColWidths[10] := 65;
    ColWidths[11] := 65;
    ColWidths[12] := 120;
    ColWidths[13] := 200;
    ColWidths[14] := 120;

  end;
end;

procedure ButtonInit;
begin
//
end;

procedure Tfrm_LOSTA250Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA250Q.FormCreate(Sender: TObject);
begin

   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
   {    }
	if ParamCount <> 6 then
  begin
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
  // common_userid     := '0294';    //ParamStr(2);
  // common_username   := '정호영';  //ParamStr(3);
  // common_usergroup  := 'SYSM';    //ParamStr(4);

    {----------------------- 공통 어플리케이션 설정 ---------------------------}

    // 프로그램 캡션 설정
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // 테스크바 캡션설정
    Application.Title := TITLE;

    // 프로그램 내부 캡션 설정
    lbl_Program_Name.Caption := TITLE;

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

    initComboBoxWithZ0xx('Z071',cmb_bl_gu_d,'전체','',cmb_bl_gu);

    InitComponents;

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA250Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   //Capiend;
end;

procedure Tfrm_LOSTA250Q.FormShow(Sender: TObject);
begin

end;

// 연락상태 변경시 실행(2)
procedure Tfrm_LOSTA250Q.cmb_ph_ynChange(Sender: TObject);
begin
     case cmb_ph_yn.ItemIndex of
     0,2 : begin
             cmb_bl_gu.Enabled := false;
             cmb_bl_gu.ItemIndex := 0;
           end;
     1   : begin
             cmb_bl_gu.Enabled := True;
           end;

     end;
end;

// 연락 가부 콤보변경시 실행(1)
procedure Tfrm_LOSTA250Q.cmb_canChange(Sender: TObject);
begin
     case cmb_can.ItemIndex of
     0,1 :
       begin
          cmb_ph_yn.Enabled := False;
          cmb_bl_gu.Enabled := False;

          cmb_ph_yn.ItemIndex := 0;
          cmb_bl_gu.ItemIndex := 0;
       end;
     2 :
       begin
          cmb_ph_yn.Enabled := True;
          cmb_bl_gu.Enabled := False;

          cmb_bl_gu.ItemIndex := 0;
       end

     end;
end;

//팝업메뉴(마우스의 오른쪽버튼을 클릭) -- 그리드의 내용을 클립보드에 복사
procedure Tfrm_LOSTA250Q.Copy1Click(Sender: TObject);
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

//'엑셀'버튼 클릭 --- 그리드의 내용을 엑셀로 변경후 화면에 보여진다.
//'Proc_gridtoexcel' 프로시저는 Func_Lib.pas 에 있다.
procedure Tfrm_LOSTA250Q.btn_excelClick(Sender: TObject);
begin
	Proc_gridtoexcel('조회관리(LOSTA250Q)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA250Q');
end;

//CTRL+C 를 눌렀을 경우 그리드의 내용을 클립보드에 복사한다.
procedure Tfrm_LOSTA250Q.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then Copy1Click(Sender);
end;

procedure Tfrm_LOSTA250Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    seq,RowPos:Integer;

    STR004 : String;
    STR005 : String;
    STR006 : String;
    STR007 : String;
    STR008 : String;
    STR009 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_ganm := '';
    seed_gano := '';
    seed_gatl := '';
    seed_mtno := '';

	//그리드 디스플레이
    seq                   := 1; 	//순번
    RowPos                := 1;	  //그리드 레코드 포지션
    grd_display.RowCount  := 2;

    qryStr := '';    

    //시작시변수 초기화
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';

    totalCount :=0;

    pInitStrGrd(Self);

    grd_display.Cursor := crSQLWait;	//작업중....

    //작업중 다른 기능 잠시 중지.
    disableComponents;


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

//분기점....
//    if z001Data[cmb_id_cd.ItemIndex].name <> '전체' then
//    	goto INQUIRY;

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid                                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                                  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                                 ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA250Q'                                      ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                                            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)                        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', Copy(cmb_can.Items.Strings[cmb_can.itemindex],41,1)        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', Copy(cmb_ph_yn.Items.Strings[cmb_ph_yn.itemindex],41,1)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_bl_gu_d[cmb_bl_gu.itemIndex].code    ) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA250Q') then goto LIQUIDATION;

  lbl_total.Caption   := convertWithCommer(TMAX.RecvString('INT101',0));
  lbl_kt.Caption	    := convertWithCommer(TMAX.RecvString('INT102',0));
  lbl_lg.Caption	    := convertWithCommer(TMAX.RecvString('INT103',0));
  lbl_sk.Caption	    := convertWithCommer(TMAX.RecvString('INT104',0));
  lbl_nk_cell.Caption := convertWithCommer(TMAX.RecvString('INT105',0));
  lbl_nk_pcs.Caption  := convertWithCommer(TMAX.RecvString('INT106',0));

//	Goto LIQUIDATION;

//내역조회
INQUIRY:
	TMAX.InitBuffer;

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid             ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA250Q'               ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'                     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text) ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', Copy(cmb_can.Items.Strings[cmb_can.itemindex],41,1)        ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', Copy(cmb_ph_yn.Items.Strings[cmb_ph_yn.itemindex],41,1)    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', cmb_bl_gu_d[cmb_bl_gu.itemIndex].code    ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR006', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', STR006) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', STR007) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR010', STR008) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', STR009) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA250Q') then goto LIQUIDATION;

  // 서버의 쿼리 카운트
  count1 := TMAX.RecvInteger('INF013',0);

  // 내부 총계
  totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        	Cells[0,RowPos] := intToStr(seq);

          (*  입고일자       *)  Cells[1,RowPos]  := TMAX.RecvString('STR101',i);
          (*  성명(업체명)   *)  seed_ganm        := TMAX.RecvString('STR102',i);
                                 Cells[2,RowPos]  := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
          (*  사업자식별코드 *)  Cells[3,RowPos]  := TMAX.RecvString('STR116',i);
        	(*  주민사업자번호 *)  seed_gano        := TMAX.RecvString('STR103',i);
        	                       Cells[4,RowPos]  := ECPlazaSeed.Decrypt(seed_gano, common_seedkey);
        	(*  연락상태       *)  Cells[5,RowPos]  := TMAX.RecvString('STR104',i);
        	(*  처리구분코드   *)  //Cells[5,RowPos]  := TMAX.RecvString('STR105',i);
        	(*  처리구분명     *)  Cells[6,RowPos]  := TMAX.RecvString('STR106',i);
        	(*  연락전화번호   *)  seed_gatl        := TMAX.RecvString('STR107',i);
        	                       Cells[7,RowPos]  := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
        	(*  우편번호       *)  Cells[8,RowPos]  := TMAX.RecvString('STR108',i);
        	(*  주소           *)  Cells[9,RowPos]  := TMAX.RecvString('STR109',i);
        	(*  모델코드       *)  //Cells[10,RowPos] := TMAX.RecvString('STR110',i);

        	(*  모델명         *)  Cells[10,RowPos] := TMAX.RecvString('STR111',i);
        	(*  단말기일련번호 *)  Cells[11,RowPos] := TMAX.RecvString('STR112',i);

        	(*  분실핸드폰번호 *)  seed_mtno        := TMAX.RecvString('STR113',i);
        	                       Cells[12,RowPos] := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
        	(*  적요           *)  Cells[13,RowPos] := TMAX.RecvString('STR114',i);
        	(*  보험금 상태    *)  Cells[14,RowPos] := TMAX.RecvString('STR115',i);

          (* 조회시작입고일자      *)  STR004 := delHyphen(TMAX.RecvString('STR101',i));
          (* 조회시작성명          *)  STR005 := Trim(TMAX.RecvString('STR102',i));
          (* 조회시작모델코드      *)  STR006 := Trim(TMAX.RecvString('STR110',i));
          (* 조회시작단말기일련번호*)  STR007 := Trim(TMAX.RecvString('STR112',i));
          (* 조회시작사업자식별코드*)  STR008 := Trim(TMAX.RecvString('STR115',i));
          (* 조회시작처리구분코드  *)  STR009 := Trim(TMAX.RecvString('STR105',i));

          Inc(seq);
          Inc(RowPos);
      end;
    end;

    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    count2 := TMAX.RecvInteger('INT100',0);
    if count1 = count2 then goto INQUIRY;

    // 쿼리를 담는다.
    qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료

    if totalCount <> 0 then
      grd_display.RowCount := grd_display.RowCount -1;
      
    enableComponents;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTA250Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA250Q.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA250Q.btn_queryClick(Sender: TObject);
var
	cmdStr    :String;
  filePath  :String;
  f         :TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\' + PGM_ID + 'QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
