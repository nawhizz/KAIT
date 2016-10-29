unit u_LOSTC100P_ADDR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, checklst, cpakmsg, so_tmax,
  localCloud,common_lib, ComObj;

type
  Tfrm_LOSTC100P_ADDR = class(TForm)
    Bevel7     : TBevel;
    Bevel8     : TBevel;
    Bevel26    : TBevel;
    Bevel20    : TBevel;
    Bevel21    : TBevel;
    Bevel22    : TBevel;
    Bevel23    : TBevel;
    Bevel24    : TBevel;
    Bevel30    : TBevel;
    Bevel1     : TBevel;
    Bevel2     : TBevel;
    Bevel3     : TBevel;
    Bevel4     : TBevel;
    Bevel5     : TBevel;
    Bevel6     : TBevel;
    Bevel9     : TBevel;
    Bevel10    : TBevel;
    Bevel14    : TBevel;
    Bevel11    : TBevel;
    btn_NPostno_Inq: TBitBtn;
    btn_GPostno_Inq: TBitBtn;
    edt_Nid_nm : TEdit;
    edt_Gbo_So : TEdit;
    edt_Nbo_So : TEdit;
    edt_Gid_Nm : TEdit;
    GroupBox1  : TGroupBox;
    GroupBox3  : TGroupBox;
    Label20    : TLabel;
    Label3     : TLabel;
    lbl_Gju_So : TLabel;
    Label4     : TLabel;
    Label8     : TLabel;
    Label5     : TLabel;
    Label22    : TLabel;
    Label6     : TLabel;
    lbl_Nid_Gu : TLabel;
    Label7     : TLabel;
    lbl_Nju_So : TLabel;
    Label14    : TLabel;
    Label23    : TLabel;
    Label1     : TLabel;
    Label21    : TLabel;
    Label24    : TLabel;
    lbl_Gid_Gu : TLabel;
    Label2     : TLabel;
    lbl_Program_Name: TLabel;
    msk_Gtl_No : TMaskEdit;
    msk_Ntl_No : TMaskEdit;
    msk_Gpt_No : TMaskEdit;
    msk_Npt_No : TMaskEdit;
    msk_Gid_No : TMaskEdit;
    msk_Nid_No : TMaskEdit;
    pnl_Command: TPanel;
    sts_Message: TStatusBar;
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
    function  ExecExternProg(progID:String):Boolean;
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure btn_click(Sender: TObject);
    procedure onKeyDown(Sender: TObject; var Key: Char);
    procedure btn_UpdateClick(Sender: TObject);
    procedure SetItemNo(number:String);
    procedure FormCreate(Sender: TObject);
    procedure onEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure onClick(Sender:TObject);
    procedure chk_ga_rodadr_ynClick(Sender: TObject);
    procedure chk_na_rodadr_ynClick(Sender: TObject);

  private
    { Private declarations }

    recvedMessage:Boolean;

    //LOSTZ820Q.exe 호출시 사용
    itemNo        :String;
    value1, value2:String;
  public
    { Public declarations }
     //procedure Link_rtn (var Msg:TMessage); message WM_LINK;
  end;

var
  frm_LOSTC100P_ADDR: Tfrm_LOSTC100P_ADDR;
  gs_gid_gu ,gs_nid_gu: Integer;
  callValue : Integer;

implementation
uses cpaklibm, u_LOSTC100P;
{$R *.DFM}

procedure Tfrm_LOSTC100P_ADDR.btn_CloseClick(Sender: TObject);
begin
  // 자식창 숨기고 부모창을 사용가능하게 하며 보여준다.
   self.hide;
   frm_LOSTC100P.Enabled := True;
   frm_LOSTC100P.Show;
end;

