{*---------------------------------------------------------------------------
프로그램ID    : LOSTA100P (입고내역 입력)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011.09.05
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
unit u_LOSTA100P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit,
  checklst, cpakmsg, CurrEdit, barprint, so_tmax, WinSkinData, common_lib,
  SimpleSFTP, localCloud,Clipbrd, Menus,u_landprt, ComObj;

const
  TITLE   = '입고내역 입력';
  PGM_ID  = 'LOSTA100P';

type
  Tfrm_LOSTA100P = class(TForm)
    Bevel1          : TBevel;
    Bevel2          : TBevel;
    Bevel4          : TBevel;
    Bevel5          : TBevel;
    Bevel6          : TBevel;
    Bevel7          : TBevel;
    Bevel9          : TBevel;
    Bevel10         : TBevel;
    Bevel11         : TBevel;
    Bevel12         : TBevel;
    Bevel14         : TBevel;
    Bevel15         : TBevel;
    Bevel20         : TBevel;
    Bevel21         : TBevel;
    Bevel22         : TBevel;
    Bevel24         : TBevel;
    Bevel26         : TBevel;
    Bevel27         : TBevel;
    Bevel29         : TBevel;
    Bevel30         : TBevel;
    Bevel32         : TBevel;
    Bevel33         : TBevel;
    Bevel3          : TBevel;
    Bevel34         : TBevel;
    Bevel16         : TBevel;
    Bevel35         : TBevel;
    Bevel17         : TBevel;
    Bevel36         : TBevel;
    Bevel37         : TBevel;
    Bevel19         : TBevel;
    Bevel18         : TBevel;
    Bevel23         : TBevel;
    Bevel25         : TBevel;
    Bevel28         : TBevel;
    Bevel31         : TBevel;
    Bevel38         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel44         : TBevel;
    Bevel45         : TBevel;
    Bevel47         : TBevel;
    Bevel48         : TBevel;
    btn_Postno_Inq  : TBitBtn;
    Button3         : TButton;
    Button1         : TButton;
    Button2         : TButton;
    cmb_Ph_gb       : TComboBox;
    cmb_bx_gu       : TComboBox;
    cmb_no_label    : TComboBox;
    cmb_gt_yn       : TComboBox;
    cmb_Gt_Gu       : TComboBox;
    cmb_Ju_Gu       : TComboBox;
    cmb_md_cd       : TComboBox;
    cmb_gm_gu       : TComboBox;
    cmb_Ph_Cd       : TComboBox;
    cmb_po_cd2      : TComboBox;
    cmb_po_cd1      : TComboBox;
    cmb_jy_cd       : TComboBox;
    PO_cb2          : TComboEdit;
    PO_cb1          : TComboEdit;
    md_cb1          : TComboEdit;
    dte_po_dt       : TDateEdit;
    dte_Ip_Dt       : TDateEdit;
    dte_Gt_Dt       : TDateEdit;
    edt_Id_Nm       : TEdit;
    edt_Bo_So       : TEdit;
    edt_ph_yo       : TEdit;
    edt_ba_no       : TEdit;
    GroupBox3       : TGroupBox;
    GroupBox1       : TGroupBox;
    GroupBox2       : TGroupBox;
    Label12         : TLabel;
    lbl_Cg_No       : TLabel;
    lbl_Lt_No       : TLabel;
    lbl_Ip_Id       : TLabel;
    Label30         : TLabel;
    lbl_Ph_Gu       : TLabel;
    Label32         : TLabel;
    Label7          : TLabel;
    Label2          : TLabel;
    Label1          : TLabel;
    lbl_Ju_So       : TLabel;
    Label33         : TLabel;
    Label34         : TLabel;
    Label3          : TLabel;
    Label15         : TLabel;
    Label35         : TLabel;
    Label5          : TLabel;
    Label16         : TLabel;
    Label9          : TLabel;
    Label14         : TLabel;
    Label20         : TLabel;
    Label26         : TLabel;
    Label6          : TLabel;
    Label36         : TLabel;
    Label17         : TLabel;
    Label21         : TLabel;
    Label27         : TLabel;
    Label38         : TLabel;
    Label10         : TLabel;
    Label28         : TLabel;
    Label39         : TLabel;
    Label22         : TLabel;
    lbl_Program_Name: TLabel;
    Label19         : TLabel;
    Label24         : TLabel;
    Label41         : TLabel;
    Label18         : TLabel;
    lbl_Lt_Gu       : TLabel;
    Label42         : TLabel;
    Label11         : TLabel;
    Label29         : TLabel;
    Label4          : TLabel;
    Label23         : TLabel;
    lbl_Id_Cd       : TLabel;
    Label25         : TLabel;
    msk_Pt_No       : TMaskEdit;
    msk_Sr_No       : TMaskEdit;
    msk_Tl_No       : TMaskEdit;
    msk_bx_no       : TMaskEdit;
    msk_mt_no       : TMaskEdit;
    msk_Gt_No       : TMaskEdit;
    Panel4          : TPanel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    Panel3          : TPanel;
    Panel14         : TPanel;
    pnl1            : TPanel;
    pnl_Bar_prn     : TPanel;
    PopupMenu1      : TPopupMenu;
    rdo_New_2       : TRadioButton;
    rdo_New_1       : TRadioButton;
    rdo_New_3       : TRadioButton;
    rce_ip_su       : TRxCalcEdit;
    rce_bx_su       : TRxCalcEdit;
    SkinData1       : TSkinData;
    btn_Add         : TSpeedButton;
    btn_Update      : TSpeedButton;
    btn_Delete      : TSpeedButton;
    btn_Inquiry     : TSpeedButton;
    btn_Link        : TSpeedButton;
    btn_query       : TSpeedButton;
    btn_excel       : TSpeedButton;
    btn_Print       : TSpeedButton;
    btn_Close       : TSpeedButton;
    btn_reset       : TSpeedButton;
    sts_Message     : TStatusBar;
    PO_Grid1        : TStringGrid;
    md_grid1        : TStringGrid;
    grd_Phon        : TStringGrid;
    PO_Grid2        : TStringGrid;
    TMAX            : TTMAX;
    Panel1: TPanel;
    chk_bl_yn: TCheckBox;
    pnl_bl_yn: TPanel;
    Bevel46: TBevel;
    Label40: TLabel;
    edt_sp_yu: TEdit;
    lbl1: TLabel;
    chk_gt_rodadr_yn: TCheckBox;
    btn_IMEI: TSpeedButton;
    Bevel8: TBevel;
    lbl_im_ei: TLabel;
    Bevel13: TBevel;
    Label8: TLabel;

    procedure PrtFormShow;
    procedure FormCreate        (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure rdo_Gt_yesClick   (Sender: TObject);
    procedure rdo_Gt_noClick    (Sender: TObject);
    procedure cmb_Gt_GuChange   (Sender: TObject);
    procedure msk_Sr_NoExit     (Sender: TObject);
    procedure cmb_Gt_GuKeyDown  (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dte_Ip_DtExit     (Sender: TObject);
    procedure dte_po_dtExit     (Sender: TObject);
    procedure grd_PhonSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure grd_PhonClick     (Sender: TObject);
    procedure btn_Next_InqClick (Sender: TObject);
    procedure btn_PrintClick    (Sender: TObject);
    procedure Button3Click      (Sender: TObject);
    procedure Button2Click      (Sender: TObject);
    procedure Button1Click      (Sender: TObject);
    procedure PO_cb1ButtonClick (Sender: TObject);
    procedure PO_Grid1Click     (Sender: TObject);
    procedure PO_Grid2Click     (Sender: TObject);
    procedure PO_cb1KeyUp       (Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dte_po_dtEnter    (Sender: TObject);
    procedure cmb_Ph_gbEnter    (Sender: TObject);
    procedure PO_cb2ButtonClick (Sender: TObject);
    procedure PO_cb2KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dte_Ip_DtEnter    (Sender: TObject);
    procedure md_grid1Click     (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmb_gt_ynChange   (Sender: TObject);
    procedure cmb_Ph_CdChange   (Sender: TObject);
    procedure cmb_Sp_CdChange   (Sender: TObject);
    procedure msk_Tl_NoKeyUp    (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edt_ba_noKeyUp    (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure msk_mt_noExit     (Sender: TObject);
    procedure PO_cb1Change      (Sender: TObject);
    procedure Link_rtn          (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure btn_click         (Sender: TObject);
    procedure InitComponents;
    procedure disableComponents;
    procedure enableComponents;

    procedure grd_displayDrawCell (Sender: TObject; ACol,
              ARow: Integer; Rect: TRect; State: TGridDrawState);

    procedure grd_displayKeyDown  (Sender: TObject; var Key: Word;
              Shift: TShiftState);

    procedure Copy1Click          (Sender: TObject);

    procedure StringGrid_DrawCell (Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);

    function  ExecExternProg      (progID:String):Boolean;

    procedure msk_Pt_NoKeyPress   (Sender: TObject; var Key: Char);
    procedure msk_Gt_NoKeyUp      (Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_AddClick        (Sender: TObject);
    procedure btn_InquiryClick    (Sender: TObject);
    procedure btn_UpdateClick     (Sender: TObject);
    procedure btn_resetClick      (Sender: TObject);

    procedure Edt_onKeyPress ( Sender : TObject; var key : Char);
    procedure onKeyPress(Sender : TObject;var Key : char);
    procedure edt_ba_noKeyPress(Sender: TObject; var Key: Char);
    procedure edt_sp_yuKeyPress(Sender: TObject; var Key: Char);
    procedure edt_Bo_SoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure md_cb1Exit(Sender: TObject);
    procedure PO_cb2Exit(Sender: TObject);
    procedure btn_IMEIClick(Sender: TObject);
    procedure chk_gt_rodadr_ynClick(Sender: TObject);

  private
    { Private declarations }

    recvedMessage:Boolean;

    //LOSTZ820Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;
    delYN         :String;

  public
    { Public declarations }
    procedure cmb_Ph_gbChange   (Sender: TObject);overload;
    procedure cmb_bx_guChange   (Sender: TObject);overload;
    procedure chk_bl_ynClick    (Sender: TObject);overload;

    procedure setEdtKeyPress;

  published
    procedure cmb_bx_guChange()   ; overload;
    procedure cmb_Ph_gbChange()   ; overload;
    procedure chk_bl_ynClick()    ; overload;
  end;

type
  THackStringGrid = class(TStringGrid);

  (* PGM_STS : 프로그램 상태  *)
  (* 0 : 조회전               *)
  (* 1 : 조회후               *)
  (* 2 : 저장후               *)
  (* 3 : 여유분               *)

  PGM_STS = set of 0..3;

var
  frm_LOSTA100P: Tfrm_LOSTA100P;
  pgm_sts1   : PGM_STS;
  MD_CD,SERIAL,IP_DT : string;

  PO_Grid1_d    : TZ0xxArray;
  PO_Grid2_d    : TZ0xxArray;
  md_grid1_d    : TZ0xxArray;
  cmb_Bx_Gu_d   : TZ0xxArray;
  cmb_Ph_Gb_d   : TZ0xxArray;
  cmb_Gt_Gu_d   : TZ0xxArray;
  cmb_Sp_Cd_d   : TZ0xxArray;
  cmb_Gm_Gu_d   : TZ0xxArray;
  cmb_Ph_Cd_d   : TZ0xxArray;
  cmb_Md_Cd_d   : TZ0xxArray;
  cmb_Po_Cd1_d  : TZ0xxArray;
  cmb_Po_Cd2_d  : TZ0xxArray;
  cmb_No_Label_d: TZ0xxArray;
  cmb_Ju_Gu_d   : TZ0xxArray;

implementation

uses u_LOSTA100P_IMEI;
{$R *.DFM}

Const
     MAXRECCNT = 10 ;
     C_BX_GU       = 'Z046';   //Box 구분
     C_PH_GB       = 'Z031';   //부분품구분
     C_GB_CD       = 'Z004';   //주민/사업자/외국인구분
     C_SP_CD       = 'Z035';   //상품코드
     C_MD_CD       = 'Z008';   //모델코드
     C_PO_CD       = 'Z042';   //우체국코드
     C_GM_GU       = 'Z038';   //습득처구분코드
     C_PH_CD       = 'Z032';   //단말기상태코드
     C_ID_CD       = 'Z001';   //사업자코드
     C_PH_GU       = 'Z003';   //단말기구분코드
     C_SP_GU       = 'Z049';   //사은품구분
     C_NO_LABEL    = 'Z053';   //라벨없음종류
     C_JU_GU       = 'Z061';   //접수구분
     PCS           = '1';      //PCS단말기
     WASTED_PHONE  = '2';      //라벨없음
     CHARGER       = '3';      //충전기
     BATTERY       = '4';      //배터리
     CELLULAR      = '9';      //셀룰러
     ANALOG        = '8';      //아날로그

type
  Talign = ( l,c,r);

  TgridData = record
    title   : string;
    width   : integer;
    align   : Talign;
    execute : string;
  end;

  arrTgrid = Array[0..48] of TgridData;

var
  arrTgrid1 : arrTgrid;
 _selRow    : integer;

(******************************************************************************)
(* procedure Name : fillTgridData(Overload)                                   *)
(* 기  능  설  명 : 함수를 통해 구조체에 데이터를 설정한다.                   *)
(******************************************************************************)
  procedure fillTgridData( var data : TgridData; title: string; width:Integer ; align : Talign;execute : string); overload;
  begin
    data.title := title;
    data.width := width;
    data.align := align;
    data.execute := execute;
  end;

(******************************************************************************)
(* procedure Name : fillTgridData(Overload)                                   *)
(* 기  능  설  명 : 함수를 통해 구조체에 데이터를 설정한다.                   *)
(******************************************************************************)
  procedure fillTgridData( var data : TgridData; title: string; width:Integer ; align : Talign); overload;
  begin
    fillTgridData( data ,title ,width ,align, '');
  end;

(******************************************************************************)
(* procedure Name : execSubProg                                               *)
(* 기  능  설  명 : 해당 그리드 데이터에 실행할 함수를 실행한다.              *)
(******************************************************************************)
  function execSubProg(var data : TgridData;strValue : string): string;
  begin
    strValue := Trim(strValue);

    if (data.execute = '') then Result := strValue;

    if (UpperCase(data.execute) = 'INSHYPHEN') then result := InsHyphen(strvalue);

  end;

(******************************************************************************)
(* procedure Name : setArrGrid                                                *)
(* 기  능  설  명 : 타이틀 및 너비를 설정한다.                                *)
(******************************************************************************)
  procedure setArrGrid(var grid : TStringGrid ; arrTgrid1 : arrTgrid);
  var i,j : Integer;
  begin

    grid.ColCount := High(ArrTgrid1);

    for i:= low(arrTgrid1) to high(arrTgrid1) do
      for j:= 0 to grid.rowcount do
        grid.cells[i,j] := '';

    with grid do
    begin
      for i := Low(arrTgrid1) to High(arrTgrid1) -1 do
      begin
        Cells[i,0] := Trim(arrTgrid1[i].title);
        if (Length(Trim(arrTgrid1[i].title)) * 10 < arrTgrid1[i].width) OR ( arrTgrid1[i].width = -1 ) then ColWidths[i] := arrTgrid1[i].width
        else ColWidths[i] := Length(Trim(arrTgrid1[i].title)) * 10;
      end;
    end;
  end;

  procedure DeleteRow(strgrd: TStringGrid; ARow: Integer);
begin
  with THackStringGrid(strgrd) do
    DeleteRow(ARow);
end;


// 프린터 폼 보여주기
procedure Tfrm_LOSTA100P.PrtFormShow;
begin
	// 출력 다이로그 박스
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet('LostB530L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;

// 세부내용 제거
procedure detail_clear_rtn;
begin
   with frm_LOSTA100P do
   begin
      edt_ba_no.text      := '';
      cmb_gt_yn.itemindex := 0;
      po_cb2.text         := '';
      cmb_ph_gb.itemindex := 0;
      cmb_ph_gb.OnChange(frm_LOSTA100P);
      md_cb1.text         := '';
      msk_sr_no.text      := '';
      msk_mt_no.text      := '';
      cmb_ju_gu.itemindex := 0;

      cmb_gt_gu.itemindex := 0;
      cmb_gt_gu.OnChange(frm_LOSTA100P);
      dte_Gt_Dt.date      := date;
      edt_Id_Nm.Text      := '';
      msk_Pt_No.Text      := '';
      lbl_Ju_So.Caption   := '';

      edt_Bo_So.Text      := '';
      msk_Tl_No.Text      := '';
      //cmb_sp_cd.itemindex := -1;
      //cmb_sp_gu.itemindex := 0;

      lbl_Lt_Gu.Caption   := '';
      lbl_Lt_No.Caption   := '';
      lbl_Id_Cd.Caption   := '';
      lbl_Ph_Gu.Caption   := '';
      lbl_Cg_No.Caption   := '';
      lbl_Ip_Id.Caption   := '';

      edt_ph_yo.text      := '';
      cmb_no_label.itemindex := -1;

      edt_sp_yu.Clear;
      pnl_bl_yn.Visible := false;
      chk_bl_yn.checked := false;
      rdo_New_1.Checked := true;
      rdo_New_2.Checked := false;
      rdo_New_3.Checked := false;
//      rdo_Old_1.Checked := true;
//      rdo_Old_2.Checked := false;

      lbl_im_ei.Caption   := '';
   end;
end;

// 박스 내용제거
procedure box_clear_rtn;
var G_col, G_row : integer;
begin
   with frm_LOSTA100P do
   begin
      cmb_bx_gu.SetFocus;

      msk_bx_no.Clear;
      cmb_bx_gu.ItemIndex := -1;
      dte_ip_dt.Date      := date;
      dte_po_dt.Date      := date;
      po_grid1.Row        := 0;
      po_cb1.Text         := '';
      rce_bx_su.Value     := 0;
      rce_ip_su.Value     := 0;

      with grd_Phon do
      Begin
         for G_col := 0 to colcount - 1 do
    	    for G_row := 1 to rowcount - 1 do
	          cells[ G_col , G_row ] := '';
         RowCount := 2;
      End;

   end;
end;

{----------------------------------------------------------------------------}
// 폼 생성
procedure Tfrm_LOSTA100P.FormCreate(Sender: TObject);
var i, j,_idx : integer;

function Inc2(var val : Integer): Integer;
begin
  result  := val + 1;
  val     := val + 1;
end;
begin


  //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.

  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
	if ParamCount <> 6 then begin
    ShowMessage('로그인 후 사용하세요');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle   := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    // 테스트 후에는 이 부분을 삭제할 것.
    //common_userid     := '0294';    //ParamStr(2);
    //common_username   := '정호영';  //ParamStr(3);
    //common_usergroup  := 'KAIT';    //ParamStr(4);

    {----------------------- 공통 어플리케이션 설정 ---------------------------}
    setEdtKeyPress;

    // 프로그램 캡션 설정
    Self.Caption := '[' + PGM_ID + ']' + TITLE;

    // 테스크바 캡션설정
    Application.Title := TITLE;

    // 프로그램 내부 캡션 설정
    lbl_Program_Name.Caption := TITLE;

    // 프로그램 상단 아이콘 설정
    fSetIcon(Application);

    // 메세지 바 넓이 설정
    pSetStsWidth(sts_Message);

    // 텍스트 선택시 전체 선택 기능
    pSetTxtSelAll(Self);

    // 프로그램 보더 아이콘 설정
    Self.BorderIcons  := [biSystemMenu,biMinimize];

    // 프로그램 시작 위치 설정
    Self.Position     := poScreenCenter;
    {--------------------------------------------------------------------------}
  
    // 스킨 초기화
    initSkinForm(SkinData1);

    //chk_gt_rodadr_yn.Checked := false;
    chk_gt_rodadr_yn.Checked := true;

    {=========================    그리드   초기화     ===========================}
    initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );
    initStrinGridWithZ0xx('Z042.dat', PO_Grid1_d , '', '',PO_Grid1  );

    {=========================    콤보박스 초기화     ===========================}

    (* 박스구분   *)  initComboBoxWithZ0xx('Z046',cmb_Bx_Gu_d   ,'','' ,cmb_Bx_Gu  ,'          ', '', '');
    (* 단말기종류 *)  initComboBoxWithZ0xx('Z031',cmb_Ph_Gb_d   ,'','' ,cmb_Ph_Gb  );
    (* 습득자구분 *)  initComboBoxWithZ0xx('Z004',cmb_Gt_Gu_d   ,'','' ,cmb_Gt_Gu  );
    //(* 상품코드   *)  initComboBoxWithZ0xx('Z035',cmb_Sp_Cd_d   ,'','' ,cmb_Sp_Cd  );
    (* 습득처쿠분 *)  initComboBoxWithZ0xx('Z038',cmb_Gm_Gu_d   ,'','' ,cmb_Gm_Gu  );
    (* 단말기상태 *)  initComboBoxWithZ0xx('Z032',cmb_Ph_Cd_d   ,'','' ,cmb_Ph_Cd  );
    (* 단말기모델 *)  initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d   ,'','' ,cmb_Md_Cd  ,'1', '', '');
    (* 접수우체국 *)  initComboBoxWithZ0xx('Z042',cmb_Po_Cd1_d  ,'','' ,cmb_po_cd1 );
    (* 라벨종류   *)  initComboBoxWithZ0xx('Z053',cmb_No_Label_d,'','' ,cmb_No_Label);
    (* 접수구분   *)  initComboBoxWithZ0xx('Z061',cmb_Ju_Gu_d   ,'','' ,cmb_Ju_Gu   );
    (* 사은품쿠분 *)  // initComboBoxWithZ0xx('Z049',cmb_Sp_Gu_d,'','',cmb_Sp_Gu); // 삭제
    (* 적요코드   *)  pFillCmCdCmb('Z060',cmb_jy_cd);

    //접수 우체국 콤보 설정
    j := 0;

    for i := 0 to cmb_Po_Cd1.Items.Count -1  do
    begin
      //우체국코드와 전산코드2가 같은 경우 감독국

      if cmb_Po_Cd1_d[i].code = cmb_Po_Cd1_d[i].Jcode2 then
      begin
         if j = 0 then
            PO_Grid1.rowcount := 1
         else
           PO_Grid1.rowcount   := PO_Grid1.rowcount + 1;
           PO_Grid1.Cells[0,j] := cmb_Po_Cd1_d[i].name;
           PO_Grid1.Cells[1,j] := cmb_Po_Cd1_d[i].code;
           PO_Grid1.Cells[2,j] := cmb_Po_Cd1_d[i].Jcode1;
           inc(j);
      end;

      if i = 0 then
         PO_Grid2.rowcount := 1
      else
        PO_Grid2.rowcount := PO_Grid2.rowcount + 1;
        PO_Grid2.Cells[0,i] := cmb_Po_Cd1_d[i].name;
        PO_Grid2.Cells[1,i] := cmb_Po_Cd1_d[i].code;
        PO_Grid2.Cells[2,i] := cmb_Po_Cd1_d[i].Jcode1;
    end;

    setEdtKeyPress;

    //FillChar(arrTgrid1,SizeOf(arrTgrid1),#0);

    _idx := 0;

    {------------------------- 스트링 그리드 설정 -----------------------------}

    msk_mt_no.OnKeyPress :=  Self.onKeyPress;
    msk_Tl_No.OnKeyPress :=  Self.onKeyPress;
    msk_Gt_No.OnKeyPress :=  Self.onKeyPress;

    edt_sp_yu.OnKeyPress := edt_sp_yuKeyPress;
    edt_Bo_So.OnKeyPress := edt_Bo_SoKeyPress;
    edt_ba_no.OnKeyPress := edt_ba_noKeyPress;

    fillTgridData(arrTgrid1[     _idx ],'입고일자            ',100 ,c,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득신고자여부      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'모델코드            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'모델명              ',100 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기일련번호      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득처구분코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득처구분명        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기상태코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기상태명        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'가입자주민사업자번호',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'가입자구분코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'가입자성명업체명    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사업자식별코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사업자식별코드명    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기부분품종류코드',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기부분품종류명  ',100 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기구분코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기구분명        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'연락필요여부        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'불명사유코드        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'불명사유            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'입금계좌번호        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자구분코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자구분명        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자성명업체명    ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자주민사업자번호',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득일자            ',100 ,c,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품상품코드      ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품상품명        ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품물품구분코드  ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품물품구분명    ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자우편번호      ',100 ,c,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자기본주소      ',180 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자상세주소      ',200 ,l);
    fillTgridData(arrTgrid1[Inc2(_idx)],'습득자전화번호      ',100 ,l,'InsHyphen');
    fillTgridData(arrTgrid1[Inc2(_idx)],'창고일련번호        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'입고자ID            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'입고자명            ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'우체국코드          ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'우체국명            ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'이동전화번호        ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'단말기적요          ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'라벨없음구분명      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품제외여부      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'사은품제외사유      ',100 ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'분실폰접수구분코드  ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'분실폰접수구분명    ',-1  ,c);
    fillTgridData(arrTgrid1[Inc2(_idx)],'IMEI코드            ',-1  ,c);

    setArrGrid(grd_Phon,arrTgrid1);
    {--------------------------------------------------------------------------}

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA100P.InitComponents;
var
  i ,j: Integer;
  component : TComponent;

  strTmp : array[0..6] of String;
begin

  MD_CD   := '';
  SERIAL  := '';
  IP_DT   := '';

  FillChar(component,SizeOf(component),#0);

  strTmp[0] := dte_Ip_Dt.Text;
  strTmp[1] := msk_bx_no.Text;
  strTmp[2] := IntToStr(cmb_bx_gu.ItemIndex);
  strTmp[3] := PO_cb1.Text;
  strTmp[4] := dte_po_dt.Text;
  strTmp[5] := rce_bx_su.Text;

  if rce_ip_su.Text = '' then strTmp[6] := '0'
  else strTmp[6] := rce_ip_su.Text;

  {-------------------------    라벨필드 초기화    ----------------------------}
  lbl_Cg_No.Caption := '';
  lbl_Ju_So.Caption := '';
  lbl_Ip_Id.Caption := '';
  lbl_Lt_No.Caption := '';
  lbl_Ph_Gu.Caption := '';
  lbl_Id_Cd.Caption := '';
  lbl_Lt_Gu.Caption := '';
  lbl_im_ei.Caption := '';

  {-------------------------    인덱스 초기화      ----------------------------}
  cmb_gt_yn.ItemIndex     :=  0;
  cmb_gm_gu.ItemIndex     :=  0;
  cmb_Bx_Gu.ItemIndex     :=  0;
  cmb_Gm_Gu.ItemIndex     := -1;
  cmb_Gt_Gu.ItemIndex     :=  0;
  cmb_no_label.ItemIndex  := -1;

  {----------------------------------------------------------------------------}

  // 버튼이미지 초기화
  changeBtn(Self);

  btn_Print.Enabled := True;

  cmb_no_label.enabled  := false;
  chk_bl_yn.Checked     := False;

  Self.cmb_bx_guChange();
  self.cmb_Ph_gbChange();

  // 일자 초기화
  dte_Ip_Dt.date := date;
  dte_Gt_Dt.Date := date;
  dte_po_dt.Date := Date;

  for i := 0 to componentcount -1 do
  begin
    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
    else
    if ( Components[i] is TMaskEdit) then
       ( Components[i] as TMaskEdit).Text := ''
    else
    if (  Components[i] is TComboEdit) then
       ( Components[i] as  TComboEdit).Text := '';
  end;

  if (pgm_sts1 <> [2]) and (delYN = 'N') then
  begin
    for i := grd_Phon.FixedRows to grd_Phon.RowCount -1 do
      grd_Phon.Rows[i].Clear;

    grd_Phon.RowCount           :=   2;
    sts_Message.Panels[1].Text  :=  '';
    pgm_sts1                    := [0];
  end;

  rce_bx_su.Text := '0';
  rce_ip_su.Text := '0';

  if pgm_sts1 = [2] then
  begin
    dte_Ip_Dt.Text      := strTmp[0];
    msk_bx_no.Text      := strTmp[1];
    cmb_bx_gu.ItemIndex := StrToInt(strTmp[2]);
    PO_cb1.Text         := strTmp[3];
    dte_po_dt.Text      := strTmp[4];
    rce_bx_su.Text      := strTmp[5];
    rce_ip_su.Text      := IntToStr(StrToint(strTmp[6]) -1) ;
  end;

  // 사은품 초기화
  rdo_New_1.Checked := true;
  rdo_New_2.Checked := false;
  rdo_New_3.Checked := false;

  PO_cb1.SetFocus;

  delYN := 'N';

end;


procedure Tfrm_LOSTA100P.btn_DeleteClick(Sender: TObject);
var
  STR001,STR002,STR003,STR004 : string;

  Label LIQUIDATION;
begin
  if pgm_sts1 = [0] then
  begin
    ShowMessage('조회 후 삭제하실 수 있습니다.');
    Exit;
  end;

  if MessageDlg('정말 삭제하시겠습니까 ?',
    mtConfirmation, mbOkCancel, 0) = mrCancel then
  begin
    sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
    Exit;
  end;

  if( not fChkLength(dte_Ip_Dt  ,8,0,'입고일자'           )) then Exit;
  if( not fChkLength(msk_bx_no  ,6,0,'박스일련번호'       )) then Exit;
  if( not fChkLength(md_cb1     ,1,1,'모델코드'           )) then Exit;
  if( not fChkLength(msk_Sr_No  ,1,1,'단말기일련번호'     )) then Exit;


  STR001 := delhyphen(dte_Ip_Dt.Text);
  STR002 := msk_bx_no.Text;
  STR003 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));
  STR004 := Trim(msk_Sr_No.Text);

  delYN := 'Y';

  MD_CD   := STR003;
  SERIAL  := STR004;
  IP_DT   := STR001;

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA100P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01'            )  < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR001' , STR001         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002' , STR002         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003' , STR003         )  < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR004' , STR004         )  < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTA100P') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' 삭제 완료';

  ShowMessage('성공적으로 삭제하였습니다.');

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  DeleteRow(grd_Phon,grd_Phon.Row);

  pgm_sts1 := [2];

  InitComponents;

  Exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTA100P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTA100P.rdo_Gt_yesClick(Sender: TObject);
begin
   GroupBox1.Enabled := true;
end;

procedure Tfrm_LOSTA100P.rdo_Gt_noClick(Sender: TObject);
begin
   GroupBox1.Enabled := false;
end;

procedure Tfrm_LOSTA100P.cmb_Gt_GuChange(Sender: TObject);
begin
  msk_Gt_No.text := '';

  if cmb_Gt_Gu_d[cmb_Gt_Gu.ItemIndex].code = '1' then
    msk_Gt_No.editmask := '999999-9999999;0;_'
  else if cmb_Gt_Gu_d[cmb_Gt_Gu.ItemIndex].code = '3' then
    msk_Gt_No.editmask := '999-99-99999;0;_'
  else
  begin
    msk_Gt_No.editmask := '';
    msk_Gt_No.MaxLength := 16;
  end;

end;

// 시리얼번호 입력 후 실행
procedure Tfrm_LOSTA100P.msk_Sr_NoExit(Sender: TObject);
var tempstr1, tempstr2 : shortstring;
    tempchr : char;
begin
   with msk_Sr_No do
   begin
      text := CRemoveSpace(text);
      if length(text) = 0 then exit;

      tempstr1 := uppercase(copy(text,1,1));

      CStrToArr(tempstr1, tempchr, False);

//      if tempchr in ['A'..'Z'] then
//      begin
//         tempstr2 := copy(text,2,length(text)-1);
//         tempstr2 := CFillStr(tempstr2, ' ', 16, false);
//         text     := tempstr1 + tempstr2;
//      end
//      else
//      begin
//       //tempstr2 := CFillStr(text, ' ', 16, false);
//       //text     := tempstr2;
//      end;
   end;
end;

// 주민/사업자/외국인구분시 키를 눌렀을 경우 콤보를 변경하고.. onChange를 실행한다.
procedure Tfrm_LOSTA100P.cmb_Gt_GuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   with cmb_Gt_Gu do
   begin
      case KEY of
         VK_NUMPAD1, Ord('1') : ItemIndex := 0;
         VK_NUMPAD2, Ord('2') : ItemIndex := 1;
         VK_NUMPAD3, Ord('3') : ItemIndex := 2;
         else
            exit;
      end;
      OnChange(frm_LOSTA100P);
   end;
end;

procedure Tfrm_LOSTA100P.dte_Ip_DtExit(Sender: TObject);
begin
  try
    dte_Ip_Dt.Date := strtodate(dte_Ip_Dt.text);
  except
    on E: EConvertError do
    begin
      ShowMessage('일자 입력이 잘못되었습니다'+#13+'오늘일자로 변경됩니다');
      dte_Ip_Dt.date := date;
      dte_Ip_Dt.setfocus;
    end;
  end;
end;

procedure Tfrm_LOSTA100P.cmb_Ph_gbChange(sender : TObject);
begin
  Self.cmb_Ph_gbChange;
end;
// 단말기 종류 변경
procedure Tfrm_LOSTA100P.cmb_Ph_gbChange();
var i : integer;
begin

   // 아날로그 단말기인 경우 콤보에 아날로그 단말기만 셋팅
   // 아닌경우 전체
   if cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = ANALOG then
   begin
      initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d,'','' ,cmb_Md_Cd  ,'', 'A', '');
   end
   else
   begin
      initComboBoxWithZ0xx('Z008',cmb_Md_Cd_d,'','' ,cmb_Md_Cd  ,cmb_ph_gb_d[cmb_ph_gb.itemIndex].code, '', '');
   end;

   // 콤보에 등록한 모델명을 그리드에 설정한다.
   for i := 0 to cmb_md_Cd.Items.Count-1 do
   begin
      if i = 0 then
         md_Grid1.rowcount := 1
      else
         md_Grid1.rowcount := md_Grid1.rowcount + 1;

      md_Grid1.Cells[0,i] := trim(Copy(cmb_md_cd.Items[i],1,40));
//      md_Grid1.Cells[1,i] := trim(Copy(cmb_md_cd.Items[i],41,10));
//      md_Grid1.Cells[2,i] := trim(Copy(cmb_md_cd.Items[i],51,10));
   end;

   md_grid1.Row := 0;

   // 단말기 구분이 'PCS','셀룰러','아날로그'인 경우
   // 모델 콤보에 ''으로 셋팅한다. 왜 그런지는 모르겠음
   // 아닌경우 그리드의 처음 값을 넣어준다.
   if ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = PCS ) or
      ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = CELLULAR ) or
      ( cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = ANALOG ) then
       md_cb1.text := ''
   else
       md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];

   // 단말기 종류 , 상품명, 상품구분 공백 설정
   cmb_ph_cd.itemindex := 0;
   //cmb_sp_cd.itemindex := -1;
   //cmb_sp_gu.itemindex := -1;

   // 폰 구분이 버린 폰, 충전기, 배터리인경우
   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = WASTED_PHONE) or
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = CHARGER) or
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = BATTERY) then
   begin
      // 시리얼번호 클리어
      msk_sr_no.text := '0000';
      msk_sr_no.Enabled := false;

      lbl_im_ei.Caption   := '';

      // 단말기 상태코드 사용불가
      cmb_ph_cd.enabled := false;

      // 습득자 사항이 사용가능한 경우
      if groupbox1.Enabled then
      begin
         //cmb_sp_cd.enabled := false;
         //cmb_sp_gu.enabled := false;
         edt_sp_yu.Clear;
         pnl_bl_yn.visible := false;
         chk_bl_yn.enabled := false;
      end;
   end
   else
   begin
      cmb_ph_cd.enabled := true;

      msk_sr_no.text := '';
      msk_sr_no.Enabled := True;

      // 2016.07.25 - 유영배 수정
      //lbl_im_ei.Caption   := '';

      if groupbox1.Enabled then
      begin
         //cmb_sp_cd.enabled := true;
         //cmb_sp_gu.enabled := true;
         pnl_bl_yn.visible := true;
         chk_bl_yn.enabled := true;
      end;
   end;

   cmb_no_label.itemindex := -1;

   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = WASTED_PHONE) then
      cmb_no_label.enabled := True
   else
      cmb_no_label.enabled := False;

   chk_bl_ynClick();

   // 2016.07.25 - 유영배 수정
   //md_cb1.setfocus;
