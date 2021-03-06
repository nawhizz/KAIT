unit u_LOSTC140P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit,u_LOSTC140P_POP, ComObj;

const
  TITLE   = '기타조정금액입력';
  PGM_ID  = 'LOSTC140P';

type
  Tfrm_LOSTC140P_CHILD = class(TForm)
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_ct_ym: TEdit;
    edt_gm_cd: TEdit;
    edt_ct_am: TEdit;
    edt_bi_go: TEdit;
    sts_Message: TStatusBar;
    btn_Print: TSpeedButton;
    btn1: TBitBtn;
    edt_gm_nm: TEdit;
    btn_Inquiry: TSpeedButton;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    edt_rg_su: TEdit;
    edt_cl_su: TEdit;
    edt_ag_su: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure edt_rg_suChange(Sender: TObject);
    procedure edt_cl_suChange(Sender: TObject);
    procedure edt_ag_suChange(Sender: TObject);
    procedure edt_rg_suKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cl_suKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ag_suKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_rg_suKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_cl_suKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_gm_cdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GM_CD : String;

  frm_LOSTC140P_CHILD: Tfrm_LOSTC140P_CHILD;

implementation
uses u_LOSTC140P;

{$R *.dfm}


{-----------------------------------------------------------------------------}
procedure Tfrm_LOSTC140P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
  sts_Message.Panels[1].Text := '';

  frm_LOSTC140P.Enabled := False;

  if (Button.Name = 'btn_Add') then begin

    changeBtn(Self);
    btn_Add.Enabled := true;
    btn_Update.Enabled := false;
    btn_Delete.Enabled := false;
    btn_Inquiry.Enabled := false;

    edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
    edt_gm_cd.Text := '';
    edt_gm_nm.Text := '';
    edt_rg_su.Text := '0';
    edt_cl_su.Text := '0';
    edt_ag_su.Text := '0';
    edt_ct_am.Text := '0';
    edt_bi_go.Text := '';

    edt_ct_ym.Enabled := False;
    edt_gm_cd.Enabled := True;
    edt_gm_nm.Enabled := False;
    edt_ct_am.Enabled := False;
    edt_bi_go.Enabled := True;

    self.Show;
    edt_gm_cd.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin

   changeBtn(Self);
   btn_Add.Enabled := false;
   btn_Update.Enabled := true;
   btn_Delete.Enabled := false;
   btn_Inquiry.Enabled := false;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := frm_LOSTC140P.grd_display.Cells[5, frm_LOSTC140P.grd_display.Row];
   edt_cl_su.Text := frm_LOSTC140P.grd_display.Cells[6, frm_LOSTC140P.grd_display.Row];
   edt_ag_su.Text := frm_LOSTC140P.grd_display.Cells[7, frm_LOSTC140P.grd_display.Row];

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := False;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := True;

   edt_rg_su.SelectAll;

   self.Show;
  end else if (Button.Name = 'btn_Update') then  begin

   changeBtn(Self);
   btn_Add.Enabled := false;
   btn_Update.Enabled := True;
   btn_Delete.Enabled := False;
   btn_Inquiry.Enabled := false;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := RG_SU;
   edt_cl_su.Text := CL_SU;
   edt_ag_su.Text := AG_SU;

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := True;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := True;

   self.Show;
  end else if (Button.Name = 'btn_Delete') then  begin

   changeBtn(Self);
   btn_Add.Enabled := False;
   btn_Update.Enabled := False;
   btn_Delete.Enabled := True;
   btn_Inquiry.Enabled := False;

   edt_ct_ym.Text := frm_LOSTC140P.CalendarMonth1.Text;
   edt_gm_cd.Text := frm_LOSTC140P.grd_display.Cells[1, frm_LOSTC140P.grd_display.Row];
   edt_gm_nm.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
   edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[3, frm_LOSTC140P.grd_display.Row];
   edt_bi_go.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
   edt_rg_su.Text := RG_SU;
   edt_cl_su.Text := CL_SU;
   edt_ag_su.Text := AG_SU;

   edt_ct_ym.Enabled := False;
   edt_gm_cd.Enabled := False;
   edt_gm_nm.Enabled := False;
   edt_ct_am.Enabled := False;
   edt_bi_go.Enabled := False;

   self.Show;
  end;

end;

procedure Tfrm_LOSTC140P_CHILD.btn_CloseClick(Sender: TObject);
begin
 close;
 frm_LOSTC140P.Enabled := True;
 frm_LOSTC140P.Show;
 frm_LOSTC140P.btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTC140P_CHILD.btn1Click(Sender: TObject);
begin
  GM_CD := '';
  GM_CD := edt_gm_cd.Text;
  frm_LOSTC140P_POP.FormShow(Sender);
