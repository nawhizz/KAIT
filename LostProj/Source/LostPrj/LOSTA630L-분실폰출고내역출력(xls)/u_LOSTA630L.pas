{*---------------------------------------------------------------------------
프로그램ID    : LOSTA630L (분실폰출고내역출력(EXCEL))
프로그램 종류 : Online
작성자	      : 정홍렬
작성일	      : 2011. 08. 17
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
unit u_LOSTA630L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '분실폰출고내역출력(EXCEL)';
  PGM_ID  = 'LOSTA630L';

type
  Tfrm_LOSTA630L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_From: TDateEdit;
    dte_To: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    cmb_id_cd: TComboBox;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    Bevel3: TBevel;
    cmb_sp_cd: TComboBox;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_FromExit(Sender: TObject);
    procedure dte_ToExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
  private
    { Private declarations }
   cmb_id_cd_d: TZ0xxArray;
   cmb_sp_cd_d: TZ0xxArray;
   qryStr:String;

  public
    { Public declarations }
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;
  end;

var
  frm_LOSTA630L: Tfrm_LOSTA630L;

implementation

{$R *.DFM}
procedure Tfrm_LOSTA630L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA630L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled  := True;
  dte_to.Enabled    := True;
  cmb_id_cd.Enabled := True;
  cmb_sp_cd.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA630L.initStrGrid;
begin
	with grd_display do begin
    RowCount    :=  2;
    ColCount    := 14;

		Cells[0,0]  :='입고일자';
		Cells[1,0]  :='출고일자';
    Cells[2,0]  :='재출고일자';
		Cells[3,0]  :='모델명';
		Cells[4,0]  :='일련번호';
		Cells[5,0]  :='창고번호';
		Cells[6,0]  :='가입명';
		Cells[7,0]  :='주민번호';
		Cells[8,0]  :='전화번호';
		Cells[9,0]  :='분실휴대폰번호';
 		Cells[10,0] :='주소';
    Cells[11,0] :='출고구분명';
    Cells[12,0] :='사업자반송상태여부';
    Cells[13,0] :='보험금상태';    


    end;
end;

procedure Tfrm_LOSTA630L.setEdtKeyPress;
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

procedure Tfrm_LOSTA630L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA630L.FormCreate(Sender: TObject);
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
  {    }
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
	//common_username:= '정호영'; //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);
  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', ' ',cmb_id_cd);
  initComboBoxWithZ0xx('Z041.dat', cmb_sp_cd_d, '전체', ' ',cmb_sp_cd);
  initStrGrid;
  btn_ResetClick(Sender);




  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA630L.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTA630L.dte_FromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

procedure Tfrm_LOSTA630L.dte_ToExit(Sender: TObject);
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

procedure Tfrm_LOSTA630L.FormShow(Sender: TObject);
begin
  cmb_id_cd.ItemIndex:=0;
  dte_from.SetFocus;
	dte_from.Date := date-30;
	dte_to.Date := date;
end;


procedure Tfrm_LOSTA630L.btn_PrintClick(Sender: TObject);
var
  i:Integer;
  count1, count2, totalCount:Integer;

  RowPos:Integer;

	STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    //그리드초기화
    pInitStrGrd(Self);

	  //그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화

    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';

    totalCount :=0;
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

//반복 조회
INQUIRY:

    TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA630L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', cmb_sp_cd_d[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR005', delHyphen(STR004)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR005) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR007', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', delHyphen(STR008)) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTA630L') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;



    //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    ShowMessage('출력할 자료가 없습니다.');
    goto LIQUIDATION;
  end;    

    with grd_display do begin
    	for i:=0 to count1-1 do begin

        STR004 := delHyphen(Trim(TMAX.RecvString('STR102',i))); // 출고일자
        STR005 := Trim(TMAX.RecvString('STR116',i)); // 출고구분코드
        STR006 := Trim(TMAX.RecvString('STR103',i)); // 모델코드
        STR007 := Trim(TMAX.RecvString('STR105',i)); // 단말기일련번호
        STR008 := delHyphen(Trim(TMAX.RecvString('STR101',i))); // 입고일자

        Cells[0,RowPos]  := TMAX.RecvString('STR101',i);	//입고일자
        Cells[1,RowPos]  := TMAX.RecvString('STR102',i);	//출고일자
        Cells[2,RowPos] := TMAX.RecvString('STR117',i);	// 재출고일자
        Cells[3,RowPos]  := TMAX.RecvString('STR104',i); //모델명
        Cells[4,RowPos]  := TMAX.RecvString('STR105',i);	//단말기일련번호
        Cells[5,RowPos]  := TMAX.RecvString('STR106',i);	// 창고일련번호
        Cells[6,RowPos]  := TMAX.RecvString('STR107',i);	// 가입자성명업체명
        Cells[7,RowPos]  := TMAX.RecvString('STR108',i);	// 가입자주민사업자번호
        Cells[8,RowPos]  := TMAX.RecvString('STR109',i);	// 가입자전화번호
        Cells[9,RowPos]  := TMAX.RecvString('STR110',i);	// 이동전화번호
        Cells[10,RowPos]  := TMAX.RecvString('STR111',i);	// 가입자주소
        Cells[11,RowPos] := TMAX.RecvString('STR112',i);	//출고구분명
        Cells[12,RowPos] := TMAX.RecvString('STR115',i);	// 사업자반송여부
        Cells[13,RowPos] := TMAX.RecvString('STR118',i);	// 보험금신청상태   



        Inc(RowPos);
      end;
    end;
    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    //디폴트로 설정한 상한 값
    count2 := TMAX.RecvInteger('INT100',0);
    if count1 = count2 then
    	goto INQUIRY;


   //엑셀로 출력
	 Proc_gridtoexcel('분실폰관리(LOSTA630L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA630L');
   qryStr:= TMAX.RecvString('INF014',0);

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;

procedure Tfrm_LOSTA630L.btn_ResetClick(Sender: TObject);
begin
	dte_from.Date := date-30;
	dte_to.Date := date;
  cmb_id_cd.ItemIndex:=0;
  changeBtn(Self);
end;

procedure Tfrm_LOSTA630L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    exit;

    filePath:='..\Temp\LOSTA630L_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.

