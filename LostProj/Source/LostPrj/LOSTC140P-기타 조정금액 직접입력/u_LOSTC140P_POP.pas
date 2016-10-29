unit u_LOSTC140P_POP;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit, ComObj;

const
  TITLE   = '기타조정금액입력';
  PGM_ID  = 'LOSTC140P';

type
  Tfrm_LOSTC140P_POP = class(TForm)
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel3: TBevel;
    lbl_Inq_Str: TLabel;
    cmb_Inq_Gu: TComboBox;
    edt_Inq_Str: TEdit;
    grd_display: TStringGrid;
    TMAX: TTMAX;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure grd_displayDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var
  frm_LOSTC140P_POP: Tfrm_LOSTC140P_POP;

implementation
 uses u_LOSTC140P_CHILD;
{$R *.dfm}

procedure Tfrm_LOSTC140P_POP.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 2;
    RowHeights[0] := 21;

    ColWidths[0] := 200;
    Cells[0,0] :='총괄국코드';

    ColWidths[1] := 250;
    Cells[1,0] :='총괄국명';
    end;
end;

procedure Tfrm_LOSTC140P_POP.FormShow(Sender: TObject);
var i : Integer;
begin

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;

  grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := '';

  frm_LOSTC140P_CHILD.Enabled := False;
  cmb_Inq_Gu.ItemIndex := 1;
  edt_Inq_Str.Text := GM_CD;
  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Print.Enabled := False;
  Self.Show;

  if Length(GM_CD) > 0 then begin
    btn_InquiryClick(Sender);

  end;

  edt_Inq_Str.SetFocus;



end;

procedure Tfrm_LOSTC140P_POP.FormCreate(Sender: TObject);
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
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  // ParamStr(3);
  //	common_usergroup:= 'KAIT'; //ParamStr(4);

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

  initStrGrid;	//그리드 초기화
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC140P_POP.btn_CloseClick(Sender: TObject);
begin

  close;
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;

end;

procedure Tfrm_LOSTC140P_POP.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '총괄국 코드';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 6;
      edt_Inq_Str.Height := 24;
      edt_Inq_Str.Width := 105;

   end
   else
   begin
      lbl_inq_str.Caption := '총괄국 명';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 20;
      edt_Inq_Str.Height := 24;
      edt_Inq_Str.Width := 105;
   end;
end;

procedure Tfrm_LOSTC140P_POP.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin
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
	if (TMAX.SendString('INF003','LOSTZ240P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Inq_Str.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', 'Y' ) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ240P') then
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

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i); //총괄국코드
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i); //총괄국명


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



procedure Tfrm_LOSTC140P_POP.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
 if Key =#13 then begin
  btn_InquiryClick(Sender);
 end;
end;



procedure Tfrm_LOSTC140P_POP.grd_displayDblClick(Sender: TObject);
begin
  frm_LOSTC140P_CHILD.edt_gm_cd.Text := grd_display.Cells[0, grd_display.Row];
  frm_LOSTC140P_CHILD.edt_gm_nm.Text := grd_display.Cells[1, grd_display.Row];

  frm_LOSTC140P_CHILD.edt_gm_nm.Enabled := False;

  close;
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;
  frm_LOSTC140P_CHILD.edt_rg_su.SetFocus;
end;

procedure Tfrm_LOSTC140P_POP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTC140P_CHILD.Enabled := True;
  frm_LOSTC140P_CHILD.Show;
end;

end.
