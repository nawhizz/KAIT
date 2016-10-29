unit u_LOSTT110P;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, so_tmax, StdCtrls, ComCtrls, Mask, ToolEdit, Buttons, ExtCtrls,
  common_lib,Grids, WinSkinData,u_LOSTT110P_CHILD, ComObj;

const
  TITLE   = '상 담 원   설 문 결 과   등 록';
  PGM_ID  = 'LOSTT110P';

type

  Tfm_LOSTT110P = class(TForm)
    cmb_gen_st    : TComboBox;
    cmb_gen_ed    : TComboBox;
    cmb_gbn_loc   : TComboBox;
    cmb_gbn_saup  : TComboBox;
    cmb_gbn_lstPh : TComboBox;
    cmb_dt_gbn    : TComboBox;
    cmb_topic     : TComboBox;
    cmb_gbn_sel   : TComboBox;
    cmb_gbn_target: TComboBox;
    dte_ip_dt_st  : TDateEdit;
    dte_ip_dt_ed  : TDateEdit;
    dte_dt_ed     : TDateEdit;
    dte_dt_st     : TDateEdit;
    grp1          : TGroupBox;
    GroupBox1     : TGroupBox;
    GroupBox2     : TGroupBox;
    pnl_Program_Name: TLabel;
    Label1        : TLabel;
    Label3        : TLabel;
    Label2        : TLabel;
    Panel3        : TPanel;
    Panel10       : TPanel;
    Panel12       : TPanel;
    Panel1        : TPanel;
    Panel2        : TPanel;
    pnl_Command   : TPanel;
    Panel5        : TPanel;
    Panel4        : TPanel;
    Panel13       : TPanel;
    Panel6        : TPanel;
    Panel7        : TPanel;
    Panel11       : TPanel;
    Panel14       : TPanel;
    Panel8        : TPanel;
    Panel9        : TPanel;
    rb2           : TRadioButton;
    rb1           : TRadioButton;
    rb3           : TRadioButton;
    rb4           : TRadioButton;
    SkinData1     : TSkinData;
    sts_Message   : TStatusBar;
    grd_display   : TStringGrid;
    TMAX          : TTMAX;
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

    procedure FormCreate          (Sender: TObject);
    procedure btn_CloseClick      (Sender: TObject);
    procedure FormShow            (Sender: TObject);
    procedure btn_InquiryClick    (Sender: TObject);
    procedure cmb_gen_stChange    (Sender: TObject);
    procedure cmb_topicChange     (Sender: TObject);
    procedure grd_displayDrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; i_align : integer);
    procedure grd_displayDblClick (Sender: TObject);
    procedure btn_LinkClick       (Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    cmb_gbn_target_d : TZ0xxArray;
    cmb_gen_st_d	   : TZ0xxArray;
    cmb_gen_ed_d	   : TZ0xxArray;
    cmb_gbn_loc_d	   : TZ0xxArray;
    cmb_gbn_saup_d   : TZ0xxArray;
    cmb_gbn_lstPh_d  : TZ0xxArray;

    isData:Boolean;
    grdFocousEnable:Boolean;

    qryStr : String;

  public
    { Public declarations }
    procedure InitComponent();
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;

  end;


var
  fm_LOSTT110P: Tfm_LOSTT110P;

implementation

{$R *.dfm}

procedure Tfm_LOSTT110P.FormCreate(Sender: TObject);
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

  initComboBoxWithZ0xx('Z074.dat',cmb_gbn_target_d  , ''    ,'', cmb_gbn_target);
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_st_d	    , '전체','', cmb_gen_st    );
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_ed_d	    , '전체','', cmb_gen_ed    );
  initComboBoxWithZ0xx('Z076.dat',cmb_gbn_loc_d	    , '전체','', cmb_gbn_loc   );
  initComboBoxWithZ0xx('Z001.dat',cmb_gbn_saup_d    , '전체','', cmb_gbn_saup  );
  initComboBoxWithZ0xx('Z077.dat',cmb_gbn_lstPh_d   , '전체','', cmb_gbn_lstPh );

  //common_lib.pas에 있다.
	initSkinForm(SkinData1);

  InitComponent;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTT110P.disableComponents;
begin
  btn_Inquiry.enabled  := False;
  btn_Link.enabled     := False;
  btn_Close.enabled    := False;

end;

procedure Tfm_LOSTT110P.enableComponents;
begin
  btn_Inquiry.enabled  := True;
  btn_Link.enabled     := True;
  btn_Close.enabled    := True;
