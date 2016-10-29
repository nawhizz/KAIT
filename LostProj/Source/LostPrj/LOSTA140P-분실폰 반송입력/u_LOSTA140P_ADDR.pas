unit u_LOSTA140P_ADDR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, checklst, cpakmsg,
  common_lib, so_tmax,localCloud, ComObj;

type
  Tfrm_LOSTA140P_ADDR = class(TForm)
    GroupBox3: TGroupBox;
    Bevel7: TBevel;
    Label7: TLabel;
    Bevel8: TBevel;
    Bevel26: TBevel;
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
    lbl_Gid_Gu: TLabel;
    Bevel30: TBevel;
    lbl_Gju_So: TLabel;
    Label8: TLabel;
    sts_Message: TStatusBar;
    msk_Gpt_No: TMaskEdit;
    edt_Gbo_So: TEdit;
    msk_Gtl_No: TMaskEdit;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label2: TLabel;
    Bevel5: TBevel;
    Label3: TLabel;
    Bevel6: TBevel;
    Label4: TLabel;
    Bevel9: TBevel;
    Label5: TLabel;
    Bevel10: TBevel;
    Label6: TLabel;
    lbl_Nid_Gu: TLabel;
    Bevel14: TBevel;
    lbl_Nju_So: TLabel;
    Label14: TLabel;
    msk_Npt_No: TMaskEdit;
    edt_Nbo_So: TEdit;
    msk_Ntl_No: TMaskEdit;
    pnl_Command: TPanel;
    edt_Gid_Nm: TEdit;
    edt_Nid_nm: TEdit;
    btn_GPostno_Inq: TBitBtn;
    btn_NPostno_Inq: TBitBtn;
    Bevel11: TBevel;
    lbl_Program_Name: TLabel;
    Bevel13: TBevel;
    Label9: TLabel;
    cmb_up_gu: TComboBox;
    msk_Gid_No: TMaskEdit;
    msk_Nid_No: TMaskEdit;
    TMAX: TTMAX;
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
    chk_ga_rodadr_yn: TCheckBox;
    chk_na_rodadr_yn: TCheckBox;


    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure msk_Gpt_NoKeyPress(Sender: TObject; var Key: Char);
    procedure msk_Npt_NoKeyPress(Sender: TObject; var Key: Char);
    procedure btn_UpdateClick(Sender: TObject);
    function ExecExternProg(progID:String):Boolean;
    //procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT;
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure btn_click(Sender: TObject);
    procedure onKeyDown(Sender: TObject; var Key: Char);
    procedure onEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InitComponents;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }

    recvedMessage:Boolean;

    //LOSTZ820Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;


  public
    { Public declarations }

  end;

var
  frm_LOSTA140P_ADDR: Tfrm_LOSTA140P_ADDR;
  gs_gid_gu,gs_nid_gu : String;
  callValue : Integer;


implementation
uses u_LOSTA140P;
{$R *.DFM}

procedure Tfrm_LOSTA140P_ADDR.btn_CloseClick(Sender: TObject);
  var
      Handle : HWND;
begin
  // 자식창 숨기고 부모창을 사용가능하게 하며 보여준다.
  Self.Hide;
  
  Handle := findwindow('Tfrm_LOSTA140P',nil);
  ShowWindow(Handle, SW_SHOW);
  ShowWindow(Handle, SW_RESTORE);
end;

procedure Tfrm_LOSTA140P_ADDR.FormShow(Sender: TObject);
var tempstr : shortstring;