end;

procedure Tfrm_LOSTA100P.dte_po_dtExit(Sender: TObject);
begin
   try
      dte_po_Dt.Date := strtodate(dte_po_Dt.text);
      except
      on E: EConvertError do
      begin
         ShowMessage('일자 입력이 잘못되었습니다'+#13+
          	     '오늘일자로 변경됩니다');
         dte_po_Dt.date := date;
         dte_po_Dt.setfocus;
      end;
   end;

end;

procedure Tfrm_LOSTA100P.cmb_bx_guChange(Sender : TObject);
begin
  self.cmb_bx_guChange;
end;

procedure Tfrm_LOSTA100P.cmb_bx_guChange();
begin
   { box 규격이 없음(협회)인경우 }
   if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code = '9' ) then
   begin
      po_cb1.Text         := '';
      po_cb1.Enabled      := false;
      po_cb2.Text         := '';
      po_cb2.Enabled      := false;
      dte_po_dt.date      := date;
      dte_po_dt.enabled   := false;
      rce_bx_su.Value     := 1;
      // 2016.07.25 - 유영배 수정
      //rce_bx_su.enabled   := false;
      cmb_gm_gu.itemindex := 1;
      cmb_ju_gu.itemindex := 1;
   end
   else
   begin
      po_cb1.enabled      := true;
      po_cb2.enabled      := true;
      dte_po_dt.enabled   := true;
      rce_bx_su.enabled   := true;
      cmb_gm_gu.itemindex := 0;
   end;
