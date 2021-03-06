unit u_LOSTZ140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '프로그램권한등록 ';
  PGM_ID  = 'LOSTZ140P';

type
  Tfrm_LOSTZ140P = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_excel: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    cmb_up_gu: TComboBox;
    grd_user_g: TStringGrid;
    grd_prgm: TStringGrid;
    sts_Message: TStatusBar;
    btn_reset: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grd_user_gDblClick(Sender: TObject);
    procedure grd_prgmDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
 
  private
    { Private declarations }
    cmb_up_gu_d: TZ0xxArray;
    // 그리드
    procedure initStrGrid_user;
    procedure initStrGrid_prgm;
    // Search
    procedure user_group_search;
    procedure user_prgm_search;

  public
    { Public declarations }
  end;

var
  frm_LOSTZ140P: Tfrm_LOSTZ140P;

implementation

{$R *.dfm}

procedure Tfrm_LOSTZ140P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ140P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTZ140P.initStrGrid_user;
begin
	with grd_user_g do begin
    	RowCount :=2;
      ColCount := 2;
    	RowHeights[0] := 21;

    	ColWidths[0] := 120;
		Cells[0,0] :='그룹코드';

    	ColWidths[1] := 140;
		Cells[1,0] :='그룹명';
    end;
end;


procedure Tfrm_LOSTZ140P.initStrGrid_prgm;
begin
	with grd_prgm do begin
    	RowCount :=2;
      ColCount := 6;
    	RowHeights[0] := 21;

    	ColWidths[0] := 70;
		Cells[0,0] :='변경여부';

    	ColWidths[1] := 100;
		Cells[1,0] :='프로그램ID';

    	ColWidths[2] := 200;
		Cells[2,0] :='프로그램명';

      ColWidths[3] := 90;
		Cells[3,0] :='사용권한여부';

      ColWidths[4] := 50;
		Cells[4,0] :='기존 사용권한여부';

      ColWidths[5] := 50;
		Cells[5,0] :='그룹코드';
    end;
end;

Procedure Tfrm_LOSTZ140P.user_group_search;
var
    i:Integer;
    count1, count2, totalCount:Integer;
    seq,RowPos:Integer;
    Label LIQUIDATION;
    Label INQUIRY;
begin
	  //그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_user_g.RowCount := 2;

    //시작시변수 초기화
    totalCount :=0;
    grd_user_g.Cursor := crSQLWait;	//작업중....

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
	if (TMAX.SendString('INF003','LOSTZ140P') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ140P') then
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
    for i := grd_user_g.fixedrows to grd_user_g.rowcount - 1 do
    grd_user_g.rows[i].Clear;
    grd_user_g.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;

  totalCount:= totalCount + count1;
  grd_user_g.RowCount := grd_user_g.RowCount + count1;

  with grd_user_g do begin
    for i:=0 to count1-1 do begin
        Cells[0,RowPos] := TMAX.RecvString('STR101',i); //메뉴구분명
        Cells[1,RowPos] := TMAX.RecvString('STR102',i); //메뉴중레벨

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
    grd_user_g.Cursor := crDefault;	//작업완료
    grd_user_g.RowCount := grd_user_g.RowCount -1;
end;


Procedure Tfrm_LOSTZ140P.user_prgm_search;
var
    i:Integer;
    count1, count2, totalCount:Integer;
    seq,RowPos:Integer;

    AUTH_YN : String;
      UR_GU : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    sts_Message.Panels[1].Text := ''; 

    UR_GU := '';
    UR_GU := grd_user_g.Cells[0, grd_user_g.Row];

	  //그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_prgm.RowCount := 2;

    //시작시변수 초기화
    totalCount :=0;
    grd_prgm.Cursor := crSQLWait;	//작업중....

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
	if (TMAX.SendString('INF003','LOSTZ140P') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', cmb_up_gu_d[cmb_up_gu.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', UR_GU )   < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ140P') then
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
    for i := grd_prgm.fixedrows to grd_prgm.rowcount - 1 do
    grd_prgm.rows[i].Clear;
    grd_prgm.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;
    {
  if count1 < 1 then begin
    for i := grd_prgm.fixedrows to grd_prgm.rowcount - 1 do
    grd_prgm.rows[i].Clear;
  grd_prgm.RowCount := 3;
  goto LIQUIDATION;
  end;
     }



    totalCount:= totalCount + count1;
    grd_prgm.RowCount := grd_prgm.RowCount + count1;

    if ( count1 = 0 ) then begin
        grd_prgm.RowCount  := 2;
        goto LIQUIDATION;
      end;

    with grd_prgm do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos] := ''; //변경 여부
          Cells[1,RowPos] := TMAX.RecvString('STR101',i); // 프로그램 ID
          Cells[2,RowPos] := TMAX.RecvString('STR102',i); // 프로그램 명
          Cells[3,RowPos] := TMAX.RecvString('STR103',i); // 사용권한여부
          Cells[4,RowPos] := TMAX.RecvString('STR103',i); // 기존 사용권한여부
          Cells[5,RowPos] := TMAX.RecvString('STR104',i); // 그룹코드

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
    grd_prgm.Cursor := crDefault;	//작업완료
    grd_prgm.RowCount := grd_prgm.RowCount -1;
