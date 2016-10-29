{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ210P (공통코드 등록)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 06
완료일	      : ####. ##. ##
프로그램 개요 : 공통 코드 자료를 등록, 수정, 삭제, 조회한다.
     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ210P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ210P_child, u_LOSTZ210P_POP, ComObj;

const
  TITLE   = '공통코드등록';
  PGM_ID  = 'LOSTZ210P';


type
  Tfrm_LOSTZ210P = class(TForm)
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
    Bevel1: TBevel;
    Label1: TLabel;
    edt_Cd_Gu: TEdit;
    pnl_Command: TPanel;
    TMAX: TTMAX;
    grd_display: TStringGrid;
    edt_Cd_Nm: TEdit;
    btn1: TBitBtn;
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
    SkinData1: TSkinData;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure edt_Cd_GuKeyPress(Sender: TObject; var Key: Char);
    procedure edt_Cd_NmKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryStr : String;
    procedure initStrGrid;
  public
    { Public declarations }
  end;


var
  frm_LOSTZ210P: Tfrm_LOSTZ210P;

  CD_GU : String;
  GU_NM : String;

  CD_NO : String;
  CD_NM : String;
  CM_01 : String;
  CM_02 : String;
  CM_03 : String;
  CM_04 : String;
  CM_05 : String;
  US_YN : String;
  SQ_NO : String;


implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ210P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ210P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTZ210P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 9;
    	RowHeights[0] := 21;

    	ColWidths[0] := 80;
		Cells[0,0] :='코드번호';

    	ColWidths[1] := 200;
		Cells[1,0] :='코드명';

      ColWidths[2] := 80;
		Cells[2,0] :='전산코드1';


      ColWidths[3] := 80;
		Cells[3,0] :='전산코드2';

      ColWidths[4] := 80;
		Cells[4,0] :='전산코드3';

      ColWidths[5] := 80;
		Cells[5,0] :='전산코드4';

      ColWidths[6] := 80;
		Cells[6,0] :='전산코드5';

      ColWidths[7] := 80;
		Cells[7,0] :='사용여부';

      ColWidths[8] := 80;
		Cells[8,0] :='조회순서';
    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ210P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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
procedure Tfrm_LOSTZ210P.FormCreate(Sender: TObject);
begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
   //setEdtKeyPress;
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
  //common_username:= '정호영';
  // ParamStr(3);
  //	common_usergroup:= 'KAIT'; //ParamStr(4);

  initStrGrid;	//그리드 초기화
  initSkinForm(SkinData1);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  qryStr := '';
end;

procedure Tfrm_LOSTZ210P.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTZ210P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;

    RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

    if (edt_Cd_Gu.Text = '') or (edt_Cd_Nm.Text = '') then begin
        ShowMessage('코드 구분을 선택해 주십시요.');
        exit;
    end;

    btn_Add.Enabled := True;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;

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
	if (TMAX.SendString('INF003','LOSTZ210P') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Cd_Gu.Text ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', edt_Inq_Str.Text ) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ210P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;


  //쿼리받기
  qryStr:= TMAX.RecvString('INF014',0);

    //조회된 갯수
	count1 := TMAX.RecvInteger('INF013',0);
    totalCount:= totalCount + count1;
    grd_display.RowCount := grd_display.RowCount + count1;

  if count1 < 1 then begin
    for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 3;
    sts_Message.Panels[1].Text := '조회된 내역이 없습니다.';
    goto LIQUIDATION;
  end;

    with grd_display do begin
    	for i:=0 to count1-1 do begin

          Cells[0,RowPos] := TMAX.RecvString('STR101',i); //코드번호
          Cells[1,RowPos] := TMAX.RecvString('STR102',i); //코드명
          Cells[2,RowPos] := TMAX.RecvString('STR103',i); //전산코드1
          Cells[3,RowPos] := TMAX.RecvString('STR104',i); //전산코드2
          Cells[4,RowPos] := TMAX.RecvString('STR105',i); //전산코드3
          Cells[5,RowPos] := TMAX.RecvString('STR106',i); //전산코드4
          Cells[6,RowPos] := TMAX.RecvString('STR107',i); //전산코드5
          Cells[7,RowPos] := TMAX.RecvString('STR108',i); //사용여부
          Cells[8,RowPos] := IntToStr(TMAX.RecvInteger('INT109',i)); //조회순서

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

procedure Tfrm_LOSTZ210P.btn1Click(Sender: TObject);
begin
 CD_GU := '';


 CD_GU := edt_Cd_Gu.Text;

 frm_LOSTZ210P_POP.Show;
end;

procedure Tfrm_LOSTZ210P.btn_AddClick(Sender: TObject);

begin

    if (edt_Cd_Gu.Text = '') or (edt_Cd_Nm.Text = '') then begin
        ShowMessage('코드 구분을 선택해 주십시요.');
        exit;
    end;

    CD_GU := '';
    GU_NM := '';

    CD_GU := edt_Cd_Gu.Text;
    GU_NM := edt_Cd_Nm.Text;
    
    frm_LOSTZ210P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ210P.grd_displayDblClick(Sender: TObject);
begin

    CD_GU := edt_Cd_Gu.Text;
    GU_NM := edt_Cd_Nm.Text;
    CD_NO := grd_display.Cells[0, grd_display.Row];
    CD_NM := grd_display.Cells[1, grd_display.Row];
    CM_01 := grd_display.Cells[2, grd_display.Row];
    CM_02 := grd_display.Cells[3, grd_display.Row];
    CM_03 := grd_display.Cells[4, grd_display.Row];
    CM_04 := grd_display.Cells[5, grd_display.Row];
    CM_05 := grd_display.Cells[6, grd_display.Row];
    US_YN := grd_display.Cells[7, grd_display.Row];
    SQ_NO := grd_display.Cells[8, grd_display.Row];

    frm_LOSTZ210P_CHILD.FormShow(Sender);
end;


procedure Tfrm_LOSTZ210P.btn_UpdateClick(Sender: TObject);
begin

    CD_GU := edt_Cd_Gu.Text;
    GU_NM := edt_Cd_Nm.Text;
    CD_NO := grd_display.Cells[0, grd_display.Row];
    CD_NM := grd_display.Cells[1, grd_display.Row];
    CM_01 := grd_display.Cells[2, grd_display.Row];
    CM_02 := grd_display.Cells[3, grd_display.Row];
    CM_03 := grd_display.Cells[4, grd_display.Row];
    CM_04 := grd_display.Cells[5, grd_display.Row];
    CM_05 := grd_display.Cells[6, grd_display.Row];
    US_YN := grd_display.Cells[7, grd_display.Row];
    SQ_NO := grd_display.Cells[8, grd_display.Row];

    frm_LOSTZ210P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ210P.btn_DeleteClick(Sender: TObject);
begin
    CD_GU := edt_Cd_Gu.Text;
    GU_NM := edt_Cd_Nm.Text;
    CD_NO := grd_display.Cells[0, grd_display.Row];
    CD_NM := grd_display.Cells[1, grd_display.Row];
    CM_01 := grd_display.Cells[2, grd_display.Row];
    CM_02 := grd_display.Cells[3, grd_display.Row];
    CM_03 := grd_display.Cells[4, grd_display.Row];
    CM_04 := grd_display.Cells[5, grd_display.Row];
    CM_05 := grd_display.Cells[6, grd_display.Row];
    US_YN := grd_display.Cells[7, grd_display.Row];
    SQ_NO := grd_display.Cells[8, grd_display.Row];

    frm_LOSTZ210P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ210P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    case ACol of
      0: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      1..6: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
      7: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);


    end;
end;

procedure Tfrm_LOSTZ210P.edt_Cd_GuKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then begin
  frm_LOSTZ210P.btn1Click(Sender);
 end;
end;

procedure Tfrm_LOSTZ210P.edt_Cd_NmKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then begin
  frm_LOSTZ210P.btn1Click(Sender);
 end;
end;

procedure Tfrm_LOSTZ210P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ210P.btn_resetClick(Sender: TObject);
var i : Integer;
begin

  changeBtn(Self);

  btn_Add.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  cmb_Inq_Gu.ItemIndex := 0;
  edt_Cd_Nm.Enabled := False;

  edt_Cd_Gu.Text := '';
  edt_Cd_Nm.Text := '';
  edt_Inq_Str.Text := '';
  cmb_Inq_Gu.ItemIndex := 0;

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;  
end;

procedure Tfrm_LOSTZ210P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTZ210P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;
procedure Tfrm_LOSTZ210P.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '코드 번호';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 10;
   end
   else
   begin
      lbl_inq_str.Caption := '코드 명';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 40;
   end;
end;

procedure Tfrm_LOSTZ210P.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

end.