end;

procedure Tfrm_LOSTA100P.grd_PhonSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
   _selRow := ARow;
end;

// 하단 그리드 클릭시 해당 데이터를 채움
procedure Tfrm_LOSTA100P.grd_PhonClick(Sender: TObject);
var tempstr, tempdt1 : shortstring;
    i : integer;
begin
   // 1. 단말기 종류
   cmb_ph_gb.itemindex := cmb_ph_Gb.items.IndexOf(Trim(grd_phon.Cells[15,_selRow]));

   // 단말기 종류 변경으로 인한 이벤트 발생
   cmb_Ph_gb.OnChange(frm_LOSTA100P);

   // 2. 모델명
   md_cb1.Text := trim(copy(grd_phon.cells[3,_selRow],1,40));

  for i := 0 to md_grid1.RowCount-1 do
    if Trim(md_grid1.Cells[0,i]) = md_cb1.text then
    begin
      md_grid1.Row := i;
      break;
    end;

   // 3. 일련번호
   msk_Sr_No.Text       := trim(grd_phon.Cells[4,_selRow]);

   // 5. 단말기 상태구분
   cmb_Ph_Cd.itemindex  := cmb_Ph_Cd.items.IndexOf
                           (trim(grd_phon.Cells[8,_selRow]));

   // 6.습득처구분

   cmb_Gm_Gu.itemindex  := cmb_Gm_Gu.items.IndexOf
                           (trim(grd_phon.Cells[6,_selRow]));

   // 7. 습득 신고서 여부
   if trim(grd_phon.cells[1,_selRow]) = 'Y' then
   begin
      cmb_gt_yn.itemindex := 0;
   end
   else
   begin
      cmb_gt_yn.itemindex := 1;
   end;
   cmb_gt_yn.Onchange(frm_LOSTA100P);

   // 8. 습득처 구분
   cmb_Gt_Gu.itemindex := cmb_Gt_Gu.items.IndexOf
                          (grd_phon.Cells[23,_selRow]);
   cmb_Gt_Gu.Onchange(frm_LOSTA100P);

   // 9. 습득자 주민번호
   msk_gt_no.text := delHyphen(trim(grd_phon.Cells[25,_selRow]));

   // 10. 습득일자
   dte_Gt_Dt.Text := grd_phon.cells[26,_selRow];

   // 11. 습득자 명
   edt_Id_Nm.text     := trim(grd_phon.cells[24,_selRow]);

   // 12. 습득자 우편번호
   msk_Pt_No.text     := CNumOnly(grd_phon.cells[31,_selRow]);

   // 13. 습득자 주소
   lbl_Ju_so.Caption  := trim(grd_phon.cells[32,_selRow]);

   // 14. 사은품 상품코드
   // 상품권1인 경우
   //if trim(copy(grd_phon.cells[27, _selRow], 41, 6)) = '200201' then
   if trim(grd_phon.cells[27, _selRow]) = '200201' then
   begin
      rdo_New_1.Checked := true;
      rdo_New_2.Checked := false;
      rdo_New_3.Checked := false;
   end;
   // 상품권2인 경우
   //if trim(copy(grd_phon.cells[27, _selRow], 41, 6)) = '200202' then
   if trim(grd_phon.cells[27, _selRow]) = '200202' then
   begin
      rdo_New_1.Checked := true;
      rdo_New_2.Checked := false;
      rdo_New_3.Checked := false;
   end;
   // 모바일상품권1인 경우
   //if trim(copy(grd_phon.cells[27, _selRow], 41, 6)) = '200203' then
   if trim(grd_phon.cells[27, _selRow]) = '200203' then
   begin
      rdo_New_1.Checked := false;
      rdo_New_2.Checked := true;
      rdo_New_3.Checked := false;
   end;
   // 모바일상품권2인 경우
   //if trim(copy(grd_phon.cells[27, _selRow], 41, 6)) = '200205' then
   if trim(grd_phon.cells[27, _selRow]) = '200205' then
   begin
      rdo_New_1.Checked := false;
      rdo_New_2.Checked := true;
      rdo_New_3.Checked := false;
   end;

   // 16. 보조주소
   edt_Bo_So.Text := trim(grd_phon.cells[33,_selRow]);
   msk_Tl_No.Text := trim(grd_phon.cells[34,_selRow]);

   // 분실자 주민/사업자/외국인번호
   lbl_Lt_No.Caption := grd_phon.cells[ 9,_selRow];


   // 분실자 성명
   lbl_Lt_Gu.Caption := grd_phon.cells[11,_selRow];

   // 출고 예정 사업자
   lbl_Id_Cd.Caption := grd_phon.cells[13,_selRow];

   // 단말기 구분
   lbl_Ph_Gu.Caption := grd_phon.cells[17,_selRow];

   // 창고 번호
   lbl_Cg_No.Caption := grd_phon.cells[35,_selRow];

   //  입고 입력자
   lbl_Ip_Id.Caption := grd_phon.cells[36,_selRow];

   // 우체국명
   po_cb2.Text := trim(grd_phon.cells[39,_selRow]);

   for i := 0 to PO_Grid2.RowCount-1 do
    if po_cb2.Text = copy(PO_Grid2.cells[0,i],1,length(po_cb2.text)) then
    begin
       PO_Grid2.Row := i;
       break;
    end;

   // 이동전화번호
   if (Copy(trim(grd_phon.cells[40,_selRow]),0,3) = '001') then
    msk_mt_no.text := Copy(trim(grd_phon.cells[40,_selRow]),2,Length(trim(grd_phon.cells[40,_selRow]))-1)
   else
    msk_mt_no.text         := trim(grd_phon.cells[40,_selRow]);

   // 단말기 적요
   edt_ph_yo.text         := trim(grd_phon.cells[41,_selRow]);

   // 라벨 없음 구분명
   cmb_no_label.itemindex := cmb_No_Label.items.IndexOf
                             (grd_phon.cells[42,_selRow]);
   // 사은품 제외 여부
   if trim(grd_phon.cells[43,_selRow]) = 'Y' then
   begin
      chk_bl_yn.Checked := True;
      edt_sp_yu.text := grd_phon.cells[44,_selRow];
      pnl_bl_yn.Visible := True;
   end
   else
   begin
      edt_sp_yu.Clear;
      pnl_bl_yn.Visible := False;
      chk_bl_yn.Checked := False;
   end;

   cmb_ju_gu.itemindex := cmb_ju_gu.items.IndexOf
                          (grd_phon.Cells[46,_selRow]);

  // 바코드 번호
  edt_ba_no.Text := grd_phon.cells[2,_selRow]
                  + grd_phon.cells[4,_selRow]
                  + delHyphen(grd_phon.cells[0,_selRow]);

   // IMEI코드
   lbl_im_ei.Caption := trim(grd_phon.cells[47,_selRow]);

