{*---------------------------------------------------------------------------
프로그램ID    : LOSTA720P (경찰서습득단말기 출고 입력)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10. 21
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
unit u_LOSTA720P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '경찰서습득단말기 출고 입력';
  PGM_ID  = 'LOSTA720P';

type
  Tfrm_LOSTA720P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    GroupBox3: TGroupBox;
    Panel2: TPanel;
    lbl_Bl_Dt: TLabel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    lbl_Ph_Cd: TLabel;
    Bevel11: TBevel;
    Label11: TLabel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Label4: TLabel;
    cmb_Cl_Gu: TComboBox;
    pnl_Command: TPanel;
    Bevel4: TBevel;
    Bevel1: TBevel;
    Label2: TLabel;
    lbl_Cl_Id: TLabel;
    cmb_md_cd: TComboBox;
    Bevel19: TBevel;
    Label3: TLabel;
    Bevel25: TBevel;
    lbl_Cg_No: TLabel;
    Bevel31: TBevel;
    Label12: TLabel;
    Bevel32: TBevel;
    lbl_Ph_Gb: TLabel;
    Panel1: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label6: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel17: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel33: TBevel;
    Label13: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    edt_phone_no: TMaskEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    md_grid1: TStringGrid;
    edt_birth_date : TEdit;
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
    SkinData1: TSkinData;
    TMAX: TTMAX;
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    Bevel3: TBevel;
    Label1: TLabel;
    Panel3: TPanel;
    rdo_Bx_yes: TRadioButton;
    rdo_Bx_No: TRadioButton;
    Bevel34: TBevel;
    Label9: TLabel;
    Panel4: TPanel;
    rdo_out_yes: TRadioButton;
    rbo_out_n: TRadioButton;
    Bevel35: TBevel;
    Bevel36: TBevel;
    lbl_insu_sts: TLabel;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    Bevel20: TBevel;
    Bevel26: TBevel;
    Bevel22: TBevel;
    Bevel27: TBevel;
    Bevel23: TBevel;
    Bevel28: TBevel;
    Bevel21: TBevel;
    Bevel29: TBevel;
    Bevel24: TBevel;
    Bevel30: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel7: TBevel;
    lbl_Pt_No: TLabel;
    lbl_Lt_No: TLabel;
    lbl_Lt_Nm: TLabel;
    lbl_Tl_No: TLabel;
    Label7: TLabel;
    lbl_Bo_So: TLabel;
    Label8: TLabel;
    lbl_Ju_So: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label20: TLabel;
    lbl_Lt_Gu: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    GroupBox2: TGroupBox;
    Bevel37: TBevel;
    msk_Gt_No: TMaskEdit;
    Bevel38: TBevel;
    edt_Gt_Nm: TEdit;
    Label19: TLabel;
    Label14: TLabel;
    Bevel39: TBevel;
    msk_Gt_Pt: TMaskEdit;
    btn_Postno_Inq: TBitBtn;
    Label25: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    Bevel40: TBevel;
    Bevel41: TBevel;
    Bevel42: TBevel;
    Label27: TLabel;
    Bevel43: TBevel;
    edt_Gt_Bo: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Bevel44: TBevel;
    msk_Gt_Tl: TMaskEdit;
    Label32: TLabel;
    lbl_Gt_Ju: TLabel;
    chk_Gt_yn: TCheckBox;
    chk_rodadr_yn: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_InquiryClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure dte_Ip_DtExit(Sender: TObject);
    procedure md_Grid1Click(Sender: TObject);
    procedure md_cb1ButtonClick(Sender: TObject);
    procedure md_cb1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure cmb_Cl_GuChange(Sender: TObject);
    procedure chk_Gt_ynClick(Sender: TObject);
    procedure btn_Postno_InqClick(Sender: TObject);
    procedure chk_rodadr_ynClick(Sender: TObject);
  private
    { Private declarations }
    cmb_Cl_Gu_d,md_grid1_d :TZ0xxArray;

    //LOSTZ830Q.exe로 메세지 받을 때 사용
    recvedMessage:Boolean;

    //LOSTZ830Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;

    //검색시 사용
    STR001:String; // 모델코드
    STR002:String; // 단말기일련번호
    STR003:String; // 입고일자

  public
    { Public declarations }
    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure Link_rtn2(var Msg:TMessage); message WM_LOSTPROJECT2;

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

    //검색 조건, 콤포넌트 별 키프레스
    procedure OnKeyPress(Sender: TObject; var Key: Char);


    function ExecExternProg(progID:String):Boolean;
    function ExecExternProg2(progID:String):Boolean;

    function keyCheck:boolean;

    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;    
  end;

var
  callValue : Integer;
  frm_LOSTA720P: Tfrm_LOSTA720P;

implementation
uses cpaklibm, Clipbrd;
{$R *.DFM}

function Tfrm_LOSTA720P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;


procedure Tfrm_LOSTA720P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA720P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

begin
	if Key <> #13 then 	//엔터키가 아니면
  begin
    if Sender is TEdit then
    begin
      if (((sender as Tedit).Name = 'edt_birth_date') or ((Sender as Tedit).name = 'serial_edit')) then
        if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
    end else
    if Sender is TMaskEdit then
    begin
      if (Sender as TMaskEdit).Name = 'edt_phone_no' then
        if not (key in ['0'..'9',#8,#9,#45]) then key := #0;
    end
    else if Sender is TDateEdit then
        if (Sender as TDateEdit).Name = 'dte_Ip_Dt' then
          if not (key in ['0'..'9',#8,#9,#45]) then key := #0;

    exit;
  end;

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
procedure Tfrm_LOSTA720P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTA720P.OnExit(Sender:TObject);
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
          callValue := 1;
          //value1 := findCodeFromName(Trim(md_cb1.Text), md_grid1_d, md_grid1.RowCount);
          value1 := Trim(md_cb1.Text); //전역변수 설정 -> value1
          value2 := Trim(edit.Text);   //전역변수 설정 -> value2
          if value2 = '' then value2 := 'dummy';
          //edit.Text := value2;
          md_grid1.Visible := False;
        end
      //성명
      else if edit = edt_Id_Nm then
      begin
        callValue := 2;
        value1:= Trim(edt_Id_Nm.Text);

        if value1 = '' then value1 := 'dummy';
        //edit.text := value1;
      end
      else if edit = edt_birth_date then
      begin
        callValue := 3;
        value1:= Trim(edt_birth_date.Text);

        if value1= '' then value1 :='dummy';
      end;
      end
    //모델명
    else if Sender.ClassType = TComboEdit then
    begin
      cedit   := Sender as TComboEdit;

      callValue := 4;
      value1  := Trim(cedit.Text);

      if value1 = '' then
        value1  := 'dummy';
    end
  //분실폰 번호
  else if Sender.ClassType = TMaskEdit then
  begin
    medit   := Sender as TMaskEdit;

    callValue := 5;
    value1  := Trim(delHyphen(medit.Text));

    if (value1 = '') then
      value1:= 'dummy'; //'010-0000-0000';
      //medit.EditText := value1;
  end;

//    ShowMessage(value1 +#13#10+value2);
end;

(******************************************************************************)
(* procedure name  : DetachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 DetachOnEnterEvent를 사용하는 개체의        *)
(*                   이벤트를 해제한다..                                      *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := nil;         // TEdit       성명
	edt_birth_date.OnEnter    := nil;         // TDateEdit   생년월일
	edt_phone_no.OnEnter  := nil;         // TMaskEdit   분실핸드폰번호
	md_cb1.OnEnter        := nil;         // TComboEdit  모델명
	serial_edit.OnEnter   := nil;         // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnExitEvent                                        *)
(* procedure 기 능 : 컴퍼넌트중에 OnExitEvent를 사용하는 개체의               *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.AttachOnExitEvent;
begin
	edt_Id_Nm.OnExit      := self.OnExit; // TEdit       성명
	edt_birth_date.OnExit     := self.OnExit; // TDateEdit   생년월일
	edt_phone_no.OnExit   := self.OnExit; // TMaskEdit   분실핸드폰번호
	md_cb1.OnExit         := self.OnExit; // TComboEdit  모델명
	serial_edit.OnExit    := self.OnExit; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : AttachOnEnterEvent                                       *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnterEvent를 사용하는 개체의              *)
(*                   이벤트를 연결한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.AttachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := self.OnEnter; // TEdit      성명
	edt_birth_date.OnEnter    := self.OnEnter; // TDateEdit  생년월일
	edt_phone_no.OnEnter  := self.OnEnter; // TMaskEdit  분실핸드폰번호
	md_cb1.OnEnter        := self.OnEnter; // TComboEdit 모델명
	serial_edit.OnEnter   := self.OnEnter; // TEdit      시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnEnter                                                  *)
(* procedure 기 능 : 컴퍼넌트중에 OnEnter를 사용하는 개체의                   *)
(*                   이벤트를 연결한다.                                       *)
(*                   엔터친 컴퍼넌트가 뭔지 파악해서 변수에 숫자를 담고 있는다*)
(******************************************************************************)
procedure Tfrm_LOSTA720P.OnEnter(Sender:TObject);
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
    if cedit = md_cb1 then begin
      md_grid1.Visible := false;
      setItemNo('4');
    end;
  end
  // 분실핸드폰번호
  else if Sender.ClassType = TMaskEdit then begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then
            SetItemNo('3');
  end;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure 기 능 : 엔터친 컴퍼넌트에 대한 숫자를 담고 있는다.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//주민/사업자/외국인번호 조회 팝업에서 메세지를 던져준다.
procedure Tfrm_LOSTA720P.Link_rtn (var Msg : TMessage);
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
  i : integer;

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

          edt_Id_Nm.Text        := smem^.name;			      //성명(업체명)
          md_cb1.Text           := smem^.model_name;	    //모델명
          serial_edit.Text      := smem^.serial_no;	      //단말기일련번호
          dte_Ip_Dt.Text        := smem^.ibgo_date;		    //입고일
          edt_birth_date.Text   := smem^.birth;			      //생년월일
          edt_phone_no.EditText := Trim(smem^.phone_no);  //분실핸드폰번호

          if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

        UnLock;

        //공유메모리를 사용 후.
        CloseMapMain;
        smem:= nil;
      end;

      if (callValue = 0 ) then
        edt_Gt_Bo.SetFocus
      else
        btn_InquiryClick(self);

    end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

//우편번호조회 팝업에서 메세지를 던져준다.
procedure Tfrm_LOSTA720P.Link_rtn2 (var Msg : TMessage);
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
  i : integer;

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

          msk_Gt_Pt.Text        := smem^.po_no;			    //우편번호
          lbl_Gt_Ju.Caption     := smem^.ju_so;	        //기본주소

        UnLock;

        //공유메모리를 사용 후.
        CloseMapMain;
        smem:= nil;
      end;

      //if (callValue = 0 ) then
      //  edt_Gt_Bo.SetFocus;
      //else
      //  btn_InquiryClick(self);
      edt_Gt_Bo.SetFocus;

    end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);
end;

// 모델콤보 클릭시 이벤트
procedure Tfrm_LOSTA720P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA720P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA720P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA720P.FormCreate(Sender: TObject);
begin
  //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
  if ParamCount < 6 then
  begin
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
  //common_userid       := '0294'   ;  // ParamStr(3);
  //common_username     := '정호영' ;  // ParamStr(4);
  //common_usergroup    := 'SYSM'   ;  // ParamStr(5);

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
  //common_lib.pas에 있다.
  initSkinForm(SkinData1);

  initComboBoxWithZ0xx ('Z041.dat', cmb_Cl_Gu_d, '', '',cmb_Cl_Gu );
  //initComboBoxWithZ0xx('Z041',cmb_Cl_Gu_d,'','' ,cmb_Cl_Gu  ,'1', '', '');
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

  // 시스템 그룹만 '강제출고 여부' 수정 가능
  if (common_usergroup = 'SYSM') then
  begin
    Bevel34.Visible := True;
    Label9.Visible  := True;
    Panel4.Visible  := True;
  end;

  chk_Gt_yn.Checked := false;
  msk_Gt_No.Enabled := false;
  edt_Gt_Nm.Enabled := false;
  msk_Gt_Pt.Enabled := false;
  edt_Gt_Bo.Enabled := false;
  msk_Gt_Tl.Enabled := false;

  chk_rodadr_yn.Checked := true;

end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA720P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin

    if (Components[i] is TLabel) then
      if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
       then (Components[i] as TLabel).Caption := '';

    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
     else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';
  end;

  changeBtn(Self);
  btn_Link.Enabled    := True;

  dte_Ip_Dt.Date      := date;

  cmb_Cl_Gu.ItemIndex := 0;
  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

  if(chk_Gt_yn.Checked = false) then
  begin
    msk_Gt_No.Enabled := false;
    edt_Gt_Nm.Enabled := false;
    msk_Gt_Pt.Enabled := false;
    edt_Gt_Bo.Enabled := false;
    msk_Gt_Tl.Enabled := false;
  end;

  //초기화
  setItemNo('1');

  //처음 실행시 윈도우 클로즈 돕기 위해
  recvedMessage:= True;
end;

procedure Tfrm_LOSTA720P.btn_AddClick(Sender: TObject);

var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_tmp : String;

	STR004,STR005,STR006:String;
  STR007,STR008,STR009,STR010,STR011,STR012,STR013:String;
  svcNm , Msg: string;

  LABEL LIQUIDATION;
  LABEL SEEDKEY;

begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

	if not keyCheck then
    exit;

  STR004 := '';
  STR005 := '';

  if ((Sender as TSpeedButton) = btn_Add) then svcNm := 'I01'
  else if (Sender as TSpeedButton) = btn_Update then svcNm := 'U01'else svcNm := 'D01';

  if( not fChkLength(md_cb1     ,1,1,'모델코드'                 )) then Exit;
  if( not fChkLength(serial_edit,1,1,'단말기일련번호'           )) then Exit;
  if( not fChkLength(dte_Ip_Dt  ,8,0,'입고일자'                 )) then Exit;

  if (chk_Gt_yn.Checked) then begin
    if( not fChkLength(msk_Gt_No  ,1,1,'습득자주민사업자번호'     )) then Exit;
    if( not fChkLength(edt_Gt_Nm  ,1,1,'습득자성명(업체명)'       )) then Exit;
    if( not fChkLength(msk_Gt_Pt  ,1,1,'습득자우편번호'           )) then Exit;
    if( not fChkLength(lbl_Gt_Ju  ,1,1,'습득자기본주소'           )) then Exit;
    if( not fChkLength(edt_Gt_Bo  ,1,1,'습득자상세주소'           )) then Exit;
    if( not fChkLength(msk_Gt_Tl  ,1,1,'습득자전화번호'           )) then Exit;
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

  (*모델코드       *) STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);
  (*단말기일련번호 *) STR002 := serial_edit.Text;
  (*입고일자       *) STR003 := delHyphen(dte_Ip_Dt.Text);
  (*출고구분코드   *)
  if(cmb_Cl_Gu.ItemIndex <> -1) then STR004 := IntToStr(cmb_Cl_Gu.itemIndex + 1);
  (*출고박스여부   *)
  if(rdo_Bx_yes.Checked)  then STR005 := 'Y' else STR005 := 'N';
  (*강제출고여부   *)
  if(rdo_out_yes.Checked) then STR006 := 'Y' else STR006 := 'N';
  (*경찰서습득단말기출고구분코드   *)
  // 1 : 습득자출고, 2 : 분실자출고
  if(chk_Gt_yn.Checked) then STR007 := '1' else STR007 := '2';

  (*습득자주민사업자번호 *) str_tmp:= delhyphen(msk_Gt_No.Text);
                            STR008 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*습득자성명(업체명)   *) str_tmp:= Trim(edt_Gt_Nm.Text);
                            STR009 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*습득자우편번호       *) STR010 := delhyphen(msk_Gt_Pt.Text);
  (*습득자기본주소       *) STR011 := Trim(lbl_Gt_Ju.Caption);
  (*습득자상세주소       *) STR012 := Trim(edt_Gt_Bo.Text);
  (*습득자전화번호       *) str_tmp:= Trim(delHyphen(msk_Gt_Tl.Text));
                            STR013 := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA720P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', STR006) < 0) then  goto LIQUIDATION;

  if (TMAX.SendString('STR007', STR007) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR008', STR008) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR009', STR009) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR010', STR010) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR011', STR011) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR012', STR012) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR013', STR013) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA720P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
    begin
      if (Pos('보험',TMAX.RecvString('INF012',0)) > 0 ) then ShowMessage( TMAX.RecvString('INF012',0))
      else
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    end
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  if ((Sender as TSpeedButton) = btn_Add) then Msg := '등록'
  else if (Sender as TSpeedButton) = btn_Update then Msg := '수정'
  else Msg := '삭제';

  ShowMessage('정상 ' + Msg + '되었습니다.');

  sts_Message.Panels[1].Text := Msg + '완료';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'수정' 버튼 클릭
procedure Tfrm_LOSTA720P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA720P.btn_DeleteClick(Sender: TObject);
	Label LIQUIDATION;
begin

	if not keyCheck then
    exit;

	if MessageDlg('정말 삭제하시겠습니까 ?',
		mtConfirmation, mbOkCancel, 0) = mrCancel then begin
		sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
		exit;
	end;

  btn_AddClick(Sender);
end;


procedure Tfrm_LOSTA720P.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_gtno, seed_gtnm, seed_gttl : String;

    Label LIQUIDATION;
    Label SEEDKEY;
    Label INQUIRY;

begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_gtno := '';
  seed_gtnm := '';
  seed_gttl := '';

	if not keyCheck then
    	exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	// 모델코드 md_cb1
	STR002:= serial_edit.Text;			                                        // 단말기일련번호
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                    // 입고일자

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
	if (TMAX.SendString('INF003','LOSTA720P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA720P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

(*  모델명               *) //md_cb1.Text         :=              Trim(TMAX.RecvString('STR124',0));
(*  단말기일련번호       *) //serial_edit.text    :=              Trim(TMAX.RecvString('STR102',0));
(*  입고일자             *) //dte_Ip_Dt.text      :=              Trim(TMAX.RecvString('STR103',0));
(*  가입자성명업체명     *) //edt_Id_Nm.text      :=              Trim(TMAX.RecvString('STR104',0));
(*  출고구분코드         *) if(TMAX.RecvString('STR105',0) <> '') then cmb_Cl_Gu.ItemIndex := StrToInt(Trim(TMAX.RecvString('STR105',0))) -1;
(*  출고박스여부         *) if Trim(TMAX.RecvString('STR106',0)) = 'Y' then rdo_Bx_yes.Checked:= True else rdo_Bx_No.Checked := True;
(*  발송예정일자         *) lbl_Bl_Dt.caption   :=  InsHyphen(  Trim(TMAX.RecvString('STR107',0)));
(*  단말기상태코드       *) //                                  Trim(TMAX.RecvString('STR108',0));
(*  단말기상태코드명     *) lbl_Ph_Cd.caption   :=              Trim(TMAX.RecvString('STR109',0));
(*  출고자ID             *) lbl_Cl_Id.caption   :=              Trim(TMAX.RecvString('STR110',0));
(*  출고자명             *) //                                  Trim(TMAX.RecvString('STR111',0));
(*  가입자구분코드       *) //                                  Trim(TMAX.RecvString('STR112',0));
(*  가입자구분코드명     *) lbl_Lt_Gu.caption   :=              Trim(TMAX.RecvString('STR113',0));
(*  가입자주민사업자번호 *) seed_gano := TMAX.RecvString('STR114',0);
                            lbl_Lt_No.caption   :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey)));
