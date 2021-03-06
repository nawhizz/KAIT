{*---------------------------------------------------------------------------
프로그램ID    : LOSTC100P (우체국처리 수취 확인 입력)
프로그램 종류 : Online
작성자        : 최대성
작성일        : 2011. 08. 23
완료일        : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      : 2012.01.18
작성자        : 최대성
변경내용      : 보험사 연계로 인한 페이지 수정
처리번호      :
Ver           :
-----------------------------------------------------------------------------*}
unit u_LOSTC100P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, common_lib, localCloud,
  Grids, so_tmax, WinSkinData, Menus, ComObj;

const
  TITLE   = '우체국처리 수취 확인 입력';
  PGM_ID  = 'LOSTC100P';

type
  Tfrm_LOSTC100P = class(TForm)
    Bevel10        : TBevel;
    Bevel11        : TBevel;
    Bevel12        : TBevel;
    Bevel13        : TBevel;
    Bevel14        : TBevel;
    Bevel16        : TBevel;
    Bevel17        : TBevel;
    Bevel19        : TBevel;
    Bevel1         : TBevel;
    Bevel20        : TBevel;
    Bevel21        : TBevel;
    Bevel22        : TBevel;
    Bevel23        : TBevel;
    Bevel24        : TBevel;
    Bevel26        : TBevel;
    Bevel27        : TBevel;
    Bevel28        : TBevel;
    Bevel29        : TBevel;
    Bevel2         : TBevel;
    Bevel30        : TBevel;
    Bevel31        : TBevel;
    Bevel32        : TBevel;
    Bevel33        : TBevel;
    Bevel34        : TBevel;
    Bevel35        : TBevel;
    Bevel36        : TBevel;
    Bevel37        : TBevel;
    Bevel38        : TBevel;
    Bevel39        : TBevel;
    Bevel3         : TBevel;
    Bevel40        : TBevel;
    Bevel41        : TBevel;
    Bevel42        : TBevel;
    Bevel43        : TBevel;
    Bevel44        : TBevel;
    Bevel47        : TBevel;
    Bevel48        : TBevel;
    Bevel49        : TBevel;
    Bevel5         : TBevel;
    Bevel7         : TBevel;
    Bevel8         : TBevel;
    Bevel9         : TBevel;
    btn1           : TBitBtn;
    btn2           : TBitBtn;
    btn3           : TBitBtn;
    btn_Name_Inq   : TBitBtn;
    cmb_md_cd      : TComboBox;
    dte_Ip_Dt      : TDateEdit;
    edt_Id_Nm      : TEdit;
    edt_Id_No      : TEdit;
    dt_ipgo        : TEdit;
    GroupBox1      : TGroupBox;
    GroupBox3      : TGroupBox;
    Label12        : TLabel;
    Label13        : TLabel;
    Label14        : TLabel;
    Label16        : TLabel;
    Label17        : TLabel;
    Label19        : TLabel;
    Label1         : TLabel;
    Label20        : TLabel;
    Label21        : TLabel;
    Label22        : TLabel;
    Label23        : TLabel;
    Label24        : TLabel;
    Label25        : TLabel;
    Label26        : TLabel;
    Label28        : TLabel;
    Label2         : TLabel;
    Label33        : TLabel;
    Label3         : TLabel;
    Label5         : TLabel;
    Label7         : TLabel;
    Label8         : TLabel;
    Label9         : TLabel;
    lbl_Cl_Dt      : TLabel;
    lbl_Gbo_So     : TLabel;
    lbl_Gid_Gu     : TLabel;
    lbl_Gid_Nm     : TLabel;
    lbl_Gid_No     : TLabel;
    lbl_Gju_So     : TLabel;
    lbl_Gpt_No     : TLabel;
    lbl_Gtl_No     : TLabel;
    lbl_Mt_No      : TLabel;
    lbl_Nbo_So     : TLabel;
    lbl_Nid_Gu     : TLabel;
    lbl_Nid_Nm     : TLabel;
    lbl_Nid_No     : TLabel;
    lbl_Nju_So     : TLabel;
    lbl_Npt_No     : TLabel;
    lbl_Ntl_no     : TLabel;
    lbl_ph_gb      : TLabel;
    lbl_Po_Nm      : TLabel;
    lbl_Program_Name: TLabel;
    Label11        : TLabel;
    msk_Ju_No      : TMaskEdit;
    edt_phone_no   : TMaskEdit;
    N13            : TMenuItem;
    pnl_Command    : TPanel;
    Panel14        : TPanel;
    mnuLnk         : TPopupMenu;
    SkinData1      : TSkinData;
    btn_Addr_Update: TSpeedButton;
    sts_Message    : TStatusBar;
    md_Grid1       : TStringGrid;
    TMAX           : TTMAX;
    Label27: TLabel;
    Bevel45: TBevel;
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
    lbl_Nm: TPanel;
    bvl1: TBevel;
    lbl_gt_nm: TLabel;
    Bevel51: TBevel;
    lbl32: TLabel;
    Bevel55: TBevel;
    lbl_nm_cd: TLabel;
    Bevel18: TBevel;
    Bevel15: TBevel;
    Label15: TLabel;
    Label18: TLabel;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    btn4: TBitBtn;
    Bevel46: TBevel;
    Bevel50: TBevel;
    Label29: TLabel;
    lbl_insu_sts: TLabel;
    btn_search_src: TButton;
    Label31: TLabel;
    Bevel53: TBevel;
    Panel3: TPanel;
    Bevel54: TBevel;
    Bevel4: TBevel;
    Label4: TLabel;
    Bevel6: TBevel;
    Label6: TLabel;
    Bevel25: TBevel;
    Label10: TLabel;
    lbl1: TLabel;
    Bevel52: TBevel;
    Label32: TLabel;
    Panel4: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    dte_Bl_dt: TDateEdit;
    edt_Ju_Yo: TEdit;
    chk1: TCheckBox;
    lbl_Phone_sts: TLabel;
    Label34: TLabel;
    Bevel70: TBevel;
    cmb_Zp_no: TComboBox;

    procedure FormCreate        (Sender: TObject);
    procedure btn_AddClick      (Sender: TObject);
    //procedure btn_UpdateClick   (Sender: TObject);
    procedure btn_DeleteClick   (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure md_cb1ButtonClick (Sender: TObject);
    procedure md_grid1Click     (Sender: TObject);
    procedure FormShow          (Sender: TObject);
    procedure md_cb1KeyUp       (Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn_Addr_UpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure Edt_onKeyPress        (Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_LinkClick(Sender: TObject);
    procedure rdo_Sh_NoClick(Sender: TObject);
    procedure rdo_Sh_YesClick(Sender: TObject);
    procedure edt_Ju_YoClick(Sender: TObject);
    procedure edt_Ju_YoEnter(Sender: TObject);
    procedure btn_search_srcClick(Sender: TObject);


  private
    { Private declarations }
    md_grid1_d :TZ0xxArray;

    //LOSTZ810Q.exe로 메세지 받을 때 사용
    recvedMessage:Boolean;

    //LOSTZ820Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;

    //검색시 사용
    STR001:String; // 모델코드
    STR002:String; // 단말기일련번호
    STR003:String; // 입고일자

  public
    { Public declarations }

    procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
    procedure SetLabelCaption(var lbl:TLabel; strtag:String);
    procedure SetItemNo(number:String);
    procedure InitComponents;

    procedure AttachOnEnterEvent;
    procedure AttachOnKeyPressEvent;
    procedure AttachOnExitEvent;
    procedure DetachOnEnterEvent;

    procedure OnExit(Sender:TObject);
    procedure OnEnter(Sender:TObject);

    procedure OnSearchClick(Sender:TObject);

    procedure OnKeyPress(Sender: TObject; var Key: Char);

    function ExecExternProg(progID:String):Boolean;

    function keyCheck:boolean;

    // 임시 주민번호 전달
    function frtnRealIdNo(gbn : Integer) : String;
  end;

  (* PGM_STS : 프로그램 상태  *)
  (* 0 : 조회전               *)
  (* 1 : 조회후               *)
  (* 2,3 : 여유분             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTC100P: Tfrm_LOSTC100P;
  strGidNo , strNidNo : String;
  pgm_sts1   : PGM_STS;

  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  cmb_Zp_no_d   : TZ0xxArray;

implementation
uses cpaklibm, Clipbrd, u_LOSTC100P_ADDR, u_LOSTC100P_POP, u_LOSTC100P_INSU;
{$R *.DFM}

function Tfrm_LOSTC100P.keyCheck:boolean;
begin
    result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;

procedure Tfrm_LOSTC100P.AttachOnKeyPressEvent;
begin
    edt_Id_Nm.OnKeyPress        := self.OnKeyPress; // TEdit       성명
    edt_birth_date.OnKeyPress   := self.OnKeyPress; // TDateEdit   생년월일
    edt_phone_no.OnKeyPress     := self.OnKeyPress; // TMaskEdit   분실핸드폰번호
    md_cb1.OnKeyPress           := self.OnKeyPress; // TComboEdit  모델명
    serial_edit.OnKeyPress      := self.OnKeyPress; // TEdit       시리얼번호
end;

(******************************************************************************)
(* procedure name  : OnKeyPress                                               *)
(* procedure 기 능 : 컴퍼넌트중에 OnKeyPress를 사용하는 개체의                *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.OnKeyPress(Sender: TObject; var Key: Char);
var
  edit:TEdit;
  dedit:TDateEdit;
  medit:TMaskEdit;
  cedit:TComboEdit;

  i : Integer;

begin
    if Key <> #13 then  //엔터키가 아니면
  begin
    if Sender is TEdit then
    begin
      if (Sender as TEdit) = edt_birth_date then
        if not (key in ['0'..'9',#3,#8,#9]) then key := #0;
      if (Sender as TEdit) = serial_edit then
        if not (key in ['0'..'z',#3,#8,#9,#22]) then key := #0;
    end else
    begin
    if Sender is TMaskEdit then
      if (Sender as TMaskEdit) = edt_phone_no then
        if not (key in ['0'..'9',#3,#8,#9]) then key := #0;
    end;

    Exit;
  end;

    if Sender.ClassType = TEdit then
        begin
          edit := Sender as TEdit;
          if edit = edt_Id_Nm           then btn1.OnClick(btn1)  // 성명
          else if edit = edt_birth_date then btn2.OnClick(btn2)  // 생년월일
          else if edit = serial_edit    then btn4.OnClick(btn4);  // 생년월일
        end
  else if Sender.ClassType = TComboEdit then
        begin
          cedit:= Sender as TComboEdit;

          for i := 0 to md_grid1.rowcount do
            if (md_cb1.Text = md_grid1.Cells[0,i]) then
              lbl_nm_cd.Caption :=  md_grid1_d[i].JCode5;

          if cedit = md_cb1 then
          begin
            if md_grid1.Visible then cedit.Text := md_grid1.Cells[0,md_grid1.Row];
            md_grid1.Visible := False;
            serial_edit.SetFocus;         //모델명
          end;

        end
  else if Sender.ClassType = TMaskEdit then
        begin
          medit:= Sender as TMaskEdit;
          if medit = edt_phone_no then btn3.OnClick(btn3);
  end;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.InitComponents;
var i :integer;
begin

  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TLabel then
      if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
        then (Components[i] as TLabel).Caption := '';

    if Components[i] is TEdit then (Components[i] as TEdit).Text := '';
    if Components[i] is TMaskEdit then (Components[i] as TMaskEdit).Text := '';
  end;

  {-------------------------    인덱스 초기화      ----------------------------}
  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  cmb_Zp_no.ItemIndex     :=  0;

  // 버튼 초기화
  changeBtn(Self);

  btn_Link.Enabled := True;

  chk1.Checked := false;

  dte_Ip_Dt.Date    := date;

  md_grid1.Row      := 0;
  md_cb1.Text       := md_grid1.Cells[0,md_grid1.Row];

  strGidNo         := '';
  strNidNo         := '';

  //초기화
  setItemNo('1');

  pgm_sts1 := [0];

  //처음 실행시 윈도우 클로즈 돕기 위해
  recvedMessage:= True;

  edt_Id_Nm.SetFocus;

end;

(******************************************************************************)
(* procedure name  : OnSearchClick                                            *)
(* procedure 기 능 : 컴퍼넌트중에 OnSearchClick를 사용하는 개체의             *)
(*                   이벤트를 실행한다.                                       *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.OnSearchClick(Sender:TObject);
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
        end
    else if Sender = btn4 then
    begin
      if not fChkLength(md_cb1,1,1,'모델코드명') then Exit;
      if not fChkLength(serial_edit,1,1,'시리얼번호') then Exit;

      serial_edit.OnExit(serial_edit);
    end;


    CreateMap;  //공유메모리 생성
      self.ExecExternProg('LOSTZ820Q');
end;

(******************************************************************************)
(* procedure name  : OnExit                                                   *)
(* procedure 기 능 : 컴퍼넌트중에 OnExit를 사용하는 개체의                    *)
(*                   이벤트를 실행한다.                                       *)
(*                   해당 이벤트가 발생한 컴퍼넌트의 값을 전역변수로 설정한다 *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.OnExit(Sender:TObject);
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
          value1 := Trim(md_cb1.Text);        //전역변수 설정 -> value1
          value2 := Trim(serial_edit.Text);   //전역변수 설정 -> value2

          if value2 = '' then value2 :='dummy';
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
procedure Tfrm_LOSTC100P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTC100P.AttachOnExitEvent;
begin
    edt_Id_Nm.OnExit      := self.OnExit; // TEdit       성명
    edt_birth_date.OnExit := self.OnExit; // TDateEdit   생년월일
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
procedure Tfrm_LOSTC100P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTC100P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTC100P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

(******************************************************************************)
(* procedure name  : SetLabelCaption                                          *)
(* procedure 기 능 : 라벨명과 캡션을 받아 라벨 캡션으로 설정한다.             *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.SetLabelCaption(var lbl:TLabel; strtag:String);
begin
    lbl.Caption:= TMAX.RecvString(strtag,0);
end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTC100P.Link_rtn (var Msg : TMessage);
var
  (**************************************************)
  (*  localcloud.pas                                *)
  (*  type :TPSharedMem                             *)
  (*  Using       :Integer;       //사용중=1,미사용=0 *)
  (*  ProgID      :String[30];  //사용중인 프로그램 *)
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
  i : Integer;

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

      edt_Id_Nm.Text        := smem^.name;                  //성명(업체명)
      md_cb1.Text           := smem^.model_name;          //모델명
      serial_edit.Text      := smem^.serial_no;         //단말기일련번호
      dte_Ip_Dt.text        := InsHyphen(smem^.pg_dt);  //입고일
      edt_birth_date.Text   := smem^.birth;                 //생년월일
      edt_phone_no.EditText := Trim(smem^.phone_no);    //분실핸드폰번호
      dt_ipgo.Text          := smem^.ibgo_date;
      msk_Ju_No.Text        := smem^.po_cd + '-' + smem^.pg_dt + '-' + smem^.ju_seq; // 접수번호
      edt_Id_No.Text        := smem^.id_no;

      for i := 0 to md_grid1.RowCount do
        if md_cb1.Text = md_grid1_d[i].name then
          lbl_nm_cd.Caption := md_grid1_d[i].JCode5;


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
procedure Tfrm_LOSTC100P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTC100P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
      lbl_nm_cd.Caption := md_grid1_d[md_grid1.Row].JCode5;
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
procedure Tfrm_LOSTC100P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   lbl_nm_cd.Caption  := md_grid1_d[md_grid1.Row].JCode5;
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;

procedure Tfrm_LOSTC100P.FormCreate(Sender: TObject);
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

    {=========================    그리드   초기화     ===========================}
    initStrinGridWithZ0xx('Z008.dat', md_grid1_d , '', '',md_grid1  );

  {=========================    콤보박스 초기화     ===========================}
  // 2016.01.10 유영배 - 재사용여부 콤보 추가
  (* 재사용구분 *)  initComboBoxWithZ0xx('Z089',cmb_Zp_no_d   ,'','' ,cmb_Zp_no );

    //콤포넌트에 이벤트를 어태치 한다.
    AttachOnEnterEvent;
    AttachOnExitEvent;
    AttachOnKeyPressEvent;

    btn1.OnClick := self.OnSearchClick;
    btn2.OnClick := self.OnSearchClick;
    btn3.OnClick := self.OnSearchClick;
    btn4.OnClick := self.OnSearchClick;

    edt_Ju_Yo.OnClick := edt_Ju_YoClick;

    //스태터스바에 사용자 정보를 보여준다.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

//'등록' 버튼 클릭
procedure Tfrm_LOSTC100P.btn_AddClick(Sender: TObject);
var
  // 서비스 변수 설정
    STR004,STR005,STR006,STR007,STR008,STR009:String;

  // 서비스 세부명 설정
  svcNm : string[3];

  LABEL LIQUIDATION;
begin

  // 서비스 실행 파라미터 설정
  if (Sender as TSpeedButton).Name = 'btn_Add' then svcNm := 'I01' else svcNm := 'U01';

  if pgm_sts1 = [0] then
  begin
    ShowMessage('조회 후 저장,삭제하실 수 있습니다.');
    Exit;
  end;

  // 문자열 검증
  if not fChkLength(msk_Ju_No,18,0,'접수번호' ) then Exit;

    STR001:= Copy(delHyphen(msk_Ju_No.Text), 1,6); // 우체국코드
    STR002:= Copy(delHyphen(msk_Ju_No.Text), 7,8); // 등록일자
  STR003:= Copy(delHyphen(msk_Ju_No.Text),15,4); // 접수일련번호

  if rdo_Sh_Yes.Checked then STR004 := 'Y' else STR004 := 'N'; // 수취여부

  STR005:= edt_Ju_Yo.Text;                                     // 적요
  STR006:= delHyphen(dte_Bl_dt.Text);                            // 발송예정일자
  if (chk1.checked) then STR007 := 'Y' else STR007 := 'N';
//  if(rb_dy_yes.Checked ) then STR007 := 'Y' else STR007 := 'N';
//  if(rb_no_yes.Checked ) then STR008 := 'Y' else STR008 := 'N';

  // 2016.01.10 유영배 - 재사용여부 추가
  if (Length(cmb_Zp_no_d[cmb_Zp_no.itemIndex].code) = 0) then
    STR009 := '0'
  else if (cmb_Zp_no_d[cmb_Zp_no.itemIndex].code = '0') then
    STR009 := '0'
  else
    STR009 := cmb_Zp_no_d[cmb_Zp_no.itemIndex].code;


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
    if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTC100P'      )   < 0) then  goto LIQUIDATION;
    
    if (TMAX.SendString('INF001', svcNm           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', STR001          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', STR002          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', STR003          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR004', STR004          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR005', STR005          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR006', STR006          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR007', STR007          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR008', STR008          )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR009', STR009          )   < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTC100P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
  begin
      sts_Message.Panels[1].Text := ' 등록 완료';
      if (svcNm = 'I01') then ShowMessage('성공적으로 등록되었습니다.')
        else if (svcNm = 'U01') then ShowMessage('성공적으로 수정되었습니다.');
  end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'삭제' 버튼 클릭
procedure Tfrm_LOSTC100P.btn_DeleteClick(Sender: TObject);
    Label LIQUIDATION;
begin

  if  pgm_sts1 = [0] then
  begin
    ShowMessage('조회 후 삭제하실 수 있습니다.');
    Exit;
  end;

    if MessageDlg('정말 삭제하시겠습니까 ?',
        mtConfirmation, mbOkCancel, 0) = mrCancel then begin
        sts_Message.Panels[1].text := '삭제가 취소되었습니다.';
        exit;
    end;

  // 문자열 검증
  if not fChkLength(msk_Ju_No,18,0,'접수번호' ) then Exit;

    STR001  := Copy(delHyphen(msk_Ju_No.Text), 1,6);  // 우체국코드
    STR002  := Copy(delHyphen(msk_Ju_No.Text), 7,8);  // 등록일자
  STR003  := Copy(delHyphen(msk_Ju_No.Text),15,4);  // 접수일련번호

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
    if (TMAX.SendString('INF003','LOSTC100P')       < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','D01')             < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', STR001)           < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', STR002)           < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', STR003)           < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTC100P') then begin
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
procedure Tfrm_LOSTC100P.btn_InquiryClick(Sender: TObject);
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

  // 문자열 검증
  // if not fChkLength(msk_Ju_No.Text,18,0,'접수번호' ) then msk_Ju_No.SetFocus; Exit;

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
    if (TMAX.SendString('INF003','LOSTC100P'      )  < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTC100P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;


  msk_Ju_No.Text := TMAX.RecvString('STR101',0) + TMAX.RecvString('STR103',0) + TMAX.RecvString('STR104',0);    //우체국코드(Z042)

  if (TMAX.RecvString('STR108',0) = 'Y') then rdo_Sh_Yes.Checked := True else rdo_Sh_No.Checked := True;

  (* 우체국명              *)  lbl_Po_Nm.Caption   :=           TMAX.RecvString('STR102',0);
  (* 등록일자              *)  dte_ip_dt.Text      := InsHyphen(TMAX.RecvString('STR103',0));
  (* 모델명                *)  md_cb1.Text         :=           TMAX.RecvString('STR106',0);
  (* 단말기일련번호        *)  serial_edit.Text    :=           TMAX.RecvString('STR107',0);
  (* 적요                  *)  edt_Ju_Yo.Text      :=           TMAX.RecvString('STR109',0);
  (* 발송예정일            *)  dte_Bl_dt.Text      := InsHyphen(TMAX.RecvString('STR110',0));
  if ( Trim(delHyphen(dte_Bl_dt.Text)) = '') then dte_Bl_dt.Date := date;

  (* 단말기종류코드명      *)  lbl_ph_gb.Caption   :=      Trim(TMAX.RecvString('STR112',0));
  (* 출고일자              *)  lbl_cl_dt.Caption   := InsHyphen(TMAX.RecvString('STR113',0));

  (* 가입자주민사업자구분명*)  lbl_Gid_Gu.Caption  :=           TMAX.RecvString('STR115',0);
  (* 가입자주민사업자번호  *)  seed_gano           :=           TMAX.RecvString('STR116',0);
                               lbl_Gid_No.Caption  := InsHyphen(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* 가입자성명(업체명)    *)  seed_ganm           :=           TMAX.RecvString('STR117',0);
                               lbl_Gid_Nm.Caption  :=           ECPlazaSeed.Decrypt(seed_ganm, common_seedkey);
  (* 가입자우편번호        *)  lbl_Gpt_No.Caption  := InsHyphen(TMAX.RecvString('STR118',0));
  (* 가입자기본주소        *)  lbl_Gju_So.Caption  :=           TMAX.RecvString('STR119',0);
  (* 가입자상세주소        *)  lbl_GBo_so.Caption  :=           TMAX.RecvString('STR120',0);
  (* 가입자전화번호        *)  seed_gatl           := TMAX.RecvString('STR121',0);
                               lbl_Gtl_No.Caption  := ECPlazaSeed.Decrypt(seed_gatl, common_seedkey);
  (* 분실핸드폰번호        *)  seed_mtno           := TMAX.RecvString('STR122',0);
                               edt_phone_no.Text   := delHyphen(ECPlazaSeed.Decrypt(seed_mtno, common_seedkey));
                               lbl_Mt_No.Caption   := ECPlazaSeed.Decrypt(seed_mtno, common_seedkey);
                               strGidNo := ECPlazaSeed.Decrypt(seed_gano, common_seedkey);
  (* 납부자주민사업자구분명*)  lbl_Nid_Gu.Caption  :=           TMAX.RecvString('STR124',0);
  (* 납부자주민사업자번호  *)  seed_nano           :=           TMAX.RecvString('STR125',0);
                               lbl_Nid_No.Caption  := InsHyphen(ECPlazaSeed.Decrypt(seed_nano, common_seedkey));
  (* 납부자성명(업체명)    *)  seed_nanm           :=           TMAX.RecvString('STR126',0);
                               lbl_Nid_Nm.Caption  := ECPlazaSeed.Decrypt(seed_nanm, common_seedkey);
  (* 납부자우편번호        *)  lbl_Npt_No.Caption  := InsHyphen(TMAX.RecvString('STR127',0));
  (* 납부자기본주소        *)  lbl_Nju_So.Caption  :=           TMAX.RecvString('STR128',0);
  (* 납부자상세주소        *)  lbl_NBo_so.Caption  :=           TMAX.RecvString('STR129',0);
  (* 납부자전화번호        *)  seed_natl           := TMAX.RecvString('STR130',0);
                               lbl_Ntl_No.Caption  := ECPlazaSeed.Decrypt(seed_natl, common_seedkey);
  (* 습득자명              *)  seed_gtnm           :=           TMAX.RecvString('STR134',0);
                               lbl_gt_nm.Caption   := ECPlazaSeed.Decrypt(seed_gtnm, common_seedkey);
                               strNidNo := ECPlazaSeed.Decrypt(seed_nano, common_seedkey);

//  if (TMAX.RecvString('STR131',0) = 'Y') then rb_dy_yes.Checked := True else rb_dy_no.Checked := True;
//  if (TMAX.RecvString('STR132',0) = 'Y') then rb_no_yes.Checked := True else rb_no_no.Checked := True;
  (* 가입자주민사업자구분  *)  //SetLabelCaption(            ,'STR114');
  (* 납부자주민사업자구분  *)  //SetLabelCaption(            ,'STR123');
  (* 보험금상태            *)  lbl_insu_sts.Caption  :=          TMAX.RecvString('STR135',0);
  (* 단말기상태            *)  lbl_Phone_sts.Caption :=          TMAX.RecvString('STR136',0);

  (* 재사용여부            *)  if(TMAX.RecvString('STR137',0) = '') then
                                   cmb_Zp_no.ItemIndex := 0
                               else
                                   cmb_Zp_no.ItemIndex := cmb_Zp_no.items.indexof(findNameFromCode(TMAX.RecvString('STR137',0),cmb_Zp_no_d,cmb_Zp_no.Items.Count));

  if (lbl_insu_sts.Caption = '보험금신청') then
    lbl_insu_sts.Font.Color  := clGreen
  else if (lbl_insu_sts.Caption = '보험금지급승인') then
    lbl_insu_sts.Font.Color   := clBlue
  else if (lbl_insu_sts.Caption = '보험금지급중지') then
    lbl_insu_sts.Font.Color   := clRed;

  sts_Message.Panels[1].Text := ' 조회 완료';

  chk1.Checked := false;

  pgm_sts1 := [1];

  //나머지 버튼 활성화
  btn_Add.Enabled     := True;
  btn_Update.Enabled  := True;
  btn_Delete.Enabled  := True;

LIQUIDATION:
    TMAX.InitBuffer;
  TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

  if ((lbl_insu_sts.Caption = '보험금신청'    ) or
      (lbl_insu_sts.Caption = '보험금지급승인') or
      (lbl_insu_sts.Caption = '단말기매각'    ))
  then
  begin
    rdo_Sh_No.Checked := True;
    frm_LOSTC100P_POP.lbl33.Caption       := lbl_insu_sts.Caption;
    //frm_LOSTC100P.Enabled := False;
    frm_LOSTC100P_POP.FormShow(Sender);
    //pnl_Command.Enabled := False;
    //Panel14.Enabled     := False;

    //pnl1.Enabled := True;
    //pnl1.Show;
  end;

end;

procedure Tfrm_LOSTC100P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
    if not recvedMessage then begin
        ShowMessage(''''+ 'LOSTZ820Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTC100P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - 호출구분          *)+ ' ' +  '01'
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

procedure Tfrm_LOSTC100P.FormShow(Sender: TObject);
begin

    //콤포넌트 초기화
    InitComponents;

    //'성명'으로 검색
    edt_Id_Nm.SetFocus;
    common_handle     := intToStr(self.Handle);

    // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능
    //if ParamStr(6) <> '' then   // 2016.06.21 수정
    if ParamStr(10) <> '' then
    begin
      edt_Id_Nm.Text        := fRNVL(ParamStr( 6));
      edt_birth_date.Text   := fRNVL( ParamStr( 7));
      md_cb1.Text           := fRNVL(ParamStr( 8));
      serial_edit.Text      := fRNVL(ParamStr( 9));
      dte_Ip_Dt.Text        := fRNVL(ParamStr(10));
      msk_Ju_No.Text        := fRNVL(ParamStr(11) + ParamStr(12)+ delHyphen(ParamStr(13)));
      edt_Id_No.Text        := fRNVL(ParamStr(14));

      btn_InquiryClick(Self);
    end;

end;

(******************************************************************************)
(* procedure name : btn_Addr_UpdateClick                                      *)
(* procedure 기능 : 주소수정  선택시 실행.                                    *)
(******************************************************************************)
procedure Tfrm_LOSTC100P.btn_Addr_UpdateClick(Sender: TObject);
begin

  if ( not fChkLength( md_cb1     , 1, 1,'모델코드'       )) then Exit;
  if ( not fChkLength( serial_edit, 1, 1,'단말기일련번호' )) then Exit;
  if ( not fChkLength( dte_Ip_Dt  , 1, 1,'입고일자'       )) then Exit;

  Self.Enabled := False;
  frm_LOSTC100P_ADDR.FormShow(Sender);

end;

function Tfrm_LOSTC100P.frtnRealIdNo(gbn : Integer) : String;
begin
  case gbn of
    0 : result := strGidNo;
    1 : result := strNidNo;
  end;
end;

procedure Tfrm_LOSTC100P.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // 외부 호출인 경우에만 실행 ex) LOSTA200Q 에서 본 프로그램 호출 가능
  if ParamStr(6) <> '' then
  begin
    PostMessage(StrToInt(common_caller), WM_LOSTPROJECT, 1, 0);
  end;
end;

procedure Tfrm_LOSTC100P.setEdtKeyPress;
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

procedure Tfrm_LOSTC100P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
  if (key = #13) then
    SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTC100P.btn_resetClick(Sender: TObject);
begin
  Self.InitComponents;
end;

procedure Tfrm_LOSTC100P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTC100P.btn_LinkClick(Sender: TObject);
var
  Value : array of string;

  commandStr:String;

  progID : string;

    ret:Integer;
begin
    progID := 'LOSTC110P';

    SetLength(Value, 7 );

    Value[0] := edt_Id_Nm.Text;
    Value[1] := edt_birth_date.Text;
    Value[2] := edt_phone_no.Text;
    Value[3] := md_cb1.Text;
    Value[4] := serial_edit.Text;
    Value[5] := dte_Ip_Dt.Text;
    Value[6] := msk_Ju_No.Text;

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
                  (* paramstr(11) -                  *)+ ' ' +  fNVL(Value[5])
                  (* paramstr(12) -                  *)+ ' ' +  fNVL(Value[6])
    ;

  ret := WinExec(PChar(commandStr), SW_Show);

  ShowWindow(Self.Handle, SW_HIDE);

  if ret <= 31 then
  begin

    MessageBeep (0);
        if ret = ERROR_FILE_NOT_FOUND then
            ShowMessage (''''+ progID +'.exe' +'''' + '을 찾을 수 없습니다')
        else
            ShowMessage (''''+ progID +'.exe' +'''' + ' 실행시 오류 발생');
    Self.Show;

    Exit;
  end;

  Self.Close;

end;

procedure Tfrm_LOSTC100P.rdo_Sh_NoClick(Sender: TObject);
begin
  dte_Bl_dt.Enabled := false;
end;

procedure Tfrm_LOSTC100P.rdo_Sh_YesClick(Sender: TObject);
begin

  if (lbl_insu_sts.Caption = '보험금지급승인') then
  begin
    if (common_usergroup = 'SYSM') then  dte_Bl_dt.Enabled := True
    else
      begin
        ShowMessage('보험금지급승인 처리된 단말기는 수취확인할 수 없습니다.');
        rdo_Sh_No.Checked := True;
      end;
  end else
    dte_Bl_dt.Enabled := True;

end;

procedure Tfrm_LOSTC100P.edt_Ju_YoClick(Sender: TObject);
begin
  // none
end;

procedure Tfrm_LOSTC100P.edt_Ju_YoEnter(Sender: TObject);
begin
 (sender as Tedit).SelStart := Length((Sender as TEdit).Text);
end;

procedure Tfrm_LOSTC100P.btn_search_srcClick(Sender: TObject);
begin
  if (Length(delHyphen(msk_Ju_No.Text)) <> 18) then
  begin
    ShowMessage('접수번호가 정상적이지 않습니다.');
    Exit;
  end;

  frm_LOSTC100P_INSU.Show;
end;

end.