end;

procedure Tfrm_LOSTA100P.btn_Next_InqClick(Sender: TObject);
begin
   detail_clear_rtn;
   box_clear_rtn;
   cmb_bx_gu.setfocus;
end;

procedure Tfrm_LOSTA100P.btn_PrintClick(Sender: TObject);
begin
//   if (length(trim(lbl_cg_no.caption)) <> 6) or
//      (savkey.ba_no <> edt_Ba_No.text ) or
//      (savkey.md_cd <> md_cb1.text) or
//      (savkey.sr_no <> msk_sr_no.text) or
//      (savkey.ip_dt <> dte_ip_dt.text) then
//   begin
//      sts_Message.Panels[1].Text := '';
//      showmessage('조회후 작업하세요.');
//      exit;
//   end;
//

   if (not fChkLength(md_cb1    , 1,1,'모델코드'    ))  then Exit;
   if (not fChkLength(msk_sr_no , 1,1,'일련번호'    ))  then Exit;
   if (not fChkLength(dte_ip_dt , 8,0,'입고일자'    ))  then Exit;

   pnl_bar_prn.Visible := true;

   button1.SetFocus;
end;

procedure Tfrm_LOSTA100P.Button3Click(Sender: TObject);
begin
   pnl_bar_prn.Visible := false;

   btn_resetClick(Sender);