(*  가입자성명업체명     *) seed_ganm := TMAX.RecvString('STR115',0);
                            lbl_Lt_Nm.caption   :=              Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
(*  가입자우편번호       *) lbl_Pt_No.caption   :=  InsHyphen(  Trim(TMAX.RecvString('STR116',0)));
(*  가입자기본주소       *) lbl_Ju_So.caption   :=              Trim(TMAX.RecvString('STR117',0));
(*  가입자상세주소       *) lbl_Bo_So.caption   :=              Trim(TMAX.RecvString('STR118',0));
(*  가입자전화번호       *) seed_gatl := TMAX.RecvString('STR119',0);
                            lbl_Tl_No.caption   :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey)));
(*  창고일련번호         *) lbl_Cg_No.caption   :=              Trim(TMAX.RecvString('STR120',0));
(*  단말기부분품종류코드 *) //                                  Trim(TMAX.RecvString('STR121',0));
(*  단말기부분품종류명   *) lbl_Ph_Gb.caption   :=              Trim(TMAX.RecvString('STR122',0));
(*  수취여부             *) //                                  Trim(TMAX.RecvString('STR123',0));
                            lbl_insu_sts.Caption:=              Trim(TMAX.RecvString('STR124',0));

(*  출고구분코드         *) if Trim(TMAX.RecvString('STR125',0)) = '1' then chk_Gt_yn.Checked   :=  True else chk_Gt_yn.Checked := false;
(*  습득자주민사업자번호 *) seed_gtno := TMAX.RecvString('STR127',0);
                            msk_Gt_No.Text      :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gtno, common_seedkey)));
