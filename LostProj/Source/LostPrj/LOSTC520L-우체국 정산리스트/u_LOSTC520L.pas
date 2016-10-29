{*---------------------------------------------------------------------------
프로그램ID    : LOSTC520L (우체국정산현황 Excel)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 10. 04
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
unit u_LOSTC520L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, monthEdit, ComObj;

const
  TITLE   = '우체국정산리스트(EXCEL)';
  PGM_ID  = 'LOSTC520L';

type
  Tfrm_LOSTC520L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel; 
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label2: TLabel;
    cmb_pl_cd: TComboBox;
    cmb_inq_gu: TComboBox;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    CalendarMonth1: TCalendarMonth;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure cmb_inq_guChange(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    cmb_pl_cd_d: TZ0xxArray;
    qryStr:String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTC520L: Tfrm_LOSTC520L;

implementation
uses   u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTC520L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC520L.enableComponents;
begin
  changeBtn(Self);

	CalendarMonth1.Enabled := True;
  cmb_inq_gu.Enabled := True;
  cmb_pl_cd.Enabled := True;

  if cmb_inq_gu.ItemIndex = 0 then begin
  cmb_pl_cd.Enabled := False;
  end else begin
  cmb_pl_cd.Enabled := True;
  end;
  
  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTC520L.setEdtKeyPress;
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

procedure Tfrm_LOSTC520L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTC520L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 20;

  Cells[0,0]  :='SEQ';
  Cells[1,0]  :='체신청번호';
  Cells[2,0]  :='체신청청명';
  Cells[3,0]  :='총괄국번호';
  Cells[4,0]  :='총괄국청명';
  Cells[5,0]  :='계좌번호';
  Cells[6,0]  :='인터넷등록건수';
  Cells[7,0]  :='인터넷등록수금액';
  Cells[8,0]  :='우체국출고건수';
  Cells[9,0]  :='우체국출고금액';
  Cells[10,0]  :='대행건수';
  Cells[11,0]  :='대행수수료';
  Cells[12,0]  :='인수증지연건수';
  Cells[13,0] :='인수증지연금액';
  Cells[14,0] :='핸드폰지연건수';
  Cells[15,0] :='핸드폰지연금액';
  Cells[16,0] :='기타조정건수';
  Cells[17,0] :='기타조정금액';
  Cells[18,0] :='건수합계';
  Cells[19,0] :='금액합계';
    end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTC520L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTC520L.FormCreate(Sender: TObject);
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

  initStrGrid;
	initSkinForm(SkinData1); //common_lib.pas에 있다.
  initComboBoxWithZ0xx('Z050.dat', cmb_pl_cd_d, '전체', '',cmb_pl_cd);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTC520L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTC520L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    seq,count1, count2, totalCount:Integer;

    RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

   //그리드초기화
   pInitStrGrd(Self);

	//그리드 디스플레이
  seq := 1;
  RowPos:= 1;	//그리드 레코드 포지션
  grd_display.RowCount := 2;

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
	if (TMAX.SendString('INF003','LOSTC520L') < 0) then  goto LIQUIDATION;

  if cmb_inq_gu.ItemIndex = 0 then begin
  	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
  end else begin
  	if (TMAX.SendString('INF001','P02') < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', CalendarMonth1.Text) < 0) then  goto LIQUIDATION;
	  if (TMAX.SendString('STR002', cmb_pl_cd_d[cmb_pl_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;
  end;

  //서비스 호출
  if not TMAX.Call('LOSTC520L') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

  //쿼리를 얻는다.
  qryStr:= TMAX.RecvString('INF014',0);


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
            Cells[0,RowPos]  := IntToStr(seq);
            Cells[1,RowPos]  := TMAX.RecvString('STR118',i);  // 체신청번호
            Cells[2,RowPos]  := TMAX.RecvString('STR119',i);  // 체신청명
            Cells[3,RowPos]  := TMAX.RecvString('STR101',i);  // 총괄국번호
            Cells[4,RowPos]  := TMAX.RecvString('STR102',i);  // 총괄국청명
            Cells[5,RowPos]  := TMAX.RecvString('STR103',i);  // 계좌번호
            Cells[6,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT104',i)));    // 인터넷등록건수
            Cells[7,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL105',i)));   // 인터넷등록수수료
            Cells[8,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT106',i)));    // 우체국출고건수
            Cells[9,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL107',i)));   // 우체국출고수수료
            Cells[10,RowPos]  := convertWithCommer(IntToStr(TMAX.RecvInteger('INT108',i)));    // 대행건수
            Cells[11,RowPos]  := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL109',i)));   // 대행수수료
            Cells[12,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT110',i)));    // 인수증지연건수
            Cells[13,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL111',i)));   // 인수증지연금액
            Cells[14,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT112',i)));    // 핸드폰지연건수
            Cells[15,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL113',i)));   // 핸드폰지연금액
            Cells[16,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT114',i)));    // 기타조정건수
            Cells[17,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL115',i)));   // 기타조정금액
            Cells[18,RowPos] := convertWithCommer(IntToStr(TMAX.RecvInteger('INT116',i)));    // 건수합계
            Cells[19,RowPos] := convertWithCommer(FloatToStr(TMAX.RecvDouble('DBL117',i)));   // 금액합계

          Inc(seq);
          Inc(RowPos);
        end;
    end;
    //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    //디폴트로 설정한 상한 값


    //엑셀로 출력
	Proc_gridtoexcel('우체국정산현황(EXCEL)(LOSTC520L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTC520L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;

procedure Tfrm_LOSTC520L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTC520L_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTC520L.cmb_inq_guChange(Sender: TObject);
begin
 if cmb_inq_gu.ItemIndex = 0 then begin
  cmb_pl_cd.Enabled := False;
 end else begin
  cmb_pl_cd.Enabled := True;
 end;
end;

procedure Tfrm_LOSTC520L.btn_ResetClick(Sender: TObject);
begin
  CalendarMonth1.SetFocus;
  cmb_inq_gu.ItemIndex := 1;
  cmb_pl_cd.Enabled := False;
  CalendarMonth1.Text := Copy(delHyphen(DateToStr(date-30)),1,6);
  changeBtn(Self);
  cmb_inq_guChange(Sender);
end;

end.
