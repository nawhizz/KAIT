{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ840Q (우편번호 등록)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10.30
완료일	      : ####. ##. ##
프로그램 개요 : 도로명주소 자료를 조회한다.

-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ840Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, so_tmax, WinSkinData, common_lib, localCloud;

type
  Tfrm_LOSTZ840Q = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    edt_adr_bldnm1: TEdit;
    lbl_Inq_Str     : TLabel;
    Label15         : TLabel;
    lbl_Program_Name: TLabel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    grd_display     : TStringGrid;
    TMAX            : TTMAX;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;
    msk_zip: TMaskEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel3: TBevel;
    Label2: TLabel;
    edt_adr_rodnm: TEdit;
    edt_ttvnm: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure edt_adr_bldnm1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure grd_displayKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    isData:Boolean;
  public
    { Public declarations }
     procedure initStrGrid;
  end;

var
  frm_LOSTZ840Q: Tfrm_LOSTZ840Q;


implementation
{$R *.DFM}

procedure Tfrm_LOSTZ840Q.initStrGrid;
begin
	with grd_display do begin
    RowCount :=2;
    ColCount := 3;
    RowHeights[0] := 21;

    ColWidths[0]  := 70;
    Cells[0,0]    :='우편번호';

    ColWidths[1]  := 400;
    Cells[1,0]    :='도로명주소';

    ColWidths[2]  := 300;
    Cells[2,0]    :='지번주소';

  end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ840Q.FormCreate(Sender: TObject);

begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.

//	if ParamCount < 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
//    	ShowMessage('전달된 파라메터 개수오류!');
//        PostMessage(self.Handle, WM_QUIT, 0,0);
//        exit;
//    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait       := ParamStr(1);
    common_caller     := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid     := ParamStr(3);
    common_username   := ParamStr(4);
    common_usergroup  := ParamStr(5);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294'; //ParamStr(2);
//    common_username   := '정호영';
//    ParamStr(3);
//    common_usergroup  := 'KAIT'; //ParamStr(4);

    initSkinForm(SkinData1);
    initStrGrid;	//그리드 초기화

    isData:= False;  //스트링그리드에 데이터가 없다.

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ840Q.btn_CloseClick(Sender: TObject);
begin
    close;
end;


procedure Tfrm_LOSTZ840Q.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 0, 0);

end;

procedure Tfrm_LOSTZ840Q.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1,  totalCount:Integer;
    RowPos:Integer;
    STR001,STR002,STR003,STR004:String;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  //그리드 디스플레이

  RowPos:= 1;	//그리드 레코드 포지션
  grd_display.RowCount := 2;
  grd_display.FixedRows:=1;

  grd_display.Cursor := crSQLWait;	//작업중....
  //disableComponents;	//작업중 다른 기능 잠시 중지.

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

//내역조회
INQUIRY:


	TMAX.InitBuffer;

	STR001:=' ';
	STR002:=' ';
	STR003:=' ';
	STR004:=' ';

  totalCount := 0;

  //공통입력 부분
  if (TMAX.SendString('INF002',common_userid    ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_username  ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF002',common_usergroup ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF003','LOSTZ840Q'      ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('INF001','S01'            ) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001', edt_adr_rodnm.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', edt_adr_bldnm1.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', msk_zip.Text) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR005', edt_ttvnm.Text) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ840Q') then goto LIQUIDATION;

  count1 := TMAX.RecvInteger('INT100',0);

  if count1 > 0 then isData := True;	//스트링그리드에 데이터가 있다.

  if count1 > 0 then
    totalCount:= totalCount + count1;

  grd_display.RowCount := grd_display.RowCount + count1;

  with grd_display do begin
    for i:=0 to count1-1 do begin
      Cells[0,RowPos] := TMAX.RecvString('STR101',i);	// 우편번호
      Cells[1,RowPos] := TMAX.RecvString('STR102',i);	// 도로명주소
      Cells[2,RowPos] := TMAX.RecvString('STR115',i);	// 지번주소

      Inc(RowPos);
    end;

  end;
  //스테터스바에 메세지 뿌리기
  sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';

  Application.ProcessMessages;

   // count2 := TMAX.RecvInteger('INT100',0);
   // if count1 = count2 then
   // 	goto INQUIRY;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  grd_display.Cursor := crDefault;	//작업완료

  if isData then grd_display.RowCount := grd_display.RowCount -1;

  if isData then
    grd_display.SetFocus	//스트링 그리드로 포커스 이동
  else
    edt_adr_rodnm.SetFocus;


end;


procedure Tfrm_LOSTZ840Q.btn_LinkClick(Sender: TObject);
var
	smem:TPSharedMem;

begin
	if not isData then begin 			//스트링 그리드에 데이터가 없으면
    	edt_adr_rodnm.SetFocus;	//'검색조건' 콤보박스로 이동
      exit;
  end;

  //공유메모리를 얻는다.
	smem:= OpenMap;

	if smem <> nil then
    begin
        Lock;  //동시 접속방지

        smem^.po_no   := delHyphen(Trim(grd_display.Cells[0,grd_display.Row])); //우편번호
        smem^.ju_so   := Trim(grd_display.Cells[1,grd_display.Row]); // 도로명주소
        smem^.ddd_no  := Trim(grd_display.Cells[2,grd_display.Row]); // 지번주소

        UnLock;
    end;

    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT2, 1, 0);

   CloseMap;

   PostMessage(self.Handle, WM_QUIT, 0,0);
end;

procedure Tfrm_LOSTZ840Q.edt_adr_bldnm1KeyPress(Sender: TObject;
  var Key: Char);
begin
	if Key <> #13 then 	//엔터키가 아니면
    	exit;

  btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ840Q.FormShow(Sender: TObject);
begin

  changeBtn(Self);

  btn_reset.Enabled := False;
  btn_excel.Enabled := False;

  // 부모창에서 데이터를 넘겨받으면 바로 조회
  if(ParamStr(8) <> '') then
  begin
    msk_zip.Text      := StringReplace(Trim(ParamStr(8)),'|','',[rfReplaceAll]);
    Self.btn_InquiryClick(Sender);
  end else
  begin
    edt_adr_rodnm.SetFocus;
  end;
end;

procedure Tfrm_LOSTZ840Q.grd_displayKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_LinkClick(Sender);
end;

end.