(*  습득자성명업체명     *) seed_gtnm := TMAX.RecvString('STR128',0);
                            edt_Gt_Nm.Text      :=              Trim(ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey));
(*  습득자우편번호       *) msk_Gt_Pt.Text      :=  InsHyphen(  Trim(TMAX.RecvString('STR129',0)));
(*  습득자기본주소       *) lbl_Gt_Ju.caption   :=              Trim(TMAX.RecvString('STR130',0));
(*  습득자상세주소       *) edt_Gt_Bo.Text      :=              Trim(TMAX.RecvString('STR131',0));
(*  습득자전화번호       *) seed_gttl := TMAX.RecvString('STR132',0);
                            msk_Gt_Tl.Text      :=  InsHyphen(  Trim(ECPlazaSeed.Decrypt(seed_gttl, common_seedkey)));

  sts_Message.Panels[1].Text := ' 조회 완료';

  //너머지 버튼 활성화
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA720P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ830Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

//On-Exit (입고일자)
procedure Tfrm_LOSTA720P.dte_Ip_DtExit(Sender: TObject);
begin
{
     try
     dte_Ip_Dt.Date := strtodate(dte_Ip_Dt.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('일자 입력 오류'+#13+
		       '오늘일자로 변경됩니다');
	   dte_Ip_Dt.date := date;
	   dte_Ip_Dt.setfocus;
	end;
     end;
}
end;

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTA720P.ExecExternProg(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;
  ret := 0;

	recvedMessage:= false;

  if (value1 = 'dummy') then value1 := '';
  if (value2 = 'dummy') then value2 := '';

  (****************************************************************************)
  (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
  (****************************************************************************)
	commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
    			      (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
    				    (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                (* paramstr(5)                     *)+ ' ' +  common_usergroup
                (* paramstr(6) - 호출구분          *)+ ' ' +  '23'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle,SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

    ShowWindow(Self.Handle,SW_SHOW);
  end
end;

function Tfrm_LOSTA720P.ExecExternProg2(progID:String):Boolean;
var
	commandStr:String;
	ret:Integer;
begin
	result:= True;

	recvedMessage:= false;

  if (value1 = 'dummy') then value1 := '';
  if (value2 = 'dummy') then value2 := '';

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

procedure Tfrm_LOSTA720P.FormShow(Sender: TObject);
begin
    //콤포넌트 초기화
    InitComponents;

    // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능
    //if ParamStr(6) <> '' then   // 2016.06.21 수정
    if ParamStr(10) <> '' then
    begin
      edt_Id_Nm.Text        :=  fRNVL(ParamStr( 6));
      edt_birth_date.Text   :=  fRNVL(InsHyphen(ParamStr( 7)));
      md_cb1.Text           :=  fRNVL(ParamStr( 8));
      serial_edit.Text      :=  fRNVL(ParamStr( 9));
      dte_Ip_Dt.Text        :=  fRNVL(ParamStr(10));
      edt_phone_no.Text     :=  fRNVL(ParamStr(11));

      btn_InquiryClick(Self);
    end;
end;

procedure Tfrm_LOSTA720P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTA720P.setEdtKeyPress;
var i : Integer;
    edt : TEdit;
begin
  for i := 0 to componentCount -1 do
  begin
    if (Components[i] is TEdit) then
    begin
      (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
    end;
  end;
end;

procedure Tfrm_LOSTA720P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTA720P.btn_LinkClick(Sender: TObject);
var
  Value : array of string;

  commandStr:String;

  progID : string;

	ret:Integer;  
begin
    progID := 'LOSTA710P';
    ret := 0;

    SetLength(Value, 5 );

    Value[0] := Trim(edt_Id_Nm.Text);       // 성명
    Value[1] := Trim(edt_birth_date.Text);  // 생년월일
    Value[2] := Trim(md_cb1.Text);          // 모델명
    Value[3] := Trim(serial_edit.Text);     // 시리얼번호
    Value[4] := dte_Ip_Dt.Text;             // 입고일자

    (****************************************************************************)
    (* 공통 조회 Prog 파일명 및 파라미터 설정                                   *)
    (****************************************************************************)
    commandStr := (* paramstr(0) - 파일명            *)         progID +'.exe'
                  (* paramstr(1) - 이용자 PW         *)+ ' ' +  common_kait
                  (* paramstr(2) - Process ID        *)+ ' ' +  intToStr(self.Handle)
                  (* paramstr(3) - 이용자 ID         *)+ ' ' +  common_userid
                  (* paramstr(4) - 이용자 명         *)+ ' ' +  common_username
                  (* paramstr(5)                     *)+ ' ' +  common_usergroup
                  (* paramstr(6) -                   *)+ ' ' +  fNVL(Value[0])
                  (* paramstr(7) -                   *)+ ' ' +  fNVL(Value[1])
                  (* paramstr(8) -                   *)+ ' ' +  fNVL(Value[2])
                  (* paramstr(9) -                   *)+ ' ' +  fNVL(Value[3])
                  (* paramstr(10) -                  *)+ ' ' +  fNVL(Value[4])
    ;

  if WinExec(PChar(commandStr), SW_Show) <= 31 then
  begin

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');
  end else
  begin
    Self.Close;
  end;

end;

procedure Tfrm_LOSTA720P.cmb_Cl_GuChange(Sender: TObject);
begin
  case cmb_Cl_Gu.ItemIndex of
    0 : rdo_Bx_yes.Checked := True;
    1 : rdo_Bx_No.Checked  := True;
    2 : rdo_Bx_No.Checked  := True;
  end;
end;

procedure Tfrm_LOSTA720P.chk_Gt_ynClick(Sender: TObject);
begin

  if(chk_Gt_yn.Checked) then
  begin
    msk_Gt_No.Enabled := true;
    edt_Gt_Nm.Enabled := true;
    msk_Gt_Pt.Enabled := true;
    edt_Gt_Bo.Enabled := true;
    msk_Gt_Tl.Enabled := true;
  end else
  begin
    msk_Gt_No.Text := '';
    msk_Gt_No.Enabled := false;
    edt_Gt_Nm.Text := '';
    edt_Gt_Nm.Enabled := false;
    msk_Gt_Pt.Text := '';
    msk_Gt_Pt.Enabled := false;
    lbl_Gt_Ju.caption := '';
    edt_Gt_Bo.Text := '';
    edt_Gt_Bo.Enabled := false;
    msk_Gt_Tl.Text := '';
    msk_Gt_Tl.Enabled := false;
  end;
end;

procedure Tfrm_LOSTA720P.btn_Postno_InqClick(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
  chkBox : TCheckBox;
begin
  bitBtn := nil;
  mskEdt := nil;
  chkBox := nil;

  if (chk_Gt_yn.Checked = true) then
  begin
    if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit) or ( Sender.ClassType = TCheckBox)) then
    begin
      if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
        else if (Sender.ClassType = TMaskEdit) then mskEdt := Sender as TMaskEdit
          else chkBox := Sender as TCheckBox;
            value1 := msk_Gt_Pt.Text;
      end;

    CreateMap;	//공유메모리 생성

    // 도로명주소 체크에 따라 우편번호 팝업 선택
    if(bitBtn = btn_Postno_Inq) or ( mskEdt = msk_Gt_Pt ) or ( chkBox = chk_rodadr_yn ) then
      begin
        if (chk_rodadr_yn.Checked = true) then self.ExecExternProg2('LOSTZ850Q')
        else self.ExecExternProg2('LOSTZ800Q');
      end;
  end;
end;

procedure Tfrm_LOSTA720P.chk_rodadr_ynClick(Sender: TObject);
begin
   if ((chk_Gt_yn.Checked = true) and (chk_rodadr_yn.Checked = true)) then
   begin
      btn_Postno_InqClick(Sender);
   end;
end;

end.
