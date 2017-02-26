{*---------------------------------------------------------------------------
프로그램ID    : LOSTA880L(경찰서습득단말기수취확인대상출력(EXCELL))
프로그램 종류 : Online
작성자	      : 유영배
작성일	      : 2013.10.28
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
unit u_LOSTA880L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '경찰서습득단말기수취확인대상출력(EXCEL)';
  PGM_ID  = 'LOSTA880Q';

type
  Tfrm_LOSTA880L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    Panel1: TPanel;
    Label5: TLabel;
    Bevel3: TBevel;
    Dte_Fr_Dt: TDateEdit;
    Label6: TLabel;
    Bevel4: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    grd_code: TStringGrid;
    Fr_Tm_H: TMaskEdit;
    Fr_Tm_M: TMaskEdit;
    To_Tm_H: TMaskEdit;
    To_Tm_M: TMaskEdit;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
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
  frm_LOSTA880L: Tfrm_LOSTA880L;

implementation

{$R *.DFM}

procedure Tfrm_LOSTA880L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA880L.enableComponents;
begin
  changeBtn(Self);

  Dte_Fr_Dt.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTA880L.setEdtKeyPress;
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

procedure Tfrm_LOSTA880L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA880L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount :=18;

		Cells[0,0]   :='등록시간';
    Cells[1,0]   :='경찰서ID';
		Cells[2,0]   :='경찰서명';
    Cells[3,0]   :='전화번호';
    Cells[4,0]   :='관리번호';
    Cells[5,0]   :='획득순번';
		Cells[6,0]   :='사업자명';
		Cells[7,0]   :='모델명';
		Cells[8,0]   :='일련번호';
		Cells[9,0]   :='이동전화번호';
		Cells[10,0]  :='가입자번호';
		Cells[11,0]  :='가입자성명';
    Cells[12,0]  :='가입자전화번호';
    Cells[13,0]  :='가입자주소';
		Cells[14,0]  :='납부자번호';
		Cells[15,0]  :='납부자성명';
		Cells[16,0]  :='납부자전화번호';
		Cells[17,0]  :='납부자 주소';
		Cells[18,0]  :='보험금 상태';

    end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA880L.FormCreate(Sender: TObject);
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
  { }
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

  qryStr := '';
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTA880L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTA880L.btn_PrintClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_nanm, seed_nano, seed_natl : String;

    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;

    tempdt1 : string;
    tempdt2 : string;


  Label LIQUIDATION;
  Label INQUIRY;
begin
   // 암호화 모듈
   ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

   seed_ganm := '';
   seed_gano := '';
   seed_gatl := '';
   seed_mtno := '';
   seed_nanm := '';
   seed_nano := '';
   seed_natl := '';

   //그리드초기화
   pInitStrGrd(Self);

   //그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

      // 한자리 숫자 입력시 0 붙여주기
      if length(trim(copy(Fr_Tm_H.text,1,2))) = 1 then
      begin
         Fr_Tm_H.text := '0' + trim(copy(Fr_Tm_H.text,1,2));
      end;

      if length(trim(copy(Fr_Tm_M.text,1,2))) = 1 then
      begin
         Fr_Tm_M.text := '0' + trim(copy(Fr_Tm_M.text,1,2));
      end;

      if length(trim(copy(To_Tm_H.text,1,2))) = 1 then
      begin
         To_Tm_H.text := '0' + trim(copy(To_Tm_H.text,1,2));
      end;

      if length(trim(copy(To_Tm_M.text,1,2))) = 1 then
      begin
         To_Tm_M.text := '0' + trim(copy(To_Tm_M.text,1,2));
      end;



      tempdt1 := copy(Fr_Tm_H.text,1,2)+copy(Fr_Tm_M.text,1,2);

      tempdt2 := copy(To_Tm_H.text,1,2)+copy(To_Tm_M.text,1,2);



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
	if (TMAX.SendString('INF003','LOSTA880Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(Dte_Fr_Dt.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', tempdt1) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', tempdt2) < 0) then  goto LIQUIDATION;


  //서비스 호출
  if not TMAX.Call('LOSTA880Q') then
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

    //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
    qryStr:= TMAX.RecvString('INF014',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    ShowMessage('출력할 자료가 없습니다.');
    goto LIQUIDATION;
  end;

      
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i);     // 등록시간
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i);     // 경찰서ID
          Cells[2,RowPos]  := TMAX.RecvString('STR103',i);     // 경찰서명
          Cells[3,RowPos]  := TMAX.RecvString('STR104',i);     // 전화번호
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i);     // 관리번호
          Cells[5,RowPos]  := TMAX.RecvString('STR106',i);     // 획득순번
          Cells[6,RowPos]  := TMAX.RecvString('STR107',i);     // 사업자명
          Cells[7,RowPos]  := TMAX.RecvString('STR108',i);     // 모델명
          Cells[8,RowPos]  := TMAX.RecvString('STR109',i);     // 일련번호
          seed_mtno        := TMAX.RecvString('STR110',i);     // 이동전화번호
          Cells[9,RowPos]  := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
          seed_gano        := TMAX.RecvString('STR111',i);     // 가입자번호
          Cells[10,RowPos] := ECPlazaSeed.Decrypt(seed_gano, common_seedkey);
          seed_ganm        := TMAX.RecvString('STR112',i);     // 가입자성명
          Cells[11,RowPos] := ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
          seed_gatl        := TMAX.RecvString('STR113',i);     // 가입자전화번호
          Cells[12,RowPos] := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
          Cells[13,RowPos] := TMAX.RecvString('STR114',i);     // 가입자주소
          seed_nano        := TMAX.RecvString('STR115',i);     // 납부자번호
          Cells[14,RowPos] := ECPlazaSeed.Decrypt(seed_nano, common_seedkey);
          seed_nanm        := TMAX.RecvString('STR116',i);     // 납부자성명
          Cells[15,RowPos] := ECPlazaSeed.Decrypt(seed_nanm, common_seedkey);
          seed_natl        := TMAX.RecvString('STR117',i);     // 납부자전화번호
          Cells[16,RowPos] := ECPlazaSeed.Decrypt(seed_natl, common_seedkey);
          Cells[17,RowPos] := TMAX.RecvString('STR118',i);     // 납부자 주소
          Cells[18,RowPos] := TMAX.RecvString('STR119',i);     // 보험금 상태

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

  // 쿼리를 받는다.
  qryStr:= TMAX.RecvString('INF014',0);
  //엑셀로 출력
	Proc_gridtoexcel('분실폰관리(LOSTA880L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA660L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;
end;

procedure Tfrm_LOSTA880L.btn_ResetClick(Sender: TObject);
begin
  Dte_Fr_Dt.date := date;
  changeBtn(Self);
  
  Fr_Tm_H.Text := '00';
  Fr_Tm_M.Text := '00';
  To_Tm_H.Text := '23';
  To_Tm_M.Text := '59';
end;

procedure Tfrm_LOSTA880L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA880Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	  WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTA880L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

end.