end;

procedure Tfrm_LOSTC140P_CHILD.FormCreate(Sender: TObject);
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
  
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC140P_CHILD.btn_AddClick(Sender: TObject);
  LABEL LIQUIDATION;
begin

  if(edt_gm_cd.Text = '' ) then begin
       ShowMessage('총괄코드를 입력해주십시오.');
    exit;
   end;

  if(edt_ct_ym.Text = '') then begin
       ShowMessage('조정달을 입력해주십시오.');
    exit;
   end;

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrToInt(delDelimiter(edt_rg_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT004', StrToInt(delDelimiter(edt_cl_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT005', StrToInt(delDelimiter(edt_ag_su.Text,','))  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT006', StrToInt(delDelimiter(edt_ct_am.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 등록 완료';
         ShowMessage('성공적으로 등록되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  edt_gm_cd.Text := '';
  edt_gm_nm.Text := '';
  edt_rg_su.Text := '0';
  edt_cl_su.Text := '0';
  edt_ag_su.Text := '0';
  edt_ct_am.Text := '0';
  edt_bi_go.Text := '';
  edt_gm_cd.SetFocus;
end;

procedure Tfrm_LOSTC140P_CHILD.btn_UpdateClick(Sender: TObject);
  LABEL LIQUIDATION;
begin

  if(edt_gm_cd.Text = '' ) then begin
       ShowMessage('총괄코드를 입력해주십시오.');
    exit;
   end;

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT003', StrToInt(delDelimiter(edt_rg_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT004', StrToInt(delDelimiter(edt_cl_su.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT005', StrToInt(delDelimiter(edt_ag_su.Text,','))  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendInteger('INT006', StrToInt(delDelimiter(edt_ct_am.Text,','))  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', edt_bi_go.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정 완료';
         ShowMessage('성공적으로 수정 되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  frm_LOSTC140P.btn_InquiryClick(Sender);
  close;

 end;
procedure Tfrm_LOSTC140P_CHILD.btn_DeleteClick(Sender: TObject);
  LABEL LIQUIDATION;
begin
 if MessageDlg('삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='삭제가 취소되었습니다';
      exit;
   end else
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

      //공통입력 부분
    if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTC140P'      )   < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_ct_ym.Text  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', edt_gm_cd.Text  )   < 0) then  goto LIQUIDATION;

      //서비스 호출
    if not TMAX.Call('LOSTC140P') then
      begin
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

        goto LIQUIDATION;
      end
    else
      begin
          sts_Message.Panels[1].Text := ' 삭제 완료';
           ShowMessage('성공적으로 삭제 되었습니다.')
      end;

  LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

 end; // begin ~ end

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suChange(Sender: TObject);
var
   cnt : Integer;
begin
{
  edt_ct_am.Text := frm_LOSTC140P.grd_display.Cells[2, frm_LOSTC140P.grd_display.Row];
  edt_rg_su.Text := frm_LOSTC140P.grd_display.Cells[4, frm_LOSTC140P.grd_display.Row];
  edt_cl_su.Text := frm_LOSTC140P.grd_display.Cells[5, frm_LOSTC140P.grd_display.Row];
  edt_ag_su.Text := frm_LOSTC140P.grd_display.Cells[6, frm_LOSTC140P.grd_display.Row];
 }
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 최대성 수정 *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suChange(Sender: TObject);
var
   cnt : Integer;
begin
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 최대성 수정 *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_ag_suChange(Sender: TObject);
var
   cnt : Integer;
begin
  if (Length(edt_rg_su.Text) = 0) or (Length(edt_cl_su.Text) = 0) or (Length(edt_ag_su.Text) = 0)
  then begin
    edt_ct_am.Text := '';
    exit;
  end;

  {* 2012.05.02 최대성 수정 *}
  if StrToInt(edt_ct_ym.Text) < 201205 then
    cnt := (StrToInt(edt_rg_su.Text) * 100) + (StrToInt(edt_cl_su.Text) * 1100) + (StrToInt(edt_ag_su.Text) * 800 )
  else
    cnt := (StrToInt(edt_rg_su.Text) * 500) + (StrToInt(edt_cl_su.Text) * 1400) + (StrToInt(edt_ag_su.Text) * 800 );

  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));
end;

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_ag_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTC140P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 frm_LOSTC140P.Enabled := True;
 frm_LOSTC140P.Show;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_rg_suKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then begin edt_cl_su.SetFocus; end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_cl_suKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then begin edt_ag_su.SetFocus; end;
end;

procedure Tfrm_LOSTC140P_CHILD.edt_gm_cdKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if Key = VK_RETURN then begin
  btn1Click(Sender);
 end;
end;

end.