end;

procedure Tfrm_LOSTA100P.Button2Click(Sender: TObject);
var
  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
  FSFTP:TSimpleSFTP;

  STR001, STR002, STR003: STring;

  Label LIQUIDATION;
begin
  self.disableComponents;

  STR001 := '';
  STR002 := '';
  STR003 := '';

  if(Length(edt_ba_no.Text) >= 18 ) then
    begin
    	STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	// 모델코드
      STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// 단말기일련번호
      STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// 입고일자
    end
    else
    begin
      if ( not fChkLength(md_cb1    ,1,1,'모델코드')      )  then exit;
      if ( not fChkLength(msk_Sr_No ,1,1,'단말기일련번호'))  then exit;
      if ( not fChkLength(dte_Ip_Dt ,8,0,'입고일자')      )  then exit;

      STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));	// 모델코드
      STR002 := msk_Sr_No.Text;			                                          // 단말기일련번호
      STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // 입고일자
    end;

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA100P')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;

  //서비스 호출
  serviceSuccess := TMAX.Call('LOSTA100P');

  if not serviceSuccess then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  //파일 패스를 얻는다.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //파일명을 얻는다.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //서버에서 파일을 전송받아 ..\KAI\LostPrj\temp 에 저장한다.
  FSFTP:=TSimpleSFTP.Create;
  //SFTP 서버 연결
//  FSFTP.Connect(fGetftpIp(),fGetftpPort(), fGetftpId(), fGetftpPw());

    FSFTP.Connect(TMAX.Host
                 ,TMAX.RecvString('STR402',0)
                 ,TMAX.RecvString('STR403',0)
                 ,TMAX.RecvString('STR404',0)
                 );

	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //출력 다이어로그를 보여줌.
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt', lbl_Program_Name.Caption,'P',63,29,14,80,60);

	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  btn_resetClick(sender);

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
  self.enableComponents;
end;

procedure Tfrm_LOSTA100P.Button1Click(Sender: TObject);
var
  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
  FSFTP:TSimpleSFTP;

  STR001, STR002, STR003: STring;

  Label LIQUIDATION;
begin
  self.disableComponents;

  STR001 := '';
  STR002 := '';
  STR003 := '';

  if(Length(edt_ba_no.Text) >= 18 ) then
  begin
    STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	// 모델코드
    STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// 단말기일련번호
    STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// 입고일자
  end
  else
  begin
    if ( not fChkLength(md_cb1    ,1,1,'모델코드')      )  then exit;
    if ( not fChkLength(msk_Sr_No ,1,1,'단말기일련번호'))  then exit;
    if ( not fChkLength(dte_Ip_Dt ,8,0,'입고일자')      )  then exit;

    STR001 := findCodeFromName(md_cb1.Text, md_grid1_d,Length(md_grid1_d));	// 모델코드
    STR002 := msk_Sr_No.Text;			                                          // 단말기일련번호
    STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // 입고일자
  end;

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
  TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA100P')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P02') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;

  //서비스 호출
  serviceSuccess := TMAX.Call('LOSTA100P');

  if not serviceSuccess then
  begin
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  //파일 패스를 얻는다.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //파일명을 얻는다.
  fileName:= getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //서버에서 파일을 전송받아 ..\KAI\LostPrj\temp 에 저장한다.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.Host
               ,TMAX.RecvString('STR402',0)
               ,TMAX.RecvString('STR403',0)
               ,TMAX.RecvString('STR404',0)
               );

	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //출력 다이어로그를 보여줌.
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt'   // 파일명
                    , lbl_Program_Name.Caption            // 프로그램명
                    , 'P'                                 // 출력방향 L : 가로 P: 세로
                    , 63                                  // 페이지당 출력 라인수
                    , 28                                  // 글자 높이
                    , 15                                  // 라인 당간격
                    , 40                                  // 위쪽 추가 여백
                    , 60 );                               // 왼쪽 여백
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  btn_resetClick(Sender);

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  self.enableComponents;
end;

procedure Tfrm_LOSTA100P.PO_cb1ButtonClick(Sender: TObject);
begin
   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   if not PO_Grid1.Visible then
   begin
     PO_Grid1.Visible := true;
   end else
     PO_Grid1.Visible := false;

   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;
end;

procedure Tfrm_LOSTA100P.PO_Grid1Click(Sender: TObject);
begin
   po_cb1.text := po_grid1.Cells[0,po_grid1.row];
   po_cb1.OnChange(frm_LOSTA100P);
   po_cb1.SetFocus;
   po_grid1.Visible := false;
end;

procedure Tfrm_LOSTA100P.PO_Grid2Click(Sender: TObject);
begin
   po_cb2.text :=po_grid2.Cells[0,po_grid2.row];
   po_cb2.SetFocus;
   po_grid2.Visible := false;
end;

procedure Tfrm_LOSTA100P.PO_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
   po_cb1.OnChange      := nil;
   po_cb1.onButtonClick := nil;
   po_cb1.OnKeyUp       := nil;
   po_grid1.OnClick     := nil;

   // 엔터일경우
   if key = 13 then
   begin
      if po_grid1.Visible then
         po_grid1.Visible := false
      else
        po_grid1.Visible := true;
        po_cb1.Text := '';
        po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;

   // 방향키 위인 경우
   end else if (key = vk_up) and (po_grid1.Visible) then
   begin
      if po_grid1.row > 0 then
      po_grid1.Row  := po_grid1.Row - 1;
        po_cb1.Text := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;
   end else if key = vk_escape then
   begin
      po_grid1.Visible := false;
   end else if (key = vk_down) and (po_grid1.Visible) then
   begin
      if po_grid1.row < po_grid1.RowCount-1 then
        po_grid1.Row  := po_grid1.Row + 1;
        po_cb1.Text   := po_grid1.Cells[0,po_grid1.Row];
        po_cb1.SelectAll;
   end else if (trim(po_cb1.Text) <> '') and (key <> 229) then
   begin
      if not po_grid1.Visible then
         po_grid1.Visible := true;

      for i := 0 to po_grid1.RowCount-1 do
      if po_cb1.Text = copy(po_grid1.cells[0,i],1,length(po_cb1.text)) then
      begin
         po_grid1.Row := i;
         break;
      end;
   end;

   po_cb1.OnChange      := PO_cb1Change;
   po_cb1.OnButtonClick := PO_cb1ButtonClick;
   po_cb1.OnKeyUp       := po_cb1KeyUp;
   po_grid1.OnClick     := PO_Grid1Click;

   if ( (key = 13) or (key = vk_escape) ) and ( not po_grid1.visible) then
      po_cb1.OnChange(frm_LOSTA100P);
end;

procedure Tfrm_LOSTA100P.dte_po_dtEnter(Sender: TObject);
begin
   po_grid1.Visible := false;
end;

procedure Tfrm_LOSTA100P.cmb_Ph_gbEnter(Sender: TObject);
begin
   po_grid2.Visible := true;
end;

// 접수 우체국 콤보 버튼 클릭시 그리드를 보여주고 아니면 숨긴다.
procedure Tfrm_LOSTA100P.PO_cb2ButtonClick(Sender: TObject);
begin
   po_cb2.onButtonClick := nil;
   po_cb2.OnKeyUp := nil;
   po_grid2.OnClick := nil;

   if not PO_Grid2.Visible then
   begin
     PO_Grid2.Visible := true;
   end else
     PO_Grid2.Visible := false;

   po_cb2.OnButtonClick := PO_cb2ButtonClick;
   po_cb2.OnKeyUp := po_cb2KeyUp;
   po_grid2.OnClick := PO_Grid2Click;
end;

