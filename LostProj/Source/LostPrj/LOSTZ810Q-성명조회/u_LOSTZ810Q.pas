{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ810Q (성명 조회)
프로그램 종류 : Online
작성자	      : KOO NAE YOUNG
작성일	      : 2011. 09. ##
완료일	      : ####. ##. ##
프로그램 개요 : 성명(업체명)을 조회한다.

-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ810Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud, ComObj;

const
  TITLE   = '성명 조회';
  PGM_ID  = 'LOSTZ810Q';

type
  Tfrm_LOSTZ810Q = class(TForm)
    GroupBox1  : TGroupBox;
    Label12    : TLabel;
    Panel3     : TPanel;
    pnl_Command: TPanel;
    Panel1     : TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SkinData1  : TSkinData;
    sts_Message: TStatusBar;
    grd_display: TStringGrid;
    TMAX       : TTMAX;
    Panel2: TPanel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    Bevel1: TBevel;
    jo_gu_label: TLabel;
    edt_Inq_Str: TEdit;
    search_condition_cb: TComboBox;
    cmb_model_cb: TComboBox;
    serial_edit: TEdit;
    serial_no_pnl: TPanel;
    edt_phone_no: TMaskEdit;
    edt_birth_date: TEdit;
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
    procedure btn_InquiryClick(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);
    procedure search_condition_cbChange(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure cmb_model_cbKeyPress(Sender: TObject; var Key: Char);
    procedure search_condition_cbKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure onKeyPress(Sender : TObject; var key : Char);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

  private
    { Private declarations }
    cmb_model_cb_d:TZ0xxArray;
    searchCondition:Integer; 	//검색조건, 1=성명, 2=날짜, 3= 폰번, 4=모델명+시리얼번호
    STR005:String;	//외부로 받는 검색조건
    isData:Boolean;	//스트링 그리드에 데이터가 있다.
    grdFocousEnable:Boolean;	//스트링그리드에 포커스가 가능한가?

  public
    { Public declarations }
    procedure initComponents;
    procedure unvisiableComponents;
    procedure initStrGrid;
  end;

var
  frm_LOSTZ810Q: Tfrm_LOSTZ810Q;
  qrystr : STring;

implementation
{$R *.DFM}

//그리드의 첫번째 라인(메목)을 이쁘게 튜닝한다.
procedure Tfrm_LOSTZ810Q.grd_displayDrawCell(Sender: TObject; ACol,
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
    end else
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
  begin
    case ACol of
      1,3,5,7,9,10 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      0,2,4,6,8,11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
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

procedure Tfrm_LOSTZ810Q.initStrGrid;
begin
	with grd_display do begin
    RowCount      :=2;
    ColCount      := 12;
    RowHeights[0] := 21;

    ColWidths[0] := 42;
		Cells[0,0] :='SEQ';

    ColWidths[1] := 80;
		Cells[1,0] :='성명(업체명)';

    ColWidths[2] := 110;
		Cells[2,0] :='주민사업자번호';

    //ColWidths[3] := 100;
		//Cells[3,0] :='처리구분코드';

    ColWidths[3] := 80;
		Cells[3,0] :='처리구분명';

    ColWidths[4] := 120;
		Cells[4,0] :='보험금상태';

    ColWidths[5] := 82;
		Cells[5,0] :='모델명';

    ColWidths[6] := 95;
		Cells[6,0] :='단말기일련번호';

    ColWidths[7] := 95;
		Cells[7,0] :='분실핸드폰번호';

    ColWidths[8] := 80;
		Cells[8,0] :='입고일자';

    ColWidths[9] := 100;
		Cells[9,0] :='전화번호';

    ColWidths[10] := 350;
		Cells[10,0] :='주소';

    ColWidths[11] := 60;
		Cells[11,0] :='우편번호';
  end;

end;

//모든 콤포넌트 숨기기
procedure Tfrm_LOSTZ810Q.unvisiableComponents;
begin
	//성명
	edt_Inq_Str.Visible     := false;
	jo_gu_label.Visible     := false;
	Bevel1.Visible          := false;
	GroupBox1.Visible       := false;

	//생년월일(1):
	edt_birth_date.Visible  := false;

	//분실핸드폰번호(2):
	edt_phone_no.Visible    := false;

	//모델명+일련번호(3):
	cmb_model_cb.Visible    := false;
	serial_edit.Visible     := false;
  serial_no_pnl.Visible   := false;
end;

//콤포넌트 자리 재 배치
procedure Tfrm_LOSTZ810Q.initComponents;
var
  i : Integer;
	compTop:Integer;
begin
  changeBtn(Self);

  qrystr := '';

 if common_usergroup = 'SYSM' then btn_query.Enabled;

  //스트링그리드에 데이터가 없다.
  isData:= False;

  edt_phone_no.Text := '';



  btn_Print.Enabled := false;
  btn_excel.Enabled := false;

  edt_Inq_Str.Text        := '';
  edt_phone_no.Text       := '';
  cmb_model_cb.ItemIndex  := 0;
  edt_birth_date.Text     := '';
  serial_edit.Text        := '';

  compTop             := edt_Inq_Str.Top;
  edt_birth_date.Top  := compTop;		        //생년월일
  edt_phone_no.Top    := compTop;	          //분실핸드폰번호
  cmb_model_cb.Top    := compTop; 	        //모델명+시리얼번호
  serial_edit.Top     := compTop;		        //
  serial_no_pnl.Top   := compTop-1;

  for i := grd_display.FixedRows to grd_display.RowCount - 1 do
    grd_display.Rows[i].Clear;

  initStrGrid;
end;

procedure Tfrm_LOSTZ810Q.FormCreate(Sender: TObject);
begin
	  initSkinForm(SkinData1); //common_lib.pas에 있다.

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);
    STR005            := ParamStr(6);	//호출하는 프로그램에 따라 값이 달라진다.

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 내부 캡션 설정
  Label12.Caption := TITLE;

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

  //콤보박스 'cmb_model_cb'에 모델정보를 채운다.
  initComboBoxWithZ0xx('Z008.dat', cmb_model_cb_d, '','',  cmb_model_cb);

  serial_edit.OnKeyPress    := Self.onKeyPress;
  edt_phone_no.OnKeyPress   := Self.onKeyPress;
  edt_birth_date.OnKeyPress := Self.onKeyPress;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ810Q.btn_CloseClick(Sender: TObject);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 0, 0);
  PostMessage(self.Handle, WM_QUIT, 0,0);
end;

//'조회' 버튼 클릭
procedure Tfrm_LOSTZ810Q.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

    i:Integer;
    count1, count2, totalCount:Integer;
    seq,RowPos:Integer;
    STR001,STR002,STR003,STR004:String;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    seed_idnm := '';
    seed_idno := '';
    seed_tlno := '';
    seed_mtno := '';

	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    totalCount := 0;
    grd_display.RowCount := 2;
    grd_display.FixedRows:=1;
    isData := False; //스트링 그리드에 데이터가 없다.

    grd_display.Cursor := crSQLWait;	//작업중....
    //disableComponents;	//작업중 다른 기능 잠시 중지.

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

//SEED KEY 조회
SEEDKEY:

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //서비스 호출
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키

//내역조회
INQUIRY:

{
STR005;
<조회쿼리구분>
외부에서 본 프로그램을 호출시 변수로 전달한다.

01: 핸드폰 분실자(전체)
02: 핸드폰 분실자(수취확인)
11: 핸드폰 습득자(전체)

12: 핸드폰 습득자(사은품 미발송)
13: 핸드폰 습득자(사은품 발송대상)

}

	TMAX.InitBuffer;

	STR001:= intToStr(searchCondition);
	STR002:=' ';
	STR003:='1';
	STR004:='1';

    case searchCondition of
    	1:	begin	//성명
        		STR002 := Trim(edt_Inq_Str.Text);

            if RadioButton1.Checked then
              STR004:= '1'
            else
              STR004:= '2';
        	end;

        2:	begin
        		STR002 :=  delHyphen(Trim(edt_birth_date.Text));  //1973-08-16 ==> 19630816
        	end;

        3,5:  begin
        		STR002 := delHyphenPhone(edt_phone_no.Text);
        	end;

        4:  begin
        		STR002 := findCodeFromName(cmb_model_cb.Text, cmb_model_cb_d, cmb_model_cb.Items.Count);
                STR003 := Trim(serial_edit.Text);
                STR004:= '2';
        	end;
    end;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ810Q'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ810Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

	count1 := TMAX.RecvInteger('INT100',0);
    if count1 >0 then
    	isData:= True;	//스트링그리드에 데이터가 있다.

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin
        Cells[ 0,RowPos] := intToStr(seq);	                    // 순번
        seed_idnm        := TMAX.RecvString('STR101',i);	      // 성명(업체명)
        Cells[ 1,RowPos] := ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
        seed_idno        := TMAX.RecvString('STR102',i);	      // 주민사업자번호
        Cells[ 2,RowPos] := ECPlazaSeed.Decrypt(seed_idno, common_seedkey);
        //Cells[3,RowPos] := TMAX.RecvString('STR103',i);	      // 처리구분코드
        Cells[ 3,RowPos] := TMAX.RecvString('STR104',i);		    // 처리구분명
        Cells[ 4,RowPos] := TMAX.RecvString('STR113',i);	      // 보험금상태
        Cells[ 5,RowPos] := TMAX.RecvString('STR106',i);		    // 모델명
        Cells[ 6,RowPos] := TMAX.RecvString('STR107',i);		    // 단말기일련번호
        seed_mtno        := TMAX.RecvString('STR112',i);	      // 분실핸드폰번호
        Cells[ 7,RowPos] := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
        Cells[ 8,RowPos] := TMAX.RecvString('STR108',i);		    // 입고일자
        seed_tlno        := TMAX.RecvString('STR109',i);		    // 전화번호
        Cells[ 9,RowPos] := ECPlazaSeed.Decrypt(seed_tlno, common_seedkey);
        Cells[10,RowPos] := Trim(TMAX.RecvString('STR110',i));	// 주소
        Cells[11,RowPos] := Trim(TMAX.RecvString('STR111',i));	// 우편번호

        Inc(seq);
        Inc(RowPos);
      end;
    end;

    // 쿼리를 담는다.
    qryStr:= TMAX.RecvString('INF014',0);

    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

   // count2 := TMAX.RecvInteger('INT100',0);
   // if count1 = count2 then
   // 	goto INQUIRY;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor    := crDefault;	//작업완료
  grd_display.RowCount  := grd_display.RowCount -1;

  if grdFocousEnable then
    grd_display.SetFocus;	//스트링 그리드로 포커스 이동
//    enableComponents;
end;

//On-KeyPress => edt_inq_str, 성명으로 조회
procedure Tfrm_LOSTZ810Q.edt_Inq_StrKeyPress(Sender: TObject;  var Key: Char);
begin
	edt_inq_str.OnKeyPress := nil;

	if key = #13 then begin
		btn_InquiryClick(self);	//'조회' 버튼 클릭
    end;

	edt_inq_str.OnKeyPress := edt_inq_strKeyPress;
end;

//On-KeyPress => 스트링 그리드
procedure Tfrm_LOSTZ810Q.grd_displayKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then
		btn_LinkClick(self)	//'선택' 버튼 클릭
end;

//'조회조건' 값이 변경된 경우
procedure Tfrm_LOSTZ810Q.search_condition_cbChange(Sender: TObject);
begin
	//모든 콤포넌트를 숨긴다.
    unvisiableComponents  ;
    searchCondition:= search_condition_cb.ItemIndex + 1;

    Case  search_condition_cb.ItemIndex of
        0:  							//성명
        begin
        	edt_Inq_Str.Visible   := True;
           edt_Inq_Str.SetFocus;
          jo_gu_label.Visible   := True;
          Bevel1.Visible        := True;
          GroupBox1.Visible     := True;
        end;
        1:
        begin
        	edt_birth_date.Visible     := True;  	//생년월일
            edt_birth_date.SetFocus;
        end;

        2,4:
        begin
        	edt_phone_no.Visible  := True;	//분실핸드폰번호
          edt_phone_no.SetFocus;
          edt_phone_no.Text := '';

          if search_condition_cb.ItemIndex = 2 then
            edt_phone_no.EditMask := 'aaa-aaaa-aaaa;0;'
          else
            edt_phone_no.EditMask := 'aaaa-aaaa-aaaa;0;';
        end;
        3: 								//모델명+일련번호
        begin
        	cmb_model_cb.Visible  := True;
          cmb_model_cb.SetFocus;
          serial_edit.Visible   := True;
          serial_no_pnl.Visible := True;
        end;
    end;
end;

procedure Tfrm_LOSTZ810Q.FormShow(Sender: TObject);
var
	str1, str2:String;
begin
  //콤포넌트 자리 재 배치
  initComponents;

  if (ParamStr(8) <> '') then
  begin

    searchCondition                 := StrToInt(ParamStr(7));
    search_condition_cb.ItemIndex   := searchCondition-1;		//검색조건을 셋팅

    str1:= fRNVL(ParamStr(8));
    str2:= fRNVL(ParamStr(9));
    if str1 = 'dummy' then str1:='';
    if str2 = 'dummy' then str2:='';

    search_condition_cbChange(search_condition_cb);			    //보여주는 콤포넌트를 교환

    case searchCondition of
      1: edt_Inq_Str.Text         := str1;			//성명으로 검색
      2: edt_birth_date.Text      := str1;			//날짜로 검색
      3,5: edt_phone_no.Text      := StringReplace(str1,'_',' ',[rfReplaceAll]);
      4: begin cmb_model_cb.Text  := str1;      //모델명+시리얼번호로 검색
               serial_edit.Text   := str2;
         end;
    end;

    grdFocousEnable:= False;

    if (str1 <> '') then
      btn_InquiryClick(self); 	//'조회' 버튼 클릭
  end else
  begin
    grdFocousEnable     := True;
    searchCondition     := 1;
    edt_birth_date.Text := '';
    search_condition_cbChange(search_condition_cb);			    //보여주는 콤포넌트를 교환
  end;
  
  if ParamStr(8) <> '' then
  begin
    grd_display.SetFocus;
    grdFocousEnable := True;
  end else
    search_condition_cb.SetFocus;

end;

//'선택' 버튼 클릭
procedure Tfrm_LOSTZ810Q.btn_LinkClick(Sender: TObject);
var
  smem:TPSharedMem;
  str_tmp:String;

  currentYear:Integer;
  year1, year2:Integer;

begin
  if not isData then begin 			//스트링 그리드에 데이터가 없으면
    search_condition_cb.SetFocus;	//'검색조건' 콤보박스로 이동
    exit;
  end;

//  currentYear := strToInt(firstString(DateToStr(Date),'-')) - 5;
//  str_tmp     := Trim(firstString(grd_display.Cells[2,grd_display.Row],'-'));	//생년월일 계산용
//  year1       := StrToInt('20'+ Copy(str_tmp,1,2));
//
//  if year1 > currentYear then
//    year1:= StrToInt('19'+ Copy(str_tmp,1,2));

	//공유메모리를 얻는다.
	smem:= OpenMap;

	if smem <> nil then begin
    Lock;  //동시 접속방지

    smem^.name        := grd_display.Cells[1,grd_display.Row];				      //성명(업체명)
    str_tmp           := Trim(grd_display.Cells[5,grd_display.Row]);        //모델명
    smem^.model_name  := str_tmp;
    smem^.model_code  := findCodeFromName(str_tmp,cmb_model_cb_d,cmb_model_cb.Items.Count); //모델코드
    smem^.serial_no   := grd_display.Cells[6,grd_display.Row];		   	      //단말기일련번호
    smem^.ibgo_date   := grd_display.Cells[8,grd_display.Row];		   	      //입고일자

//    str_tmp           := Trim(firstString(grd_display.Cells[2,grd_display.Row],'-'));	//생년월일 계산용
//    str_tmp           := IntToStr(year1)+ Copy(str_tmp,3, Length(str_tmp)-2);
//    smem^.birth       := InsHyphen(str_tmp);					   			              //생년월일
    smem^.birth       := delHyphen(Copy(grd_display.Cells[2,grd_display.Row],0,8));
    smem^.phone_no    := grd_display.Cells[7,grd_display.Row];		   	      //분실핸드폰번호
    smem^.phone_no2   := grd_display.Cells[9,grd_display.Row];		   	      //전화번호

    UnLock;
  end;

	if STR005 = '12' then //LOSTB130P.EXE에서 호출
    	//패런트 윈도우를 호출
		PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, searchCondition)
	else
		PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, 0);

  //공유메모리를 닫는다.
  CloseMap;

  //자신을 닫는다.
  PostMessage(self.Handle, WM_QUIT, 0,0);
