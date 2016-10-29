{*---------------------------------------------------------------------------
프로그램ID    : LOSTA660L(국내소포 수령증 원부)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 05
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
unit u_LOSTA660L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '국내소포수령증원부(EXCEL)';
  PGM_ID  = 'LOSTA660L';

type
  Tfrm_LOSTA660L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    grd_code: TStringGrid;
    Label1: TLabel;
    Bevel1: TBevel;
    dtp_tm_to: TDateTimePicker;
    Label3: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    dtp_tm_from: TDateTimePicker;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTA660L: Tfrm_LOSTA660L;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA660L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA660L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled := True;
  dte_to.Enabled := True;
  dtp_tm_from.Enabled := True;
  dtp_tm_to.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA660L.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount :=13;

		Cells[0,0]  :='등기번호';
		Cells[1,0]  :='중량';
		Cells[2,0]  :='요금';
		Cells[3,0]  :='사업자코드';
		Cells[4,0]  :='성명';
		Cells[5,0]  :='주소';
		Cells[6,0]  :='우편번호';
		Cells[7,0]  :='모델명';
		Cells[8,0]  :='일련번호';
		Cells[9,0]  :='창고번호';
    Cells[10,0] :='반송여부';
    Cells[11,0] :='가입자연락처';
    Cells[12,0] :='보험금상태';    

  end;
end;

procedure Tfrm_LOSTA660L.setEdtKeyPress;
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

procedure Tfrm_LOSTA660L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA660L.FormCreate(Sender: TObject);
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
	//common_username:= '정호영'; //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);
  initStrGrid;
  btn_ResetClick(Sender);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA660L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA660L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

procedure Tfrm_LOSTA660L.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA660L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;


  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;
  STR010 : String;
  tempdtfrom : String;
  tempdtto : String;

  Label LIQUIDATION;
  Label INQUIRY;
begin

   //그리드초기화
   pInitStrGrd(Self);

	 //그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;
    datetimetostring(tempdtfrom, 'hhmmss', dtp_tm_from.time);
    datetimetostring(tempdtto, 'hhmmss', dtp_tm_to.time);
    //시작시변수 초기화

    
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';
    STR010 :=' ';
    qryStr := ' ';

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
	if (TMAX.SendString('INF002',common_userid            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA660L'              ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', FormatDateTime('HHMMSS',dtp_tm_from.time) ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004', FormatDateTime('HHMMSS',dtp_tm_to.time)   ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', STR010) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTA660L') then
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

    ShowMessage('출력할 자료가 없습니다.');

    goto LIQUIDATION;
  end;
    
  totalCount:= totalCount + count1;
  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin

      Cells[ 3,RowPos]  := TMAX.RecvString('STR101',i);     //사업자코드
      Cells[ 4,RowPos]  := TMAX.RecvString('STR102',i);     //성명
      Cells[ 5,RowPos]  := TMAX.RecvString('STR103',i);     //주소
      Cells[ 6,RowPos]  := TMAX.RecvString('STR104',i);     //우편번호
      Cells[ 7,RowPos]  := TMAX.RecvString('STR105',i);     //모델명
      Cells[ 8,RowPos]  := TMAX.RecvString('STR111',i);     //모델명
      Cells[ 9,RowPos]  := TMAX.RecvString('STR106',i);     //창고번호
      Cells[10,RowPos]  := TMAX.RecvString('STR107',i);     //반송여부
      Cells[11,RowPos] := TMAX.RecvString('STR108',i);      //이동전화
      Cells[12,RowPos] := TMAX.RecvString('STR114',i);      //보험금상태

      STR005 := Trim(TMAX.RecvString('STR109',i)); // 조회시작 구분코드
      STR006 := Trim(TMAX.RecvString('STR106',i)); // 조회시작 창고번호
      STR007 := Trim(TMAX.RecvString('STR110',i)); // 조회시작 출고시간
      STR008 := Trim(TMAX.RecvString('STR113',i)); // 조회시작 모델코드
      STR009 := Trim(TMAX.RecvString('STR111',i)); // 조회시작 일련번호
      STR010 := Trim(TMAX.RecvString('STR112',i)); // 조회시작 입고일자

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

  qryStr:= TMAX.RecvString('INF014',0);
  //엑셀로 출력
	Proc_gridtoexcel('분실폰관리(LOSTA660L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA660L');

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1;

  enableComponents;
end;

procedure Tfrm_LOSTA660L.btn_ResetClick(Sender: TObject);
begin
	dte_from.Date     := date-1;
	dte_to.Date       := date-1;
  dtp_tm_from.Time  := StrToTime('오전 7:00:00');
  dtp_tm_to.Time    := StrToTime('오후 11:00:00');

  changeBtn(Self);

end;

procedure Tfrm_LOSTA660L.btn_queryClick(Sender: TObject);
var
  cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    exit;

  filePath:='..\Temp\LOSTA660L_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA660L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

end.
