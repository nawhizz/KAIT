unit u_LOSTT100P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, so_tmax, StdCtrls, ComCtrls, Mask, ToolEdit, Buttons, ExtCtrls,
  common_lib,Grids,u_LOSTT100P;

type
  Tfm_LOSTT100P_CHILD = class(TForm)
    pnl_Command: TPanel;
    pnl_Program_Name: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    edt_topic: TEdit;
    Panel3: TPanel;
    cmb_dt_gbn: TComboBox;
    Label3: TLabel;
    dte_dt_st: TDateEdit;
    dte_dt_ed: TDateEdit;
    Panel4: TPanel;
    cmb_prog_sts: TComboBox;
    sts_Message: TStatusBar;
    GroupBox1: TGroupBox;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    cmb_gbn_target: TComboBox;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    cmb_gen_st: TComboBox;
    cmb_gen_ed: TComboBox;
    Label1: TLabel;
    cmb_gbn_loc: TComboBox;
    grp1: TGroupBox;
    rbOutYn_Y: TRadioButton;
    rbOutYn_N: TRadioButton;
    cmb_gbn_saup: TComboBox;
    Panel11: TPanel;
    GroupBox2: TGroupBox;
    rbTransYn_Y: TRadioButton;
    rbTransYn_N: TRadioButton;
    cmb_gbn_lstPh: TComboBox;
    GroupBox3: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    edt5: TEdit;
    edt6: TEdit;
    edt7: TEdit;
    edt8: TEdit;
    edt9: TEdit;
    edt10: TEdit;
    edt11: TEdit;
    edt12: TEdit;
    edt13: TEdit;
    edt14: TEdit;
    edt15: TEdit;
    TMAX: TTMAX;
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
    rbOutYn_A: TRadioButton;
    rbTransYn_A: TRadioButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_DeleteClick(Sender: TObject);
    procedure cmb_gen_stChange(Sender: TObject);
    
  private
    { Private declarations }
    cmb_gbn_target_d : TZ0xxArray;
    cmb_gen_st_d	   : TZ0xxArray;
    cmb_gen_ed_d	   : TZ0xxArray;
    cmb_gbn_loc_d	   : TZ0xxArray;
    cmb_gbn_saup_d   : TZ0xxArray;
    cmb_gbn_lstPh_d  : TZ0xxArray;


  public
    { Public declarations }
    procedure InitComponent();
  end;

var
  fm_LOSTT100P_CHILD: Tfm_LOSTT100P_CHILD;

implementation

{$R *.dfm}


procedure Tfm_LOSTT100P_CHILD.FormCreate(Sender: TObject);
begin
  initComboBoxWithZ0xx('Z074.dat',cmb_gbn_target_d  , ''    ,'', cmb_gbn_target);
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_st_d	    , '전체','', cmb_gen_st    );
  initComboBoxWithZ0xx('Z075.dat',cmb_gen_ed_d	    , '전체','', cmb_gen_ed    );
  initComboBoxWithZ0xx('Z076.dat',cmb_gbn_loc_d	    , '전체','', cmb_gbn_loc   );
  initComboBoxWithZ0xx('Z001.dat',cmb_gbn_saup_d    , '전체','', cmb_gbn_saup  );
  initComboBoxWithZ0xx('Z077.dat',cmb_gbn_lstPh_d   , '전체','', cmb_gbn_lstPh );

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

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfm_LOSTT100P_CHILD.InitComponent;
var
  i : Integer;
  component : TComponent;
begin

  // 버튼 이미지 초기화
  changeBtn(Self);
  btn_Print.Enabled := False;
  btn_Inquiry.Enabled := False;
  btn_reset.Enabled := false;
  btn_query.Enabled := false;


  
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TEdit) then
      (component as TEdit).Text := '';

    if (component is TComboBox) then
      (component as TComboBox).ItemIndex := 0;
  end;

  cmb_dt_gbn.ItemIndex    := -1;
  cmb_prog_sts.ItemIndex  := -1;
  cmb_dt_gbn.ItemIndex    :=  0;
  cmb_prog_sts.ItemIndex  :=  0;

  btn_Excel.Enabled := false;
  dte_dt_st.Date := date;
  dte_dt_ed.Date := date;

  rbTransYn_A.Checked := True;
  rbOutYn_A.Checked   := True;
end;

procedure Tfm_LOSTT100P_CHILD.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure Tfm_LOSTT100P_CHILD.FormShow(Sender: TObject);
begin
  self.Show;

  // 컴포넌트 초기화
  InitComponent();  

  // 그리드를 선택하여 창을 연 경우
  if Sender is TStringGrid then
  begin
    btn_InquiryClick(Sender);
    btn_Add.Enabled    := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;
  end else if Sender is TSpeedButton then
  begin
    if (sender as TSpeedButton).Name = 'btn_Link' then
    begin
      btn_InquiryClick(Sender);
      btn_Add.Enabled    := False;
      btn_Update.Enabled := True;
      btn_Delete.Enabled := True;
    end else if (sender as TSpeedButton).Name = 'btn_Add' then
    begin
      btn_Add.Enabled    := True;
      btn_Update.Enabled := False;
      btn_Delete.Enabled := False;
    end
  end;

  edt_topic.SetFocus;
