{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ150P (메뉴 등록)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 19
완료일	      : ####. ##. ##
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}

unit u_LOSTZ150P_pop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

type
  Tfrm_LOSTZ150P_pop = class(TForm)
    pnl_Command: TPanel;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Close: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    lbl_Inq_Str: TLabel;
    edt_pg_id: TEdit;
    grd_display: TStringGrid;
    sts_Message: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var

  frm_LOSTZ150P_pop: Tfrm_LOSTZ150P_pop;

implementation
uses u_LOSTZ150P_CHILD;
{$R *.dfm}

procedure Tfrm_LOSTZ150P_pop.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 2;
    	RowHeights[0] := 21;

    	ColWidths[0] := 210;
		Cells[0,0] :='프로그램 ID';

    	ColWidths[1] := 210;
		Cells[1,0] :='프로그램명 ';

    end;
end;



{-----------------------------------------------------------------------------}


procedure Tfrm_LOSTZ150P_pop.FormCreate(Sender: TObject);
begin
{   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
}
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

  initStrGrid;	//그리드 초기화


  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  btn_Add.Enabled := False;
  btn_Link.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;

 // btn_InquiryClick(Sender);

end;


procedure Tfrm_LOSTZ150P_pop.btn_CloseClick(Sender: TObject);
begin
  close;
  frm_LOSTZ150P_child.Enabled := True;
  frm_LOSTZ150P_child.Show;
end;



procedure Tfrm_LOSTZ150P_pop.FormShow(Sender: TObject);
begin
      frm_LOSTZ150P_child.Enabled := False;
      edt_pg_id.Text := PG_ID;
      frm_LOSTZ150P_pop.btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ150P_pop.btn_InquiryClick(Sender: TObject);
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
	if (TMAX.SendString('INF003','LOSTZ150P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02') < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_pg_id.Text )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ150P') then goto LIQUIDATION;

    //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos] := TMAX.RecvString('STR101',i); //프로그램 ID
          Cells[1,RowPos] := TMAX.RecvString('STR102',i); //프로그램 명

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

procedure Tfrm_LOSTZ150P_pop.grd_displayDblClick(Sender: TObject);
begin

    frm_LOSTZ150P_child.edt_pg_id.Text := grd_display.Cells[0, grd_display.Row];
    frm_LOSTZ150P_child.edt_pg_nm.Text := grd_display.Cells[1, grd_display.Row];
    frm_LOSTZ150P_child.edt_mu_nm.Text := grd_display.Cells[1, grd_display.Row];
    frm_LOSTZ150P_child.edt_pg_nm.Enabled := False;


    close;

end;

procedure Tfrm_LOSTZ150P_pop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ150P_child.Enabled := True;
  frm_LOSTZ150P_child.Show;
end;

end.
