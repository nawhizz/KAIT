{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ220P (우편번호 등록)
프로그램 종류 : Online
작성자	      : hysys
작성일	      : 2011. 09. 27
완료일	      : ####. ##. ##
프로그램 개요 : 우편번호 자료를 등록, 수정, 삭제, 조회한다.

     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ220P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  inifiles, WinSkinData, common_lib, Func_Lib, so_tmax, Menus, Clipbrd,
  monthEdit,u_LOSTZ220P_child, ComObj;

const
  TITLE   = '우편번호등록';
  PGM_ID  = 'LOSTZ220P';

type
  Tfrm_LOSTZ220P = class(TForm)
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
    grd_display: TStringGrid;
    pnl_Command: TPanel;
    SkinData1: TSkinData;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    TMAX: TTMAX;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    btn_reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Inq_GuChange(Sender: TObject);
    procedure edt_Inq_StrKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);

  private
    { Private declarations }
    qryStr:String;
    procedure initStrGrid;
    procedure initString;
  public
    { Public declarations }
  end;

var

  PO_NO, SQ_NO, SI_DO, GU_NM
  , DN_NM, RI_NM, DO_BJ, SN_BJ
  , ST_01, ST_02, ED_01, ED_02
  , BD_NM, ST_DO, ED_DO, CH_DT
  , JU_SO, DD_NO, DL_YN, BI_GO : String;

  frm_LOSTZ220P: Tfrm_LOSTZ220P;


implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ220P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ220P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTZ220P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 20;
    	RowHeights[0] := 21;

   	ColWidths[0] := 150;
		Cells[0,0] :='우편번호';

    	ColWidths[1] := 150;
		Cells[1,0] :='일련번호';

    	ColWidths[2] := 100;
		Cells[2,0] :='시도';

    	ColWidths[3] := -1;
		Cells[3,0] :='시군구';

    	ColWidths[4] := -1;
		Cells[4,0] :='읍면동';

    	ColWidths[5] := -1;
		Cells[5,0] :='리';

        ColWidths[6] := -1;
		Cells[6,0] :='도서';

    	ColWidths[7] := -1;
		Cells[7,0] :='산번지';

    	ColWidths[8] := -1;
		Cells[8,0] :='주시작번지';

    	ColWidths[9] := -1;
		Cells[9,0] :='부시작번지';

    	ColWidths[10] := -1;
		Cells[10,0] :='주끝번지';

    	ColWidths[11] := -1;
		Cells[11,0] :='부끝번지';

    	ColWidths[12] := -1;
		Cells[12,0] :='아파트건물명';

    	ColWidths[13] := -1;
		Cells[13,0] :='시작동';

    	ColWidths[14] := -1;
		Cells[14,0] :='끝동';

    	ColWidths[15] := -1;
		Cells[15,0] :='변경일';

    	ColWidths[16] := 350;
		Cells[16,0] :='주소';

    	ColWidths[17] := 100;
		Cells[17,0] :='DDD번호';

    	ColWidths[18] := -1;
		Cells[18,0] :='삭제여부';

    	ColWidths[19] := -1;
		Cells[19,0] :='조정사유';

    end;
end;

procedure Tfrm_LOSTZ220P.initString;
begin
  PO_NO := ' ';
  SQ_NO := ' ';
  SI_DO := ' ';
  GU_NM := ' ';
  DN_NM := ' ';
  RI_NM := ' ';
  DO_BJ := ' ';
  SN_BJ := ' ';
  ST_01 := ' ';
  ST_02 := ' ';
  ED_01 := ' ';
  ED_02 := ' ';
  BD_NM := ' ';
  ST_DO := ' ';
  ED_DO := ' ';
  CH_DT := ' ';
  JU_SO := ' ';
  DD_NO := ' ';
  DL_YN := ' ';
  BI_GO := ' ';
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ220P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ220P.cmb_Inq_GuChange(Sender: TObject);
begin
   edt_inq_str.Text := '';
   if cmb_inq_gu.ItemIndex = 0 then
   begin
      lbl_inq_str.Caption := '우편 번호';
      edt_inq_str.ImeMode := imSAlpha;
      edt_inq_str.MaxLength := 6;
   end
   else
   begin
      lbl_inq_str.Caption := '동     명';
      edt_inq_str.ImeMode := imSHanguel;
      edt_inq_str.MaxLength := 18;
   end;

   edt_Inq_Str.SetFocus

end;

procedure Tfrm_LOSTZ220P.edt_Inq_StrKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (key = #13) then
   begin
    btn_InquiryClick(Sender); 
   end;



end;

procedure Tfrm_LOSTZ220P.FormCreate(Sender: TObject);
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

	initSkinForm(SkinData1); //common_lib.pas에 있다.

  initStrGrid;	//그리드 초기화

	qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ220P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);

end;

procedure Tfrm_LOSTZ220P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;

    Label LIQUIDATION;
    Label INQUIRY;
begin

  if (cmb_Inq_Gu.ItemIndex = 0) and (edt_Inq_Str.Text = '')  then
   begin
    ShowMessage('우편번호를 입력해 주십시오.');
    exit;
   end;

   if (cmb_Inq_Gu.ItemIndex = 1) and (edt_Inq_Str.Text = '')  then
   begin
    ShowMessage('동 명을 입력해 주십시오.');
    exit;
   end;

  btn_Update.Enabled := True;
  btn_Delete.Enabled := True;
  btn_query.Enabled := True;

 	//그리드 디스플레이
    seq:= 1; 	//순번
    RowPos:= 1;	//그리드 레코드 포지션
    grd_display.RowCount := 2;

    //시작시변수 초기화

    totalCount :=0;
    qryStr:= '';	//쿼리 스트리링...'쿼리'버튼을 클릭했을 때 보여줌.
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

  goto INQUIRY;

