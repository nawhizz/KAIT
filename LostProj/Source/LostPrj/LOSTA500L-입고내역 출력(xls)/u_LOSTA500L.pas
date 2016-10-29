{*---------------------------------------------------------------------------
프로그램ID    : LOSTA500L (입고내역출력(EXCELL))
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011.08.26
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
unit u_LOSTA500L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
 TITLE   = '입고내역출력(EXCEL)';
 PGM_ID  = 'LOSTA500L';

type
  Tfrm_LOSTA500L = class(TForm)
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
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
  private
    { Private declarations }
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    //실행중 콤포넌트 사용중지
    procedure disableComponents;
    //실행완료 후 콤포넌트 사용 가능하게
    procedure enableComponents;
  end;

var
  frm_LOSTA500L: Tfrm_LOSTA500L;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA500L.disableComponents;
begin
    dte_From.Enabled := false;
    dte_To.Enabled := false;
    btn_Close.Enabled := false;
    btn_Print.Enabled := false;


end;

procedure Tfrm_LOSTA500L.enableComponents;
begin
    dte_From.Enabled := true;
    dte_To.Enabled := true;
    btn_Close.Enabled := true;
    btn_Print.Enabled := true;
end;

procedure Tfrm_LOSTA500L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 16;

	Cells[0,0]  :='구분명';
  Cells[1,0]  :='사업자ID';
	Cells[2,0]  :='사업자명';
	Cells[3,0]  :='모델코드';
	Cells[4,0]  :='모델명';
	Cells[5,0]  :='일련번호';
	Cells[6,0]  :='가입자명';
	Cells[7,0]  :='이동전화번호';
	Cells[8,0]  :='입고일자';
	Cells[9,0]  :='연락필요여부';
 	Cells[10,0]  :='출고일자';
  Cells[11,0] :='창고번호';
  Cells[12,0] :='구분';
  Cells[13,0] :='수취거부';
  Cells[14,0] :='본인폰';
  Cells[15,0] :='보험금상태';

    end;
end;

procedure Tfrm_LOSTA500L.setEdtKeyPress;
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

procedure Tfrm_LOSTA500L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA500L.FormCreate(Sender: TObject);
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
  btn_resetClick(Sender);
  initSkinForm(SkinData1);
  initStrGrid;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;


procedure Tfrm_LOSTA500L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA500L.dte_FromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

procedure Tfrm_LOSTA500L.dte_ToExit(Sender: TObject);
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


procedure Tfrm_LOSTA500L.FormShow(Sender: TObject);
begin
  dte_from.SetFocus;
  dte_from.Date := date;
  dte_from.Date := Date;
end;


procedure Tfrm_LOSTA500L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;

  STR003 : String;
	STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;


    Label LIQUIDATION;
    Label INQUIRY;
begin
	//그리드 디스플레이

    pInitStrGrd(Self);

    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화

    STR003 :=' ';
    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :='%%%XX%%%';
    STR009 :='%%%본인%%%';

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
	if (TMAX.SendString('INF003','LOSTA500L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR005', delHyphen(STR005)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;

    //서비스 호출
  if not TMAX.Call('LOSTA500L') then
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

    if totalCount = 0 then begin
      for i := grd_display.fixedrows to grd_display.rowcount - 1 do
        grd_display.rows[i].Clear;

      grd_display.RowCount := 3;

      ShowMessage('출력할 자료가 없습니다.');

      goto LIQUIDATION;
    end;

    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

        STR003 := Trim(TMAX.RecvString('STR101',i));  //조회시작구분코드
        STR004 := Trim(TMAX.RecvString('STR102',i)); // 조회시작사업자코드
        STR005 := Trim(TMAX.RecvString('STR110',i)); // 조회시작입고날자
        STR006 := Trim(TMAX.RecvString('STR105',i)); // 조회시작모델코드
        STR007 := Trim(TMAX.RecvString('STR107',i)); // 조회시작일련번호

        Cells[0,RowPos]  := TMAX.RecvString('STR103',i);     //구분명
        Cells[1,RowPos]  := STR004;                          //사업자코드
        Cells[2,RowPos]  := TMAX.RecvString('STR104',i);     //사업자명
        Cells[3,RowPos]  := TMAX.RecvString('STR105',i);     //모델코드
        Cells[4,RowPos]  := TMAX.RecvString('STR106',i);     //모델명            
        Cells[5,RowPos]  := TMAX.RecvString('STR107',i);     //일련번호
        Cells[6,RowPos]  := TMAX.RecvString('STR108',i);     //가입자명
        Cells[7,RowPos]  := TMAX.RecvString('STR119',i);     //이동전화번호
        Cells[8,RowPos]  := TMAX.RecvString('STR110',i);     //입고일자
        Cells[9,RowPos]  := TMAX.RecvString('STR111',i);     //연락필요여부 (Y,n)
        Cells[10,RowPos] := TMAX.RecvString('STR112',i);     //출고일자
        Cells[11,RowPos] := TMAX.RecvString('STR113',i);	   //창고번호
        Cells[12,RowPos] := TMAX.RecvString('STR114',i);	   //구분(구형/신형)
        Cells[13,RowPos] := TMAX.RecvString('STR115',i);	   //수취거부 (Y/n)
        Cells[14,RowPos] := TMAX.RecvString('STR116',i);	   //본인폰(Y/n)
        Cells[15,RowPos] := TMAX.RecvString('STR117',i);	   //보험금상태

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
	Proc_gridtoexcel('입고내역출력(EXCEL)(LOSTA500L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA500L');

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//작업완료
  grd_display.RowCount := grd_display.RowCount -1;
  enableComponents;

end;






procedure Tfrm_LOSTA500L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

  filePath:='..\Temp\LOSTA500_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA500L.btn_ResetClick(Sender: TObject);
begin
	dte_from.Date := date-30;
	dte_to.Date := date;
  changeBtn(Self);
end;

end.