end;

//On-KeyPress =>모델코드 콤보박스
procedure Tfrm_LOSTZ810Q.cmb_model_cbKeyPress(Sender: TObject; var Key: Char);
begin
	if key = #13 then begin
		serial_edit.SetFocus;	//시리얼번호로 포커스 이동
    end;
end;

//On-KeyPress =>검색조건 콤보박스
procedure Tfrm_LOSTZ810Q.search_condition_cbKeyPress(Sender: TObject;  var Key: Char);
begin
	if key = #13 then begin
    	Case self.searchCondition of
        1: edt_Inq_Str.SetFocus;
        2: edt_birth_date.SetFocus;
        3: edt_phone_no.SetFocus;
        4: cmb_model_cb.SetFocus;
        end;
    end;
end;

//On-KeyPressUp =>스트링 그리드
procedure Tfrm_LOSTZ810Q.grd_displayKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
    if key = vk_F2 then
    	search_condition_cb.SetFocus;	//'검색조건' 콤보박스로 포커스이동
end;

procedure Tfrm_LOSTZ810Q.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 0, 0);
  PostMessage(self.Handle, WM_QUIT, 0,0);

end;

procedure Tfrm_LOSTZ810Q.onKeyPress(Sender : TObject;var Key : char);
begin
  if key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'9',#8,#9,'-']) then key := #0;

end;

procedure Tfrm_LOSTZ810Q.btn_resetClick(Sender: TObject);
begin
  self.initComponents;
end;

procedure Tfrm_LOSTZ810Q.btn_queryClick(Sender: TObject);
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

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ810Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

    if (TStringGrid(Sender).Cells[ 4, ARow] <> '') and (ACol = 4)then
    begin
      TStringGrid(Sender).Canvas.Brush.Color := clPurple;
      TStringGrid(Sender).Canvas.Font.Color  := clWhite;
    end;

    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;
end.