INQUIRY:
	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LostZ220P') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', IntToStr(cmb_Inq_Gu.ItemIndex)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Inq_Str.Text) < 0) then  goto LIQUIDATION;


  //서비스 호출
  if not TMAX.Call('LOSTZ220P') then
  begin
   if (TMAX.RecvString('INF011',0) = 'Y') then
     sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
   else
     MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
    goto LIQUIDATION;
  end;

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

          Cells[0,RowPos]  := TMAX.RecvString('STR101',i); //우편번호     
          Cells[1,RowPos]  := TMAX.RecvString('STR102',i); //일련번호     
          Cells[2,RowPos]  := TMAX.RecvString('STR103',i); //시도         
          Cells[3,RowPos]  := TMAX.RecvString('STR104',i); //시군구       
          Cells[4,RowPos]  := TMAX.RecvString('STR105',i); //읍면동       
          Cells[5,RowPos]  := TMAX.RecvString('STR106',i); //리           
          Cells[6,RowPos]  := TMAX.RecvString('STR107',i); //도서         
          Cells[7,RowPos]  := TMAX.RecvString('STR108',i); //산번지       
          Cells[8,RowPos]  := TMAX.RecvString('STR109',i); //주시작번지   
          Cells[9,RowPos]  := TMAX.RecvString('STR110',i); //부시작번지   
          Cells[10,RowPos] := TMAX.RecvString('STR111',i); //주끝번지     
          Cells[11,RowPos] := TMAX.RecvString('STR112',i); //부끝번지     
          Cells[12,RowPos] := TMAX.RecvString('STR113',i); //아파트건물명 
          Cells[13,RowPos] := TMAX.RecvString('STR114',i); //시작동       
          Cells[14,RowPos] := TMAX.RecvString('STR115',i); //끝동         
          Cells[15,RowPos] := TMAX.RecvString('STR116',i); //변경일       
          Cells[16,RowPos] := TMAX.RecvString('STR117',i); //주소         
          Cells[17,RowPos] := TMAX.RecvString('STR118',i); //DDD번호      
          Cells[18,RowPos] := TMAX.RecvString('STR119',i); //삭제여부     
          Cells[19,RowPos] := TMAX.RecvString('STR120',i); //조정사유    

          Inc(seq);
          Inc(RowPos);
        end;
    end;
   //스테터스바에 메세지 뿌리기
    sts_Message.Panels[1].Text := ' ' + intToStr(totalCount) + '건이 조회 되었습니다.';
    Application.ProcessMessages;

    //'쿼리'버튼을 클릭 했을 때 보여줄 스트링
    qryStr:= TMAX.RecvString('INF014',0);

//빠져나오는곳
LIQUIDATION:

	TMAX.InitBuffer;
    TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
    grd_display.Cursor := crDefault;	//작업완료
    grd_display.RowCount := grd_display.RowCount -1;
  
end;

procedure Tfrm_LOSTZ220P.btn_AddClick(Sender: TObject);
begin
  frm_LOSTZ220P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ220P.grd_displayDblClick(Sender: TObject);
begin
  initString;

  PO_NO := grd_display.Cells[0, grd_display.Row];
  SQ_NO := grd_display.Cells[1, grd_display.Row];
  SI_DO := grd_display.Cells[2, grd_display.Row];
  GU_NM := grd_display.Cells[3, grd_display.Row];
  DN_NM := grd_display.Cells[4, grd_display.Row];
  RI_NM := grd_display.Cells[5, grd_display.Row];
  DO_BJ := grd_display.Cells[6, grd_display.Row];
  SN_BJ := grd_display.Cells[7, grd_display.Row];
  ST_01 := grd_display.Cells[8, grd_display.Row];
  ST_02 := grd_display.Cells[9, grd_display.Row];
  ED_01 := grd_display.Cells[10, grd_display.Row];
  ED_02 := grd_display.Cells[11, grd_display.Row];
  BD_NM := grd_display.Cells[12, grd_display.Row];
  ST_DO := grd_display.Cells[13, grd_display.Row];
  ED_DO := grd_display.Cells[14, grd_display.Row];
  CH_DT := grd_display.Cells[15, grd_display.Row];
  JU_SO := grd_display.Cells[16, grd_display.Row];
  DD_NO := grd_display.Cells[17, grd_display.Row];
  DL_YN := grd_display.Cells[18, grd_display.Row];
  BI_GO := grd_display.Cells[19, grd_display.Row];

  frm_LOSTZ220P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ220P.btn_UpdateClick(Sender: TObject);
begin
  DL_YN := grd_display.Cells[18, grd_display.Row];


  frm_LOSTZ220P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ220P.btn_DeleteClick(Sender: TObject);
begin

  frm_LOSTZ220P_CHILD.FormShow(Sender);

end;

procedure Tfrm_LOSTZ220P.btn_resetClick(Sender: TObject);
begin
  changeBtn(Self);
  btn_Print.Enabled := False;
  btn_Link.Enabled := False;
  btn_excel.Enabled := False;
  btn_query.Enabled := False;
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  cmb_Inq_Gu.ItemIndex :=  0;


end;

procedure Tfrm_LOSTZ220P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTZ220P_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

end.


