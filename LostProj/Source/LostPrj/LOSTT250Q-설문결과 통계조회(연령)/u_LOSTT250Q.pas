unit u_LOSTT250Q;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, so_tmax, StdCtrls, ComCtrls, Mask, ToolEdit, Buttons, ExtCtrls,
  common_lib,Grids, WinSkinData,Func_Lib, ComObj;

const
  TITLE   = '설문결과통계조회(연령)';
  PGM_ID  = 'LOSTT250Q';

type

  Tfm_LOSTT250Q = class(TForm)
    cmb_gen_st    : TComboBox;
    cmb_gen_ed    : TComboBox;
    cmb_gbn_loc   : TComboBox;
    cmb_gbn_saup  : TComboBox;
    cmb_gbn_lstPh : TComboBox;
    cmb_dt_gbn    : TComboBox;
    cmb_topic     : TComboBox;
    cmb_gbn_target: TComboBox;
    dte_dt_ed     : TDateEdit;
    dte_dt_st     : TDateEdit;
    grp1          : TGroupBox;
    GroupBox1     : TGroupBox;
    GroupBox2     : TGroupBox;
    lbl_Program_Name: TLabel;
    Label1        : TLabel;
    Label3        : TLabel;
    Panel3        : TPanel;
    Panel10       : TPanel;
    Panel12       : TPanel;
    Panel1        : TPanel;
    Panel2        : TPanel;
    pnl_Command   : TPanel;
    Panel5        : TPanel;
    Panel6        : TPanel;
    Panel7        : TPanel;
    Panel11       : TPanel;
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
    btn_Search_Topic: TBitBtn;
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
    procedure btn_InquiryClick    (Sender: TObject);
    procedure btn_UpdateClick     (Sender: TObject);
    procedure btn_AddClick        (Sender: TObject);
    procedure btn_DeleteClick     (Sender: TObject);
    procedure cmb_gen_stChange    (Sender: TObject);
    procedure grd_displayDrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure StringGrid_DrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; i_align : integer);
    procedure btn_ExcelClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_Search_TopicClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);

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

    qryStr:String;

  public
    { Public declarations }
    procedure InitComponent();
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;

  end;

var
  fm_LOSTT250Q: Tfm_LOSTT250Q;

implementation
uses u_LOSTT250Q_CHILD;
{$R *.dfm}

procedure Tfm_LOSTT250Q.FormCreate(Sender: TObject);
begin
  {   }
  (*======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================    *)
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    ShowMessage('메인프로그램에서 실행 시키세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);  	//메인프로그램 핸들
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
//  common_userid   := '0294';    //ParamStr(3);
//  common_username := '정호영';  //ParamStr(4);
//  common_usergroup:= 'SYSM';    //ParamStr(5);

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

  initComboBoxWithZ0xx('Z074.dat',cmb_gbn_target_d  , ''    ,'', cmb_gbn_target);
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_st_d	    , '전체','', cmb_gen_st    );
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_ed_d	    , '전체','', cmb_gen_ed    );
  initComboBoxWithZ0xx('Z076.dat',cmb_gbn_loc_d	    , '전체','', cmb_gbn_loc   );
  initComboBoxWithZ0xx('Z001.dat',cmb_gbn_saup_d    , '전체','', cmb_gbn_saup  );
  initComboBoxWithZ0xx('Z077.dat',cmb_gbn_lstPh_d   , '전체','', cmb_gbn_lstPh );

  //common_lib.pas에 있다.
	initSkinForm(SkinData1);

  // 컴포넌트 초기화
  InitComponent();

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTT250Q.disableComponents;
begin
  btn_Inquiry.Enabled := False;
  btn_query.Enabled   := False;
  btn_Excel.Enabled   := False;
  btn_Close.Enabled   := False;

end;

procedure Tfm_LOSTT250Q.enableComponents;
begin
  btn_Inquiry.Enabled  := True;
  btn_query.Enabled    := True;
  btn_Excel.Enabled    := True;
  btn_Close.Enabled    := True;

end;

procedure Tfm_LOSTT250Q.InitComponent;
var
  i : Integer;
  component : TComponent;
begin

  // 버튼 이미지 초기화
  changeBtn(Self);

  pInitStrGrd(Self);

  // 그리드 초기화
  initStrGrid;

  //쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.
  qryStr        := '';

  grdFocousEnable := True;

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

end;

procedure Tfm_LOSTT250Q.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.btn_InquiryClick(Sender: TObject);
var

  i,j:Integer;

  STR001,STR002 : string;

  Label LIQUIDATION;