(******************************************************************************)
(* procedure Name : FormShow                                                  *)
(* procedure 기능 : 폼이 보여질 시 수행됨                                     *)
(******************************************************************************)
procedure Tfrm_LOSTC100P_ADDR.FormShow(Sender: TObject);
var tempstr : shortstring;
begin
  changeBtn(Self);

  btn_Print.Enabled := False;  

  Self.Show;

  btn_Delete.Enabled  := False;
  btn_Add.Enabled     := False;
  btn_Inquiry.Enabled := False;
  btn_reset.Enabled   := False;

  // 호출 대상에 대한 변수 초기값 : 0
  callValue := 0;

  common_handle     := intToStr(self.Handle);

  if( Length(frm_LOSTC100P.lbl_Gid_No.Caption) = 14 ) or
    ( Length(frm_LOSTC100P.lbl_Gid_No.Caption) = 0 )
  then gs_gid_gu := 1 else gs_gid_gu := 3;



  // 가입자 구분을 parent 폼에서 가져와서 설정함
  lbl_Gid_Gu.Caption := frm_LOSTC100P.lbl_Gid_Gu.Caption;

  // 가입자구분이 '개인' 일 경우 주민번호 형식으로 설정함
  if gs_gid_gu = 1 then
  begin
    msk_Gid_No.editmask := '999999-9999999;0;_' ;
    tempstr := delHyphen(InsHyphen(frm_LOSTC100P.lbl_Gid_No.Caption));
  end
  // 가입자가 사업자일 경우 사업자 형식으로 설정함
  else if gs_gid_gu = 3 then
  begin
    msk_Gid_No.editmask := '999-99-99999;0;_' ;
    tempstr := copy(frm_LOSTC100P.lbl_Gid_No.Caption,1,3)
             + copy(frm_LOSTC100P.lbl_Gid_No.Caption,5,2)
             + copy(frm_LOSTC100P.lbl_Gid_No.Caption,8,5);
  end
  else
  // 제외적일때 설정
  begin
    msk_Gid_No.editmask   := '';
    msk_Gid_No.MaxLength  := 16;
    tempstr := frm_LOSTC100P.lbl_Gid_No.Caption;
  end;

  // 주민번호를 설정함
  msk_Gid_No.text := tempstr;

  // 부모페이지의 정보를 가져와서 보여줌(가입자)
  edt_Gid_Nm.text    := frm_LOSTC100P.lbl_Gid_Nm.Caption;                 // 가입자명
  msk_Gpt_No.Text    := CNumOnly(frm_LOSTC100P.lbl_Gpt_No.Caption);       // 우편번호
  lbl_Gju_So.Caption := frm_LOSTC100P.lbl_Gju_So.Caption;                 // 주소
  edt_Gbo_so.Text    := trim(frm_LOSTC100P.lbl_Gbo_so.Caption);           // 보조주소
  msk_Gtl_No.Text    := delHyphen(frm_LOSTC100P.lbl_Gtl_No.Caption);      // 전화번호

  // 납부자 정보를 parent 폼에서 가져와서 설정함
  lbl_Nid_Gu.Caption := frm_LOSTC100P.lbl_Nid_Gu.Caption;

  if( Length(frm_LOSTC100P.lbl_Nid_No.Caption) = 14 ) or
    ( Length(frm_LOSTC100P.lbl_Nid_No.Caption) = 0 )
  then gs_nid_gu := 1 else gs_nid_gu := 3;

  if gs_nid_gu = 1 then
   begin
      msk_Nid_No.editmask := '999999-9999999;0;_' ;
      tempstr := delHyphen(InsHyphen(frm_LOSTC100P.lbl_Nid_No.Caption));
   end
  else if gs_nid_gu = 3 then
   begin
      msk_Nid_No.editmask := '999-99-99999;0;_' ;
      tempstr := copy(frm_LOSTC100P.lbl_Nid_No.Caption,1,3)
               + copy(frm_LOSTC100P.lbl_Nid_No.Caption,5,2)
               + copy(frm_LOSTC100P.lbl_Nid_No.Caption,8,5);
   end
  else
  begin
    msk_Nid_No.editmask := '';
    msk_Nid_No.MaxLength := 16;
    tempstr := frm_LOSTC100P.lbl_Nid_No.Caption;
  end;

  msk_Nid_No.text := tempstr;

  edt_Nid_Nm.text      := frm_LOSTC100P.lbl_Nid_Nm.Caption;
  msk_Npt_No.Text      := CNumOnly(frm_LOSTC100P.lbl_Npt_No.Caption);
  lbl_Nju_So.Caption   := frm_LOSTC100P.lbl_Nju_So.Caption;
  edt_Nbo_so.Text      := trim(frm_LOSTC100P.lbl_Nbo_so.Caption);
  msk_Ntl_No.Text      := delHyphen(frm_LOSTC100P.lbl_Ntl_No.Caption);

  sts_Message.Panels[1].text  := '';
  frm_LOSTC100P.enabled       := false;

  //초기화
  setItemNo('1');
end;

procedure Tfrm_LOSTC100P_ADDR.FormHide(Sender: TObject);
begin
   frm_LOSTC100P.Enabled := true;
end;

procedure Tfrm_LOSTC100P_ADDR.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
  chkBox : TCheckBox;