// 접수 우체국 콤보 키업시 발생되는 이벤트
procedure Tfrm_LOSTA100P.PO_cb2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
   po_cb2.onButtonClick := nil;
   po_cb2.OnKeyUp := nil;
   po_grid2.OnClick := nil;

   if key = 13 then
   begin
      if po_grid2.Visible then
         po_grid2.Visible := false
      else
         po_grid2.Visible := true;
      po_cb2.Text := '';
      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
      po_cb2.SelectAll;
   end else
   if (key = vk_up) and (po_grid2.Visible) then
   begin
      if po_grid2.row > 0 then
         po_grid2.Row := po_grid2.Row - 1;
      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
      po_cb2.SelectAll;
   end else
   if key = vk_escape then
   begin
      po_grid2.Visible := false;
   end else
   if (key = vk_down) and (po_grid2.Visible) then
   begin
      if po_grid2.Row < po_grid2.RowCount-1 then
         po_grid2.Row := po_grid2.Row + 1;
      po_cb2.Text := po_grid2.Cells[0,po_grid2.Row];
      po_cb2.SelectAll;
   end else
   if (trim(po_cb2.Text) <> '') and (key <> 229) then
   begin
      if not po_grid2.Visible then
         po_grid2.Visible := true;
      for i := 0 to po_grid2.RowCount-1 do
      if po_cb2.Text = copy(po_grid2.cells[0,i],1,length(po_cb2.text)) then
      begin
         po_grid2.Row := i;
         break;
      end;
   end;

   po_cb2.OnButtonClick := PO_cb2ButtonClick;
   po_cb2.OnKeyUp := po_cb2KeyUp;
   po_grid2.OnClick := PO_Grid2Click;
end;

// 입고일자 엔터 누를 시
procedure Tfrm_LOSTA100P.dte_Ip_DtEnter(Sender: TObject);
begin
   po_grid1.Visible := false;
   po_grid2.Visible := false;
   md_grid1.Visible := false;
end;

// 모델 그리드 클릭시 실행
procedure Tfrm_LOSTA100P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

// 모델 콤보 클릭시 실행
procedure Tfrm_LOSTA100P.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   if not md_Grid1.Visible then
   begin
      md_Grid1.Visible := true;
   end else
      md_Grid1.Visible := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;

end;

// 모델 콤보 키업시 실행
procedure Tfrm_LOSTA100P.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   if key = 13 then
   begin
      if md_grid1.Visible then
        md_grid1.Visible  := false
      else
        md_grid1.Visible  := true;
        md_cb1.Text       := '';
        md_cb1.Text       := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
        md_grid1.Row  := md_grid1.Row - 1;
        md_cb1.Text   := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
        md_grid1.Row  := md_grid1.Row + 1;
        md_cb1.Text   := md_grid1.Cells[0,md_grid1.Row];
        md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then  md_grid1.Visible := true;

      for i := 0 to md_grid1.RowCount-1 do
        if md_cb1.Text = copy(md_grid1.cells[0,i],1,length(md_cb1.text)) then
        begin
           md_grid1.Row := i;
           break;
        end;
   end;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 습득 신고 여부 변화 시 실행되는 이벤트
procedure Tfrm_LOSTA100P.cmb_gt_ynChange(Sender: TObject);
begin
   //cmb_sp_cd.itemindex := -1;
   //cmb_sp_gu.itemindex := -1;

   if cmb_gt_yn.itemindex = 0 then
   begin
      groupbox1.Enabled := true;
      if ( (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = PCS      ) or
           (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = CELLULAR ) or
           (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code = ANALOG)  ) and
           (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> '1111'  ) then
      begin
         //cmb_sp_cd.enabled := true;
         //cmb_sp_gu.enabled := true;
         pnl_bl_yn.visible := true;
         chk_bl_yn.enabled := true;
      end
      else
      begin
         //cmb_sp_cd.enabled := false;
         //cmb_sp_gu.enabled := false;
         pnl_bl_yn.visible := false;
         chk_bl_yn.enabled := false;
         edt_sp_yu.Clear;
      end;
   end
   else
      groupbox1.Enabled := false;
end;

procedure Tfrm_LOSTA100P.cmb_Ph_CdChange(Sender: TObject);
begin
   if (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> PCS      ) and
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> CELLULAR ) and
      (cmb_Ph_Gb_d[cmb_ph_gb.ItemIndex].code <> ANALOG   ) then
       exit;

   //cmb_sp_cd.itemindex := -1;
   //cmb_sp_gu.itemindex := -1;

   if cmb_Ph_Cd_d[cmb_ph_cd.ItemIndex].code = '1111' then
   begin
      if groupbox1.Enabled then
      begin
         //cmb_sp_cd.enabled := false;
         //cmb_sp_gu.enabled := false;
         edt_sp_yu.clear;
         pnl_bl_yn.visible := false;
         chk_bl_yn.enabled := false;
      end;
   end
   else
   begin
      if groupbox1.Enabled then
      begin
         //cmb_sp_cd.enabled := true;
         //cmb_sp_gu.enabled := true;
         pnl_bl_yn.visible := true;
         chk_bl_yn.enabled := true;
      end;
   end;
end;

procedure Tfrm_LOSTA100P.cmb_Sp_CdChange(Sender: TObject);
begin
   //cmb_sp_gu.itemindex := 0;
end;

procedure Tfrm_LOSTA100P.msk_Tl_NoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 107 then
  begin
    btn_AddClick(Sender);
  end;
end;

procedure Tfrm_LOSTA100P.edt_ba_noKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_RETURN then
   begin
    btn_InquiryClick(Sender);
   end;
end;

// 이동전화번호검증
procedure Tfrm_LOSTA100P.msk_mt_noExit(Sender: TObject);
var tempstr1, tempstr2, tempstr3 : shortstring;
begin
   if CRemoveSpace(msk_mt_no.text) = '' then
   begin
      msk_mt_no.text := '';
      exit;
   end;

   tempstr1 := CRemoveSpace(copy(msk_mt_no.text,1,3));
   tempstr2 := CRemoveSpace(copy(msk_mt_no.text,4,4));
   tempstr3 := CRemoveSpace(copy(msk_mt_no.text,8,4));

   if tempstr1 <> '' then
      tempstr1 := CFillStr(tempstr1, '0', 3, false)
   else
      tempstr1 := CFillStr(tempstr1, ' ', 3, false);
   if tempstr2 <> '' then
      tempstr2 := CFillStr(tempstr2, '0', 4, false)
   else
      tempstr2 := CFillStr(tempstr2, ' ', 4, false);
   if tempstr3 <> '' then
      tempstr3 := CFillStr(tempstr3, '0', 4, false);

   if CRemoveSpace(tempstr1+tempstr2+tempstr3) = '' then
      msk_mt_no.text := ''
   else if CRemoveSpace(tempstr2+tempstr3) = '' then
      msk_mt_no.text := tempstr1
   else
      msk_mt_no.text := tempstr1 + tempstr2 + tempstr3;
end;

// 좌측 우체국명 변경시
procedure Tfrm_LOSTA100P.PO_cb1Change(Sender: TObject);
var i : integer;
begin

   initStrinGridWithZ0xx('Z042.dat',cmb_Po_Cd2_d  ,'','' ,PO_Grid2 ,'',PO_Grid1.Cells[1,PO_Grid1.row],'');

   po_cb2.Text := '';

//   for i := 0 to PO_Grid2.RowCount -1 do
//   begin
//      if i = 0 then
//         PO_Grid2.rowcount := 1
//      else
//        PO_Grid2.rowcount := PO_Grid2.rowcount + 1;
//        PO_Grid2.Cells[0,i] := cmb_Po_Cd2_d[i].name;
//        PO_Grid2.Cells[1,i] := cmb_Po_Cd2_d[i].code;
//        PO_Grid2.Cells[2,i] := cmb_Po_Cd2_d[i].Jcode2;
//   end;

   po_grid2.Row := 0;
end;


procedure Tfrm_LOSTA100P.chk_bl_ynClick();
begin
   if chk_bl_yn.Checked = true then
   begin
      pnl_bl_yn.Visible := True;
      edt_sp_yu.SetFocus;
   end
   else
   begin
      edt_sp_yu.Clear;
      pnl_bl_yn.Visible := False;
   end;

end;

// 사은품 제회 선택시 이벤트
procedure Tfrm_LOSTA100P.chk_bl_ynClick(Sender: TObject);
begin
  self.chk_bl_ynClick();
end;


procedure Tfrm_LOSTA100P.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin
  if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit)) then
  begin
    if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
    else  mskEdt := Sender as TMaskEdit;

    value1 := msk_Pt_No.Text;

  end;

  CreateMap;	//공유메모리 생성

  // 도로명주소 체크에 따라 우편번호 팝업 선택
  if (chk_gt_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
      else self.ExecExternProg('LOSTZ800Q');

end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTA100P.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;		  //사용중=1,미사용=0 *)
  (*  ProgID      :String[30];	//사용중인 프로그램 *)
  (*                                                *)
  (*  name        :String[30];                      *)
  (*  model_name  :String[30];                      *)
  (*  model_code  :String[30];                      *)
  (*  serial_no   :String[30];                      *)
  (*  ibgo_date   :String[30];                      *)
  (*  birth       :String[30];                      *)
  (*  phone_no    :String[30];                      *)
  (**************************************************)
  smem  :TPSharedMem;
  //modelName, serial_no, ibgoil:String;
  //str:String;

begin
	//'LOSTZ810.exe'으로 부터 메세지를 받았다.
	recvedMessage:= True;

  //공유메모리 엑세스 필요여부는 wparam을 참조할 것.
  if Msg.wParam = 1 then
  begin
    //공유메모리를 얻는다.
    smem:= OpenMap;

    if smem <> nil then
    begin
      Lock;  //동시 접속방지

      msk_Pt_No.Text        := smem^.po_no;			    // 우편번호
      lbl_Ju_So.Caption     := smem^.ju_so;	        // 주소

      //if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    edt_Bo_So.SetFocus;

  end;

    ShowWindow(Self.Handle, SW_SHOW     );
    ShowWindow(Self.Handle, SW_RESTORE  );
end;

function Tfrm_LOSTA100P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  (****************************************************************************)
  (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
    			      (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - 호출구분          *)+ ' ' +  '12'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  '1'
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  value1
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  value2
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);

		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

    ShowWindow(Self.Handle, SW_SHOW     );
    ShowWindow(Self.Handle, SW_RESTORE  );
  end;

end;

procedure Tfrm_LOSTA100P.msk_Pt_NoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> #13 then Exit;

  Self.btn_click(Sender);
end;

procedure Tfrm_LOSTA100P.msk_Gt_NoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strTmp : string;

  function getRtnValue(value : string): string;
  var i : integer;
  begin
    for i := 1 to 7 do
      result := result + value;
  end;
begin
  strTmp := delHyphen(Trim((Sender as TMaskEdit).text));

  if(Length(strTmp) = 13) and (Key = VK_RETURN) then dte_Gt_Dt.SetFocus;

  if ((cmb_Gt_Gu.ItemIndex = 0) and (Length(strTmp) >= 7)) then
  begin
//    if Copy(strTmp,7,1) = '1' then (Sender as TMaskEdit).text := Copy(strTmp,0,6) + '1111111'
//    else (Sender as TMaskEdit).text := Copy(strTmp,0,6) + '2222222';

  case StrToInt(Copy(strTmp,7,1)) of
    1..9 : (Sender as TMaskEdit).text := Copy(strTmp,0,6) + getRtnValue(Copy(strTmp,7,1));
  end;
  end;
end;

procedure Tfrm_LOSTA100P.grd_displayDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  grid: TStringGrid;
  S     :String;
begin
	grid:= Sender as TStringGrid;
  grid.RowHeights[ARow] := 21;

	S:= grid.Cells[ACol,ARow];
    if (ARow =0) then begin
    	grid.Canvas.Brush.Color := clBtnFace;
      grid.Canvas.Font.Color  := clBlack;
    	grid.Canvas.FillRect(Rect);
    	DrawText(grid.canvas.Handle, PChar(S), length(S), Rect, dt_center or dt_singleline or dt_vcenter);
    end
    else
    // 타이틀인 첫행을 제외한 컬럼들의 정렬을 담당한다.
    begin
      case arrTgrid1[ACol].align of
        l : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 0);
        c : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 1);
        r : StringGrid_DrawCell(Sender, ACol, ARow, Rect, 2);
        else ShowMessage(IntToStr(ACol) + '의 정렬 기준이 다릅니다.');
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

