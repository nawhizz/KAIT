{*---------------------------------------------------------------------------
프로그램ID    : LOSTA760P (경찰서습득단말기 국고귀속 출고취소 입력)
프로그램 종류 : Online
작성자	      : 유 영 배
작성일	      : 2013. 10. 28
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
unit u_LOSTA760P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  Grids, Menus, WinSkinData, so_tmax, common_lib, localCloud, ComObj;

const
  TITLE   = '경찰서습득단말기 국고귀속 출고취소 입력';
  PGM_ID  = 'LOSTA760P';

type
  Tfrm_LOSTA760P = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    GroupBox3: TGroupBox;
    Bevel20: TBevel;
    Label20: TLabel;
    Bevel21: TBevel;
    Label21: TLabel;
    Bevel22: TBevel;
    Label22: TLabel;
    Bevel23: TBevel;
    Label23: TLabel;
    Bevel24: TBevel;
    Label24: TLabel;
    Bevel27: TBevel;
    Bevel28: TBevel;
    Bevel29: TBevel;
    lbl_Pt_No: TLabel;
    Bevel30: TBevel;
    Bevel7: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel8: TBevel;
    lbl_Bo_So: TLabel;
    Bevel9: TBevel;
    lbl_Tl_No: TLabel;
    Bevel10: TBevel;
    Bevel26: TBevel;
    lbl_Bl_Dt: TLabel;
    Bevel5: TBevel;
    Label5: TLabel;
    Bevel6: TBevel;
    lbl_Ph_Cd: TLabel;
    Bevel11: TBevel;
    Label11: TLabel;
    Bevel12: TBevel;
    lbl_Lt_Gu: TLabel;
    lbl_Lt_Nm: TLabel;
    lbl_Ju_So: TLabel;
    lbl_Lt_No: TLabel;
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
    mnuLnk: TPopupMenu;
    N13: TMenuItem;
    md_grid1: TStringGrid;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel2: TPanel;
    Bevel18: TBevel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label1: TLabel;
    Label10: TLabel;
    Bevel16: TBevel;
    Label15: TLabel;
    Bevel3: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Bevel45: TBevel;
    Label25: TLabel;
    edt_Id_Nm: TEdit;
    dte_Ip_Dt: TDateEdit;
    btn1: TBitBtn;
    md_cb1: TComboEdit;
    serial_edit: TEdit;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btn4: TBitBtn;
    edt_birth_date: TEdit;
    edt_phone_no: TMaskEdit;
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
  private
    { Private declarations }
    cmb_Cl_Gu_d,md_grid1_d :TZ0xxArray;

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
  end;

  (* PGM_STS : 프로그램 상태  *)
  (* 0 : 조회전               *)
  (* 1 : 조회후               *)
  (* 2,3 : 여유분             *)
  PGM_STS = set of 0..3;

var
  frm_LOSTA760P: Tfrm_LOSTA760P;

  pgm_sts1   : PGM_STS;

implementation
uses cpaklibm, Clipbrd;
{$R *.DFM}

function Tfrm_LOSTA760P.keyCheck:boolean;
begin
	result:= True;
    if (Trim(md_cb1.Text) ='') or (Trim(serial_edit.Text) ='') or (Trim(delHyphen(dte_Ip_Dt.Text))='')  then
      begin
        ShowMessage('모델명, 시리얼번호 및 입고일자를 입력하세요');
        result := false;
      end;
end;

procedure Tfrm_LOSTA760P.AttachOnKeyPressEvent;
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
procedure Tfrm_LOSTA760P.OnKeyPress(Sender: TObject; var Key: Char);
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
procedure Tfrm_LOSTA760P.OnSearchClick(Sender:TObject);
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
procedure Tfrm_LOSTA760P.OnExit(Sender:TObject);
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
procedure Tfrm_LOSTA760P.DetachOnEnterEvent;
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
procedure Tfrm_LOSTA760P.AttachOnExitEvent;
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
procedure Tfrm_LOSTA760P.AttachOnEnterEvent;
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
procedure Tfrm_LOSTA760P.OnEnter(Sender:TObject);
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
procedure Tfrm_LOSTA760P.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTA760P.Link_rtn (var Msg : TMessage);
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
procedure Tfrm_LOSTA760P.md_cb1ButtonClick(Sender: TObject);
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
procedure Tfrm_LOSTA760P.md_cb1KeyUp(Sender: TObject; var Key: Word;
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
procedure Tfrm_LOSTA760P.md_grid1Click(Sender: TObject);
begin
   md_cb1.text := md_grid1.Cells[0,md_grid1.row];
   md_cb1.SetFocus;
   md_grid1.Visible := false;
end;


procedure Tfrm_LOSTA760P.FormCreate(Sender: TObject);
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
  //common_userid     := '0294';    //ParamStr(2);
  //common_username   := '정호영';  //ParamStr(3);
  //common_usergroup  := 'KAIT';    //ParamStr(4);

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

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure 기 능 : 폼에사용한 컴퍼넌트를 초기화한다.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTA760P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin

  edt_Id_Nm.Text      := '';
  edt_birth_date.Text := '';
  edt_phone_no.Text   := '';
  md_cb1.Text         := '';
  serial_edit.Text    := '';
  dte_Ip_Dt.Text      := '';

  changeBtn(Self);
  
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos('lbl_',(component as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(component as TLabel).Name) = 0)
        then (component as TLabel).Caption := '';
  end;

  //초기화
  setItemNo('1');

  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;


  //처음 실행시 윈도우 클로즈 돕기 위해
  recvedMessage:= True;

  dte_Ip_Dt.Date  := date;

  md_grid1.Row    := 0;
  md_cb1.Text     := md_grid1.Cells[0,md_grid1.Row];

  pgm_sts1 := [0];    
end;

procedure Tfrm_LOSTA760P.btn_AddClick(Sender: TObject);

var
	STR004,STR005:String;
  svcNm , Msg: string;

  LABEL LIQUIDATION;


begin

	if not keyCheck then
    	exit;

  STR004 := '';
  STR005 := '';

  if ((Sender as TSpeedButton) = btn_Add) then svcNm := 'I01'
  else if (Sender as TSpeedButton) = btn_Update then svcNm := 'U01'else svcNm := 'D01';



  // 건수 별 재조회를 위한 데이터 변수 설정
  STR001 := findCodeFromName(md_cb1.Text, md_grid1_d, md_grid1.RowCount);	      //모델코드 md_cb1
  STR002 := serial_edit.Text;			                                              //단말기일련번호    serial_edit
  STR003 := delHyphen(dte_Ip_Dt.Text);	                                          //입고일자  dte_Ip_Dt

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
	if (TMAX.SendString('INF003','LOSTA760P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001',svcNm)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', STR004) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', STR005) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA760P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  if ((Sender as TSpeedButton) = btn_Add) then Msg := '등록'
  else if (Sender as TSpeedButton) = btn_Update then Msg := '수정'
  else Msg := '삭제';

  ShowMessage('정상 ' + Msg + '되었습니다.');

  sts_Message.Panels[1].Text := Msg + '완료';

  pgm_sts1 := [0];

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;
end;

//'수정' 버튼 클릭
procedure Tfrm_LOSTA760P.btn_UpdateClick(Sender: TObject);
begin
  btn_AddClick(Sender);
end;

procedure Tfrm_LOSTA760P.btn_DeleteClick(Sender: TObject);
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


procedure Tfrm_LOSTA760P.btn_InquiryClick(Sender: TObject);
var
    // 암호화 관련 변수
    ECPlazaSeed: OLEVariant;
    seed_gano, seed_ganm, seed_gatl, seed_mtno : String;

    Label LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  seed_gano := '';
  seed_ganm := '';
  seed_gatl := '';
  seed_mtno := '';

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA760P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTA760P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  (* 모델코드                *)   //                :=           Trim(TMAX.RecvString('STR101',0));
  (* 모델명                  *)   md_cb1.Text       :=           Trim(TMAX.RecvString('STR102',0));
  (* 단말기일련번호          *)   serial_edit.Text  :=           Trim(TMAX.RecvString('STR103',0));
  (* 입고일자                *)   dte_Ip_Dt.Text    := InsHyphen(Trim(TMAX.RecvString('STR104',0)));
  (* 단말기종류코드          *)   //                :=           Trim(TMAX.RecvString('STR105',0));
  (* 단말기종류              *)   lbl_Ph_Gb.Caption :=           Trim(TMAX.RecvString('STR106',0));
  (* 발송예정일              *)   lbl_Bl_Dt.Caption := InsHyphen(Trim(TMAX.RecvString('STR107',0)));
  (* 단말기상태코드          *)   //                :=           Trim(TMAX.RecvString('STR108',0));
  (* 단말기상태              *)   lbl_Ph_Cd.Caption :=           Trim(TMAX.RecvString('STR109',0));
  (* 창고일련번호            *)   lbl_Cg_No.Caption :=           Trim(TMAX.RecvString('STR110',0));
  (* 가입자주민사업자구분코드*)   //                :=           Trim(TMAX.RecvString('STR111',0));
  (* 가입자주민사업자구분    *)   lbl_Lt_Gu.Caption :=           Trim(TMAX.RecvString('STR112',0));
  (* 가입자주민사업자번호    *)   seed_gano := TMAX.RecvString('STR113',0);
                                  lbl_Lt_No.Caption :=           Trim(ECPlazaSeed.Decrypt(seed_gano, common_seedkey));
  (* 가입자성명(업체명)      *)   seed_ganm := TMAX.RecvString('STR114',0);
                                  lbl_Lt_Nm.Caption :=           Trim(ECPlazaSeed.Decrypt(seed_ganm, common_seedkey));
  (* 가입자우편번호          *)   lbl_Pt_No.Caption := InsHyphen(Trim(TMAX.RecvString('STR115',0)));
  (* 가입자기본주소          *)   lbl_Ju_So.Caption :=           Trim(TMAX.RecvString('STR116',0));
  (* 가입자상세주소          *)   lbl_Bo_So.Caption :=           Trim(TMAX.RecvString('STR117',0));
  (* 가입자전화번호          *)   seed_gatl := TMAX.RecvString('STR118',0);
                                  lbl_Tl_No.Caption := InsHyphen(Trim(ECPlazaSeed.Decrypt(seed_gatl, common_seedkey)));
  (* 출고입력자ID            *)   lbl_Cl_Id.Caption :=           Trim(TMAX.RecvString('STR119',0));
  (* 출고입력자              *)   //                             Trim(TMAX.RecvString('STR120',0));

  sts_Message.Panels[1].Text := ' 조회 완료';

  //너머지 버튼 활성화
  btn_Add.Enabled     := True;

  pgm_sts1 := [1];    

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA760P.btn_CloseClick(Sender: TObject);
begin
    //호출한 APP가 살이 있으면 메세지....
	if not recvedMessage then begin
    	ShowMessage(''''+ 'LOSTZ810Q.exe' +''''+'를 먼저 종료 하십시오.');
      exit;
  end;

  close;
end;

//On-Exit (입고일자)
procedure Tfrm_LOSTA760P.dte_Ip_DtExit(Sender: TObject);
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
function Tfrm_LOSTA760P.ExecExternProg(progID:String):Boolean;
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
                (* paramstr(6) - 호출구분          *)+ ' ' +  '22'
                (* paramstr(7) - 호출 컴퍼넌트 변수*)+ ' ' +  itemNo
                (* paramstr(8) - 조건 변수 1       *)+ ' ' +  fNVL(value1)
                (* paramstr(9) - 조건 변수 2       *)+ ' ' +  fNVL(value2)
  ;

	ret := WinExec(PChar(commandStr), SW_Show);

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

procedure Tfrm_LOSTA760P.FormShow(Sender: TObject);
begin
  //콤포넌트 초기화
  InitComponents;
end;

procedure Tfrm_LOSTA760P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

end.
