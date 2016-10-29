{*---------------------------------------------------------------------------
프로그램ID    : LOSTC110P (우체국처리 출고 입력)
프로그램 종류 : Online
작성자	      : 최대성
작성일	      : 2011. 09. 15
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
unit u_LOSTC110P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax,common_lib,localCloud, ComObj;

const
  TITLE   = '우체국처리 출고 입력';
  PGM_ID  = 'LOSTC110P';

type
  Tfrm_LOSTC110P = class(TForm)
    Bevel2          : TBevel;
    Bevel20         : TBevel;
    Bevel21         : TBevel;
    Bevel22         : TBevel;
    Bevel23         : TBevel;
    Bevel24         : TBevel;
    Bevel27         : TBevel;
    Bevel28         : TBevel;
    Bevel29         : TBevel;
    Bevel30         : TBevel;
    Bevel7          : TBevel;
    Bevel8          : TBevel;
    Bevel9          : TBevel;
    Bevel10         : TBevel;
    Bevel26         : TBevel;
    Bevel44         : TBevel;
    Bevel43         : TBevel;
    Bevel5          : TBevel;
    Bevel6          : TBevel;
    Bevel31         : TBevel;
    Bevel32         : TBevel;
    Bevel18         : TBevel;
    Bevel33         : TBevel;
    Bevel1          : TBevel;
    Bevel3          : TBevel;
    Bevel16         : TBevel;
    Bevel37         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel42         : TBevel;
    btn2            : TBitBtn;
    btn3            : TBitBtn;
    btn1            : TBitBtn;
    cmb_md_cd       : TComboBox;
    cmb_gt_yn       : TComboBox;
    md_cb1          : TComboEdit;
    dte_po_dt       : TDateEdit;
    dte_Ip_Dt       : TDateEdit;
    serial_edit     : TEdit;
    edt_Id_Nm       : TEdit;
    GroupBox3       : TGroupBox;
    Label9          : TLabel;
    Label23         : TLabel;
    lbl_Po_Nm       : TLabel;
    Label21         : TLabel;
    Label5          : TLabel;
    Label7          : TLabel;
    lbl_Ga_Gu       : TLabel;
    lbl_Ga_Nm       : TLabel;
    lbl_Ga_Ju       : TLabel;
    lbl_Ga_No       : TLabel;
    Label1          : TLabel;
    Label8          : TLabel;
    Label15         : TLabel;
    Label18         : TLabel;
    Label3          : TLabel;
    Label12         : TLabel;
    Label2          : TLabel;
    Label24         : TLabel;
    Label27         : TLabel;
    lbl_Ph_Gb       : TLabel;
    Label29         : TLabel;
    lbl_Ga_Bo       : TLabel;
    Label20         : TLabel;
    lbl_Ga_Tl       : TLabel;
    Label22         : TLabel;
    lbl_Program_Name: TLabel;
    Label30         : TLabel;
    Label32         : TLabel;
    lbl_Cl_Dt       : TLabel;
    lbl_Ga_Pt       : TLabel;
    msk_Ju_No       : TMaskEdit;
    edt_phone_no    : TMaskEdit;
    N13             : TMenuItem;
    pnl_Command     : TPanel;
    Panel14         : TPanel;
    mnuLnk          : TPopupMenu;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
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
    edt_birth_date: TEdit;
    GroupBox1: TGroupBox;
    Bevel48: TBevel;
    Bevel4: TBevel;
    Bevel11: TBevel;
    Label4: TLabel;
    Bevel12: TBevel;
    Label6: TLabel;
    Label10: TLabel;
    Bevel13: TBevel;
    Label11: TLabel;
    Bevel14: TBevel;
    Label13: TLabel;
    Bevel15: TBevel;
    Label14: TLabel;
    Bevel17: TBevel;
    Label16: TLabel;
    Bevel19: TBevel;
    Label17: TLabel;
    Bevel25: TBevel;
    lbl_Ju_So: TLabel;
    Label42: TLabel;
    edt_Bo_So: TEdit;
    cmb_Gt_Gu: TComboBox;
    msk_Gt_No: TMaskEdit;
    Edit1: TEdit;
    msk_Pt_No: TMaskEdit;
    msk_Tl_No: TMaskEdit;
    dte_Gt_Dt: TDateEdit;
    btn_Postno_Inq: TBitBtn;
    Panel4: TPanel;
    rdo_New_1: TRadioButton;
    rdo_New_2: TRadioButton;
    rdo_New_3: TRadioButton;
    Panel1: TPanel;
    chk_bl_yn: TCheckBox;
    pnl_bl_yn: TPanel;
    Bevel46: TBevel;
    Label40: TLabel;
    edt_sp_yu: TEdit;
    md_grid1: TStringGrid;
    Bevel50: TBevel;
    Bevel34: TBevel;
    Label19: TLabel;
    Label25: TLabel;
    Panel2: TPanel;
    rb_dy_yes: TRadioButton;
    rb_dy_no: TRadioButton;
    Panel3: TPanel;
    rb_no_yes: TRadioButton;
    rb_no_no: TRadioButton;
    Bevel35: TBevel;
    Label26: TLabel;
    Bevel36: TBevel;
    lbl_insu_sts: TLabel;
    Bevel38: TBevel;
    Label28: TLabel;
    Panel5: TPanel;
    rdo_out_yes: TRadioButton;
    rbo_out_n: TRadioButton;
    lbl1: TLabel;
    chk_gt_rodadr_yn: TCheckBox;

    procedure FormCreate          (Sender: TObject);
    procedure btn_DeleteClick     (Sender: TObject);
    procedure btn_CloseClick      (Sender: TObject);
    procedure md_Grid1Click       (Sender: TObject);
    procedure md_cb1ButtonClick   (Sender: TObject);
    procedure md_cb1KeyUp         (Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edt_ba_noEnter      (Sender: TObject);
    procedure edt_ba_noKeyUp      (Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cmb_gt_ynChange     (Sender: TObject);
    procedure msk_Ju_NoEnter      (Sender: TObject);
    procedure cmb_Gt_GuChange     (Sender: TObject);
    procedure cmb_Gt_GuKeyDown    (Sender: TObject; var Key: Word;Shift: TShiftState);
//    procedure cmb_Sp_CdChange     (Sender: TObject);
    procedure chk_bl_ynClick      (Sender: TObject);
    procedure btn_InquiryClick    (Sender: TObject);
    procedure btn_Postno_InqClick (Sender: TObject);
    procedure msk_Pt_NoKeyPress   (Sender: TObject; var Key: Char);
    procedure btn_AddClick        (Sender: TObject);
    procedure btn_UpdateClick     (Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure msk_Gt_NoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dte_po_dtExit(Sender: TObject);
    procedure msk_Tl_NoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chk_gt_rodadr_ynClick(Sender: TObject);

  private
    { Private declarations }
    md_grid1_d ,cmb_Sp_Cd_d,cmb_sp_gu_d:TZ0xxArray;

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
    procedure Link_rtn (var Msg:TMessage); message WM_LOSTPROJECT;
    procedure Link_rtn2(var Msg:TMessage); message WM_LOSTPROJECT2;

    procedure SetItemNo(number:String);
    procedure InitComponents;

    procedure AttachOnEnterEvent;
    procedure AttachOnKeyPressEvent;
    procedure AttachOnExitEvent;
    procedure DetachOnEnterEvent;

    procedure OnExit  (Sender:TObject);
    procedure OnEnter (Sender:TObject);

    //쌍안경 이미지 버튼 클릭
    procedure OnSearchClick(Sender:TObject);

    //검색 조건, 콤포넌트 별 키프레스
    procedure OnKeyPress(Sender: TObject; var Key: Char);

    function ExecExternProg(progID:String):Boolean;

    function keyCheck:boolean;
  end;

  (* PGM_STS : 프로그램 상태  *)
  (* 0 : 조회전               *)
  (* 1 : 조회후               *)
  (* 2,3 : 여유분             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTC110P: Tfrm_LOSTC110P;
  pgm_sts1   : PGM_STS;


implementation

{$R *.DFM}

function Tfrm_LOSTC110P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;

procedure Tfrm_LOSTC110P.AttachOnKeyPressEvent;
begin
	edt_Id_Nm.OnKeyPress    := self.OnKeyPress; // TEdit       성명
	edt_birth_date.OnKeyPress   := self.OnKeyPress; // TDateEdit   생년월일
	edt_phone_no.OnKeyPress := self.OnKeyPress; // TMaskEdit   분실핸드폰번호
	md_cb1.OnKeyPress       := self.OnKeyPress; // TComboEdit  모델명
	serial_edit.OnKeyPress  := self.OnKeyPress; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnKeyPress                                               *)
(* procedure 기 능 : 컴퍼넌트중에 OnKeyPress를 사용하는 개체의                *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC110P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

  i : Integer;

begin
	if Key <> #13 then 	//엔터키가 아니면
  begin
    if Sender is TEdit then
    begin
      if (Sender as TEdit) = edt_birth_date then
        if not (key in ['0'..'9',#8,#9]) then key := #0;
    end else
    begin
    if Sender is TMaskEdit then
      if (Sender as TMaskEdit) = edt_phone_no then
        if not (key in ['0'..'9',#8,#9]) then key := #0;
    end;

    Exit;
  end;

	if Sender.ClassType = TEdit then
        begin
          edit := Sender as TEdit;
          if edit = edt_Id_Nm           then btn1.OnClick(btn1)  // 성명
          else if edit = edt_birth_date then btn2.OnClick(btn2)  // 생년월일
        end
  else if Sender.ClassType = TComboEdit then
        begin
          cedit:= Sender as TComboEdit;

          md_grid1.Visible := false;

          if cedit = md_cb1 then serial_edit.SetFocus;	      //모델명

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
procedure Tfrm_LOSTC110P.OnSearchClick(Sender:TObject);
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
    //날짜
    else if Sender = btn2 then
        begin
          edt_birth_date.SetFocus;
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
        end;

    CreateMap;	//공유메모리 생성
	  self.ExecExternProg('LOSTZ820Q');
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure 기 능 : 컴퍼넌트중에 OnExit를 사용하는 개체의                    *)
(*                   이벤트를 실행한다.                                       *)
(*                   해당 이벤트가 발생한 컴퍼넌트의 값을 전역변수로 설정한다 *)
(******************************************************************************)
procedure Tfrm_LOSTC110P.OnExit(Sender:TObject);
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
          //value1 := findCodeFromName(Trim(md_cb1.Text), md_grid1_d, md_grid1.RowCount);
          value1 := Trim(md_cb1.Text); //전역변수 설정 -> value1
          value2 := Trim(edit.Text);   //전역변수 설정 -> value2
          if value2 ='' then value2 :='dummy';
          //edit.Text := value2;
          md_grid1.Visible := False;
        end
      //성명
      else begin
        value1:= Trim(edit.Text);
        if value1='' then
          value1 :='dummy';
          //edit.text := value1;
      end;
    end
    //모델명
    else if Sender.ClassType = TComboEdit then
      begin
    	cedit:= Sender as TComboEdit;
        //value1:= findCodeFromName(Trim(cedit.Text), md_grid1_d, md_grid1.RowCount);
        value1:= Trim(cedit.Text);
        if value1 = '' then
          //value1:= findCodeFromName(Trim(md_grid1.Cells[0,0]), md_grid1_d, md_grid1.RowCount);
          value1:= 'dummy';//Trim(md_grid1.Cells[0,0]);
          //cedit.Text:= md_grid1.Cells[0,0];
          //cedit.Text:= value1;
    end
    //생년월일
    else if Sender.ClassType =  TDateEdit then begin
    	dedit:= Sender as TDateEdit;
        value1:= Trim(dedit.Text);
        if (value1[1]='-') or (value1[Length(value1)] = '-') then begin
        	//dedit.Date := date;
            value1:= 'dummy';//dedit.Text;
        	dedit.Text := '    -  -  ';
        end;
        //dedit.Text := value1;
    end
    //분실폰 번호
    else if Sender.ClassType = TMaskEdit then begin
    	medit:= Sender as TMaskEdit;
        value1:= Trim(medit.EditText);
        if (value1[1]='-') or (value1[Length(value1)] = '-') then
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
procedure Tfrm_LOSTC110P.DetachOnEnterEvent;
begin
	edt_Id_Nm.OnEnter     := nil;         // TEdit       성명
	edt_birth_date.OnEnter:= nil;         // TDateEdit   생년월일
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
procedure Tfrm_LOSTC110P.AttachOnExitEvent;
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
procedure Tfrm_LOSTC110P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTC110P.OnEnter(Sender:TObject);
var
  edit  :TEdit;
  dedit :TDateEdit;
  medit :TMaskEdit;
  cedit :TComboEdit;
begin
	if Sender.ClassType = TEdit then begin
    	edit := Sender as TEdit;
        //성명
        if edit = edt_Id_Nm then
        	SetItemNo('1')
        //시리얼 번호
        else if edit = serial_edit then
        	SetItemNo('4')
        else if edit = edt_birth_date then
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
procedure Tfrm_LOSTC110P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTC110P.Link_rtn (var Msg : TMessage);
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

      edt_Id_Nm.Text        := smem^.name;			        //성명(업체명)
      md_cb1.Text           := smem^.model_name;	      //모델명
      serial_edit.Text      := smem^.serial_no;	        //단말기일련번호
      dte_Ip_Dt.text        := InsHyphen(smem^.pg_dt);  //입고일
      edt_birth_date.Text   := smem^.birth;			        //생년월일
      edt_phone_no.EditText := Trim(smem^.phone_no);    //분실핸드폰번호
      msk_Ju_No.Text        := smem^.po_cd  + smem^.pg_dt + smem^.ju_seq; // 접수번호


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
procedure Tfrm_LOSTC110P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTC110P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTC110P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];

   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTC110P.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	//이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
  //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
	if ParamCount < 6 then begin
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

  initStrinGridWithZ0xx('Z008.dat', md_grid1_d  , '', '',md_grid1   );



  //콤포넌트에 이벤트를 어태치 한다.
  AttachOnEnterEvent;
  AttachOnExitEvent;
  AttachOnKeyPressEvent;

  btn1.OnClick := self.OnSearchClick;
  btn2.OnClick := self.OnSearchClick;
  btn3.OnClick := self.OnSearchClick;

  // 시스템 그룹만 '강제출고 여부' 수정 가능
  if (common_usergroup = 'SYSM') then
  begin
    Bevel34.Visible := True;
    Label9.Visible  := True;
    Panel4.Visible  := True;
  end;

  // 도로명주소여부 체크
  chk_gt_rodadr_yn.Checked := True;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC110P.InitComponents;
var i : Integer;
begin

    changeBtn(Self);

    for i := 0 to ComponentCount -1 do
    begin
      if (Components[i] is TMaskEdit) then (Components[i] as TMaskEdit).Clear;
      if (Components[i] is TEdit)     then (Components[i] as TEdit).Clear;
      if (Components[i] is TLabel)    then
        if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
         then (Components[i] as TLabel).Caption := '';
    end;
    
    cmb_gt_yn.itemindex  := 0;
    dte_po_dt.date       := date;
    dte_Gt_Dt.Date       := date;

    chk_bl_yn.checked    := false;
    edt_sp_yu.Clear;
    pnl_bl_yn.Visible    := false;

    cmb_Gt_Gu.ItemIndex  := 0;

    dte_Gt_Dt.date       := date;

    rdo_New_1.Checked     := true;
    rdo_New_2.Checked     := false;
    rdo_New_3.Checked     := false;

    dte_Ip_Dt.Date  := date;

    // 도로명주소체크 초기화
    chk_gt_rodadr_yn.Checked := True;

    md_grid1.Row        := 0;
    md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];

    //초기화
    setItemNo('1');

    pgm_sts1 := [0];

    //처음 실행시 윈도우 클로즈 돕기 위해
    recvedMessage:= True;

    cmb_gt_yn.ItemIndex := 0;

end;

procedure Tfrm_LOSTC110P.btn_DeleteClick(Sender: TObject);
  Label LIQUIDATION;
begin
    if  pgm_sts1 = [0] then
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

    if not keyCheck then
      exit;

    STR001:= Copy(delHyphen(msk_Ju_No.Text), 1,6); // 우체국코드
    STR002:= Copy(delHyphen(msk_Ju_No.Text), 7,8); // 등록일자
    STR003:= Copy(delHyphen(msk_Ju_No.Text),15,4); // 접수일련번호

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

      //공통입력 부분
    if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTC110P'      )  < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','D01'            )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

      //서비스 호출
    if not TMAX.Call('LOSTC110P') then
    begin
      if (TMAX.RecvString('INF011',0) = 'Y') then
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
      else
        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;    

    sts_Message.Panels[1].Text := ' 삭제 완료';

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

procedure Tfrm_LOSTC110P.edt_ba_noEnter(Sender: TObject);
begin
 md_grid1.Visible := false;
end;

procedure Tfrm_LOSTC110P.edt_ba_noKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_F2 then
   begin

   end;
end;

procedure Tfrm_LOSTC110P.cmb_gt_ynChange(Sender: TObject);
begin
   chk_bl_yn.checked    := false;
   edt_sp_yu.Clear;
   pnl_bl_yn.Visible    := False;

   if cmb_gt_yn.itemindex = 0 then
   begin
      groupbox1.Enabled := true;
      chk_bl_yn.enabled := true;
   end
   else
   begin
      groupbox1.Enabled := false;
   end;

end;

procedure Tfrm_LOSTC110P.msk_Ju_NoEnter(Sender: TObject);
begin
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTC110P.cmb_Gt_GuChange(Sender: TObject);
begin
     msk_Gt_No.text := '';

     with cmb_Gt_Gu do
     begin
        if copy(text,41,1) = '1' then
           msk_Gt_No.editmask := '999999-9999999;0;_'
        else if copy(text,41,1) = '3' then
           msk_Gt_No.editmask := '999-99-99999;0;_'
        else
        begin
           msk_Gt_No.editmask := '';
           msk_Gt_No.MaxLength := 16;
        end;
     end;
end;

procedure Tfrm_LOSTC110P.cmb_Gt_GuKeyDown(Sender: TObject; var Key: Word;
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
      OnChange(frm_LOSTC110P);
   end;
end;

procedure Tfrm_LOSTC110P.chk_bl_ynClick(Sender: TObject);
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

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTC110P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  value1
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  value2
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(self.Handle,SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

    ShowWindow(Self.Handle, SW_SHOW);
    ShowWindow(Self.Handle, SW_RESTORE  );
   end

end;

procedure Tfrm_LOSTC110P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

procedure Tfrm_LOSTC110P.btn_InquiryClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_gtnm, seed_gtno, seed_gttl : String;

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

	if not keyCheck then
    	exit;

	STR001:= Copy(delHyphen(msk_Ju_No.Text), 1,6); // 우체국코드
	STR002:= Copy(delHyphen(msk_Ju_No.Text), 7,8); // 등록일자
  STR003:= Copy(delHyphen(msk_Ju_No.Text),15,4); // 접수일련번호

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
	if (TMAX.SendString('INF003','LOSTC110P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC110P') then
  begin

    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

(* 우체국코드             *) //                       := Trim(TMAX.RecvString('STR101',0));
(* 우체국명               *) lbl_Po_Nm.Caption      := Trim(TMAX.RecvString('STR102',0));
(* 등록일자               *) //edt_ip_dt.Text         := InsHyphen(Trim(TMAX.RecvString('STR103',0)));
(* 접수일련번호           *) //msk_Ju_No.Text         := InsHyphen(Trim(TMAX.RecvString('STR104',0)));
(* 모델코드               *) //                     := Trim(TMAX.RecvString('STR105',0));
(* 모델명                 *) md_cb1.Text            := Trim(TMAX.RecvString('STR106',0));
(* 단말기일련번호         *) serial_edit.Text       := Trim(TMAX.RecvString('STR107',0));
(* 분실핸드폰번호         *) seed_mtno              := TMAX.RecvString('STR108',0);
                             edt_phone_no.Text      := delHyphen(Trim(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey)));
(* 가입자주민사업자구분   *) //                     := Trim(TMAX.RecvString('STR109',0));
(* 가입자주민사업자구분명 *) lbl_Ga_Gu.Caption      := Trim(TMAX.RecvString('STR110',0));
(* 가입자주민사업자번호   *) seed_gano              := TMAX.RecvString('STR111',0);
                             lbl_Ga_No.Caption      := Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
(* 가입자성명(업체명)     *) seed_ganm              := TMAX.RecvString('STR112',0);
                             lbl_Ga_Nm.Caption      := Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
(* 가입자우편번호         *) lbl_Ga_Pt.Caption      := InsHyphen(Trim(TMAX.RecvString('STR113',0)));
(* 가입자기본주소         *) lbl_Ga_Ju.Caption      := Trim(TMAX.RecvString('STR114',0));
(* 가입자상세주소         *) lbl_Ga_Bo.Caption      := Trim(TMAX.RecvString('STR115',0));
(* 가입자전화번호         *) seed_gatl              := TMAX.RecvString('STR116',0);
                             lbl_Ga_Tl.Caption      := InsHyphen(Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey)));
(* 단말기종류코드         *) //                     := Trim(TMAX.RecvString('STR117',0));
(* 단말기종류코드명       *) lbl_Ph_Gb.Caption      := Trim(TMAX.RecvString('STR118',0));
(* 습득신고자여부         *) if ((Trim(TMAX.RecvString('STR119',0)) = 'Y') or (Trim(TMAX.RecvString('STR119',0)) = '')) then cmb_gt_yn.itemIndex := 0 else cmb_gt_yn.itemIndex := 1;
(* 출고일자               *) lbl_Cl_Dt.Caption      := Trim(TMAX.RecvString('STR120',0));
(* 습득자구분코드         *) //                     := Trim(TMAX.RecvString('STR121',0));
(* 습득자구분명           *) cmb_Gt_Gu.itemIndex    := cmb_Gt_Gu.Items.IndexOf(Trim(TMAX.RecvString('STR122',0)));
if (cmb_Gt_Gu.itemIndex = -1) then cmb_Gt_Gu.itemIndex := 0;
(* 습득자주민사업자번호   *) seed_gtno              := TMAX.RecvString('STR123',0);
                             msk_Gt_No.Text         := Trim(ECPlazaSeed.Decrypt(seed_gtno, common_seedkey));
(* 습득일자               *) dte_Gt_Dt.Text         := InsHyphen(Trim(TMAX.RecvString('STR124',0)));
if (Length(delHyphen(dte_Gt_Dt.Text)) = 0) then dte_Gt_Dt.Date := date;
(* 사은품물품구분코드     *) //                     := Trim(TMAX.RecvString('STR125',0));
(* 사은품물품구분명       *) //                     := Trim(TMAX.RecvString('STR126',0));
(* 사은품상품코드         *) //                     := Trim(TMAX.RecvString('STR127',0));
(* 사은품상품명           *) //cmb_Sp_Cd.itemIndex    := cmb_Sp_Cd.items.IndexOf(Trim(TMAX.RecvString('STR128',0)));
(* 습득자성명업체명       *) seed_gtnm              := TMAX.RecvString('STR129',0);
                             Edit1.Text             := Trim(ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey));
(* 습득자우편번호         *) msk_Pt_No.Text         := Trim(TMAX.RecvString('STR130',0));
(* 습득자기본주소         *) lbl_Ju_So.Caption      := Trim(TMAX.RecvString('STR131',0));
(* 습득자상세주소         *) edt_Bo_So.Text         := Trim(TMAX.RecvString('STR132',0));
(* 습득자전화번호         *) seed_gttl              := TMAX.RecvString('STR133',0);
                             msk_Tl_No.Text         := InsHyphen(Trim(ECPlazaSeed.Decrypt(seed_gttl, common_seedkey)));
(* 사은품제외여부         *) if Trim(TMAX.RecvString('STR134',0)) = 'Y' then chk_bl_yn.Checked := True else chk_bl_yn.Checked := false;
(* 사은품제외사유         *) edt_sp_yu.Text         := Trim(TMAX.RecvString('STR135',0));
(* 신형모델상품코드       *)      if Trim(TMAX.RecvString('STR136',0)) = 'Y'   then rdo_New_1.Checked := True
                             else if Trim(TMAX.RecvString('STR136',0)) = 'N'   then rdo_New_2.Checked := True
                             else if Trim(TMAX.RecvString('STR136',0)) = 'X'   then rdo_New_2.Checked := True;
//(* 구형모델상품코드       *)      if Trim(TMAX.RecvString('STR137',0)) = 'Y'   then rdo_Old_1.Checked := True
//                             else if Trim(TMAX.RecvString('STR137',0)) = 'N'   then rdo_Old_2.Checked := True;

  if (TMAX.RecvString('STR138',0) = 'Y') then rb_dy_yes.Checked := True else rb_dy_no.Checked := True;
  if (TMAX.RecvString('STR139',0) = 'Y') then rb_no_yes.Checked := True else rb_no_no.Checked := True;
(* 보험금상태             *) lbl_insu_sts.Caption   := Trim(TMAX.RecvString('STR140',0));

  sts_Message.Panels[1].Text := ' 조회 완료';

  pgm_sts1 := [1];

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

procedure Tfrm_LOSTC110P.btn_Postno_InqClick(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin

  value1 := delHyphen(msk_Pt_No.Text);
  value2 := '';

  CreateMap;	//공유메모리 생성

  //self.ExecExternProg('LOSTZ800Q');

  if (chk_gt_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
  else self.ExecExternProg('LOSTZ800Q');

  //edt_Bo_So.SetFocus;

end;

procedure Tfrm_LOSTC110P.Link_rtn2 (var Msg : TMessage);
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
      lbl_Ju_So.Caption     := smem^.ju_so;	        // 기본주소

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    edt_Bo_So.SetFocus;

  end;

  ShowWindow(Self.Handle, SW_SHOW);
  ShowWindow(Self.Handle, SW_RESTORE);  
end;

procedure Tfrm_LOSTC110P.msk_Pt_NoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btn_Postno_InqClick(Sender);  
end;

procedure Tfrm_LOSTC110P.btn_AddClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_gt_no, str_idnm, str_tl_no : String;
  seed_mtno, seed_idno, seed_gtno, seed_idnm, seed_tlno : String;

  // 서비스 파라미터
  STRVALUE : array[1..23] of string;

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

  seed_mtno := '';
  seed_idno := '';
  seed_gtno := '';
  seed_idnm := '';
  seed_tlno := '';

  if pgm_sts1 = [0] then
  begin
    ShowMessage('조회 후 저장,삭제하실 수 있습니다.');
    Exit;
  end;

  if( not fChkLength(edt_Id_Nm  , 1,1,'성명(업체명)'                 )) then Exit;
  if( not fChkLength(msk_Ju_No  ,18,0,'접수번호'                     )) then Exit;
  if( not fChkLength(dte_Ip_Dt  , 8,0,'등록일자'                     )) then Exit;
  if( not fChkLength(msk_Gt_No  ,10,1,'습득자주민번호'               )) then Exit;
  if( not fChkLength(lbl_Ga_No  , 1,1,'가입자주민번호'               )) then Exit;

  //==========================================================================//
  // 일자 형식 검수

  //if ( not fValidDate( dte_po_dt )) then
  if (Trim(delHyphen(dte_po_dt.Text))='')  then
  begin
    ShowMessage('우체국 배달일자 날짜형식이 잘못되었습니다.'); Exit;
  end;

  //if ( not fValidDate( dte_Ip_Dt )) then
  if (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
  begin
    ShowMessage('입고일자 날짜형식이 잘못되었습니다.'); Exit;
  end;

  //if ( not fValidDate( dte_Gt_Dt )) then
  if (Trim(delHyphen(dte_Gt_Dt.Text))='')  then
  begin
    ShowMessage('접수일자 날짜형식이 잘못되었습니다.'); Exit;
  end;
  //==========================================================================//
  // 접수일자 <= 배달일자 <= 현재일자
//  if (StrToInt(delHyphen(DateToStr(date))) < StrToInt(delHyphen(dte_po_dt.Text))) then
//  begin
//    ShowMessage('배달일자가 현재일자보다 이후에 존재합니다.');
//    exit;
//  end;
//
//  if (StrToInt(delHyphen(dte_Gt_Dt.Text)) > StrToInt(delHyphen(dte_po_dt.Text))) then
//  begin
//    ShowMessage('접수일자가 배달일자보다 이후에 존재합니다.');
//    exit;
//  end;
  //==========================================================================//
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

  // 서비스 실행 파라미터 설정
  if Sender is TSpeedButton then
    if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if Sender is TMaskEdit then
    if (sender as TMaskEdit).Name = 'msk_Tl_No' then svcNm := 'I01';

  FillChar(STRVALUE,SizeOf(STRVALUE),#0);

  str_gt_no := delHyphen(msk_Gt_No.Text);
  str_idnm  := Edit1.Text;
  str_tl_no := delHyphen(msk_Tl_No.Text);
  seed_idno := ECPlazaSeed.Encrypt(str_gt_no, common_seedkey);
  seed_gtno := ECPlazaSeed.Encrypt(str_gt_no, common_seedkey);
  seed_idnm := ECPlazaSeed.Encrypt(str_idnm, common_seedkey);
  seed_tlno := ECPlazaSeed.Encrypt(str_tl_no, common_seedkey);

(*  우체국코드           *) STRVALUE[ 1] := Copy(delHyphen(msk_Ju_No.Text), 1,6);
(*  등록일자             *) STRVALUE[ 2] := Copy(delHyphen(msk_Ju_No.Text), 7,8);
(*  접수일련번호         *) STRVALUE[ 3] := Copy(delHyphen(msk_Ju_No.Text),15,4);
(*  습득자주민사업자번호 *) STRVALUE[ 4] := seed_idno;
(*  습득신고자여부       *) if (cmb_gt_yn.ItemIndex = 0 ) then STRVALUE[ 5] := 'Y' else STRVALUE[ 5] := 'N';
(*  우체국분실폰배달일자 *) STRVALUE[ 6] := delHyphen(dte_po_dt.Text);
(*  사은품제외여부       *) if (chk_bl_yn.checked) then STRVALUE[ 7] := 'Y' else STRVALUE[ 7] := 'N';
(*  사은품제외사유       *) STRVALUE[ 8] := Trim(edt_sp_yu.Text);
(*  습득자구분코드       *) STRVALUE[ 9] := IntToStr(cmb_Gt_Gu.itemIndex + 1);
(*  습득자주민사업자번호 *) STRVALUE[10] := seed_gtno;
(*  습득신고일자         *) STRVALUE[11] := delHyphen(dte_Gt_Dt.Text);
(*  사은품상품코드       *) STRVALUE[12] := '';
//(*  사은품상품코드       *) STRVALUE[12] := cmb_Sp_Cd_d[cmb_Sp_Cd.itemIndex].code;
(*  습득자성명(업체명)   *) STRVALUE[13] := seed_idnm;
(*  습득자우편번호       *) STRVALUE[14] := delHyphen(msk_Pt_No.Text);
(*  습득자기본주소       *) STRVALUE[15] := Trim(lbl_Ju_So.Caption);
(*  습득자상세주소       *) STRVALUE[16] := Trim(edt_Bo_So.Text);
(*  습득자전화번호       *) STRVALUE[17] := seed_tlno;
(*  사은품물품구분코드   *) STRVALUE[18] := '';
//(*  사은품물품구분코드   *) STRVALUE[18] := cmb_sp_gu_d[cmb_sp_gu.itemIndex].code;
(*  신형모델상품코드     *)      if (rdo_New_1.checked) then STRVALUE[19] := 'Y'
                            else if (rdo_New_2.Checked) then STRVALUE[19] := 'N'
                            else if (rdo_New_3.Checked) then STRVALUE[19] := 'X';
//(*  구형모델상품코드     *)      if (rdo_Old_1.checked) then STRVALUE[20] := 'Y'
//                            else if (rdo_Old_2.Checked) then STRVALUE[20] := 'N';
                            STRVALUE[20] := '';

  if(rb_dy_yes.Checked ) then STRVALUE[21] := 'Y' else STRVALUE[21] := 'N';
  if(rb_no_yes.Checked ) then STRVALUE[22] := 'Y' else STRVALUE[22] := 'N';
 if(rdo_out_yes.Checked) then STRVALUE[23] := 'Y' else STRVALUE[23] := 'N';
  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC110P')       < 0) then  goto LIQUIDATION;

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
	if not TMAX.Call('LOSTC110P') then
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
    //chk_gt_rodadr_yn.Checked := True;

    //msk_Pt_No.Text := '';
    //lbl_Ju_So.Caption := '';
    //edt_Bo_So.Text := '';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

procedure Tfrm_LOSTC110P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTC110P.FormShow(Sender: TObject);
begin
    //콤포넌트 초기화
    InitComponents;
    
    // 외부 호출인 경우에만 실행 ex) LOSTC100Q 에서 본 프로그램 호출 가능
    //if ParamStr(6) <> '' then   // 2016.06.21 수정
    if ParamStr(8) <> '' then
    begin
      edt_Id_Nm.Text        :=  fRNVL(ParamStr( 6));
      edt_birth_date.Text   :=  fRNVL(ParamStr( 7));
      edt_phone_no.Text     :=  fRNVL(ParamStr( 8));
      md_cb1.Text           :=  fRNVL(ParamStr( 9));
      serial_edit.Text      :=  fRNVL(ParamStr(10));
      dte_Ip_Dt.Text        :=  fRNVL(ParamStr(11));

      msk_Ju_No.Text        :=  delHyphen(ParamStr(12));

      btn_InquiryClick(Self);
    end;
end;

procedure Tfrm_LOSTC110P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTC110P.msk_Gt_NoKeyUp(Sender: TObject; var Key: Word;
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

procedure Tfrm_LOSTC110P.dte_po_dtExit(Sender: TObject);
begin
chk_bl_yn.SetFocus;
end;

procedure Tfrm_LOSTC110P.msk_Tl_NoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 107 then
  begin
    btn_AddClick(Sender);
  end;
end;

procedure Tfrm_LOSTC110P.chk_gt_rodadr_ynClick(Sender: TObject);
begin
//   if chk_gt_rodadr_yn.Checked = true then
//   begin
//      btn_Postno_InqClick(Sender);
//   end;
end;

end.