procedure Tfrm_LOSTA100P.grd_displayKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if ((ssCtrl in Shift) AND (Key = ord('C'))) then
		Copy1Click(Sender);
end;

procedure Tfrm_LOSTA100P.Copy1Click(Sender: TObject);
var
  select: TGridRect;
  str:String;
  i,j:Integer;
begin
	select := grd_Phon.Selection;
    with select do begin
        str:='';

    	if (Left = Right) and (Top = Bottom) then
        	str := grd_Phon.Cells[Left,Top]

        else begin
        	for j:= Top to Bottom do begin
        		for i:= Left to Right do
            		str := str + grd_Phon.Cells[i,j] + '|';

            	str:= str +#13#10;
        	end;
        end;
    end;
    Clipboard.AsText := str;
end;

(******************************************************************************)
(* procedure Name : StringGrid_DrawCell                                       *)
(* 기 능 설 명 : 정해진 변수에 따라서 Grid의 정렬이 된다.                     *)
(******************************************************************************)
procedure Tfrm_LOSTA100P.StringGrid_DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; i_align : integer);
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

procedure Tfrm_LOSTA100P.btn_AddClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_gtno, str_gtnm, str_tlno, str_mtno, str_imei : String;
  seed_gtno, seed_gtnm, seed_tlno, seed_mtno, seed_imei : String;

  // 서비스 파라미터
  STRVALUE : array[1..33] of string;

  // 서비스 변수 번호 ex) 001,002..xxx
  STRNUM : string;

  // 서비스 실행 파라미터 ex) I01,U01,D01..
  svcNm  : string;

  // 루프변수
  i : Integer;
  Label LIQUIDATION;
  Label SEEDKEY;

begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  str_gtno := '';
  str_gtnm := '';
  str_tlno := '';
  str_mtno := '';
  str_imei := '';
  seed_gtno := '';
  seed_gtnm := '';
  seed_tlno := '';
  seed_mtno := '';
  seed_imei := '';

  if (rce_bx_su.AsInteger <= 0 ) then
  begin
    ShowMessage('Box당 수량은 0보다 커야합니다.');
    Exit;
  end;

  // 서비스 실행 파라미터 설정
  if Sender is TSpeedButton then
    if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if Sender is TMaskEdit then
    if ((sender as TMaskEdit).Name = 'msk_Tl_No') or ((sender as TMaskEdit).Name = 'msk_mt_no')
      then svcNm := 'I01';

  if ( (pgm_sts1 = [1]) and (svcNm = 'I01')) then
  begin
    ShowMessage('초기화 후 저장하실 수 있습니다.');
    Exit;
  end else if (( pgm_sts1 = [0]) and (svcNm = 'U01')) then
  begin
    ShowMessage('조회 후 수정하실 수 있습니다.');
    Exit;
  end;

  if (rce_bx_su.AsInteger = rce_ip_su.AsInteger) AND (svcNm = 'I01') then
  begin
    ShowMessage('이미 모든 박스수량만큼 입력하셨습니다.');
    rdo_New_1.Checked := true;
    rdo_New_2.Checked := false;
    rdo_New_3.Checked := false;
    Exit;
  end;

  if( not fChkLength(dte_Ip_Dt  ,8,0,'입고일자'                 )) then Exit;
  if( not fChkLength(cmb_bx_gu  ,1,1,'박스구분코드'             )) then Exit;
  if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code <> '9' ) then
  if( not fChkLength(PO_cb1     ,1,1,'우체국코드'               )) then Exit;

  if( not fChkLength(dte_po_dt  ,1,1,'감독국송부일자'           )) then Exit;
  if( not fChkLength(cmb_Ph_gb  ,1,1,'단말기부분품종류코드'     )) then Exit;
  if( not fChkLength(md_cb1     ,1,1,'모델코드'                 )) then Exit;
  if( not fChkLength(msk_Sr_No  ,1,1,'단말기일련번호'           )) then Exit;
  if( not fChkLength(msk_Gt_No  ,1,1,'습득자주민사업자번호'     )) then Exit;
  if( not fChkLength(dte_Gt_Dt  ,8,0,'습득신고일자'             )) then Exit;
  if( not fChkLength(edt_Id_Nm  ,1,1,'습득자성명(업체명)'       )) then Exit;
  if( not fChkLength(msk_Pt_No  ,1,1,'습득자우편번호'           )) then Exit;
  if( not fChkLength(lbl_Ju_So  ,1,1,'습득자기본주소'           )) then Exit;
  if( not fChkLength(msk_Tl_No  ,1,1,'습득자전화번호'           )) then Exit;
  if cmb_bx_gu.ItemIndex = 0 then
  if( not fChkLength(PO_cb2     ,1,1,'우체국코드'               )) then Exit;
//  if( not fChkLength(msk_mt_no  ,1,1,'이동전화번호'             )) then Exit;

  //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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

//SEED KEY 조회
SEEDKEY:

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //서비스 호출
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키

  TMAX.InitBuffer;

  FillChar(STRVALUE,SizeOf(STRVALUE),#0);

  str_gtno := delhyphen(msk_Gt_No.Text);
  str_gtnm := Trim(edt_Id_Nm.Text);
  str_tlno := Trim(delHyphen(msk_Tl_No.Text));
  str_mtno := msk_mt_no.Text;
  str_imei := Trim(lbl_im_ei.Caption);

(*  입고일자             *) STRVALUE[ 1] := delHyphen(dte_Ip_Dt.Text);
(*  박스일련번호         *) STRVALUE[ 2] := Trim(msk_bx_no.Text);
(*  박스구분코드         *) STRVALUE[ 3] := cmb_bx_gu_d[cmb_bx_gu.itemindex].code;
if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code = '9' ) then
begin
(*  우체국코드           *) STRVALUE[ 4] := '      ';
(*  체신청코드           *) STRVALUE[ 5] := '      ';
end else
begin
(*  우체국코드           *) STRVALUE[ 4] := Trim(po_grid1.Cells[1,po_grid1.row]);
(*  체신청코드           *) STRVALUE[ 5] := Trim(po_grid1.Cells[2,po_grid1.row]);
end;
(*  우체국분실폰배달일자 *) STRVALUE[ 6] := delHyphen(dte_po_dt.Text);
(*  박스당단말기수량     *) STRVALUE[ 7] := Trim(rce_bx_su.Text);
(*  습득신고자여부       *) STRVALUE[ 8] := Trim(Copy(cmb_gt_yn.Items.Strings[cmb_gt_yn.itemIndex],41,10));
(*  단말기부분품종류코드 *) STRVALUE[ 9] := cmb_Ph_gb_d[cmb_Ph_gb.itemIndex].code;
(*  모델코드             *) STRVALUE[10] := trim(findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d)));
(*  단말기일련번호       *) STRVALUE[11] := Trim(msk_Sr_No.Text);
(*  습득처구분코드       *) STRVALUE[12] := cmb_gm_gu_d[cmb_gm_gu.itemIndex].code;
(*  단말기상태코드       *) STRVALUE[13] := cmb_Ph_Cd_d[cmb_Ph_Cd.itemIndex].code;
(*  습득자구분코드       *) STRVALUE[14] := cmb_Gt_Gu_d[cmb_Gt_Gu.itemIndex].code;
(*  습득자주민사업자번호 *) STRVALUE[15] := ECPlazaSeed.Encrypt(str_gtno, common_seedkey);
(*  습득신고일자         *) STRVALUE[16] := delhyphen(dte_Gt_Dt.Text);
(*  사은품상품코드       *) STRVALUE[17] := '';
(*  습득자성명(업체명)   *) STRVALUE[18] := ECPlazaSeed.Encrypt(str_gtnm, common_seedkey);
(*  습득자우편번호       *) STRVALUE[19] := delhyphen(msk_Pt_No.Text);
(*  습득자기본주소       *) STRVALUE[20] := Trim(lbl_Ju_So.Caption) ;
(*  습득자상세주소       *) STRVALUE[21] := Trim(edt_Bo_So.Text);
(*  습득자전화번호       *) STRVALUE[22] := ECPlazaSeed.Encrypt(str_tlno, common_seedkey);
(*  사은품물품구분코드   *) STRVALUE[23] := '';
if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code = '9' ) then
(*  우체국코드           *) STRVALUE[24] := '      '
else
(*  우체국코드           *) STRVALUE[24] := cmb_Po_Cd2_d[PO_Grid2.Row].code;
(*  이동전화번호         *) STRVALUE[25] := ECPlazaSeed.Encrypt(str_mtno, common_seedkey);
(*  단말기적요           *) STRVALUE[26] := Trim(edt_ph_yo.Text);
if(cmb_no_label.Enabled) then
(*  라벨없음구분코드     *) STRVALUE[27] := cmb_no_label_d[cmb_no_label.itemIndex].code
else
(*  라벨없음구분코드     *) STRVALUE[27] := ' ';
(*  사은품제외여부       *) if(chk_bl_yn.Checked) then STRVALUE[28] := 'Y' else STRVALUE[28] := 'N';
(*  사은품제외사유       *) STRVALUE[29] := Trim(edt_sp_yu.Text);
(*  분실폰접수구분코드   *) STRVALUE[30] := cmb_Ju_Gu_d[cmb_Ju_Gu.itemIndex].code;
(*  신형모델상품코드     *) if(rdo_New_1.Checked) then STRVALUE[31] := 'Y';
                            if(rdo_New_2.Checked) then STRVALUE[31] := 'N';
                            if(rdo_New_3.Checked) then STRVALUE[31] := 'X';