end;

{---------------------------------------------------------------------------}
procedure Tfrm_LOSTZ140P.FormCreate(Sender: TObject);
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
  {   }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2); 
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4); 
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);


  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);


  initSkinForm(SkinData1);
  initStrGrid_user;	//그리드 초기화
  initComboBoxWithZ0xx('Z097.dat', cmb_up_gu_d, '전체', ' ',cmb_up_gu);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ140P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTZ140P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ140P.grd_user_gDblClick(Sender: TObject);
begin
  initStrGrid_prgm;
  user_prgm_search;

end;

procedure Tfrm_LOSTZ140P.grd_prgmDblClick(Sender: TObject);
begin
  if ( grd_prgm.Cells[0, grd_prgm.Row] = '' ) then begin
     grd_prgm.Cells[0, grd_prgm.Row] := '수정';

  end else begin
     grd_prgm.Cells[0, grd_prgm.Row] := '';
  end;

  if (grd_prgm.Cells[3, grd_prgm.Row] = 'Y') then begin
   grd_prgm.Cells[3, grd_prgm.Row] := 'N';
  end else begin
   grd_prgm.Cells[3, grd_prgm.Row] := 'Y';
  end;

end;

procedure Tfrm_LOSTZ140P.btn_UpdateClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;
  seq,RowPos:Integer;

  NEW_AU : String;
  PRE_AU : String;


  LABEL LIQUIDATION;
begin
  RowPos := 1;

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

	TMAX.AllocBuffer(1024*1024);
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
	if (TMAX.SendString('INF003','LOSTZ140P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;

  for i:= grd_prgm.FixedRows to grd_prgm.RowCount - 1 do begin
    NEW_AU :=  grd_prgm.Cells[3,i];
    PRE_AU :=  grd_prgm.Cells[4,i];

    if ( NEW_AU <> PRE_AU ) then begin
      if (TMAX.SendString('STR001', grd_prgm.Cells[1,i]  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR002', grd_prgm.Cells[3,i]  )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR003', grd_prgm.Cells[5,i]  )   < 0) then  goto LIQUIDATION;

    end;
  end;

  //서비스 호출
	if not TMAX.Call('LOSTZ140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정  완료';
         ShowMessage('성공적으로 수정되었습니다.')
    end;

  LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

  user_prgm_search;
  end;
procedure Tfrm_LOSTZ140P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);

  btn_Link.Enabled := False;
  btn_excel.Enabled := False;
  btn_Print.Enabled := False;
  btn_Add.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Inquiry.Enabled := False;
  sts_Message.Panels[1].Text := '';
  user_group_search;

  for i := grd_prgm.fixedrows to grd_prgm.rowcount - 1 do
    grd_prgm.rows[i].Clear;
    grd_prgm.RowCount := 2;

end;

end.



