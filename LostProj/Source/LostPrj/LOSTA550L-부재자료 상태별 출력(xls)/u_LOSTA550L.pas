{*---------------------------------------------------------------------------
프로그램ID    :  LOSTA550(부재자료상태별출력(EXCEL))
프로그램 종류 : Online
작성자	      : 정홍렬
작성일	      : 2011. 08. 24
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
unit u_LOSTA550L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '부재자료상태별출력(EXCEL)';
  PGM_ID  = 'LOSTA550L';

type
  Tfrm_LOSTA550L = class(TForm)
    pnl_Command: TPanel;
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_from: TDateEdit;
    dte_to: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    Label3: TLabel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    grd_display: TStringGrid;
    GroupBox: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    Panel1: TPanel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_fromExit(Sender: TObject);
    procedure dte_toExit(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    cmb_id_cd_d: TZ0xxArray;
    qryStr : String;
  public
    { Public declarations }
    procedure initStrGrid;
    procedure disableComponents;
    procedure enableComponents;
    procedure CheckValue;
  end;

var
  frm_LOSTA550L: Tfrm_LOSTA550L;

  checked1:String;
  checked2:String;
  checked3:String;
  checked4:String;
  checked5:String;
  checked6:String;
  checked7:String;
  checked8:String;
  checked9:String;
  checked10:String;
  checked11:String;

implementation
{$R *.DFM}
procedure Tfrm_LOSTA550L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA550L.enableComponents;
begin
  changeBtn(Self);

	dte_from.Enabled := True;
  dte_to.Enabled := True;
  btn_Print.Enabled := True;
  cmb_id_cd.Enabled := True;
  btn_query.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '데이터 처리완료.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTA550L.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
        ColCount := 16;

		Cells[0,0]  :='사업자코드';
		Cells[1,0]  :='창고번호';
		Cells[2,0]  :='모델명';
		Cells[3,0]  :='시리얼';
		Cells[4,0]  :='입고일자';
		Cells[5,0]  :='단말기구분';
		Cells[6,0]  :='단말기상태';
		Cells[7,0]  :='분실자명';
		Cells[8,0]  :='분실자주민번호';
 		Cells[9,0]  :='우편번호';
    Cells[10,0] :='주소';
    Cells[11,0] :='사업자명';
    Cells[12,0] :='전화번호';
    Cells[13,0] :='분실핸드폰번호';
    Cells[14,0] :='납부자전화번호 ';
    Cells[15,0] :='적요';

    end;
end;


procedure Tfrm_LOSTA550L.CheckValue;
begin


  checked1   := ' ';
  checked2   := ' ';
  checked3   := ' ';
  checked4   := ' ';
  checked5   := ' ';
  checked6   := ' ';
  checked7   := ' ';
  checked8   := ' ';
  checked9   := ' ';
  checked10  := ' ';
  checked11  := ' ';

  if CheckBox1.Checked = true then begin
     checked1 := 'Y';
  end else begin
     checked1 := 'N';
  end;

  if CheckBox2.Checked = true then begin
     checked2 := 'Y';
  end else begin
     checked2 := 'N';
  end;

  if CheckBox3.Checked = true then begin
     checked3 := 'Y';
  end else begin
     checked3 := 'N';
  end;

  if CheckBox4.Checked = true then begin
     checked4 := 'Y';
  end else begin
     checked4 := 'N';
  end;

  if CheckBox5.Checked = true then begin
     checked5 := 'Y';
  end else begin
     checked5 := 'N';
  end;

  if CheckBox6.Checked = true then begin
     checked6 := 'Y';
  end else begin
     checked6 := 'N';
  end;

  if CheckBox7.Checked = true then begin
     checked7 := 'Y';
  end else begin
     checked7 := 'N';
  end;

  if CheckBox8.Checked = true then begin
     checked8 := 'Y';
  end else begin
     checked8 := 'N';
  end;

  if CheckBox9.Checked = true then begin
     checked9 := 'Y';
  end else begin
     checked9 := 'N';
  end;

  if CheckBox10.Checked = true then begin
     checked10 := 'Y';
  end else begin
     checked10 := 'N';
  end;

  if CheckBox11.Checked = true then begin
     checked11 := 'Y';
  end else begin
     checked11 := 'N';
  end;

end;

procedure Tfrm_LOSTA550L.setEdtKeyPress;
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

procedure Tfrm_LOSTA550L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA550L.FormCreate(Sender: TObject);
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
    {       }
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

  initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', ' ',cmb_id_cd);
  btn_ResetClick(Sender);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA550L.btn_CloseClick(Sender: TObject);
begin
     close;

end;

procedure Tfrm_LOSTA550L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

procedure Tfrm_LOSTA550L.dte_toExit(Sender: TObject);
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

procedure Tfrm_LOSTA550L.FormShow(Sender: TObject);
begin
  //dte_from.SetFocus;
  cmb_id_cd.ItemIndex := 0;
  CheckBox1.Checked := true;
end;

procedure Tfrm_LOSTA550L.btn_PrintClick(Sender: TObject);
var
    i:Integer;
    count1, count2, totalCount:Integer;

    RowPos:Integer;

	STR004 : String;
  STR005 : String;
  STR006 : String;
  STR007 : String;
  STR008 : String;
  STR009 : String;


  Label LIQUIDATION;
  Label INQUIRY;
begin
    pInitStrGrd(Self);
    CheckValue;

	//그리드 디스플레이
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화

    STR004 :=' ';
    STR005 :=' ';
    STR006 :=' ';
    STR007 :=' ';
    STR008 :=' ';
    STR009 :=' ';


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
	if (TMAX.SendString('INF003','LOSTA550L') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR004', checked1) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', checked2) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR006', checked3) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR007', checked4) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', checked5) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR009', checked6) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR010', checked7) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR011', checked8) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR012', checked9) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR013', checked10) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR014', checked11) < 0) then  goto LIQUIDATION;


  if (TMAX.SendString('STR015', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR016', STR005) < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR017', STR006) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR018', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR019', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR020', delHyphen(STR009)) < 0) then  goto LIQUIDATION;




  //서비스 호출
  if not TMAX.Call('LOSTA550L') then
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

  qryStr:= TMAX.RecvString('INF014',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    ShowMessage('출력할 자료가 없습니다.');
    goto LIQUIDATION;
  end;    




    with grd_display do begin
    	for i:=0 to count1-1 do begin


        	Cells[0,RowPos]  := TMAX.RecvString('STR101',i);  //사업자코드
        	Cells[1,RowPos]  := TMAX.RecvString('STR102',i);  //창고번호
        	Cells[2,RowPos]  := TMAX.RecvString('STR103',i);  //모델명
        	Cells[3,RowPos]  := TMAX.RecvString('STR104',i);  //시리얼
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i);  //입고일자
        	Cells[5,RowPos]  := TMAX.RecvString('STR106',i);  //단말기구분
        	Cells[6,RowPos]  := TMAX.RecvString('STR107',i);  //단말기상태
        	Cells[7,RowPos]  := TMAX.RecvString('STR108',i);  //분실자명
        	Cells[8,RowPos]  := TMAX.RecvString('STR109',i);  //분실자주민번호
          Cells[9,RowPos]  := TMAX.RecvString('STR110',i);  //우편번호
          Cells[10,RowPos] := TMAX.RecvString('STR111',i);  //주소
          Cells[11,RowPos] := TMAX.RecvString('STR112',i);  //사업자명
          Cells[12,RowPos] := TMAX.RecvString('STR113',i);  //전화번호
          Cells[13,RowPos] := TMAX.RecvString('STR114',i);  //분실핸드폰번호
          Cells[14,RowPos] := TMAX.RecvString('STR115',i);  //납부자전화번호
          Cells[15,RowPos] := TMAX.RecvString('STR116',i);  //적요


          STR004 := Trim(TMAX.RecvString('STR101',i)); // 조회시작 사업구분
          STR005 := Trim(TMAX.RecvString('STR108',i)); // 조회시작 분실자명
          STR006 := Trim(TMAX.RecvString('STR102',i)); // 조회시작 창고번호
          STR007 := Trim(TMAX.RecvString('STR117',i)); // 조회시작 모델코드
          STR008 := Trim(TMAX.RecvString('STR104',i)); // 조회시작 일련번호
          STR009 := Trim(TMAX.RecvString('STR105',i)); // 조회시작 입고일자

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
	Proc_gridtoexcel('분실폰수취미확인LIST(LOSTA550L)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTA550L');

LIQUIDATION:
	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
    enableComponents;

end;


procedure Tfrm_LOSTA550L.btn_ResetClick(Sender: TObject);
begin

  cmb_id_cd.ItemIndex := 0;
  CheckBox1.Checked := true;
	dte_from.Date := date-30;
	dte_to.Date := date;
  changeBtn(Self);

  CheckBox1.Checked   := False;
  CheckBox2.Checked   := False;
  CheckBox3.Checked   := False;
  CheckBox4.Checked   := False;
  CheckBox5.Checked   := False;
  CheckBox6.Checked   := False;
  CheckBox7.Checked   := False;
  CheckBox8.Checked   := False;
  CheckBox9.Checked   := False;
  CheckBox10.Checked  := False;
  CheckBox11.Checked  := False;

end;

procedure Tfrm_LOSTA550L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA560_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.