(*  구형모델상품코드     *) STRVALUE[32] := '';
(*  IMEI코드             *) STRVALUE[33] := ECPlazaSeed.Encrypt(str_imei, common_seedkey);

  MD_CD   := STRVALUE[10];
  SERIAL  := STRVALUE[11];
  IP_DT   := STRVALUE[ 1];

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA100P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;

  for i := Low( STRVALUE ) to High( STRVALUE ) do
  begin
    case Length(IntToStr(i)) of
      1 : STRNUM := '00' + IntToStr(i);
      2 : STRNUM := '0'  + IntToStr(i);
      3 : STRNUM :=        IntToStr(i);
    end;

    if (TMAX.SendString('STR' + STRNUM , STRVALUE[i]     ) < 0) then  goto LIQUIDATION;
  end;

    //서비스 호출
	if not TMAX.Call('LOSTA100P') then
  begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar(PGM_ID),MB_OK);

    goto LIQUIDATION;
  end;

  if(svcNm = 'I01') then
  begin
    sts_Message.Panels[1].Text := ' 등록 완료';

    ShowMessage('성공적으로 등록하였습니다.');
  end else
  begin
    sts_Message.Panels[1].Text := ' 수정 완료';

    ShowMessage('성공적으로 수정하였습니다.');
  end;

    rdo_New_1.Checked     := true;
    rdo_New_2.Checked     := false;
    rdo_New_3.Checked     := false;

    // 도로명주소체크 초기화
    //chk_gt_rodadr_yn.Checked := false;
    chk_gt_rodadr_yn.Checked := true;

    msk_Pt_No.Text := '';
    lbl_Ju_So.Caption := '';
    edt_Bo_So.Text := '';

    lbl_im_ei.Caption := '';

  if ((TMAX.RecvString('STR102',0) = 'Y')
  or (TMAX.RecvInteger('INI101',0) = StrToInt(rce_bx_su.Text))) then
  begin
    pnl_Bar_prn.Visible := True;
    pgm_sts1 := [3];
    button1.SetFocus;
  end;

  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  if pgm_sts1 <> [3] then
    pgm_sts1 := [2];

  btn_InquiryClick(Sender);

  Exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

end;


procedure Tfrm_LOSTA100P.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_temp : String;

    i ,j: integer;
    STR001, STR002, STR003 , STRNUM: STring;

  Label LIQUIDATION;
  Label SEEDKEY;
  Label INQUIRY;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_ganm := '';
  seed_gano := '';
  seed_gatl := '';
  seed_mtno := '';
  seed_temp := '';

  STR001 := '';
  STR002 := '';
  STR003 := '';
  STRNUM := '';

  if(Length(Trim(edt_ba_no.Text)) = 28 ) then
  begin
    STR001 := copy(Trim(edt_ba_no.Text),0,4)  ;	                        // 모델코드
    STR002 := copy(Trim(edt_ba_no.Text),5,Length(edt_ba_no.Text) - 12);	// 단말기일련번호
    STR003 := copy(Trim(edt_ba_no.Text),Length(edt_ba_no.Text) - 7,8);	// 입고일자
  end
  else if ( MD_CD <> '') then
  begin
    STR001 := MD_CD;
    STR002 := SERIAL;
    STR003 := IP_DT;
  end else
  begin
    if ( not fChkLength(md_cb1    ,1,1,'모델코드')      )  then exit;
    if ( not fChkLength(msk_Sr_No ,1,1,'단말기일련번호'))  then exit;
    if ( not fChkLength(dte_Ip_Dt ,8,0,'입고일자')      )  then exit;

    STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, Length(md_grid1_d));	// 모델코드
    STR002 := msk_Sr_No.Text;			                                          // 단말기일련번호
    STR003 := delHyphen(dte_Ip_Dt.Text);	                                  // 입고일자

  end;

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

//SEED KEY 조회
SEEDKEY:

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ900Q') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S03') < 0) then  goto LIQUIDATION;

  //서비스 호출
	//if not TMAX.Call('LOSTB220Q') then goto LIQUIDATION;
  if not TMAX.Call('LOSTZ900Q') then goto LIQUIDATION;

  common_seedkey := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR101', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키

//내역조회
INQUIRY:

  TMAX.InitBuffer;
  
  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA100P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTA100P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  InitComponents;

(* 입고일자            	 *)  dte_Ip_Dt.Text       := InsHyphen(TMAX.RecvString('STR011',0));
(* 박스일련번호        	 *)  msk_bx_no.Text       :=           TMAX.RecvString('STR012',0);
(* 박스구분코드        	 *)  cmb_bx_gu.ItemIndex  := cmb_bx_gu.items.indexof(findNameFromCode(TMAX.RecvString('STR013',0),cmb_Bx_Gu_d,cmb_bx_gu.Items.Count));
(* 우체국분실폰배달일자	 *)  dte_po_dt.Text       := InsHyphen(TMAX.RecvString('STR014',0));
(* 우체국명            	 *)  PO_cb1.Text	        :=           TMAX.RecvString('STR018',0);
                             for i := 0 to po_grid1.RowCount-1 do
                              if po_cb1.Text = copy(po_grid1.cells[0,i],1,length(po_cb1.text)) then
                              begin
                                 po_grid1.Row := i;
                                 break;
                              end;
                             PO_cb1Change(self);
(* 박스당단말기수량    	 *)  rce_bx_su.Text       :=           TMAX.RecvString('INT016',0);
(* 입고단말기수량      	 *)  rce_ip_su.Text       :=           TMAX.RecvString('INT017',0);

  grd_Phon.RowCount := TMAX.RecvInteger('INF013',0) + 1;

  // 2016.07.25 - 유영배 추가
   { box 규격이 없음(협회)인경우 }
   if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code = '9' ) then
   begin
      po_cb1.Text         := '';
      po_cb1.Enabled      := false;
      po_cb2.Text         := '';
      po_cb2.Enabled      := false;
      dte_po_dt.date      := date;
      dte_po_dt.enabled   := false;
      //rce_bx_su.Value     := 1;
      // 2016.07.25 - 유영배 수정
      //rce_bx_su.enabled   := false;
      cmb_gm_gu.itemindex := 1;
      cmb_ju_gu.itemindex := 1;
   end
   else
   begin
      po_cb1.enabled      := true;
      po_cb2.enabled      := true;
      dte_po_dt.enabled   := true;
      rce_bx_su.enabled   := true;
      cmb_gm_gu.itemindex := 0;
   end;

  for i := 0 to TMAX.RecvInteger('INF013',0) -1 do
  begin

    for j := Low( arrTgrid1 ) + 1 to High( arrTgrid1 ) do
    begin
      case Length(IntToStr(j)) of
        1 : STRNUM := '10' + IntToStr(j);
        2 : STRNUM := '1'  + IntToStr(j);
        3 : STRNUM :=        IntToStr(j);
      end;

      if ( (STRNUM = '110') OR (STRNUM = '112') OR (STRNUM = '122') OR (STRNUM = '125') OR (STRNUM = '126') OR (STRNUM = '137') OR (STRNUM = '138') OR (STRNUM = '141') OR (STRNUM = '148') ) then
      begin
        seed_temp := TMAX.RecvString('STR' + STRNUM ,i);
        grd_Phon.Cells[j-1,i+1] := execSubProg(arrTgrid1[j-1],ECPlazaSeed.Decrypt(seed_temp, common_seedkey));
      end
      else
        grd_Phon.Cells[j-1,i+1] := execSubProg(arrTgrid1[j-1],TMAX.RecvString('STR' + STRNUM ,i));

    end;

    if pgm_sts1 <> [2] then
    begin
      if (STR001 = Trim(grd_Phon.Cells[2,i+1])) AND
         (Trim(CFillStr(STR002, '0', 16, false)) = Trim(grd_Phon.Cells[4,i+1])) AND
         (STR003 = Delhyphen(grd_Phon.Cells[0,i+1])) then
        grd_Phon.Row := i+1;
    end;
  end;

  sts_Message.Panels[1].Text := ' 조회 완료';

  //나머지 버튼 활성화
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

  if pgm_sts1 <> [2] then
  begin
    grd_PhonClick(Sender);
    pgm_sts1 := [1];
  end;

  MD_CD   := '';
  SERIAL  := '';
  IP_DT   := '';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

   if (cmb_Bx_Gu_d[cmb_bx_gu.ItemIndex].code = '9' ) then
   begin
      cmb_Ph_gb.SetFocus;
   end
   else
   begin
      PO_cb2.SetFocus;
   end;

end;

procedure Tfrm_LOSTA100P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA100P.disableComponents;
begin

  btn_Add.Enabled     := False;
  btn_Update.Enabled  := False;
  btn_Delete.Enabled  := False;
  btn_Inquiry.Enabled := False;
  btn_Print.Enabled   := False;


    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA100P.enableComponents;
begin
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;
  btn_Inquiry.Enabled := True;
  btn_Print.Enabled   := True;

    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '데이터 처리완료.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA100P.btn_resetClick(Sender: TObject);
begin
  pgm_sts1 := [0];
  Self.InitComponents;
end;

procedure Tfrm_LOSTA100P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA100P.setEdtKeyPress;
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


procedure Tfrm_LOSTA100P.onKeyPress(Sender : TObject;var Key : char);
begin
  if key = #13 then SelectNext( Sender as TWinControl , true, True)
  else if not (key in ['0'..'9',#8,#9,#45]) then key := #0
  else if Sender is TMaskEdit then
        if (Sender as TMaskEdit) = msk_mt_no then
         if key = #107 then btn_AddClick(Sender);


end;

procedure Tfrm_LOSTA100P.edt_ba_noKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender)
  else if not (key in ['0'..'z',#8,#9,#22]) then key := #0;
end;

procedure Tfrm_LOSTA100P.edt_sp_yuKeyPress(Sender: TObject; var Key: Char);
begin
  if ( key = #13) then
    msk_Gt_No.SetFocus;
end;

procedure Tfrm_LOSTA100P.edt_Bo_SoKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) or (key = #10) then msk_Tl_No.SetFocus;
end;

procedure Tfrm_LOSTA100P.FormShow(Sender: TObject);
begin
  // 콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTA100P.md_cb1Exit(Sender: TObject);
begin
  md_grid1.Visible := False;
end;

procedure Tfrm_LOSTA100P.PO_cb2Exit(Sender: TObject);
begin
  PO_Grid2.Visible := False;
end;

procedure Tfrm_LOSTA100P.btn_IMEIClick(Sender: TObject);
begin
  // 에디트박스 초기화
  lbl_im_ei.Caption := '';
  frm_LOSTA100P_IMEI.edt_imei_cd.Text := '';
  frm_LOSTA100P_IMEI.edt_imei_md_nm.Text := '';
  frm_LOSTA100P_IMEI.edt_imei_sr_no.Text := '';
  frm_LOSTA100P_IMEI.edt_kait_md_cd.Text := '';
  frm_LOSTA100P_IMEI.edt_kait_md_nm.Text := '';
  frm_LOSTA100P_IMEI.edt_kait_sr_no.Text := '';

  Self.Enabled := false;
  frm_LOSTA100P_IMEI.Show;

  frm_LOSTA100P_IMEI.edt_imei_cd.SetFocus;

end;

procedure Tfrm_LOSTA100P.chk_gt_rodadr_ynClick(Sender: TObject);
begin
//   if chk_gt_rodadr_yn.Checked = true then
//   begin
//      btn_click(Sender);
//   end;
end;

end.