end;

procedure Tfm_LOSTT110P.InitComponent;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
	begin
		component := Components[i];

		if (component is TEdit) then
			(component as TEdit).Text := '';

		if (component is TComboBox) then
			(component as TComboBox).ItemIndex := 0;
	end;

  cmb_dt_gbn.ItemIndex	:= -1;
  cmb_dt_gbn.ItemIndex	:=  0;

  dte_dt_st.Date				:= date;
  dte_dt_ed.Date				:= date;

  rb1.Checked						:= True;
  rb3.Checked						:= True;

  // 입력 날짜 셋팅
  dte_ip_dt_st.Date			:= date -30;
  dte_ip_dt_ed.Date			:= date;

  // 버튼 이미지 초기화
  changeBtn(Self);

  btn_Add.Enabled     := False;
  btn_Update.Enabled  := False;
  btn_Delete.Enabled  := False;
  btn_query.Enabled   := True;

  pInitStrGrd(Self);

  // 그리드 초기화
  initStrGrid;

  grdFocousEnable := True;

end;

procedure Tfm_LOSTT110P.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tfm_LOSTT110P.FormShow(Sender: TObject);
var
  i:Integer;

  function CfillChar(src : string; fchar : Char;size : Integer) : string;
  var idx : Integer;
      dest : string;
  begin
    for idx := Length(Trim(src)) to Size - 1 do
     dest := dest + fchar;

    result := src + dest;
  end;

  Label LIQUIDATION;