begin

  if cmb_topic.ItemIndex = -1 then
  begin
    ShowMessage('설문항목을 선택 후 조회 가능합니다.');
    Exit;
  end;

  j := 0;

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

    TMAX.InitBuffer;

    STR001 := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],101,10));
    STR002 := Trim(Copy(cmb_topic.Items.Strings[cmb_topic.itemindex],110, 3));

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTT250Q'        ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01'              ) < 0) then  goto LIQUIDATION;

    if (TMAX.SendString ('STR001',STR001            ) < 0) then  goto LIQUIDATION;
    if (TMAX.SendInteger('INT002',StrToInt(STR002)  ) < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTT250Q') then begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;

    grd_display.RowCount := grd_display.RowCount + TMAX.RecvInteger('INT100',0);

    for i := 0 to TMAX.RecvInteger('INT100',0) -1 do
    begin
      with grd_display do
      begin
        j := 0;

        if ( i = (TMAX.RecvInteger('INT100',0) -1)) then Cells[ fInc(j),i+1] := TMAX.RecvString ('STR102',i)
        else
        (* 설문보기번호 *) Cells[ fInc(j),i+1] := TMAX.RecvString ('INT101',i) + '.' + TMAX.RecvString ('STR102',i);
        (* 10대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT103',i));
        (* 20대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT104',i));
        (* 30대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT105',i));
        (* 40대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT106',i));
        (* 50대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT107',i));
        (* 60대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT108',i));
        (* 70대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT109',i));
        (* 80대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT110',i));
        (* 90대         *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT111',i));
        (* 계           *) Cells[ fInc(j),i+1] := convertWithCommer(  TMAX.RecvString ('INT113',i));

      end;
    end;

    sts_Message.Panels[1].Text := '조회 되었습니다.';
    Application.ProcessMessages;


  //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
  qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor    := crDefault;	//작업완료
  grd_display.RowCount  := grd_display.RowCount -1;

  if grdFocousEnable then
    grd_display.SetFocus;	//스트링 그리드로 포커스 이동


  enableComponents;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.btn_UpdateClick(Sender: TObject);
var
  i,j,cnt:Integer;

  component : TComponent;

  // 서비스 파라미터
  STRVALUE : array[1..16] of string;

  // 서비스 실행 파라미터 ex) I01,U01,D01..
  svcNm  : string;

  success : Boolean;

  Label LIQUIDATION;
begin
  i     := 0;
  j     := 1;
  cnt   := 0;
  success := false;

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

  // 서비스 실행 파라이터 설정
  if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01'
    else if (Sender as TSpeedButton).Name = 'btn_Update' then svcNm := 'U01';


  // 서비스 변수 설정
  FillChar(STRVALUE,SizeOf(STRVALUE),#0);


  for i := 0 to ComponentCount -1 do
  begin
    component := Components[i];

    if(component is TEdit) then
      if (Length(Trim((component as TEdit).Text)) <> 0) and (Pos('edt_',(component as TEdit).Name) = 0) then
      begin
        cnt := cnt + 1;
      end;
  end;

  (*  작업일자       *) STRVALUE[ 1] := '00000000';
  (*  작업일련번호   *) STRVALUE[ 2] := '0';

  (*  설문주제       *) STRVALUE[ 3] := cmb_topic.Text;
  (*  일자기준       *) STRVALUE[ 4] := IntToStr(cmb_dt_gbn.itemIndex + 1);
  (*  시작일자       *) STRVALUE[ 5] := delHyphen(dte_dt_st.Text);
  (*  종료일자       *) STRVALUE[ 6] := delHyphen(dte_dt_ed.Text);
  (*  설문대상자구분 *) STRVALUE[ 9] := cmb_gbn_target_d[cmb_gbn_target.itemindex ].code;
  (*  연령대구분1    *) STRVALUE[10] := cmb_gen_st_d    [cmb_gen_st.itemIndex     ].code;
  (*  연령대구분2    *) STRVALUE[11] := cmb_gen_ed_d    [cmb_gen_ed.itemIndex + cmb_gen_st.itemIndex].code;
  (*  지역구분       *) STRVALUE[12] := cmb_gbn_loc_d   [cmb_gbn_loc.itemIndex    ].code;
  (*  사업자구분     *) STRVALUE[13] := cmb_gbn_saup_d  [cmb_gbn_saup.itemIndex   ].code;
  (*  분실폰구분     *) STRVALUE[14] := cmb_gbn_lstPh_d [cmb_gbn_lstPh.itemIndex].code;
  (*  핸드폰출고여부 *) if rb1.Checked then STRVALUE[15] := 'Y' else STRVALUE[15] := 'N';
  (*  사은품전달여부 *) if rb3.Checked then STRVALUE[16] := 'Y' else STRVALUE[16] := 'N';

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001', STRVALUE[ 1]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002', StrToInt(STRVALUE[ 2])     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR003', STRVALUE[ 3]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR004', STRVALUE[ 4]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR005', STRVALUE[ 5]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR006', STRVALUE[ 6]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR007', STRVALUE[ 7]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT008', StrToInt(STRVALUE[ 8])     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR009', STRVALUE[ 9]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR010', STRVALUE[10]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR011', STRVALUE[11]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR012', STRVALUE[12]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR013', STRVALUE[13]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR014', STRVALUE[14]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR015', STRVALUE[15]     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString ('STR016', STRVALUE[16]     ) < 0) then  goto LIQUIDATION;

  for i := 0 to ComponentCount -1 do
  begin
    component := Components[i];

    if(component is TEdit) then
      if (Length(Trim((component as TEdit).Text)) <> 0) and (Pos('edt_',(component as TEdit).Name) = 0) then
      begin
        if (TMAX.SendInteger('INT021', fInc(j)                         ) < 0) then  goto LIQUIDATION;
        if (TMAX.SendString ('STR022', Trim((component as TEdit).Text) ) < 0) then  goto LIQUIDATION;
      end;
  end;

  //서비스 호출
	if not TMAX.Call('LOSTT100P') then goto LIQUIDATION;

  if(svcNm = 'I01') then
  begin
    sts_Message.Panels[1].Text := ' 등록 완료';

    ShowMessage('성공적으로 등록하였습니다.');
  end else
  begin
    sts_Message.Panels[1].Text := ' 수정 완료';

    ShowMessage('성공적으로 수정하였습니다.');
    success := True;
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.btn_AddClick(Sender: TObject);
begin
  btn_UpdateClick(Sender);
end;

procedure Tfm_LOSTT250Q.btn_DeleteClick(Sender: TObject);
var

  STR001,STR002 : string;

  Label LIQUIDATION;
begin
   if MessageDlg('정말 삭제하시겠습니까 ?',
      mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
      Exit;
   end;

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
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001', STR001           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002', strToInt(Trim(STR002)) ) < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTT100P') then goto LIQUIDATION;

  ShowMessage('성공적으로 삭제되었습니다.');

  sts_Message.Panels[1].Text := '삭제 완료';

  self.InitComponent;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.cmb_gen_stChange(Sender: TObject);
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
procedure Tfm_LOSTT250Q.initStrGrid;
var
  j : Integer;
begin
  j := 0;
  with grd_display do begin
    RowCount      :=  2;
    ColCount      := 11;
    RowHeights[0] := 21;

    ColWidths[fInc(j)] := 280;  //
    ColWidths[fInc(j)] := 80;   // 10대
    ColWidths[fInc(j)] := 80;   // 20대
    ColWidths[fInc(j)] := 80;   // 30대
    ColWidths[fInc(j)] := 80;   // 40대
    ColWidths[fInc(j)] := 80;   // 50대
    ColWidths[fInc(j)] := 80;   // 60대
    ColWidths[fInc(j)] := 80;   // 70대
    ColWidths[fInc(j)] := 80;   // 80대
    ColWidths[fInc(j)] := 80;   // 90대
    ColWidths[fInc(j)] := 80;   // 계

    j := 0;

    Cells[fInc(j),0]   :=  '';
    Cells[fInc(j),0]   :=  '10대';
    Cells[fInc(j),0]   :=  '20대';
    Cells[fInc(j),0]   :=  '30대';
    Cells[fInc(j),0]   :=  '40대';
    Cells[fInc(j),0]   :=  '50대';
    Cells[fInc(j),0]   :=  '60대';
    Cells[fInc(j),0]   :=  '70대';
    Cells[fInc(j),0]   :=  '80대';
    Cells[fInc(j),0]   :=  '90대';
    Cells[fInc(j),0]   :=  '합계';
  end;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.grd_displayDrawCell(Sender: TObject; ACol,
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
      0 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      else
       StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
     end;
  end;
end;

{------------------------------------------------------------------------------}
procedure Tfm_LOSTT250Q.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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


procedure Tfm_LOSTT250Q.btn_ExcelClick(Sender: TObject);
begin
	Proc_gridtoexcel(TITLE + '(' + PGM_ID + ')',grd_display.RowCount, grd_display.ColCount, grd_display, PGM_ID);
end;

procedure Tfm_LOSTT250Q.btn_queryClick(Sender: TObject);
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

procedure Tfm_LOSTT250Q.btn_Search_TopicClick(Sender: TObject);
begin
  self.hide;
  fm_LOSTT250Q_CHILD.show;
end;

procedure Tfm_LOSTT250Q.FormShow(Sender: TObject);
var
  i,j:Integer;

  component : TComponent;

  Label LIQUIDATION;
begin

  if (cmb_topic.Items.Count = 0) then Exit;


  cmb_topic.ItemIndex := 0;

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

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
 end;

procedure Tfm_LOSTT250Q.btn_resetClick(Sender: TObject);
begin
  Self.InitComponent;
end;

end.