begin
  bitBtn := nil;
  mskEdt := nil;
  chkBox := nil;

    if ((Sender.ClassType = TBitBtn) or ( Sender.ClassType = TMaskEdit) or ( Sender.ClassType = TCheckBox)) then
    begin
      if (Sender.ClassType = TBitBtn) then bitBtn := Sender as TBitBtn
      else if (Sender.ClassType = TMaskEdit) then mskEdt := Sender as TMaskEdit
      else chkBox := Sender as TCheckBox;

      if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = msk_Gpt_No ) or ( chkBox = chk_ga_rodadr_yn ) then
        begin
          callValue := 0;
          value1 := msk_Gpt_No.Text;
        end
      else if(bitBtn = btn_NPostno_Inq) or (mskEdt = msk_Npt_No ) or ( chkBox = chk_na_rodadr_yn ) then
        begin
          callValue := 1;
          value1 := msk_Npt_No.Text;
        end
    end;

  CreateMap;	//공유메모리 생성

  // 도로명주소 체크에 따라 우편번호 팝업 선택
  if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = msk_Gpt_No ) or ( chkBox = chk_ga_rodadr_yn ) then
    begin
      if (chk_ga_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
      else self.ExecExternProg('LOSTZ800Q');
    end
  else if(bitBtn = btn_NPostno_Inq) or ( mskEdt = msk_Npt_No ) or ( chkBox = chk_na_rodadr_yn ) then
    begin
      if (chk_na_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
      else self.ExecExternProg('LOSTZ800Q');
    end;

end;
//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTC100P_ADDR.ExecExternProg(progID:String):Boolean;
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
procedure Tfrm_LOSTC100P_ADDR.Link_rtn (var Msg : TMessage);
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

    //edt_Gbo_So.SetFocus;
    if(callValue = 0 ) then
        edt_Gbo_So.SetFocus
    else
        edt_Nbo_So.SetFocus;

  end;
end;

procedure Tfrm_LOSTC100P_ADDR.onKeyDown(Sender: TObject; var Key: Char);
begin
	if Key <> #13 then 	//엔터키가 아니면
    	exit;

  btn_click(Sender);
end;


procedure Tfrm_LOSTC100P_ADDR.btn_UpdateClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_gid_no, str_frtnRealIdNo, str_gid_nm, str_gtl_no, str_nid_no, str_nid_nm, str_ntl_no : String;
  seed_ganm, seed_gano, seed_gatl, seed_mtno, seed_nanm, seed_nano, seed_natl : String;

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid)     < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC100P')       < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U02')   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', Copy(frm_LOSTC100P.msk_Ju_No.Text, 1,6)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', Copy(frm_LOSTC100P.msk_Ju_No.Text, 7,8)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', Copy(frm_LOSTC100P.msk_Ju_No.Text,15,4)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', IntToStr(gs_gid_gu) ) < 0) then  goto LIQUIDATION;

  // 주민번호 체크
  if (delHyphen(Trim(frm_LOSTC100P.lbl_Gid_No.Caption)) <> delHyphen(Trim(msk_Gid_No.Text))) then
    begin
        str_gid_no := delHyphen(msk_Gid_No.Text );
        seed_gano := ECPlazaSeed.Encrypt(str_gid_no, common_seedkey);
        if (TMAX.SendString('STR005', seed_gano) < 0) then  goto LIQUIDATION;
    end
  else
    begin
       str_frtnRealIdNo := frm_LOSTC100P.frtnRealIdNo(0);
       seed_gano := ECPlazaSeed.Encrypt(str_frtnRealIdNo, common_seedkey);
       if (TMAX.SendString('STR005', seed_gano ) < 0) then  goto LIQUIDATION;
    end;

  str_gid_nm := Trim(edt_gid_nm.text);
  seed_ganm := ECPlazaSeed.Encrypt(str_gid_nm, common_seedkey);
	if (TMAX.SendString('STR006', seed_ganm           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', msk_Gpt_No.Text     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', lbl_Gju_so.caption  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', edt_GBo_so.text     ) < 0) then  goto LIQUIDATION;

  str_gtl_no := Trim(msk_Gtl_No.text);
  seed_gatl := ECPlazaSeed.Encrypt(str_gtl_no, common_seedkey);
	if (TMAX.SendString('STR010', seed_gatl           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR011', IntToStr(gs_Nid_gu) ) < 0) then  goto LIQUIDATION;

  // 주민번호 체크
  if (delHyphen(Trim(frm_LOSTC100P.lbl_Nid_No.Caption)) <> delHyphen(Trim(msk_Nid_No.Text))) then
  begin
      str_nid_no := delHyphen(msk_Nid_No.Text );
      seed_nano := ECPlazaSeed.Encrypt(str_nid_no, common_seedkey);
    	if (TMAX.SendString('STR012', seed_nano) < 0) then  goto LIQUIDATION;
  end
  else
  begin
     str_frtnRealIdNo := frm_LOSTC100P.frtnRealIdNo(1);
     seed_nano := ECPlazaSeed.Encrypt(str_frtnRealIdNo, common_seedkey);
     if (TMAX.SendString('STR012', seed_nano ) < 0) then  goto LIQUIDATION;
  end;

  str_nid_nm := Trim(edt_Nid_nm.text);
  seed_nanm := ECPlazaSeed.Encrypt(str_nid_nm, common_seedkey);
	if (TMAX.SendString('STR013', seed_nanm           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR014', Trim(delHyphen(msk_Npt_No.Text))     ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR015', lbl_Nju_so.caption  ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR016', edt_NBo_so.text     ) < 0) then  goto LIQUIDATION;

  str_ntl_no := Trim(msk_Ntl_No.text);
  seed_natl := ECPlazaSeed.Encrypt(str_ntl_no, common_seedkey);
	if (TMAX.SendString('STR017', seed_natl           ) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC100P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
      ShowMessage('성공적으로 수정되었습니다.');
      sts_Message.Panels[1].Text := ' 수정 완료';
      frm_LOSTC100P.btn_InquiryClick(self);
    end;



LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

function fChkLength(strValue : String; len : Integer; cond : Integer; strName : string): Boolean; // Cond 0: Equal 1:Min 2:Max
  begin
    strValue := delHyphen(Trim(strValue));
    Result := False;

    case cond of
      0 : begin
         if(Length(strValue) = len) then Result := True;
      end;

      1 : begin
         if(Length(strValue) >= len) then Result := True;
      end;

      2 : begin
         if(Length(strValue) <= len) then Result := True;
      end;

      else begin
        ShowMessage('잘못된 사용방법입니다.');
        result := False;
      end;
    end;

    if (result = False) then ShowMessage(strName + '이(가) 정확하지 않습니다.');
  end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure 기 능 : 엔터친 컴퍼넌트에 대한 숫자를 담고 있는다.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTC100P_ADDR.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;
  
procedure Tfrm_LOSTC100P_ADDR.FormCreate(Sender: TObject);
begin

  {------------------------- 사용자 정보 설정 -------------------------------}

  //공통변수 설정--common_lib.pas 참조할 것.
//  common_kait     := ParamStr(0);
//  common_caller   := ParamStr(1);
//  common_handle   := intToStr(self.Handle);
//  common_userid   := ParamStr(2);
//  common_username := ParamStr(3);
//  common_usergroup:= ParamStr(4);

  //테스트 후에는 이 부분을 삭제할 것.
//  common_userid     := '0294';    //ParamStr(2);
//  common_username   := '정호영';  //ParamStr(3);
//  common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  Application.Title := TITLE;
  fSetIcon(Application);
  pSetStsWidth(sts_Message);

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  edt_Gid_Nm.OnEnter := self.onEnter;
  msk_Gid_No.OnEnter := self.onEnter;
  msk_Gpt_No.OnEnter := self.onEnter;
  msk_Gtl_No.onclick := self.onclick;
  edt_Gbo_So.onclick := self.onclick;
  edt_Nid_nm.OnEnter := self.onEnter;
  msk_Npt_No.OnEnter := self.onEnter;
  msk_Nid_No.OnEnter := self.onEnter;
  edt_Nbo_So.onclick := self.onclick;
  msk_Ntl_No.onclick := self.onclick;

  chk_ga_rodadr_yn.Checked := True;
  chk_na_rodadr_yn.Checked := True;
  
end;

procedure Tfrm_LOSTC100P_ADDR.onEnter(Sender: TObject);
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

procedure Tfrm_LOSTC100P_ADDR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   self.hide;
   frm_LOSTC100P.Enabled := True;
   frm_LOSTC100P.Show;
end;

procedure Tfrm_LOSTC100P_ADDR.onClick(Sender: TObject);
begin
  if Sender is TEdit      then (Sender as Tedit).SelectAll;
  if Sender is TMaskEdit  then (Sender as TMaskEdit).SelectAll;
end;

procedure Tfrm_LOSTC100P_ADDR.chk_ga_rodadr_ynClick(Sender: TObject);
begin
//   if chk_ga_rodadr_yn.Checked = true then
//   begin
//      btn_click(Sender);
//   end;
end;

procedure Tfrm_LOSTC100P_ADDR.chk_na_rodadr_ynClick(Sender: TObject);
begin
//   if chk_na_rodadr_yn.Checked = true then
//   begin
//      btn_click(Sender);
//   end;
end;

end.