begin

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT110P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'              ) < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTT110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  if (cmb_topic.Items.Count = 0) then
  begin
    for i := 0 to TMAX.RecvInteger('INT100',0) -1 do
      cmb_topic.Items.Add(   CfillChar(Trim(TMAX.RecvString('STR103',i))      ,' ',100)
                           + CfillChar(TMAX.RecvString('STR101',i)            ,' ', 10)
                           + CfillChar(IntToStr(TMAX.RecvInteger('INT102',i)) ,' ',  3)
                         );
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.btn_InquiryClick(Sender: TObject);
const MAXRECCNT = 1000;
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_idnm, seed_idno, seed_tlno, seed_mtno : String;

  i,j:Integer;

  STR001,STR002,STR003,STR004,STR005 : string;
  INT006,INT007        : Integer;

  count , total : integer;

  Label LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_idnm := '';
  seed_idno := '';
  seed_tlno := '';
  seed_mtno := '';

  if cmb_topic.ItemIndex = -1 then
  begin
    ShowMessage('설문항목을 선택 후 조회 가능합니다.');
    Exit;
  end;

  pInitStrGrd(Self);

  qryStr := '';

  j := 0;

  total := 0;
  count := MAXRECCNT;

  grd_display.RowCount  := 2;
  grd_display.FixedRows := 1;
  isData                := False; //스트링 그리드에 데이터가 없다.

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

  INT006 :=         1;
  INT007 := MAXRECCNT;

  while count = MAXRECCNT do
  begin

    count := 0;

    TMAX.InitBuffer;



    STR001 := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10));
    STR002 := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3));
    STR003 := delHyphen(dte_ip_dt_st.Text);
    STR004 := delHyphen(dte_ip_dt_ed.Text);

    if cmb_gbn_sel.itemIndex = 0 then STR005 := '*' else STR005 := ' ';

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTT110P'        ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S03'              ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString ('STR001',STR001            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendInteger('INT002',StrToInt(STR002)  ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR003',STR003            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR004',STR004            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString ('STR005',STR005            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendInteger('INT006',INT006            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendInteger('INT007',INT007            ) < 0) then  goto LIQUIDATION;


    //서비스 호출
    if not TMAX.Call('LOSTT110P') then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;    

    count := TMAX.RecvInteger('INT100',0);

    //쿼리 얻기
    qryStr := TMAX.RecvString('INF014',0);    

    grd_display.RowCount := grd_display.RowCount + count;

    for i := 0 to count -1 do
    begin
      with grd_display do
      begin
      j := 0;

      (*  SEQ                *) Cells[ fInc(j),total+i+1] :=  IntToStr(total+i+1);
      (*  설문처리상태       *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR111',i);
      (*  성명               *) seed_idnm                 :=             Self.TMAX.RecvString ('STR101',i);
                                Cells[ fInc(j),total+i+1] :=  ECPlazaSeed.Decrypt(seed_idnm, common_seedkey);
      (*  주민사업자번호     *) seed_idno                 :=             Self.TMAX.RecvString ('STR102',i);
                                Cells[ fInc(j),total+i+1] :=  InsHyphen (ECPlazaSeed.Decrypt(seed_idno, common_seedkey));
      (*  전화번호           *) seed_tlno                 :=             Self.TMAX.RecvString ('STR103',i);
                                Cells[ fInc(j),total+i+1] :=  InsHyphen (ECPlazaSeed.Decrypt(seed_tlno, common_seedkey));
      (*  사은품처리구분코드 *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR104',i);
      (*  사은품처리구분명   *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR105',i);
      (*  모델코드           *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR106',i);
      (*  모델명             *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR107',i);
      (*  단말기일련번호     *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR108',i);
      (*  주소               *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR109',i);
      (*  우편번호           *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR110',i);

      (*  분실폰구분         *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR112',i);
      (*  입고일자           *) Cells[ fInc(j),total+i+1] :=  InsHyphen (Self.TMAX.RecvString ('STR113',i));
      (*  선택보기번호       *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('INT114',i);
      (*  기타의견           *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('STR115',i);
      (*  설문상태           *) Cells[ fInc(j),total+i+1] :=  InsHyphen (Self.TMAX.RecvString ('STR116',i));
      (*설문작업결과일련번호 *) Cells[ fInc(j),total+i+1] :=             Self.TMAX.RecvString ('INT117',i);
      end;
    end;

    INT006 := INT006 + MAXRECCNT;
    INT007 := INT007 + MAXRECCNT;

    total := total + count;

    sts_Message.Panels[1].Text := ' ' + intToStr(total) + '건이 조회 되었습니다.';
    Application.ProcessMessages;
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor    := crDefault;	//작업완료

  if total >0 then
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

procedure Tfm_LOSTT110P.cmb_gen_stChange(Sender: TObject);
var
  i,j : Integer;
begin

  initComboBoxWithZ0xx('Z075.dat',cmb_gen_ed_d	    , '전체','', cmb_gen_ed    );

  if(cmb_gen_st.ItemIndex = 0) then
  begin
    cmb_gen_ed.ItemIndex := 0;
    cmb_gen_ed.Enabled   := False;
  end
  else
  begin
    for i := 0 to cmb_gen_st.ItemIndex -1 do
    begin
      j := i;
      cmb_gen_ed.Items.Delete(i-j);
    end;

    cmb_gen_ed.ItemIndex := 0;
    cmb_gen_ed.Enabled   := True;
  end;



end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.cmb_topicChange(Sender: TObject);
var
  i,j:Integer;

  component : TComponent;

  Label LIQUIDATION;
begin

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT110P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001',Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10))            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002',StrToInt(Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3)))            ) < 0) then  goto LIQUIDATION;


  //서비스 호출
	if not TMAX.Call('LOSTT110P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
  end;

(* 설문작업일자       *) //                       := TMAX.RecvString('STR101',0);
(* 설문작업일련번호   *) //                       := TMAX.RecvString('INT102',0);
(* 설문주제           *) cmb_topic.text           := TMAX.RecvString('STR103',0);
(* 설문대상자구분     *) cmb_gbn_target.itemIndex := StrToInt(TMAX.RecvString('STR104',0)) -1;
(* 연령대구분1        *) cmb_gen_st.itemIndex     := cmb_gen_st.items.indexOf(    findNameFromCode(TMAX.RecvString('STR105',0),cmb_gen_st_d,cmb_gen_st.Items.Count));
(* 연령대구분2        *) cmb_gen_ed.itemIndex     := cmb_gen_ed.items.indexOf(    findNameFromCode(TMAX.RecvString('STR106',0),cmb_gen_ed_d,cmb_gen_ed.items.Count));
(* 지역구분           *) cmb_gbn_loc.itemIndex    := cmb_gbn_loc.items.indexOf(   findNameFromCode(TMAX.RecvString('STR107',0),cmb_gbn_loc_d,cmb_gbn_loc.items.Count));
(* 사업자구분         *) cmb_gbn_saup.itemIndex   := cmb_gbn_saup.items.indexof(  findNameFromCode(TMAX.RecvString('STR108',0),cmb_gbn_saup_d,cmb_gbn_saup.Items.count));
(* 분실폰구분         *) cmb_gbn_lstPh.itemIndex  := cmb_gbn_lstPh.items.indexOf( findNameFromCode(TMAX.RecvString('STR109',0),cmb_gbn_lstPh_d,cmb_gbn_lstPh.Items.Count));
(* 핸드폰출고여부     *) if ( TMAX.RecvString('STR110',0) = 'Y') then rb1.checked := true else rb2.Checked := True;
(* 사은품전달여부     *) if ( TMAX.RecvString('STR111',0) = 'Y') then rb3.checked := true else rb4.Checked := True;
(* 일자기준           *) cmb_dt_gbn.itemIndex     := StrToInt ( TMAX.RecvString('STR112',0)) -1;
(* 시작일자           *) dte_dt_st.text           := InsHyphen( TMAX.RecvString('STR113',0));
(* 종료일자           *) dte_dt_ed.text           := InsHyphen( TMAX.RecvString('STR114',0));
dte_ip_dt_st.Text := dte_dt_st.text;
dte_ip_dt_ed.Text := dte_dt_ed.text;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
 end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.initStrGrid;
var
  j : Integer;
begin
  j := 0;
  with grd_display do begin
    RowCount      :=  2;
    ColCount      := 18;
    RowHeights[0] := 21;

    ColWidths[fInc(j)] :=  50;   // SEQ
    ColWidths[fInc(j)] :=  90;   // 설문처리상태
    ColWidths[fInc(j)] := 120;   // 성명
    ColWidths[fInc(j)] := 120;   // 주민사업자번호
    ColWidths[fInc(j)] := 110;   // 전화번호
    ColWidths[fInc(j)] :=  -1;   // 처리구분코드
    ColWidths[fInc(j)] := 120;   // 처리구분
    ColWidths[fInc(j)] :=  -1;   // 모델코드
    ColWidths[fInc(j)] := 160;   // 모델명
    ColWidths[fInc(j)] := 120;   // 단말기일련번호
    ColWidths[fInc(j)] := 240;   // 주소
    ColWidths[fInc(j)] :=  90;   // 우편번호
    ColWidths[fInc(j)] := 100;   // 설문처리상태
    ColWidths[fInc(j)] :=  80;   // 입고일자

    ColWidths[fInc(j)] :=  -1;   // 선택보기번호
    ColWidths[fInc(j)] :=  -1;   // 기타의견
    ColWidths[fInc(j)] :=  -1;   // 설문상태
    ColWidths[fInc(j)] :=  -1;   // 설문작업결과일련번호

    j := 0;

    Cells[fInc(j),0]   :=  'SEQ';
    Cells[fInc(j),0]   :=  '설문상태';
    Cells[fInc(j),0]   :=  '성명';
    Cells[fInc(j),0]   :=  '주민사업자번호';
    Cells[fInc(j),0]   :=  '전화번호';
    Cells[fInc(j),0]   :=  '처리구분코드';
    Cells[fInc(j),0]   :=  '처리구분';
    Cells[fInc(j),0]   :=  '모델코드';
    Cells[fInc(j),0]   :=  '모델명';
    Cells[fInc(j),0]   :=  '단말기일련번호';
    Cells[fInc(j),0]   :=  '주소';
    Cells[fInc(j),0]   :=  '우편번호';
    Cells[fInc(j),0]   :=  '분실폰구분';
    Cells[fInc(j),0]   :=  '입고일자';

    Cells[fInc(j),0]   :=  '선택보기번호';
    Cells[fInc(j),0]   :=  '기타의견';
    Cells[fInc(j),0]   :=  '설문상태';
    Cells[fInc(j),0]   :=  '설문작업결과일련번호';
  end;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
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
      0,3,11,12 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      else
       StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
     end;
  end;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
procedure Tfm_LOSTT110P.grd_displayDblClick(Sender: TObject);
begin
  //fm_LOSTT110P_CHILD.FormShow(Sender);
  if grd_display.Cells[1, grd_display.Row] <> '미처리' then Exit;

  fm_LOSTT110P_CHILD.Show;
  Self.Enabled := False;
  Self.Hide;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT110P.btn_LinkClick(Sender: TObject);
begin
  grd_displayDblClick(Sender);
end;

procedure Tfm_LOSTT110P.btn_resetClick(Sender: TObject);
begin
  self.InitComponent;
end;

procedure Tfm_LOSTT110P.btn_queryClick(Sender: TObject);
var
  cmdStr    :String;
  filePath  :String;
  f:TextFile;
begin
	if qryStr = '' then
    exit;

  filePath := '..\Temp\' + PGM_ID + '_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
