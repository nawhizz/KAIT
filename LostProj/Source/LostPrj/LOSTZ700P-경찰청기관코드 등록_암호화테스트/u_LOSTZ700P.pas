{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ700P (경찰청기관코드 등록)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10. 30
완료일	      : ####. ##. ##
프로그램 개요 : 경찰청기관코드 자료를 등록, 수정, 삭제, 조회한다.

     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ700P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,printers,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ700P_child, LOSTZ700P_PRT_HEAD, ComObj;

const
  TITLE   = '경찰청기관코드 등록';
  PGM_ID  = 'LOSTZ700P';


type
  Tfrm_LOSTZ700P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    cmb_Inq_Gu: TComboBox;
    edt_Inq_Str: TEdit;
    pnl_Command: TPanel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; State: TGridDrawState);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);


  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
  public
    { Public declarations }
  end;

var
  ORD_TP_CD  : String;
  CTL_LCT_CD : String;

  frm_LOSTZ700P: Tfrm_LOSTZ700P;

  cmb_Inq_Gu_d   : TZ0xxArray;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ700P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ700P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTZ700P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 15;
    	RowHeights[0] := 21;

    	ColWidths[0] := -1;
		Cells[0,0] :='기관아이디';

    	ColWidths[1] := 90;
		Cells[1,0] :='기관명';

      ColWidths[2] := -1;
		Cells[2,0] :='기관유형코드';

      ColWidths[3] := 100;
		Cells[3,0] :='기관유형명';

      ColWidths[4] := -1;
		Cells[4,0] :='지역코드';

      ColWidths[5] := 100;
		Cells[5,0] :='지역명';

      ColWidths[6] := 60;
		Cells[6,0] :='우편번호';

      ColWidths[7] := 150;
		Cells[7,0] :='주소';

      ColWidths[8] := 100;
		Cells[8,0] :='상세주소';

      ColWidths[9] := 100;
		Cells[9,0] :='전화번호';

      ColWidths[10] := -1;
		Cells[10,0] :='상위기관코드';

      ColWidths[11] := 150;
		Cells[11,0] :='상위기관명';

      ColWidths[12] := 80;
		Cells[12,0] :='최종수정자ID';

      ColWidths[13] := 80;
		Cells[13,0] :='최종수정일자';

    ColWidths[14] := 0;
		Cells[14,0] :='암호화전화번호';

    end;
end;


{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ700P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
var
  LeftPos: Integer;
  TopPos : integer;
  CellStr: string;
begin
  with TStringGrid(Sender).Canvas do begin
    CellStr := TStringGrid(Sender).Cells[ACol, ARow];
    TopPos  := ((Rect.Top - Rect.Bottom -TStringGrid(Sender).Canvas.TextHeight(CellStr)) div 2) + Rect.Bottom;
    case i_align of
      1 :  LeftPos := ((Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) div 2) + Rect.Left;
      2 :  LeftPos :=  (Rect.Right - Rect.Left - TStringGrid(Sender).Canvas.TextWidth(CellStr)) +
                        Rect.Left - 5;
      else LeftPos := Rect.Left + 5;
    end;
    FillRect(Rect);
    TextOut(LeftPos, TopPos, CellStr);
  end;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ700P.FormCreate(Sender: TObject);
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
  {     }
  //if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
  //  	ShowMessage('로그인 후 사용하세요');
  //    PostMessage(self.Handle, WM_QUIT, 0,0);
  //    exit;
  //end;

  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := 'K2I5I4S3L3C0H1U1';

  //테스트 후에는 이 부분을 삭제할 것.
  //common_userid:= '0294'; //ParamStr(2);
  //common_username:= '정호영';
  //ParamStr(3);
  //common_usergroup:= 'KAIT'; //ParamStr(4);
  //initSkinForm(SkinData1);

{=========================    콤보박스 초기화     ===========================}

  (* 기관유형코드 *)  initComboBoxWithZ0xx('Z010',cmb_Inq_Gu_d   ,'','' ,cmb_Inq_Gu  );


  initStrGrid;	//그리드 초기화
  qryStr := '';

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ700P.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   edt_inq_str.ImeMode := imSHanguel;
end;

procedure Tfrm_LOSTZ700P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ700P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    data: String;
    encdata, decdata: String;

    Label LIQUIDATION;
    Label INQUIRY;
begin
    // 암호화 모듈
    ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;
    btn_query.Enabled := True;

	  //그리드 디스플레이
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
	if (TMAX.SendString('INF003','LOSTZ700P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_Inq_Gu_d[cmb_Inq_Gu.itemIndex].code) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Inq_Str.Text ) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ700P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

  //쿼리 얻기
  qryStr:= TMAX.RecvString('INF014',0);

  //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;

    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i); //기관아이디
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i); //기관명
          Cells[2,RowPos]  := TMAX.RecvString('STR103',i); //기관유형코드
          Cells[3,RowPos]  := TMAX.RecvString('STR104',i); //기관유형명
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i); //지역코드
          Cells[5,RowPos]  := TMAX.RecvString('STR106',i); //지역명
          Cells[6,RowPos]  := TMAX.RecvString('STR107',i); //우편번호
          Cells[7,RowPos]  := TMAX.RecvString('STR108',i); //주소
          Cells[8,RowPos]  := TMAX.RecvString('STR109',i); //주소상세

          // 전화번호 복호화
          //Cells[9,RowPos]  := TMAX.RecvString('STR110',i); //전화번호
          Cells[14,RowPos] := TMAX.RecvString('STR110',i); //전화번호
          Cells[9,RowPos]  := ECPlazaSeed.Decrypt(Cells[14,RowPos], common_seedkey);

          Cells[10,RowPos] := TMAX.RecvString('STR111',i); //상위기관코드
          Cells[11,RowPos] := TMAX.RecvString('STR112',i); //상위기관명
          Cells[12,RowPos] := TMAX.RecvString('STR113',i); //최종수정자ID
          Cells[13,RowPos] := TMAX.RecvString('STR114',i); //최종수정일자

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

procedure Tfrm_LOSTZ700P.btn_AddClick(Sender: TObject);
begin

    frm_LOSTZ700P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ700P.grd_displayDblClick(Sender: TObject);
begin
  ORD_TP_CD  := grd_display.Cells[2, grd_display.Row];
  CTL_LCT_CD := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ700P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ700P.btn_UpdateClick(Sender: TObject);
begin
  ORD_TP_CD  := grd_display.Cells[2, grd_display.Row];
  CTL_LCT_CD := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ700P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ700P.btn_DeleteClick(Sender: TObject);
begin
  ORD_TP_CD  := grd_display.Cells[2, grd_display.Row];
  CTL_LCT_CD := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ700P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ700P.btn_excelClick(Sender: TObject);
begin
Proc_gridtoexcel('시스템관리(LOSTZ700P)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTZ700P');
end;

procedure Tfrm_LOSTZ700P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      2: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      4: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      5: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      7: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      8: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      9: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
      10: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      11: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
    end;

end;

procedure Tfrm_LOSTZ700P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  cmb_Inq_Gu.ItemIndex := 0;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_query.Enabled := False;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' '; 

end;

procedure Tfrm_LOSTZ700P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTA210Q_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ700P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

end.