end;

procedure Tfm_LOSTT100P_CHILD.btn_InquiryClick(Sender: TObject);
var
  i,j:Integer;

  STR001,STR002 : string;

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

	(* 	조회일자구분 *)  STR001  := fm_LOSTT100P.grd_display.Cells[1,fm_LOSTT100P.grd_display.row];
	(* 	조회시작일자 *)  STR002  := fm_LOSTT100P.grd_display.Cells[2,fm_LOSTT100P.grd_display.row];

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001', STR001           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002', strToInt(Trim(STR002)) ) < 0) then  goto LIQUIDATION;


  //서비스 호출
	if not TMAX.Call('LOSTT100P') then goto LIQUIDATION;

  self.InitComponent;

  (* 설문작업일자       *) //                       :=                              TMAX.RecvString('STR101',0);
  (* 설문작업일련번호   *) //                       :=                              TMAX.RecvString('INT102',0);
  (* 설문주제           *) edt_topic.text           :=                              TMAX.RecvString('STR103',0);
  (* 일자기준           *) cmb_dt_gbn.itemIndex     := StrToInt(TMAX.RecvString('STR104',0)) -1;
  (* 시작일자           *) dte_dt_st.text           := InsHyphen(                   TMAX.RecvString('STR105',0));
  (* 종료일자           *) dte_dt_ed.text           := InsHyphen(                   TMAX.RecvString('STR106',0));
  (* 진행여부           *) if(TMAX.RecvString('STR107',0) = 'Y') then cmb_prog_sts.itemIndex := 0
                            else cmb_prog_sts.itemIndex := 1;
  (* 설문대상자구분     *) cmb_gbn_target.itemIndex := StrToInt(TMAX.RecvString('STR108',0)) -1;
  (* 연령대구분1        *) cmb_gen_st.itemIndex     := cmb_gen_st.items.indexOf(    findNameFromCode(TMAX.RecvString('STR109',0),cmb_gen_st_d,cmb_gen_st.Items.Count));
  (* 연령대구분2        *) cmb_gen_ed.itemIndex     := cmb_gen_ed.items.indexOf(    findNameFromCode(TMAX.RecvString('STR110',0),cmb_gen_ed_d,cmb_gen_ed.items.Count));
  (* 지역구분           *) cmb_gbn_loc.itemIndex    := cmb_gbn_loc.items.indexOf(   findNameFromCode(TMAX.RecvString('STR111',0),cmb_gbn_loc_d,cmb_gbn_loc.items.Count));
  (* 사업자구분         *) cmb_gbn_saup.itemIndex   := cmb_gbn_saup.items.indexof(  findNameFromCode(TMAX.RecvString('STR112',0),cmb_gbn_saup_d,cmb_gbn_saup.Items.count));
  (* 분실폰구분         *) cmb_gbn_lstPh.itemIndex  := cmb_gbn_lstPh.items.indexOf( findNameFromCode(TMAX.RecvString('STR113',0),cmb_gbn_lstPh_d,cmb_gbn_lstPh.Items.Count));
  (* 핸드폰출고여부     *) if ( TMAX.RecvString('STR114',0) = '*') then rbOutYn_A.checked := True   else
                           if ( TMAX.RecvString('STR114',0) = 'Y') then rbOutYn_Y.checked := True   else rbOutYn_N.Checked := True;
  (* 사은품전달여부     *) if ( TMAX.RecvString('STR115',0) = '*') then rbTransYn_A.checked := True else
                           if ( TMAX.RecvString('STR115',0) = 'Y') then rbTransYn_Y.checked := True else rbTransYn_N.checked := True;
  (* 보기갯수           *) //     := TMAX.RecvInteger('INT116',0);


  for i := 0 to TMAX.RecvInteger('INT100',0) do
  begin
    for j := 0 to ComponentCount - 1 do
    begin
      component := Components[j];

      if (component is TEdit) then
      begin
        if (component as TEdit).Name = 'edt' + IntToStr(i+1) then
        begin
          (component as TEdit).Text := TMAX.RecvString('STR122',i);
        end;
      end;
    end;
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfm_LOSTT100P_CHILD.btn_UpdateClick(Sender: TObject);
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

  if(svcNm = 'I01') then
  begin
  (*  작업일자       *) STRVALUE[ 1] := '00000000';
  (*  작업일련번호   *) STRVALUE[ 2] := '0';
  end
  else begin
  (*  작업일자       *) STRVALUE[ 1] := fm_LOSTT100P.grd_display.Cells[1,fm_LOSTT100P.grd_display.row];
  (*  작업일련번호   *) STRVALUE[ 2] := fm_LOSTT100P.grd_display.Cells[2,fm_LOSTT100P.grd_display.row];
  end;

  (*  설문주제       *) STRVALUE[ 3] := edt_topic.Text;
  (*  일자기준       *) STRVALUE[ 4] := IntToStr(cmb_dt_gbn.itemIndex + 1);
  (*  시작일자       *) STRVALUE[ 5] := delHyphen(dte_dt_st.Text);
  (*  종료일자       *) STRVALUE[ 6] := delHyphen(dte_dt_ed.Text);
  (*  진행여부       *) if(cmb_prog_sts.itemIndex = 0) then STRVALUE[ 7] := 'Y' else STRVALUE[ 7] := 'N';
  (*  보기갯수       *) STRVALUE[ 8] := IntToStr(cnt);
  (*  설문대상자구분 *) STRVALUE[ 9] := cmb_gbn_target_d[cmb_gbn_target.itemindex ].code;
  (*  연령대구분1    *) STRVALUE[10] := cmb_gen_st_d    [cmb_gen_st.itemIndex     ].code;
  (*  연령대구분2    *) STRVALUE[11] := cmb_gen_ed_d    [cmb_gen_ed.itemIndex     ].code;
  (*  지역구분       *) STRVALUE[12] := cmb_gbn_loc_d   [cmb_gbn_loc.itemIndex    ].code;
  (*  사업자구분     *) STRVALUE[13] := cmb_gbn_saup_d  [cmb_gbn_saup.itemIndex   ].code;
  (*  분실폰구분     *) STRVALUE[14] := cmb_gbn_lstPh_d [cmb_gbn_lstPh.itemIndex].code;
  (*  핸드폰출고여부 *) if rbOutYn_A.Checked    then STRVALUE[15] := '*' else
                        if rbOutYn_Y.Checked    then STRVALUE[15] := 'Y' else STRVALUE[15] := 'N';
  (*  사은품전달여부 *) if rbTransYn_A.Checked  then STRVALUE[16] := '*' else
                        if rbTransYn_Y.Checked  then STRVALUE[16] := 'Y' else STRVALUE[16] := 'N';

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
	if not TMAX.Call('LOSTT100P') then
  begin
    success := False;

    if (TMAX.RecvString('INF010',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      
    goto LIQUIDATION;
  end;

  if(svcNm = 'I01') then
  begin
    sts_Message.Panels[1].Text := ' 등록 완료';

    ShowMessage('성공적으로 등록하였습니다.');
  end else
  begin
    sts_Message.Panels[1].Text := ' 수정 완료';

    ShowMessage('성공적으로 수정하였습니다.');

  end;

  success := True;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if success then
  begin
    self.Close;
    fm_LOSTT100P.Show;
    fm_LOSTT100P.btn_InquiryClick(Sender);
  end;
end;

procedure Tfm_LOSTT100P_CHILD.btn_AddClick(Sender: TObject);
begin
  btn_UpdateClick(Sender);
end;

procedure Tfm_LOSTT100P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  self.Hide;
  fm_LOSTT100P.Enabled := True;
  fm_LOSTT100P.Show;
  fm_LOSTT100P.btn_InquiryClick(Sender);

end;

procedure Tfm_LOSTT100P_CHILD.btn_DeleteClick(Sender: TObject);
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

	(* 	조회일자구분 *)  STR001  := fm_LOSTT100P.grd_display.Cells[1,fm_LOSTT100P.grd_display.row];
	(* 	조회시작일자 *)  STR002  := fm_LOSTT100P.grd_display.Cells[2,fm_LOSTT100P.grd_display.row];

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid      ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup   ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTT100P'        ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString ('STR001', STR001           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT002', strToInt(Trim(STR002)) ) < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTT100P') then
  begin
      if (TMAX.RecvString('INF010',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
  end;

  ShowMessage('성공적으로 삭제되었습니다.');

  sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

  self.InitComponent;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfm_LOSTT100P_CHILD.cmb_gen_stChange(Sender: TObject);
var
  i,j : Integer;
begin

  initComboBoxWithZ0xx('Z075.dat',cmb_gen_ed_d	    , '전체','', cmb_gen_ed    );
  if(cmb_gen_st.ItemIndex = 0) then
  begin
    cmb_gen_ed.ItemIndex := 0;
    cmb_gen_ed.Enabled := False;
  end
  else
  begin
    for i := 0 to cmb_gen_st.ItemIndex -1 do
    begin
      j := i;
      cmb_gen_ed.Items.Delete(i-j);
    end;

    cmb_gen_ed.ItemIndex := 0;
    cmb_gen_ed.Enabled := True;
  end;



end;



end.
