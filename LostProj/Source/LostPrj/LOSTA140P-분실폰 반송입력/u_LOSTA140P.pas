{*---------------------------------------------------------------------------
프로그램ID    : LOSTA140P (분실폰 반송내역 입력)
프로그램 종류 : Online
작성자	      : 최 대 성
작성일	      : 2011. 09. 01
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
unit u_LOSTA140P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, so_tmax, WinSkinData,common_lib,localCloud,u_LOSTA140P_ADDR,
  ShellAPI, ComObj;

const
  TITLE   = '분실폰 반송내역 입력';
  PGM_ID  = 'LOSTA140P';

type
  Tfrm_LOSTA140P = class(TForm)
    Bevel2          : TBevel;
    Bevel6          : TBevel;
    Bevel17         : TBevel;
    Bevel43         : TBevel;
    Bevel44         : TBevel;
    Bevel4          : TBevel;
    Bevel3          : TBevel;
    Bevel10         : TBevel;
    Bevel9          : TBevel;
    Bevel7          : TBevel;
    Bevel8          : TBevel;
    Bevel26         : TBevel;
    Bevel20         : TBevel;
    Bevel21         : TBevel;
    Bevel22         : TBevel;
    Bevel23         : TBevel;
    Bevel24         : TBevel;
    Bevel27         : TBevel;
    Bevel28         : TBevel;
    Bevel29         : TBevel;
    Bevel30         : TBevel;
    Bevel11         : TBevel;
    Bevel12         : TBevel;
    Bevel13         : TBevel;
    Bevel5          : TBevel;
    Bevel19         : TBevel;
    Bevel25         : TBevel;
    Bevel32         : TBevel;
    Bevel34         : TBevel;
    Bevel35         : TBevel;
    Bevel36         : TBevel;
    Bevel38         : TBevel;
    Bevel39         : TBevel;
    Bevel40         : TBevel;
    Bevel41         : TBevel;
    Bevel31         : TBevel;
    Bevel33         : TBevel;
    Bevel37         : TBevel;
    Bevel42         : TBevel;
    cmb_Bn_Sy       : TComboBox;
    cmb_Md_Cd       : TComboBox;
    dte_Bn_Dt       : TDateEdit;
    GroupBox1       : TGroupBox;
    GroupBox3       : TGroupBox;
    lbl_Gid_Gu      : TLabel;
    Label17         : TLabel;
    Label7          : TLabel;
    Label19         : TLabel;
    lbl_Nid_Gu      : TLabel;
    lbl_Gid_No      : TLabel;
    lbl_Nid_No      : TLabel;
    Label13         : TLabel;
    lbl_Nid_Nm      : TLabel;
    lbl_Gid_Nm      : TLabel;
    lbl_Npt_No      : TLabel;
    Label11         : TLabel;
    lbl_Nju_So      : TLabel;
    Label33         : TLabel;
    lbl_Nbo_So      : TLabel;
    lbl_Ntl_no      : TLabel;
    lbl_Gpt_No      : TLabel;
    Label5          : TLabel;
    lbl_Ju_Dt       : TLabel;
    lbl_Ph_Gb       : TLabel;
    Label6          : TLabel;
    lbl_Gju_So      : TLabel;
    Label8          : TLabel;
    lbl_Cg_No       : TLabel;
    lbl_Gbo_So      : TLabel;
    lbl_Gtl_No      : TLabel;
    Label20         : TLabel;
    Label9          : TLabel;
    Label21         : TLabel;
    lbl_Program_Name: TLabel;
    Label2          : TLabel;
    Label22         : TLabel;
    lbl_Cl_Dt       : TLabel;
    Label23         : TLabel;
    Label12         : TLabel;
    Label3          : TLabel;
    Label4          : TLabel;
    Label24         : TLabel;
    Label14         : TLabel;
    N13             : TMenuItem;
    pnl_Command     : TPanel;
    Panel1          : TPanel;
    mnuLnk          : TPopupMenu;
    SkinData1       : TSkinData;
    btn_Addr_Update : TSpeedButton;
    sts_Message     : TStatusBar;
    md_grid1        : TStringGrid;
    TMAX            : TTMAX;
    edt_md_cd: TEdit;
    Panel2: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label1: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel1: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel45: TBevel;
    Label25: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    edt_phone_no: TMaskEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    edt_birth_date: TEdit;
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


    procedure FormCreate        (Sender: TObject);
    procedure btn_AddClick      (Sender: TObject);
    procedure btn_UpdateClick   (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure dte_Ip_DtExit     (Sender: TObject);
    procedure dte_Bn_DtExit     (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_grid1Click     (Sender: TObject);
    procedure md_cb1KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Addr_UpdateClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    
  private
    { Private declarations }
    cmb_Bn_Sy_d,md_grid1_d :TZ0xxArray;

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

    //검색 조건, 콤포넌트 별 키프레스
    procedure OnKeyPress(Sender: TObject; var Key: Char);


    function ExecExternProg(progID:String):Boolean;

    function keyCheck:boolean;

    // 임시 주민번호 전달
    function frtnRealIdNo(gbn : Integer) : String;
  end;

var
  frm_LOSTA140P: Tfrm_LOSTA140P;
  strGidNo , strNidNo : String;

implementation
{$R *.DFM}

function Tfrm_LOSTA140P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;

procedure Tfrm_LOSTA140P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA140P.OnKeyPress(Sender: TObject; var Key: Char);
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
procedure Tfrm_LOSTA140P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTA140P.OnExit(Sender:TObject);
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
          if value2 = '' then value2 := 'dummy';
          //edit.Text := value2;
          md_grid1.Visible := False;
        end
      //성명
      else if edit = edt_Id_Nm then
      begin
        value1:= Trim(edt_Id_Nm.Text);

        if value1 = '' then value1 := 'dummy';
        //edit.text := value1;
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
procedure Tfrm_LOSTA140P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTA140P.AttachOnExitEvent;
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
procedure Tfrm_LOSTA140P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTA140P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTA140P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTA140P.Link_rtn (var Msg : TMessage);
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
        edt_phone_no.EditText := Trim(smem^.phone_no2);  //분실핸드폰번호

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
procedure Tfrm_LOSTA140P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA140P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA140P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTA140P.FormCreate(Sender: TObject);
begin
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
//	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
	  if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle     := intToStr(self.Handle);
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
    initComboBoxWithZ0xx ('Z034.dat', cmb_Bn_Sy_d, '', '',cmb_Bn_Sy );
    initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

    //콤포넌트에 이벤트를 어태치 한다.
    AttachOnEnterEvent;
    AttachOnExitEvent;
    AttachOnKeyPressEvent;
    btn1.OnClick := self.OnSearchClick;
    btn2.OnClick := self.OnSearchClick;
    btn3.OnClick := self.OnSearchClick;
    btn4.OnClick := self.OnSearchClick;

    //콤포넌트 초기화
    InitComponents;

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA140P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos('lbl_',(component as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(component as TLabel).Name) = 0)
         then (component as TLabel).Caption := '';

    if ( Components[i] is TEdit) then
      ( Components[i] as TEdit).Text := ''
    else if ( Components[i] is TMaskEdit) then
      ( Components[i] as TMaskEdit).Text := '';


  end;

  //초기화
  setItemNo('1');

  changeBtn(self);
  btn_Link.Enabled := True;

  recvedMessage := true;

  dte_Ip_Dt.Date  := date;
  dte_Bn_Dt.Date  := date;

  cmb_Bn_Sy.ItemIndex := -1;
  md_grid1.Row        := 0;
  md_cb1.Text         := md_grid1.Cells[0,md_grid1.Row];
        
end;

//'등록' 버튼 클릭
procedure Tfrm_LOSTA140P.btn_AddClick(Sender: TObject);
var
	STR004,STR005:String;
    LABEL LIQUIDATION;
begin
{
_I01

입력:
STR001,"모델코드"
STR002,"단말기일련번호"
STR003,"입고일자"
STR004,"반송일자"
STR005,"반송사유코드"

출력:
RETURN = TURE 일경우 메세지
}
	if not keyCheck then
    	exit;

  if (Trim(delHyphen(dte_Bn_Dt.Text))='') or (Trim(cmb_Bn_Sy.Text) ='') then begin
    ShowMessage('반송일자 및 사유를 입력하세요');
      exit;
  end;

  // 건수 별 재조회를 위한 데이터 변수 설정
  STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	      //모델코드 md_cb1
  STR002:= serial_edit.Text;			                                              //단말기일련번호    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	                                          //입고일자  dte_Ip_Dt
  STR004:= delHyphen(dte_Bn_Dt.Text);	                                          //반송일자
  STR005:= findCodeFromName(cmb_Bn_Sy.Text,cmb_Bn_Sy_d, cmb_Bn_Sy.Items.Count);	//반송사유

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
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01')   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' 등록 완료';

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'수정' 버튼 클릭
procedure Tfrm_LOSTA140P.btn_UpdateClick(Sender: TObject);
var
	STR004,STR005:String;
  LABEL LIQUIDATION;
begin
{
_U01

입력:
STR001,"모델코드" 
STR002,"단말기일련번호" 
STR003,"입고일자" 
STR004,"반송일자"
STR005,"반송사유코드"

출력:
RETURN = TURE 일경우 메세지
}
	if not keyCheck then
    	exit;

  if (Trim(delHyphen(dte_Bn_Dt.Text))='') or (Trim(cmb_Bn_Sy.Text) ='') then begin
    ShowMessage('반송일자 및 사유를 입력하세요');
      exit;
  end;

  STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//모델코드 md_cb1
  STR002:= serial_edit.Text;			//단말기일련번호    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	//입고일자  dte_Ip_Dt
  STR004:= delHyphen(dte_Bn_Dt.Text);	//반송일자
  STR005:= findCodeFromName(cmb_Bn_Sy.Text,cmb_Bn_Sy_d, cmb_Bn_Sy.Items.Count);	//반송사유

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
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U01')   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := ' 수정 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

//'삭제' 버튼 클릭
procedure Tfrm_LOSTA140P.btn_DeleteClick(Sender: TObject);
	Label LIQUIDATION;
begin
{
_D01

입력:

STR001,"모델코드"
STR002,"단말기일련번호"
STR003,"입고일자"

출력:
RETURN = TURE 일경우 메세지
}
	if not keyCheck then
    exit;

	if MessageDlg('정말 삭제하시겠습니까 ?',
		mtConfirmation, mbOkCancel, 0) = mrCancel then begin
		sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
		exit;
	end;

	STR001  := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//모델코드 md_cb1
	STR002  := serial_edit.Text;			                                        //단말기일련번호    serial_edit
  STR003  := delHyphen(dte_Ip_Dt.Text);	                                    //입고일자  dte_Ip_Dt

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
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','D01')             < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001)           < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002)           < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003)           < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA140P') then begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
  end;

   	sts_Message.Panels[1].Text := ' 삭제 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

//'조회' 버튼 클릭
procedure Tfrm_LOSTA140P.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_nano, seed_nanm, seed_natl, seed_mtno : String;

    Label LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_nano := '';
  seed_nanm := '';
  seed_natl := '';
  seed_mtno := '';

	if not keyCheck then
    	exit;

	STR001:= findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	//모델코드 md_cb1
	STR002:= serial_edit.Text;			//단말기일련번호    serial_edit
  STR003:= delHyphen(dte_Ip_Dt.Text);	//입고일자  dte_Ip_Dt

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
	if (TMAX.SendString('INF003','LOSTA140P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA140P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
    end;

  (* 모델코드               *) edt_md_cd.Text     :=              TMAX.RecvString('STR101',0);
  (* 모델명                 *) md_cb1.Text        :=              TMAX.RecvString('STR102',0);
  (* 단말기일련번호         *) serial_edit.Text   :=              TMAX.RecvString('STR103',0);
  (* 입고일자               *) dte_Ip_Dt.Text     := InsHyphen(   TMAX.RecvString('STR104',0));
  (* 수취여부               *) //                 :=              TMAX.RecvString('STR105',0);
  (* 처리구분코드           *) //                 :=              TMAX.RecvString('STR106',0);
  (* 단말기종류코드         *) //                 :=              TMAX.RecvString('STR107',0);
  (* 단말기종류명           *) lbl_Ph_Gb.Caption  :=              TMAX.RecvString('STR108',0);
  (* 단말기적요             *) //                 :=              TMAX.RecvString('STR109',0);
  (* 출고일자               *) lbl_Cl_Dt.Caption  :=              TMAX.RecvString('STR110',0);
  (* 우체국출고접수일자     *) lbl_Ju_Dt.Caption  := InsHyphen(   TMAX.RecvString('STR111',0));
  (* 단말기상태코드         *) //                 :=              TMAX.RecvString('STR112',0);
  (* 단말기상태명           *) //                 :=              TMAX.RecvString('STR113',0);
  (* 창고번호               *) lbl_Cg_No.Caption  :=              TMAX.RecvString('STR114',0);
  (* 반송일자               *) dte_Bn_Dt.Text     := InsHyphen(   TMAX.RecvString('STR115',0));
  (* 반송사유코드           *)
  if  dte_Bn_Dt.Text = '    -  -  '  then
  begin
    dte_Bn_Dt.Date := date;
    cmb_Bn_Sy.ItemIndex :=-1
  end
  else
    cmb_Bn_Sy.Text := TMAX.RecvString('STR116',0);
  (* 반송사유               *) //                 :=              TMAX.RecvString('STR117',0);
  (* 가입자주민사업자구분   *) //                 :=              TMAX.RecvString('STR118',0);
  (* 가입자주민사업자구분명 *) lbl_Gid_Gu.Caption :=              TMAX.RecvString('STR119',0);
  (* 가입자주민사업자번호   *) seed_gano          := TMAX.RecvString('STR120',0);
                               lbl_Gid_No.Caption := InsHyphen(   ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* 가입자성명(업체명)     *) seed_ganm          := TMAX.RecvString('STR121',0);
                               lbl_Gid_Nm.Caption :=              ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
  (* 가입자우편번호         *) lbl_Gpt_No.Caption := InsHyphen(   TMAX.RecvString('STR122',0));
  (* 가입자기본주소         *) lbl_Gju_So.Caption :=              TMAX.RecvString('STR123',0);
  (* 가입자상세주소         *) lbl_Gbo_So.Caption :=              TMAX.RecvString('STR124',0);
  (* 가입자전화번호         *) seed_gatl          := TMAX.RecvString('STR125',0);
                               lbl_Gtl_No.Caption := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
  (* 분실핸드폰번호         *) seed_mtno          := TMAX.RecvString('STR126',0);
                               edt_phone_no.Text  :=              ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
  (* 납부자주민사업자구분   *) //                 :=              TMAX.RecvString('STR127',0);
  (* 납부자주민사업자구분명 *) lbl_Nid_Gu.Caption :=              TMAX.RecvString('STR128',0);
  (* 납부자주민사업자번호   *) seed_nano          := TMAX.RecvString('STR129',0);
                               lbl_Nid_No.Caption := InsHyphen(   ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
  (* 납부자성명(업체명)     *) seed_nanm          := TMAX.RecvString('STR130',0);
                               lbl_Nid_Nm.Caption :=              ECPlazaSeed.Decrypt(seed_nanm, common_seedkey);
  (* 납부자우편번호         *) lbl_Npt_No.Caption := InsHyphen(   TMAX.RecvString('STR131',0));
  (* 납부자기본주소         *) lbl_Nju_So.Caption :=              TMAX.RecvString('STR132',0);
  (* 납부자상세주소         *) lbl_Nbo_So.Caption :=              TMAX.RecvString('STR133',0);
  (* 납부자전화번호         *) seed_natl          := TMAX.RecvString('STR134',0);
                               lbl_Ntl_no.Caption := ECPlazaSeed.Decrypt(seed_natl, common_seedkey);
  (* 주소정보수정구분코드   *)
  if TMAX.RecvString('STR135',0) <> '' then
    frm_LOSTA140P_ADDR.cmb_up_gu.ItemIndex := StrToInt(TMAX.RecvString('STR135',0));


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

procedure Tfrm_LOSTA140P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

//On-Exit (입고일자)
procedure Tfrm_LOSTA140P.dte_Ip_DtExit(Sender: TObject);
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

//On-Eixt (반송일)
procedure Tfrm_LOSTA140P.dte_Bn_DtExit(Sender: TObject);
begin
{
     try
     dte_Bn_Dt.Date := strtodate(dte_Bn_Dt.text);
     except
     on E: EConvertError do
	begin
	   ShowMessage('일자 입력 오류'+#13+
		       '오늘일자로 변경됩니다');
	   dte_Bn_Dt.date := date;
	   dte_Bn_Dt.setfocus;
	end;
     end;
}
end;

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTA140P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - 호출구분          *)+ ' ' +  '02'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(self.Handle, SW_HIDE);

	if ret <= 31 then
  begin
		result:= False;

    MessageBeep (0);
		if ret = ERROR_FILE_NOT_FOUND then
			ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
		else
			ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');

   end
end;

function Tfrm_LOSTA140P.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTA140P.btn_Addr_UpdateClick(Sender: TObject);
begin
  frm_LOSTA140P_ADDR.Show;

  ShowWindow(Self.Handle,SW_HIDE);
end;

procedure Tfrm_LOSTA140P.btn_LinkClick(Sender: TObject);
const
  URL = 'http://post.handphone.or.kr/post/npost/jem.php';
begin
  shellexecute(0, 'open', 'iexplore.exe',pchar(URL), nil, SW_MAXIMIZE);
end;

procedure Tfrm_LOSTA140P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

end.
