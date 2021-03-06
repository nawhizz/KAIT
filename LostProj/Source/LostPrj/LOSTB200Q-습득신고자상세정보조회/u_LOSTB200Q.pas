{*---------------------------------------------------------------------------
프로그램ID    : LOSTB200Q (습득신고자 상세 정보 조회)
프로그램 종류 : Online
작성자	      : 최대성
작성일	      : 2011. 08. 10
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
unit u_LOSTB200Q;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask, ToolEdit, checklst, cpakmsg,
  WinSkinData, so_tmax, common_lib,localCloud, ComObj;

const
  TITLE   = '습득신고자 정보 조회';
  PGM_ID  = 'LOSTB200Q';

type
  Tfrm_LOSTB200Q = class(TForm)
    Bevel1     : TBevel;
    Bevel32    : TBevel;
    Bevel19    : TBevel;
    Bevel20    : TBevel;
    Bevel35    : TBevel;
    Bevel49    : TBevel;
    Bevel50    : TBevel;
    Bevel38    : TBevel;
    Bevel37    : TBevel;
    Bevel36    : TBevel;
    Bevel16    : TBevel;
    Bevel4     : TBevel;
    Bevel13    : TBevel;
    Bevel5     : TBevel;
    Bevel7     : TBevel;
    Bevel9     : TBevel;
    Bevel10    : TBevel;
    Bevel14    : TBevel;
    Bevel12    : TBevel;
    Bevel45    : TBevel;
    Bevel46    : TBevel;
    Bevel51    : TBevel;
    Bevel52    : TBevel;
    Bevel18    : TBevel;
    Bevel2     : TBevel;
    Bevel3     : TBevel;
    Bevel6     : TBevel;
    Bevel17    : TBevel;
    Bevel11    : TBevel;
    Bevel21    : TBevel;
    Bevel53    : TBevel;
    Bevel48    : TBevel;
    Bevel47    : TBevel;
    Bevel44    : TBevel;
    Bevel43    : TBevel;
    Bevel42    : TBevel;
    Bevel40    : TBevel;
    Bevel39    : TBevel;
    Bevel41    : TBevel;
    Bevel26    : TBevel;
    Bevel22    : TBevel;
    Bevel23    : TBevel;
    Bevel24    : TBevel;
    Bevel25    : TBevel;
    Bevel27    : TBevel;
    Bevel28    : TBevel;
    Bevel29    : TBevel;
    Bevel30    : TBevel;
    Bevel31    : TBevel;
    Bevel33    : TBevel;
    Bevel34    : TBevel;
    Bevel55    : TBevel;
    Bevel56    : TBevel;
    Bevel57    : TBevel;
    Bevel58    : TBevel;
    Bevel59    : TBevel;
    Bevel60    : TBevel;
    Bevel61    : TBevel;
    Bevel62    : TBevel;
    Bevel63    : TBevel;
    Bevel64    : TBevel;
    Bevel65    : TBevel;
    Bevel66    : TBevel;
    Bevel67    : TBevel;
    Bevel68    : TBevel;
    Bevel69    : TBevel;
    Bevel70    : TBevel;
    Bevel71    : TBevel;
    Bevel72    : TBevel;
    Bevel73    : TBevel;
    Bevel74    : TBevel;
    Bevel75    : TBevel;
    Bevel76    : TBevel;
    Bevel77    : TBevel;
    Bevel78    : TBevel;
    Bevel79    : TBevel;
    Bevel80    : TBevel;
    Bevel81    : TBevel;
    Bevel82    : TBevel;
    Bevel83    : TBevel;
    Bevel84    : TBevel;
    Bevel85    : TBevel;
    Bevel86    : TBevel;
    Bevel87    : TBevel;
    Bevel88    : TBevel;
    Bevel89    : TBevel;
    Bevel90    : TBevel;
    Bevel91    : TBevel;
    Bevel92    : TBevel;
    Bevel93    : TBevel;
    btn3       : TBitBtn;
    btn4       : TBitBtn;
    btn1       : TBitBtn;
    btn2       : TBitBtn;
    cmb_md_cd  : TComboBox;
    md_cb1     : TComboEdit;
    dte_Ip_Dt  : TDateEdit;
    serial_edit: TEdit;
    edt_Id_Nm  : TEdit;
    edt_md_cd  : TEdit;
    edt_id_cd  : TEdit;
    GroupBox2  : TGroupBox;
    GroupBox1  : TGroupBox;
    GroupBox3  : TGroupBox;
    GroupBox4  : TGroupBox;
    lbl_ju_dt  : TLabel;
    lbl_bo_so  : TLabel;
    lbl_bn_sy  : TLabel;
    Label28    : TLabel;
    lbl_ip_id  : TLabel;
    Label30    : TLabel;
    lbl_bl_id  : TLabel;
    Label3     : TLabel;
    lbl_ch_id  : TLabel;
    Label11    : TLabel;
    lbl_id_cd  : TLabel;
    lbl_pt_no  : TLabel;
    lbl_sp_cd  : TLabel;
    Label29    : TLabel;
    lbl_Sn_Dt  : TLabel;
    lbl_tl_no  : TLabel;
    Label14    : TLabel;
    Label31    : TLabel;
    lbl_Ph_cd2 : TLabel;
    lbl_sp_gu  : TLabel;
    Label34    : TLabel;
    Label26    : TLabel;
    lbl_cg_no2 : TLabel;
    Label5     : TLabel;
    Label36    : TLabel;
    lbl_cg_no  : TLabel;
    lbl_ph_gb2 : TLabel;
    Label32    : TLabel;
    lbl_sp_yu  : TLabel;
    Label38    : TLabel;
    lbl_ph_yo  : TLabel;
    Label7     : TLabel;
    lbl_bl_yn  : TLabel;
    lbl_Program_Name: TLabel;
    Label39        : TLabel;
    Label4         : TLabel;
    Label17        : TLabel;
    Label40        : TLabel;
    Label12        : TLabel;
    Label41        : TLabel;
    lbl_ph_gb      : TLabel;
    Label42        : TLabel;
    Label9         : TLabel;
    Label43        : TLabel;
    lbl_ph_cd      : TLabel;
    Label44        : TLabel;
    lbl_Gid_Gu     : TLabel;
    Label6         : TLabel;
    lbl_Gid_No     : TLabel;
    lbl_Gid_Nm     : TLabel;
    Label10        : TLabel;
    lbl_Gpt_No     : TLabel;
    Label20        : TLabel;
    lbl_Gju_So     : TLabel;
    Label45        : TLabel;
    lbl_Gbo_So     : TLabel;
    lbl_Gtl_No     : TLabel;
    Label15        : TLabel;
    lbl_Mt_No      : TLabel;
    Label21        : TLabel;
    Label13        : TLabel;
    Label22        : TLabel;
    Label16        : TLabel;
    Label46        : TLabel;
    Label23        : TLabel;
    Label18        : TLabel;
    Label24        : TLabel;
    Label47        : TLabel;
    Label19        : TLabel;
    Label48        : TLabel;
    Label25        : TLabel;
    Label49        : TLabel;
    lbl_ch_Gu      : TLabel;
    Label50        : TLabel;
    Label2         : TLabel;
    Label51        : TLabel;
    lbl_Nid_Gu     : TLabel;
    lbl_gt_yn      : TLabel;
    lbl_Nid_No     : TLabel;
    lbl_Ju_So      : TLabel;
    lbl_Nid_Nm     : TLabel;
    lbl_bn_dt      : TLabel;
    lbl_Npt_No     : TLabel;
    lbl_gt_dt      : TLabel;
    lbl_Nju_So     : TLabel;
    Label52        : TLabel;
    lbl_Nbo_So     : TLabel;
    lbl_Ntl_no     : TLabel;
    lbl_bl_dt      : TLabel;
    edt_phone_no    : TMaskEdit;
    PageControl1    : TPageControl;
    Panel1          : TPanel;
    pnl_Command     : TPanel;
    SkinData1       : TSkinData;
    btn_Addr_Update : TSpeedButton;
    SpeedButton1    : TSpeedButton;
    sts_Message     : TStatusBar;
    md_grid1        : TStringGrid;
    TMAX            : TTMAX;
    ts2             : TTabSheet;
    ts1             : TTabSheet;
    edt_birth_date: TEdit;
    Label1: TLabel;
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
    Bevel8: TBevel;
    Bevel15: TBevel;
    Label8: TLabel;
    lbl_ip_dt: TLabel;

    procedure btn_CloseClick        (Sender: TObject);
    procedure FormCreate            (Sender: TObject);
    procedure btn_DeleteClick       (Sender: TObject);
    procedure md_grid1Click         (Sender: TObject);
    procedure md_cb1ButtonClick     (Sender: TObject);
    procedure md_cb1KeyUp           (Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_InquiryClick      (Sender: TObject);
    procedure SpeedButton1Click     (Sender: TObject);
    procedure btn_Addr_UpdateClick  (Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    md_grid1_d :TZ0xxArray;

    //LOSTZ810Q.exe로 메세지 받을 때 사용
    recvedMessage:Boolean;

    //LOSTZ810Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;

    //검색시 사용
    STR001:String; // 모델코드
    STR002:String; // 단말기일련번호
    STR003:String; // 입고일자

  public
    { Public declarations }
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;

    procedure SetItemNo(number:String);
    procedure InitComponents;

    procedure AttachOnEnterEvent;
    procedure AttachOnKeyPressEvent;
    procedure AttachOnExitEvent;
    procedure DetachOnEnterEvent;

    procedure OnExit(Sender:TObject);
    procedure OnEnter(Sender:TObject);

    //쌍안경 이미지 버튼 클릭
    procedure OnSearchClick(Sender:TObject);
    procedure SetLabelCaption(var lbl:TLabel; strtag:String);

    //검색 조건, 콤포넌트 별 키프레스
    procedure OnKeyPress(Sender: TObject; var Key: Char);

    function ExecExternProg(progID:String):Boolean;

    function keyCheck:boolean;

    function frtnRealIdNo(gbn : Integer) : String;

  end;

var
  frm_LOSTB200Q: Tfrm_LOSTB200Q;
  strGidNo , strNidNo : String;

implementation

uses u_LOSTB200Q_ADDR,u_LOSTB200Q_ADDR2;

{$R *.DFM}

function Tfrm_LOSTB200Q.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;


procedure Tfrm_LOSTB200Q.AttachOnKeyPressEvent;
begin
	edt_Id_Nm.OnKeyPress      := self.OnKeyPress; // TEdit       성명
	edt_birth_date.OnKeyPress := self.OnKeyPress; // TDateEdit   생년월일
	edt_phone_no.OnKeyPress   := self.OnKeyPress; // TMaskEdit   분실핸드폰번호
	md_cb1.OnKeyPress         := self.OnKeyPress; // TComboEdit  모델명
	serial_edit.OnKeyPress    := self.OnKeyPress; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnKeyPress                                               *)
(* procedure 기 능 : 컴퍼넌트중에 OnKeyPress를 사용하는 개체의                *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

begin
	if Key <> #13 then 	//엔터키가 아니면
    	exit;

	if Sender.ClassType = TEdit then
        begin
          edit := Sender as TEdit;
          if edit = edt_Id_Nm            then btn1.OnClick(btn1)  // 성명
          else if edit = serial_edit     then btn4.OnClick(btn4) 	// 시리얼 번호
          else if edit = edt_birth_date  then btn2.OnClick(btn2); // 생년월일
        end
  else if Sender.ClassType = TComboEdit then
        begin
          cedit:= Sender as TComboEdit;
          
          if cedit = md_cb1 then
          begin
            if md_grid1.Visible then cedit.Text := md_grid1.Cells[0,md_grid1.Row];
            md_grid1.Visible := False;
            serial_edit.SetFocus;	      //모델명
          end;
        end
  else if Sender.ClassType = TMaskEdit then
        begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then btn3.OnClick(btn3);
  end;
end;

(******************************************************************************)
(* procedure name  : OnSearchClick                                            *)
(* procedure 기 능 : 컴퍼넌트중에 OnSearchClick를 사용하는 개체의             *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.OnSearchClick(Sender:TObject);
begin
    //성명
    if Sender = btn1 then
      begin
        edt_Id_Nm.SetFocus;
          if Trim(edt_Id_Nm.Text)= '' then
          begin
            ShowMessage('성명(업체명)을 입력하세요');
            exit;
          end;
        edt_Id_Nm.OnExit(edt_Id_Nm);
        //Application.ProcessMessages;
      end
    else if Sender = btn2 then
        begin
          edt_birth_date.SetFocus;	//날짜
          if Trim(delHyphen(edt_birth_date.Text))='' then
          begin
            ShowMessage('날짜를 입력하세요');
            exit;
          end;
          edt_birth_date.OnExit(edt_birth_date);
        end
    //분실폰번
    else if Sender = btn3 then
        begin
          edt_phone_no.SetFocus;
          if Trim(edt_phone_no.Text)='' then
          begin
            ShowMessage('폰 번호를 입력하세요');
            exit;
          end;
          edt_phone_no.OnExit(edt_phone_no);

        end
    //시리얼 번호
    else if Sender = btn4 then
        begin
          serial_edit.SetFocus;
          if (Trim(md_cb1.Text) = '') or  (Trim(serial_edit.Text) ='') then begin
            ShowMessage('모델명과 시리얼번호를 입력하세요');
            exit;
          end;
          serial_edit.OnExit(serial_edit);
    end;

    CreateMap;	//공유메모리 생성
	  self.ExecExternProg('LOSTZ810Q');
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure 기 능 : 컴퍼넌트중에 OnExit를 사용하는 개체의                    *)
(*                   이벤트를 실행한다.                                       *)
(*                   해당 이벤트가 발생한 컴퍼넌트의 값을 전역변수로 설정한다 *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.OnExit(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	value2:= 'dummy';

	if Sender.ClassType = TEdit then
    begin
      edit := Sender as TEdit;
      //시리얼 번호
      if edit = serial_edit then
        begin
          value1 := Trim(md_cb1.Text); //전역변수 설정 -> value1
          value2 := Trim(edit.Text);   //전역변수 설정 -> value2

          if value2 = '' then value2 := 'dummy';

          md_grid1.Visible := False;
        end
      //성명
      else if edit = edt_Id_Nm then
      begin
        value1:= Trim(edt_Id_Nm.Text);

        if value1 = '' then value1 := 'dummy';
      end
      else if edit = edt_birth_date then
      begin
        value1:= Trim(edt_birth_date.Text);

        if value1= '' then value1 :='dummy';
      end;
      end
    //모델명
    else if Sender.ClassType = TComboEdit then
    begin
      cedit   := Sender as TComboEdit;

      value1  := Trim(cedit.Text);

      if value1 = '' then
        value1  := 'dummy';
    end
  //분실폰 번호
  else if Sender.ClassType = TMaskEdit then
  begin
    medit   := Sender as TMaskEdit;
    value1  := StringReplace(Trim(delHyphen(medit.Text)),' ','_',[rfReplaceAll]);

    if (value1 = '') then
      value1 := 'dummy'; //'010-0000-0000';
  end;

end;

(******************************************************************************)
(* procedure name  : DetachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 DetachOnEnterEvent를 사용하는 개체의        *)
(*                   이벤트를 해제한다..                                      *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter      := nil;         // TEdit       성명
	edt_birth_date.OnEnter := nil;         // TDateEdit   생년월일
	edt_phone_no.OnEnter   := nil;         // TMaskEdit   분실핸드폰번호
	md_cb1.OnEnter         := nil;         // TComboEdit  모델명
	serial_edit.OnEnter    := nil;         // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnExitEvent                                        *)
(* procedure 기 능 : 컴퍼넌트중에 OnExitEvent를 사용하는 개체의               *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.AttachOnExitEvent;
begin
	edt_Id_Nm.OnExit        := self.OnExit; // TEdit       성명
	edt_birth_date.OnExit   := self.OnExit; // TDateEdit   생년월일
	edt_phone_no.OnExit     := self.OnExit; // TMaskEdit   분실핸드폰번호
	md_cb1.OnExit           := self.OnExit; // TComboEdit  모델명
	serial_edit.OnExit      := self.OnExit; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnterEvent를 사용하는 개체의              *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.AttachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter       := self.OnEnter; // TEdit      성명
	edt_birth_date.OnEnter  := self.OnEnter; // TDateEdit  생년월일
	edt_phone_no.OnEnter    := self.OnEnter; // TMaskEdit  분실핸드폰번호
	md_cb1.OnEnter          := self.OnEnter; // TComboEdit 모델명
	serial_edit.OnEnter     := self.OnEnter; // TEdit      시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnEnter                                                  *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnter를 사용하는 개체의                   *)
(*                   이벤트를 연결한다.                                       *)
(*                   엔터친 컴퍼넌트가 뭔지 파악해서 변수에 숫자를 담고 있는다*)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.OnEnter(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;

begin
	if Sender.ClassType = TEdit then
  begin
    edit := Sender as TEdit;
    //성명
    if edit = edt_Id_Nm then
      SetItemNo('1')
    //시리얼 번호
    else if edit = serial_edit then
      SetItemNo('4')
    else if edit = edt_birth_date then
    // 생년월일
      SetItemNo('2');
  end
  //모델명
  else if Sender.ClassType = TComboEdit then begin
    cedit:= Sender as TComboEdit;

    if cedit = md_cb1 then
    begin
      md_grid1.Visible := false;
      setItemNo('4');
    end;
  end
  // 분실핸드폰번호
  else if Sender.ClassType = TMaskEdit then begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then
            SetItemNo('5');
  end;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure 기 능 : 엔터친 컴퍼넌트에 대한 숫자를 담고 있는다.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTB200Q.Link_rtn (var Msg : TMessage);
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
  modelName, serial_no, ibgoil:String;
  str:String;

  hThreadID: Cardinal;
  FocusWnd: THandle;

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

      edt_Id_Nm.Text        := smem^.name;			      // 성명(업체명)
      md_cb1.Text           := smem^.model_name;	    // 모델명
      serial_edit.Text      := smem^.serial_no;	      // 단말기일련번호
      dte_Ip_Dt.Text        := smem^.ibgo_date;		    // 입고일
      edt_birth_date.Text   := smem^.birth;			      // 생년월일
      edt_phone_no.EditText := Trim(smem^.phone_no2); // 전화번호

      if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    //'조회' 버튼 클릭
    btn_InquiryClick(self);
  end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);  

end;

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTB200Q.md_cb1ButtonClick(Sender: TObject);
begin
   md_cb1.onButtonClick  := nil;
   md_cb1.OnKeyUp        := nil;
   md_grid1.OnClick      := nil;

   if not md_Grid1.Visible then md_Grid1.Visible  := true
   else md_Grid1.Visible  := false;

   md_cb1.OnButtonClick := md_cb1ButtonClick;
   md_cb1.OnKeyUp       := md_cb1KeyUp;
   md_grid1.OnClick     := md_Grid1Click;
end;

// 모델 콤보 KeyUp 이벤트
procedure Tfrm_LOSTB200Q.md_cb1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i : integer;
begin
   md_cb1.onButtonClick := nil;
   md_cb1.OnKeyUp       := nil;
   md_grid1.OnClick     := nil;

   // 엔터 누를 시
   if key = 13 then
   begin
      if md_grid1.Visible then
         md_grid1.Visible := false
      else
         md_grid1.Visible := true;

      md_cb1.Text := '';
      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else

   //방향키 위로 누를 시
   if (key = vk_up) and (md_grid1.Visible) then
   begin
      if md_grid1.row > 0 then
         md_grid1.Row := md_grid1.Row - 1;

      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if key = vk_escape then
   begin
      md_grid1.Visible := false;
   end else

   // 방향키 아래로 누를 시
   if (key = vk_down) and (md_grid1.Visible) then
   begin
      if md_grid1.row < md_grid1.RowCount-1 then
         md_grid1.Row := md_grid1.Row + 1;

      md_cb1.Text := md_grid1.Cells[0,md_grid1.Row];
      md_cb1.SelectAll;
   end else
   if (trim(md_cb1.Text) <> '') and (key <> 229) then
   begin
      if not md_grid1.Visible then
         md_grid1.Visible := true;
         
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

// 모델 그리드 클릭시
procedure Tfrm_LOSTB200Q.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

(******************************************************************************)
(* procedure name  : SetLabelCaption                                          *)
(* procedure 기 능 : 라벨명과 캡션을 받아 라벨 캡션으로 설정한다.             *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q.SetLabelCaption(var lbl:TLabel; strtag:String);
begin
    lbl.Caption:= TMAX.RecvString(strtag,0);
end;

procedure Tfrm_LOSTB200Q.btn_CloseClick(Sender: TObject);
begin
     close;
end;

procedure Tfrm_LOSTB200Q.FormCreate(Sender: TObject);
var i : integer;
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

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

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

  //common_lib.pas에 있다.
  initSkinForm(SkinData1);

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

  //콤포넌트에 이벤트를 어태치 한다.
  AttachOnEnterEvent;
  AttachOnExitEvent;
  AttachOnKeyPressEvent;

  btn1.OnClick := self.OnSearchClick;
  btn2.OnClick := self.OnSearchClick;
  btn3.OnClick := self.OnSearchClick;
  btn4.OnClick := self.OnSearchClick;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB200Q.InitComponents;
var
  i : Integer;
begin
  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TLabel then
    begin
      if (Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0) then
      (Components[i] as TLabel).Caption := '';
    end else if Components[i] is TEdit then (Components[i] as TEdit).Text := ''
    else if Components[i] is TMaskEdit then  (Components[i] as TMaskEdit).Text := ''
  end;

  dte_Ip_Dt.Date  := date;

  PageControl1.ActivePageIndex := 0;

  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

  //초기화
  setItemNo('1');

  //처음 실행시 윈도우 클로즈 돕기 위해
  recvedMessage:= True;

  changeBtn(Self);
  btn_query.Enabled := false;
  btn_excel.Enabled := False;
end;

procedure Tfrm_LOSTB200Q.btn_DeleteClick(Sender: TObject);
begin
    //
end;

procedure Tfrm_LOSTB200Q.btn_InquiryClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_gtnm, seed_gtno, seed_gttl, seed_nanm, seed_nano, seed_natl : String;

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
  seed_gtnm := '';
  seed_gtno := '';
  seed_gttl := '';
  seed_nanm := '';
  seed_nano := '';
  seed_natl := '';

  if(not fChkLength(md_cb1,1,1,'모델코드')) then Exit;
  if(not fChkLength(serial_edit,1,1,'단말기 일련번호')) then Exit;
  if(not fChkLength(dte_Ip_Dt,8,0,'입고일자')) then Exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//모델코드
	STR002:= serial_edit.Text;			                                        //단말기일련번호
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                    //입고일자

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
	if (TMAX.SendString('INF003','LOSTB200Q'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTB200Q') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;


(* 모델코드              *) edt_md_cd.Text     :=             Trim(TMAX.RecvString('STR101',0));
                            frm_LOSTB200Q_ADDR2.lbl_Md_Cd.Caption := edt_md_cd.Text;
(* 모델명                *) md_cb1.Text        :=             Trim(TMAX.RecvString('STR102',0));
//(* 단말기일련번호        *) serial_edit.Text   :=             Trim(TMAX.RecvString('STR103',0));
(* 입고일자              *) dte_Ip_Dt.Text     := InsHyphen(  Trim(TMAX.RecvString('STR104',0)));
                            lbl_ip_dt.Caption  := dte_Ip_Dt.Text ;
(* 단말기종류코드        *) //                 :=             Trim(TMAX.RecvString('STR105',0));
(* 단말기종류            *) lbl_ph_gb.Caption  :=             Trim(TMAX.RecvString('STR106',0));
                            lbl_ph_gb2.Caption :=             Trim(TMAX.RecvString('STR106',0));
(* 단말기상태코드        *) //                 :=             Trim(TMAX.RecvString('STR107',0));
(* 단말기상태            *) lbl_ph_cd.Caption  :=             Trim(TMAX.RecvString('STR108',0));
                            lbl_Ph_cd2.Caption :=             Trim(TMAX.RecvString('STR108',0));
(* 단말기적요            *) lbl_ph_yo.Caption  :=             Trim(TMAX.RecvString('STR109',0));
(* 창고번호              *) lbl_cg_no.Caption  :=             Trim(TMAX.RecvString('STR110',0));
                            lbl_cg_no2.Caption :=             Trim(TMAX.RecvString('STR110',0));
(* 출고일자              *) lbl_Sn_Dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR111',0)));
(* 습득자주민사업자번호  *) //edt_id_cd.Text     :=             Trim(TMAX.RecvString('STR112',0));
                            seed_gtno          :=             Trim(TMAX.RecvString('STR112',0));
                            edt_id_cd.Text     :=             ECPlazaSeed.Decrypt(seed_gtno, common_seedkey);
(* 습득자성명            *) //edt_Id_Nm.Text     :=             Trim(TMAX.RecvString('STR156',0));
                            seed_gtnm          :=             Trim(TMAX.RecvString('STR156',0));
                            edt_Id_Nm.Text     :=             ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey);
(* 습득일자              *) lbl_gt_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR114',0)));
(* 습득자우편번호        *) lbl_pt_no.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR115',0)));
(* 습득자기본주소        *) lbl_Ju_So.Caption  :=             Trim(TMAX.RecvString('STR116',0));
(* 습득자상세주소        *) lbl_bo_so.Caption  :=             Trim(TMAX.RecvString('STR117',0));
(* 습득자전화번호        *) //lbl_tl_no.Caption  :=   Trim(TMAX.RecvString('STR118',0));
                            seed_gttl          :=             Trim(TMAX.RecvString('STR118',0));
                            lbl_tl_no.Caption  :=             ECPlazaSeed.Decrypt(seed_gttl, common_seedkey);
(* 사은품물품구분코드    *) //                 :=             Trim(TMAX.RecvString('STR119',0));
(* 사은품물품구분        *) lbl_sp_gu.Caption  :=             Trim(TMAX.RecvString('STR120',0));
(* 사은품상품코드        *) //                 :=             Trim(TMAX.RecvString('STR121',0));
(* 사은품상품명          *) lbl_sp_cd.Caption  :=             Trim(TMAX.RecvString('STR122',0));
(* 사은품제외여부        *) lbl_bl_yn.Caption  :=             Trim(TMAX.RecvString('STR123',0));
(* 사은품제외사유        *) lbl_sp_yu.Caption  :=             Trim(TMAX.RecvString('STR124',0));
(* 사은품처리구분코드    *) //                 :=             Trim(TMAX.RecvString('STR125',0));
(* 사은품처리구분        *) lbl_ch_Gu.Caption  :=             Trim(TMAX.RecvString('STR126',0));
(* 사은품발송일자        *) lbl_bl_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR127',0)));
(* 사은품수취여부        *) lbl_gt_yn.Caption  :=             Trim(TMAX.RecvString('STR128',0));
(* 전달일자              *) lbl_ju_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR129',0)));
(* 반송일자              *) lbl_bn_dt.Caption  := InsHyphen(  Trim(TMAX.RecvString('STR130',0)));
(* 반송사유코드          *) //                 :=             Trim(TMAX.RecvString('STR131',0));
(* 반송사유              *) lbl_bn_sy.Caption  :=             Trim(TMAX.RecvString('STR132',0));
(* 입력자ID              *) lbl_ip_id.Caption  :=             Trim(TMAX.RecvString('STR133',0));
(* 사은품발송자ID        *) lbl_bl_id.Caption  :=             Trim(TMAX.RecvString('STR134',0));
(* 반송처리자ID          *) lbl_ch_id.Caption  :=             Trim(TMAX.RecvString('STR135',0));
(* 사업자식별코드        *) //                 :=             Trim(TMAX.RecvString('STR136',0));
(* 사업자명              *) lbl_id_cd.Caption  :=             Trim(TMAX.RecvString('STR137',0));

(* 분실핸드폰번호        *) seed_mtno          :=             TMAX.RecvString('STR138',0);
                            lbl_Mt_No.Caption  :=             Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
(* 가입자주민구분코드    *) //                 :=             Trim(TMAX.RecvString('STR139',0));
(* 가입자주민사업자구분  *) lbl_Gid_Gu.Caption :=             Trim(TMAX.RecvString('STR140',0));
(* 가입자주민사업자번호  *) //lbl_Gid_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR141',0)));
                            //strGidNo           :=             Trim(TMAX.RecvString('STR141',0));
                            seed_gano          :=             TMAX.RecvString('STR141',0);
                            lbl_Gid_No.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
                            strGidNo           :=             lbl_Gid_No.Caption;
(* 가입자성명(업체명)    *) //lbl_Gid_Nm.Caption :=             Trim(TMAX.RecvString('STR142',0));
                            seed_ganm          :=             TMAX.RecvString('STR142',0);
                            lbl_Gid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
(* 가입자우편번호        *) lbl_Gpt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR143',0)));
(* 가입자기본주소        *) lbl_Gju_So.Caption :=             Trim(TMAX.RecvString('STR144',0));
(* 가입자상세주소        *) lbl_Gbo_So.Caption :=             Trim(TMAX.RecvString('STR145',0));
(* 가입자전화번호        *) //lbl_Gtl_No.Caption :=   Trim(TMAX.RecvString('STR146',0));
                            seed_gatl          :=             TMAX.RecvString('STR146',0);
                            lbl_Gtl_No.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey));
(* 납부자주민구분코드    *) //                 :=             Trim(TMAX.RecvString('STR147',0));
(* 납부자주민사업자구분  *) lbl_Nid_Gu.Caption :=             Trim(TMAX.RecvString('STR148',0));
(* 납부자주민사업자번호  *) //lbl_Nid_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR149',0)));
                            //strNidNo           :=             Trim(TMAX.RecvString('STR149',0));
                            seed_nano          :=             TMAX.RecvString('STR149',0);
                            lbl_Nid_No.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
                            strNidNo           :=             lbl_Nid_No.Caption;
(* 납부자성명(업체명)    *) //lbl_Nid_Nm.Caption :=             Trim(TMAX.RecvString('STR150',0));
                            seed_nanm          :=             TMAX.RecvString('STR150',0);
                            lbl_Nid_Nm.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_nanm, common_seedkey));
(* 납부자우편번호        *) lbl_Npt_No.Caption := InsHyphen(  Trim(TMAX.RecvString('STR151',0)));
(* 납부자기본주소        *) lbl_Nju_So.Caption :=             Trim(TMAX.RecvString('STR152',0));
(* 납부자상세주소        *) lbl_Nbo_So.Caption :=             Trim(TMAX.RecvString('STR153',0));
(* 납부자전화번호        *) //lbl_Ntl_no.Caption :=   Trim(TMAX.RecvString('STR154',0));
                            seed_natl          :=             TMAX.RecvString('STR154',0);
                            lbl_Ntl_no.Caption :=             Trim(ECPlazaSeed.Decrypt(seed_natl, common_seedkey));
(* 습득자구분코드        *) frm_LOSTB200Q_ADDR2.cmb_Gt_Gu.ItemIndex :=  frm_LOSTB200Q_ADDR2.cmb_Gt_Gu.items.IndexOf(Trim(TMAX.RecvString('STR113',0)));


LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

function Tfrm_LOSTB200Q.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - 호출구분          *)+ ' ' +  '11'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  fNVL(value2)
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

    ShowWindow(Self.Handle, SW_SHOW);

   end

end;

function Tfrm_LOSTB200Q.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTB200Q.SpeedButton1Click(Sender: TObject);
begin
  frm_LOSTB200Q_ADDR2.Show;
  self.Enabled := false;
end;

procedure Tfrm_LOSTB200Q.btn_Addr_UpdateClick(Sender: TObject);
begin
  frm_LOSTB200Q_ADDR.Show;
  self.Enabled := false;
end;

procedure Tfrm_LOSTB200Q.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTB200Q.btn_resetClick(Sender: TObject);
begin
  Self.InitComponents;
end;

end.