begin
{ 코드 load }

  InitComponents;

  if( Length(delHyphen(frm_LOSTA140P.lbl_Gid_No.Caption)) = 13) then  gs_gid_gu := '1'
  else gs_gid_gu := '3';

  if( Length(delHyphen(frm_LOSTA140P.lbl_Nid_No.Caption)) = 13) then  gs_nid_gu := '1'
  else gs_nid_gu := '3';

  lbl_Gid_Gu.Caption := frm_LOSTA140P.lbl_Gid_Gu.Caption;

  if gs_gid_gu = '1' then
  begin
    msk_Gid_No.editmask := '999999-9999999;0;_' ;
    tempstr := copy(frm_LOSTA140P.lbl_Gid_No.Caption,1,6)
             + copy(frm_LOSTA140P.lbl_Gid_No.Caption,8,7);
  end
  else if gs_gid_gu = '3' then
  begin
    msk_Gid_No.editmask := '999-99-99999;0;_' ;
    tempstr := copy(frm_LOSTA140P.lbl_Gid_No.Caption,1,3)
             + copy(frm_LOSTA140P.lbl_Gid_No.Caption,5,2)
             + copy(frm_LOSTA140P.lbl_Gid_No.Caption,8,5);
  end
  else
  begin
    msk_Gid_No.editmask := '';
    msk_Gid_No.MaxLength := 16;
    tempstr := frm_LOSTA140P.lbl_Gid_No.Caption;
  end;
  msk_Gid_No.text := tempstr;

  edt_Gid_Nm.text    := frm_LOSTA140P.lbl_Gid_Nm.Caption;
  msk_Gpt_No.Text    := delHyphen(frm_LOSTA140P.lbl_Gpt_No.Caption);
  lbl_Gju_So.Caption := frm_LOSTA140P.lbl_Gju_So.Caption;
  edt_Gbo_so.Text    := trim(frm_LOSTA140P.lbl_Gbo_so.Caption);
  msk_Gtl_No.Text    := frm_LOSTA140P.lbl_Gtl_No.Caption;

  lbl_Nid_Gu.Caption := frm_LOSTA140P.lbl_Nid_Gu.Caption;
  if gs_nid_gu = '1' then
  begin
    msk_Nid_No.editmask := '999999-9999999;0;_' ;
    tempstr := copy(frm_LOSTA140P.lbl_Nid_No.Caption,1,6)
             + copy(frm_LOSTA140P.lbl_Nid_No.Caption,8,7);
  end
  else if gs_gid_gu = '3' then
  begin
    msk_Nid_No.editmask := '999-99-99999;0;_' ;
    tempstr := copy(frm_LOSTA140P.lbl_Nid_No.Caption,1,3)
             + copy(frm_LOSTA140P.lbl_Nid_No.Caption,5,2)
             + copy(frm_LOSTA140P.lbl_Nid_No.Caption,8,5);
  end
  else
  begin
    msk_Nid_No.editmask := '';
    msk_Nid_No.MaxLength := 16;
    tempstr := frm_LOSTA140P.lbl_Nid_No.Caption;
  end;
  msk_Nid_No.text := tempstr;

  edt_Nid_Nm.text    := frm_LOSTA140P.lbl_Nid_Nm.Caption;
  msk_Npt_No.Text    := delHyphen(frm_LOSTA140P.lbl_Npt_No.Caption);
  lbl_Nju_So.Caption := frm_LOSTA140P.lbl_Nju_So.Caption;
  edt_Nbo_so.Text    := trim(frm_LOSTA140P.lbl_Nbo_so.Caption);
  msk_Ntl_No.Text    := frm_LOSTA140P.lbl_Ntl_no.Caption;

  itemNo := '1';

  changeBtn(Self);

  btn_Delete.Enabled  := false;
  btn_Add.Enabled     := false;
  btn_reset.Enabled   := false;

//   if trim(gs_up_gu) = '' then
//      cmb_up_gu.itemindex := -1
//   else
//   begin
//      cmb_up_gu.itemindex := strtoint(gs_up_gu) - 1;
//   end;

   frm_LOSTA140P.enabled := false;
end;

procedure Tfrm_LOSTA140P_ADDR.FormHide(Sender: TObject);
begin
   frm_LOSTA140P.Enabled := true;
end;

procedure Tfrm_LOSTA140P_ADDR.msk_Gpt_NoKeyPress(Sender: TObject;
  var Key: Char);
begin
msk_Gpt_no.OnKeyPress := nil;

   if key = #13 then
   begin

   end;

   msk_Gpt_no.OnKeyPress := msk_Gpt_noKeyPress;

end;

procedure Tfrm_LOSTA140P_ADDR.msk_Npt_NoKeyPress(Sender: TObject;
  var Key: Char);
begin
msk_Npt_no.OnKeyPress := nil;
   if key = #13 then
   begin

   end;

  msk_Npt_no.OnKeyPress := msk_Npt_noKeyPress;

end;

