{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ250P (우체국 정산예정일자 입력)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 27
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
unit u_LOSTZ250P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, Menus,Clipbrd,u_LOSTZ250P_CHILD, ComObj;

const
  TITLE   = '우체국정산예정일자 입력';
  PGM_ID  = 'LOSTZ250P';

type
  Tfrm_LOSTZ250P = class(TForm)
    pnl_Command: TPanel;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    grd_display: TStringGrid;
    PopupMenu1: TPopupMenu;
    Copy1: TMenuItem;
    sts_Message: TStatusBar;
    cmb_year: TEdit;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer;
    Rect: TRect; i_align : integer);
    procedure btn_queryClick(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure grd_displayDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Copy1Click(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure cmb_yearKeyPress(Sender: TObject; var Key: Char);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure grd_displayDblClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
    qryStr:String;
    procedure initStrGrid;
    procedure initString;
  public
    { Public declarations }
  end;

var

  AC_YM : String;
  DU_DT : String;
  AC_DT : String;
  AC_GU : String;
  AC_NM : String;

  frm_LOSTZ250P: Tfrm_LOSTZ250P;

implementation

{$R *.dfm}

procedure Tfrm_LOSTZ250P.setEdtKeyPress;
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


procedure Tfrm_LOSTZ250P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


procedure Tfrm_LOSTZ250P.initString;
begin
  AC_YM := '';
  DU_DT := '';
  AC_DT := '';
  AC_GU := '';
  AC_NM := '';
end;


procedure Tfrm_LOSTZ250P.initStrGrid;
begin
	with grd_display do begin
    	RowCount :=2;
      ColCount := 5;
    	RowHeights[0] := 21;

    	ColWidths[0] := 100;
		Cells[0,0] :='정산월';

    	ColWidths[1] := 150;
		Cells[1,0] :='정산예정일자';

      ColWidths[2] := 150;
		Cells[2,0] :='실제정산일자';

      ColWidths[3] := 100;
		Cells[3,0] :='정산구분';

      ColWidths[4] := 210;
		Cells[4,0] :='정산구분명';

    end;
end;

{*******************************************************************************
* procedure Name : StringGrid_DrawCell
* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.
*******************************************************************************}
procedure Tfrm_LOSTZ250P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

{-----------------------------------------------------------------------------}


procedure Tfrm_LOSTZ250P.FormCreate(Sender: TObject);
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
  //common_username:= '정호영';
  //ParamStr(3);
  //common_usergroup:= 'KAIT'; //ParamStr(4);

  initSkinForm(SkinData1);
  initStrGrid;	//그리드 초기화
  
  qryStr := '';
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ250P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTZ250P.FormShow(Sender: TObject);
begin
  btn_resetClick(Sender);
end;

procedure Tfrm_LOSTZ250P.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;
    filePath:='..\Temp\LOSTZ250Z_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTZ250P.btn_excelClick(Sender: TObject);
begin
  Proc_gridtoexcel('우체국 정산 예정일자 입력 (LOSTZ250P)',grd_display.RowCount, grd_display.ColCount, grd_display, 'LOSTZ250P');
end;

procedure Tfrm_LOSTZ250P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid:TStringGrid;
  S:String;
begin
	grid:= Sender as TStringGrid;
    grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];
    if (ARow =0) then begin
    	grid.Canvas.Brush.Color := clBtnFace;
        grid.Canvas.Font.Color := clBlack;
    	grid.Canvas.FillRect(Rect);
    	DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
    end
    else
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
    case ACol of
      0..3: StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
      4 : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
    end;
  end;
{
    if (ARow mod 2) = 1 then begin
		grid.Canvas.Brush.Color := RGB(240,240,240);
		grid.Canvas.FillRect(Rect);
		grid.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, S);
    end;
}
end;


procedure Tfrm_LOSTZ250P.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_display.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_display.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_display.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

procedure Tfrm_LOSTZ250P.btn_InquiryClick(Sender: TObject);
var
    i:Integer;
    count1, totalCount:Integer;
    seq,RowPos:Integer;
    Label LIQUIDATION;
    Label INQUIRY;
begin
    btn_Add.Enabled := True;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := True;

    if Length(cmb_year.text) < 4 then begin
      ShowMessage('정산년도를 입력해주십시오.');
      exit;
    end;

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
	if (TMAX.SendString('INF003','LOSTZ250P') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF001','S01') < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_year.Text) < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ250P') then
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

          Cells[0,RowPos] := TMAX.RecvString('STR101',i); // 정산월
          Cells[1,RowPos] := InsHyphen(TMAX.RecvString('STR102',i)); // 정산예정일자
          Cells[2,RowPos] := InsHyphen(TMAX.RecvString('STR103',i)); // 실제정산일자
          Cells[3,RowPos] := TMAX.RecvString('STR104',i); // 정산구분    
          Cells[4,RowPos] := TMAX.RecvString('STR105',i); // 정산구분명

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

procedure Tfrm_LOSTZ250P.cmb_yearKeyPress(Sender: TObject; var Key: Char);
begin

  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
  
  if Key = #13 then begin
    btn_InquiryClick(Sender);
  end;
end;

procedure Tfrm_LOSTZ250P.btn_AddClick(Sender: TObject);
begin
  initString;

  AC_DT := grd_display.Cells[2, grd_display.Row];
  frm_LOSTZ250P_CHILD.FormShow(Sender);

end;



procedure Tfrm_LOSTZ250P.btn_UpdateClick(Sender: TObject);
begin
  initString;

  AC_YM := grd_display.Cells[0, grd_display.Row];
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := grd_display.Cells[2, grd_display.Row];
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];



  frm_LOSTZ250P_CHILD.FormShow(Sender);
end;


procedure Tfrm_LOSTZ250P.grd_displayDblClick(Sender: TObject);
begin
  AC_YM := grd_display.Cells[0, grd_display.Row];
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := grd_display.Cells[2, grd_display.Row];
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];

  frm_LOSTZ250P_CHILD.FormShow(Sender);
end;

procedure Tfrm_LOSTZ250P.btn_DeleteClick(Sender: TObject);
begin
  AC_YM := delHyphen(grd_display.Cells[0, grd_display.Row]);
  DU_DT := delHyphen(grd_display.Cells[1, grd_display.Row]);
  AC_DT := delHyphen(grd_display.Cells[2, grd_display.Row]);
  AC_GU := grd_display.Cells[3, grd_display.Row];
  AC_NM := grd_display.Cells[4, grd_display.Row];
  if (AC_DT = '') then begin
    frm_LOSTZ250P_CHILD.FormShow(Sender);
  end else
    ShowMessage('정산일자가 존재하여 수정,삭제할수 없습니다.');
    exit;
end;

procedure Tfrm_LOSTZ250P.btn_resetClick(Sender: TObject);
var i : Integer;
begin
  changeBtn(Self);
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;

  cmb_year.Text := Copy(DateToStr(Date),1,4);

  for i := grd_display.fixedrows to grd_display.rowcount - 1 do
    grd_display.rows[i].Clear;
    grd_display.RowCount := 2;

  sts_Message.Panels[1].Text := ' ';     
end;

end.