procedure Tfrm_LOSTA140P_ADDR.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin
  bitBtn := nil;
  mskEdt := nil;
  
    if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit)) then
    begin
      if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
      else  mskEdt := Sender as TMaskEdit;

      if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = msk_Gpt_No ) then
        begin
          callValue := 0;
          value1 := msk_Gpt_No.Text;
        end
      else if(bitBtn = btn_NPostno_Inq) or (mskEdt = msk_Npt_No ) then
        begin
          callValue := 1;
          value1 := msk_Npt_No.Text;
        end
    end;

  CreateMap;	//공유메모리 생성

  // 도로명주소 체크에 따라 우편번호 팝업 선택
  if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = msk_Gpt_No ) then
    begin
      if (chk_ga_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
      else self.ExecExternProg('LOSTZ800Q');
    end
  else if(bitBtn = btn_NPostno_Inq) or ( mskEdt = msk_Npt_No ) then
    begin
      if (chk_na_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
      else self.ExecExternProg('LOSTZ800Q');
    end;

end;

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTA140P_ADDR.ExecExternProg(progID:String):Boolean;
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

//'LOSTZ810Q.exe'에서 메세지를 던져준다.
procedure Tfrm_LOSTA140P_ADDR.Link_rtn (var Msg : TMessage);
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

      if(callValue = 0 ) then
        begin
          msk_gPt_No.Text        := smem^.po_no;			    //성명(업체명)
          lbl_Gju_so.Caption     := smem^.ju_so;	        //모델명
          //msk_Gtl_No.Text        := smem^.ddd_no;	        //단말기일련번호
        end else
        begin
          msk_Npt_No.Text        := smem^.po_no;			    //성명(업체명)
          lbl_Nju_So.Caption     := smem^.ju_so;	        //모델명
          //msk_Ntl_No.Text        := smem^.ddd_no;	        //단말기일련번호
        end;

      //if edt_phone_no.EditText = '' then edt_phone_no.EditText := '   -    -    ';

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    edt_Gbo_So.SetFocus;

  end;
end;

procedure Tfrm_LOSTA140P_ADDR.onKeyDown(Sender: TObject; var Key: Char);
begin
	if Key <> #13 then 	//엔터키가 아니면
    	exit;

  btn_click(Sender);
end;

procedure Tfrm_LOSTA140P_ADDR.btn_UpdateClick(Sender: TObject);

var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_tmp : String;

  STRVALUE : array[1..18] of string;
  i : Integer;
  STRNUM : string;

LABEL LIQUIDATION;

begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  // 입력필드 체크
  if (not fChkLength(edt_Gid_Nm,1,1,'성명/업체명'                 )) then Exit;
  //if (not fChkLength(msk_Gpt_No,6,0,'우편번호'                    )) then Exit;
  if (not fChkLength(edt_Gbo_So,1,1,'보조주소'                    )) then Exit;
  if (not fChkLength(msk_Gtl_No,8,1,'전화번호'                    )) then Exit;
  //if (not fChkLength(msk_Nid_No,13,0,'주민/사업자등록/외국인번호' )) then Exit;
//  if (not fChkLength(edt_Nid_nm,1,1,'성명/업체명'                 )) then Exit;
//  if (not fChkLength(msk_Npt_No,6,0,'우편번호'                    )) then Exit;
//  if (not fChkLength(edt_Nbo_So,1,1,'보조주소'                    )) then Exit;
//  if (not fChkLength(msk_Ntl_No,8,1,'전화번호'                    )) then Exit;

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

  FillChar(STRVALUE, SizeOf(STRVALUE),#0);

  i := 0;

  (*  모델코드            *)STRVALUE[ 1] := frm_LOSTA140P.edt_md_cd.Text;
  (*  단말기일련번호      *)STRVALUE[ 2] := frm_LOSTA140P.serial_edit.Text;
  (*  입고일자            *)STRVALUE[ 3] := delHyphen(frm_LOSTA140P.dte_Ip_Dt.Text);
  (*  수정구분코드        *)STRVALUE[ 4] := IntToStr(cmb_up_gu.itemIndex + 1);
  (*  가입자구분코드      *)STRVALUE[ 5] := gs_gid_gu;

//  if (delHyphen(Trim(frm_LOSTA140P.lbl_Gid_No.Caption)) <> delHyphen(Trim(msk_Gid_No.Text))) then
//        STRVALUE[ 6] := delHyphen(msk_Gid_No.Text )
//  else  STRVALUE[ 6] := frm_LOSTA140P.frtnRealIdNo(0);
  str_tmp      := delHyphen(msk_Gid_No.Text );
  STRVALUE[ 6] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);

  (*  가입자성명(업체명)  *)str_tmp      := edt_Gid_Nm.Text;
                            STRVALUE[ 7] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*  가입자우편번호      *)STRVALUE[ 8] := delHyphen(msk_Gpt_No.Text);
  (*  가입자기본주소      *)STRVALUE[ 9] := lbl_Gju_So.Caption;
  (*  가입자상세주소      *)STRVALUE[10] := edt_Gbo_So.Text;

  (*  가입자전화번호      *)str_tmp      := delHyphen(msk_Gtl_No.Text);
                            STRVALUE[11] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*  납부자구분코드      *)STRVALUE[12] := gs_nid_gu;

  (*  납부자주민사업자    *)
//  if (delHyphen(Trim(frm_LOSTA140P.lbl_Nid_No.Caption)) <> delHyphen(Trim(msk_Nid_No.Text))) then
//       STRVALUE[13] := delHyphen(msk_Nid_No.Text )
//  else STRVALUE[13] := frm_LOSTA140P.frtnRealIdNo(1);

  str_tmp      := delHyphen(msk_Nid_No.Text );
  STRVALUE[13] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);

  (*  납부자성명(업체명)  *)str_tmp      := edt_Nid_nm.Text;
                            STRVALUE[14] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);
  (*  납부자우편번호      *)STRVALUE[15] := delHyphen(msk_Npt_No.Text);
  (*  납부자기본주소      *)STRVALUE[16] := lbl_Nju_So.Caption;
  (*  납부자상세주소      *)STRVALUE[17] := edt_Nbo_So.Text;
  (*  납부자전화번호      *)str_tmp      := delHyphen(msk_Ntl_No.Text);
                            STRVALUE[18] := ECPlazaSeed.Encrypt(str_tmp, common_seedkey);

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA140P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U02')   < 0) then  goto LIQUIDATION;

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
	if not TMAX.Call('LOSTA140P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
      ShowMessage('성공적으로 수정되었습니다.');
      sts_Message.Panels[1].Text := ' 수정 완료';
      frm_LOSTA140P.btn_InquiryClick(self);
    end;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTA140P_ADDR.onEnter(Sender: TObject);
begin
  if (Sender is TMaskEdit) then
  begin
    (Sender as TMaskEdit).SelStart := Length((Sender as TMaskEdit).EditText);
  end;


  if (Sender is TEdit) then
  begin
    (Sender as TEdit).SelStart := Length((Sender as TEdit).Text);
  end;
end;

procedure Tfrm_LOSTA140P_ADDR.FormCreate(Sender: TObject);
begin

  fSetIcon(Application);
  pSetStsWidth(sts_Message);
  //pSetTxtSelAll(Self);

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     := poScreenCenter;
  
  edt_Gid_Nm.OnEnter := self.onEnter;
  msk_Gid_No.OnEnter := self.onEnter;
  msk_Gpt_No.OnEnter := self.onEnter;
  msk_Gtl_No.OnEnter := self.onEnter;
  edt_Gbo_So.OnEnter := self.onEnter;
  edt_Nid_nm.OnEnter := self.onEnter;
  msk_Npt_No.OnEnter := self.onEnter;
  msk_Nid_No.OnEnter := self.onEnter;
  edt_Nbo_So.OnEnter := self.onEnter;
  msk_Ntl_No.OnEnter := self.onEnter;

  chk_ga_rodadr_yn.Checked := True;
  chk_na_rodadr_yn.Checked := True;

end;

procedure Tfrm_LOSTA140P_ADDR.InitComponents;
begin
  changeBtn(self);
  sts_Message.Panels[1].text := '';
end;

procedure Tfrm_LOSTA140P_ADDR.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
      Handle : HWND;

begin
  Handle := findwindow('Tfrm_LOSTA140P',nil);
  ShowWindow(Handle, SW_SHOW);
  ShowWindow(Handle, SW_RESTORE);
end;

end.
