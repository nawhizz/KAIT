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
unit u_LOSTB200Q_ADDR2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, Mask,ToolEdit,
  checklst, cpakmsg,common_lib, so_tmax,localCloud, ComObj;

const
  TITLE   = '습득자 주소 수정';
  PGM_ID  = 'LOSTB200Q';

type
  Tfrm_LOSTB200Q_ADDR2 = class(TForm)
    sts_Message: TStatusBar;
    GroupBox1: TGroupBox;
    msk_Pt_No: TMaskEdit;
    edt_Bo_So: TEdit;
    msk_Tl_No: TMaskEdit;
    GroupBox2: TGroupBox;
    lbl_Program_Name: TLabel;
    Bevel7: TBevel;
    Label7: TLabel;
    Bevel9: TBevel;
    Label9: TLabel;
    Bevel10: TBevel;
    Label10: TLabel;
    Bevel12: TBevel;
    Label12: TLabel;
    Bevel14: TBevel;
    lbl_Ju_So: TLabel;
    Label15: TLabel;
    Bevel15: TBevel;
    pnl_Command: TPanel;
    Label18: TLabel;
    Bevel18: TBevel;
    GroupBox3: TGroupBox;
    Bevel6: TBevel;
    Label6: TLabel;
    edt_Id_Nm: TEdit;
    lbl_Md_Cd: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    lbl_Sr_No: TLabel;
    Label1: TLabel;
    Bevel5: TBevel;
    Bevel13: TBevel;
    lbl_Ip_Dt: TLabel;
    btn_Postno_Inq: TBitBtn;
    Bevel4: TBevel;
    Label4: TLabel;
    cmb_Gt_Gu: TComboBox;
    Bevel11: TBevel;
    Label11: TLabel;
    msk_Gt_No: TMaskEdit;
    Bevel16: TBevel;
    Bevel17: TBevel;
    Label2: TLabel;
    lbl_Ph_Gb: TLabel;
    Bevel19: TBevel;
    Label3: TLabel;
    Bevel21: TBevel;
    lbl_sp_cd: TLabel;
    Bevel22: TBevel;
    Label5: TLabel;
    Bevel23: TBevel;
    lbl_bn_sy: TLabel;
    TMAX: TTMAX;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;
    chk_gt_rodadr_yn: TCheckBox;
    procedure btn_CloseClick(Sender: TObject);
    procedure cmb_Gt_GuChange(Sender: TObject);
    procedure cmb_Gt_GuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_Id_NmKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_click(Sender: TObject);
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT2;

    function ExecExternProg(progID:String):Boolean;
    procedure FormShow(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure SetItemNo(number:String);
    procedure onEnter(Sender: TObject);


    procedure FormCreate(Sender: TObject);  private
    { Private declarations }
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
    procedure attachOnEnter;
  end;

var
  frm_LOSTB200Q_ADDR2: Tfrm_LOSTB200Q_ADDR2;

implementation
uses cpaklibm, u_LOSTB200Q;
{$R *.DFM}

//Const
//     MAXRECCNT = 1 ;
//     C_GB_CD = 'Z004'; //주민/사업자/외국인구분
//     C_MD_CD = 'Z008'; //모델코드
//     C_PH_GB = 'Z031'; //단말기,부분품구분
//type
//    Tsendbody = record
//          ip_dt : array [0..7] of char;
//          md_cd : array [0..3] of char;
//          sr_no : array [0..6] of char;
//          sp_cd : array [0..19] of char;
//          bn_sy : array [0..19] of char;
////습득자사항
//          gt_gu : char;
//          gt_no : array [0..15] of char;
//          id_nm : array [0..39] of char;
//          pt_no : array [0..5] of char;
//          bn_ji : array [0..13] of char;
//          bo_so : array [0..39] of char;
//          tl_no : array [0..11] of char;
//    end ;
//
//    Trecvbody = record
//          ip_dt : array [0..7] of char;
//          md_cd : array [0..3] of char;
//          sr_no : array [0..6] of char;
//          sp_cd : array [0..19] of char;
//          bn_sy : array [0..19] of char;
////습득자사항
//          gt_gu : char;
//          gt_no : array [0..15] of char;
//          id_nm : array [0..39] of char;
//          pt_no : array [0..5] of char;
//          si_do : array [0..23] of char;
//          dn_nm : array [0..17] of char;
//          bn_ji : array [0..13] of char;
//          bo_so : array [0..39] of char;
//          tl_no : array [0..11] of char;
//          ph_gb : char;
//    end ;
//
//    Trecvhead = record
//          filler : char;
//    end ;
//
//    Tsendrec = record
//          func : char ;
//          bd : Tsendbody ;
//    end ;
//
//    Trecvrec = record
//          ContFlag : char;
//          ErrFlag : char;
//          MsgStr : array [0..59] of char;
//          RecCnt : array [0..3] of char;
//          hd : Trecvhead;
//          bd : array [0..(MAXRECCNT - 1)] of Trecvbody ;
//    end ;
//
//    Tsavkey = record
//          id_nm : shortstring;
//    end ;
//
//var
//  send : Tsendrec;
//  recv : Trecvrec;
//  savkey : Tsavkey;
{--------------- user define function and procedure declaration -------------}
//procedure btninit_rtn; forward;
//procedure scrinit_rtn; forward;
//procedure comm_rtn( func : char ); forward;
//procedure scr2buff_rtn; forward;
//procedure buff2scr_rtn; forward;
//function errchk_rtn : integer ; forward ;
{--------------- user define function and procedure code --------------------}
//procedure btninit_rtn;
//begin
//
//  with frm_LOSTB200Q_ADDR2 do
//  begin
//    btn_Add.Enabled       := True;
//    btn_Update.Enabled    := False;
//    btn_Delete.Enabled    := False;
//    btn_Inquiry.Enabled   := True;
//    btn_Next_Inq.Enabled  := False;
//    btn_Link.Enabled      := False;
//    btn_Print.Enabled     := False;
//  end;
//
//end;
{----------------------------------------------------------------------------}
//procedure scrinit_rtn;
//begin
//  with frm_LOSTB200Q_ADDR2 do
//  begin
//     msk_Pt_No.Text := '';
//     lbl_Ju_So.Caption := '';
//     edt_Bn_Ji.Text := '';
//     edt_Bo_So.Text := '';
//     msk_Tl_No.Text := '';
//     cmb_gt_gu.ItemIndex := -1;
//     msk_gt_no.text := '';
//     lbl_Ph_Gb.Caption := '';
//  end;
//end;

//procedure comm_rtn (func : char) ;
//begin
//
//  with frm_LOSTB200Q_ADDR2 do
//  begin
//
//     sts_Message.Panels[1].text := '통신중입니다.';
//
//     { send buffer 초기화 }
//     FillChar (send, sizeof (send), ' ') ;
//     send.func := func ;
//
//     if errchk_rtn = -1 then
//     begin
//        sts_Message.Panels[1].text := '';
//	exit ;
//     end ;
//
//     scr2buff_rtn ;
//
//     if CSendRecv( 'losta10p', @send, sizeof(send), @recv, True ) = -1 then
//     begin
//        exit ;
//     end;
//
//     if send.func = 'I' then
//        scrinit_rtn;
//
//     sts_Message.Panels[1].text := recv.MsgStr;
//
//     if recv.ErrFlag = 'E' then
//     begin
//        showmessage(recv.MsgStr);
//        exit ;
//     end ;
//
//     buff2scr_rtn;
//
//     { 조회나 입력일 경우 키 값을 저장한다 }
//     if send.func <> 'D' then
//     begin
//        savkey.id_nm := edt_id_nm.Text;
//     end;
//  end;
//end ;
//
//function errchk_rtn : integer ;
//{ OK : 0, Error : -1 }
//begin
//    { 입력 자료 중 error를 체크한다.}
//  with frm_LOSTB200Q_ADDR2 do
//  begin
//   result := 0 ;
//
//   if (trim(lbl_md_cd.caption) = '') or
//      (trim(lbl_sr_no.caption) = '') or
//      (trim(lbl_Ip_Dt.caption) = '') then
//   begin
//         showmessage('성명 조회후 작업하십시요 !!');
//         result := -1 ;
//         exit ;
//   end;
//
//   if send.func = 'I' then
//       exit;
//
//      if cmb_Gt_Gu.ItemIndex = -1 then
//      begin
//      showmessage('주민/사업자/외국인구분을 선택하십시요 !!');
//      cmb_Gt_Gu.setfocus;
//      result := -1 ;
//      exit ;
//      end;
//
//      msk_Gt_No.text := CNumOnly(msk_Gt_No.text);
//      if length(msk_Gt_No.text) = 0 then
//      begin
//      showmessage('주민/사업자/외국인번호를 확인하십시요 !!');
//      msk_Gt_No.setfocus;
//      result := -1 ;
//      exit ;
//      end;
//
//   edt_Id_nm.text := CRemoveSpace(edt_id_nm.text);
//   if edt_id_nm.text = '' then
//   begin
//      showmessage('성명(업체명)을 확인하십시요 !!');
//      edt_id_nm.setfocus;
//      result := -1 ;
//      exit ;
//   end;
//
//   msk_Pt_No.text := CNumOnly(msk_Pt_No.text);
//   if length(msk_Pt_No.text) <> 6 then
//   begin
//      showmessage('우편번호를 확인하십시요 !!');
//      msk_Pt_No.setfocus;
//      result := -1 ;
//      exit ;
//   end;
//
//   edt_Bn_Ji.text := trim(edt_Bn_Ji.text);
//   edt_Bo_So.text := trim(edt_Bo_So.text);
//
//   if (length(edt_Bn_Ji.text) = 0) and (length(edt_Bo_So.text) = 0) then
//   begin
//      showmessage('주소번지나 보조주소를 입력하십시요 !!');
//      edt_Bn_Ji.setfocus;
//      result := -1 ;
//      exit ;
//   end;
//
//   msk_Tl_No.text := Trim(msk_Tl_No.text);
//   if length(CNumOnly(msk_Tl_No.text)) = 0 then
//   begin
//      showmessage('전화번호를 확인하십시요 !!');
//      msk_Tl_No.setfocus;
//      result := -1 ;
//      exit ;
//   end;
//
//  end;
//end ;
//
//procedure scr2buff_rtn ;
//begin
//
//   { 화면의 내용을 send으로 옮긴다 }
//   with frm_LOSTB200Q_ADDR2 do
//   begin
//      CStrToArr (trim(copy(lbl_md_cd.caption,41,10)), send.bd.md_cd, False) ;
//      CStrToArr (trim(lbl_sr_no.caption), send.bd.sr_no, False) ;
//      CStrToArr (trim(lbl_sp_cd.caption), send.bd.sp_cd, False) ;
//      CStrToArr (trim(lbl_bn_sy.caption), send.bd.bn_sy, False) ;
//      CStrToArr (CNumOnly(lbl_Ip_Dt.caption), send.bd.ip_dt, False) ;
//
//      if send.func = 'I' then
//          exit;
//
//      CStrToArr (edt_id_nm.text, send.bd.id_nm, False) ;
//      CStrToArr (trim(copy(cmb_Gt_Gu.text,41,10)), send.bd.gt_gu, False) ;
//      CStrToArr (msk_gt_no.text, send.bd.gt_no, False) ;
//      CStrToArr (msk_Pt_No.text, send.bd.pt_no, False) ;
//      CStrToArr (edt_Bn_Ji.text, send.bd.bn_ji, False) ;
//      CStrToArr (edt_Bo_So.text, send.bd.bo_so, False) ;
//      CStrToArr (msk_Tl_No.text, send.bd.tl_no, False) ;
//
//     end;
//end;
//
//procedure buff2scr_rtn ;
//var tempdt1, tempstr : shortstring;
//begin
//    { recv의 내용을 화면으로 옮긴다 }
//    with frm_LOSTB200Q_ADDR2 do
//    begin
//       edt_id_nm.Text := trim(CArrToStr(recv.bd[0].id_nm));
//       if recv.bd[0].gt_gu = '1' then
//       cmb_Gt_Gu.itemindex := cmb_Gt_Gu.items.IndexOf
//       (CFindCode(C_GB_CD,CArrToStr(recv.bd[0].gt_gu )));
//       cmb_Gt_Gu.Onchange(frm_LOSTB200Q_ADDR2);
//       msk_gt_no.Text := trim(CArrToStr(recv.bd[0].gt_no));
//       msk_pt_no.text := trim(CArrToStr(recv.bd[0].pt_no));
//       lbl_Ju_So.Caption := trim(CArrToStr(recv.bd[0].si_do)) + ' ' +
//                            trim(CArrToStr(recv.bd[0].dn_nm));
//       edt_Bn_ji.Text := trim(CArrToStr(recv.bd[0].bn_ji));
//       edt_Bo_So.Text := trim(CArrToStr(recv.bd[0].bo_so));
//       msk_Tl_No.Text := trim(CArrToStr(recv.bd[0].tl_no));
//
//       lbl_Md_Cd.Caption := (CFindCode(C_MD_CD, CArrToStr(recv.bd[0].md_cd)));
//       lbl_Sr_No.Caption := trim(CArrToStr(recv.bd[0].sr_no));
//       lbl_sp_cd.Caption := trim(CArrToStr(recv.bd[0].sp_cd));
//       lbl_bn_sy.Caption := trim(CArrToStr(recv.bd[0].bn_sy));
//
//       tempstr := CArrToStr(recv.bd[0].ip_dt);
//       if trim(tempstr) <> '' then
//       begin
//          tempdt1 := copy(tempstr,1,4)+'/'+copy(tempstr,5,2)+'/'+
//                     copy(tempstr,7,2);
//          lbl_Ip_Dt.Caption := tempdt1;
//       end;
//       lbl_Ph_Gb.Caption := (CFindCode(C_PH_GB, CArrToStr(recv.bd[0].ph_gb)));
//    end;
//
//end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB200Q_ADDR2.btn_CloseClick(Sender: TObject);
begin
  self.Hide;
  frm_LOSTB200Q.Enabled := true;
  frm_LOSTB200Q.Show;
  Close;
end;

procedure Tfrm_LOSTB200Q_ADDR2.cmb_Gt_GuChange(Sender: TObject);
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

procedure Tfrm_LOSTB200Q_ADDR2.cmb_Gt_GuKeyDown(Sender: TObject; var Key: Word;
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
      OnChange(frm_LOSTB200Q_ADDR2);
   end;
end;

procedure Tfrm_LOSTB200Q_ADDR2.edt_Id_NmKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_F2 then
      btn_Postno_Inq.OnClick(frm_LOSTB200Q_ADDR2);
end;

procedure Tfrm_LOSTB200Q_ADDR2.btn_click(Sender: TObject);
var
  bitBtn : TBitBtn;
  mskEdt : TMaskEdit;
begin
  value1 := msk_Pt_No.Text;
  CreateMap;	//공유메모리 생성

  // 도로명주소 체크에 따라 우편번호 팝업 선택
  if (chk_gt_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ850Q')
  else self.ExecExternProg('LOSTZ800Q');
end;

//common_lib.pas에 있는 함수와 다르다.
function Tfrm_LOSTB200Q_ADDR2.ExecExternProg(progID:String):Boolean;
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
procedure Tfrm_LOSTB200Q_ADDR2.Link_rtn (var Msg : TMessage);
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

      msk_Pt_No.Text        := smem^.po_no;			    //우편번호
      lbl_Ju_So.Caption     := smem^.ju_so;          //주소


      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    edt_Bo_So.SetFocus;

  end;
end;
procedure Tfrm_LOSTB200Q_ADDR2.FormShow(Sender: TObject);
begin
  changeBtn(Self);
  btn_Update.Enabled  := True;
  btn_reset.Enabled   := False;
  btn_excel.Enabled   := False;
  btn_query.Enabled   := False;
  btn_Inquiry.Enabled := False;  

  setItemNo('1');

  edt_Id_Nm.Text    := frm_LOSTB200Q.edt_Id_Nm.Text;
  msk_Gt_No.Text    := delHyphen(frm_LOSTB200Q.edt_id_cd.text);
  msk_Pt_No.Text    := delHyphen(frm_LOSTB200Q.lbl_pt_no.Caption);
  lbl_Ju_So.Caption := frm_LOSTB200Q.lbl_Ju_So.caption;
  edt_Bo_So.Text    := frm_LOSTB200Q.lbl_bo_so.Caption;
  msk_Tl_No.Text    := delHyphen(frm_LOSTB200Q.lbl_tl_no.Caption);
  lbl_Sr_No.Caption := frm_LOSTB200Q.serial_edit.text;
  lbl_Ip_Dt.Caption := delHyphen(frm_LOSTB200Q.dte_Ip_Dt.Text);

end;

procedure Tfrm_LOSTB200Q_ADDR2.btn_UpdateClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  str_gtno, str_gtnm, str_gttl : String;
  seed_gtno, seed_gtnm, seed_gttl : String;

  STR004,STR005,STR006 : string;
  label LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  if(not fChkLength(lbl_Md_Cd,1,1,'모델코드'))        then Exit;
  if(not fChkLength(lbl_Sr_No,1,1,'단말기 일련번호')) then Exit;
  if(not fChkLength(lbl_Ip_Dt,8,0,'입고일자'))        then Exit;

	STR001 := lbl_Md_Cd.caption;	            //모델코드
	STR002 := lbl_Sr_No.caption;			        //단말기일련번호
  STR003 := delHyphen(lbl_Ip_Dt.Caption);	  //입고일자


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
	if (TMAX.SendString('INF003','LOSTB200Q'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','U01'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', IntToStr(cmb_Gt_Gu.itemindex + 1)         )  < 0) then  goto LIQUIDATION;
	//if (TMAX.SendString('STR005', msk_Gt_No.Text         )  < 0) then  goto LIQUIDATION;
  str_gtno  := msk_Gt_No.Text;
  seed_gtno := ECPlazaSeed.Encrypt(str_gtno, common_seedkey);
  if (TMAX.SendString('STR005', seed_gtno       )  < 0) then  goto LIQUIDATION;

	//if (TMAX.SendString('STR006', Trim(edt_Id_Nm.Text)         )  < 0) then  goto LIQUIDATION;
  str_gtnm  := Trim(edt_Id_Nm.Text);
  seed_gtnm := ECPlazaSeed.Encrypt(str_gtnm, common_seedkey);
	if (TMAX.SendString('STR006', seed_gtnm       )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR007', delHyphen(msk_Pt_No.Text)         )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', Trim(lbl_Ju_So.Caption)         )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', Trim(edt_Bo_So.Text)         )  < 0) then  goto LIQUIDATION;
	//if (TMAX.SendString('STR010', delHyphen(msk_Tl_No.Text)         )  < 0) then  goto LIQUIDATION;
  str_gttl  := delHyphen(msk_Tl_No.Text);
  seed_gttl := ECPlazaSeed.Encrypt(str_gttl, common_seedkey);
  if (TMAX.SendString('STR010', seed_gttl      )  < 0) then  goto LIQUIDATION;

  //서비스 호출
	if not TMAX.Call('LOSTB200Q') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  sts_Message.Panels[1].Text := '수정 완료';
  ShowMessage('성공적으로 수정되었습니다.');


LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

(******************************************************************************)
(* procedure name  : SetItemNo                                                *)
(* procedure 기 능 : 엔터친 컴퍼넌트에 대한 숫자를 담고 있는다.               *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB200Q_ADDR2.SetItemNo(number:String);
begin
    itemNo  := number;
    value1  :='';
    value2  :='';
end;

procedure Tfrm_LOSTB200Q_ADDR2.FormCreate(Sender: TObject);
begin
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

    chk_gt_rodadr_yn.Checked := True;

    {--------------------------------------------------------------------------}
    attachOnEnter;    
end;

procedure Tfrm_LOSTB200Q_ADDR2.onEnter(Sender: TObject);
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

procedure Tfrm_LOSTB200Q_ADDR2.attachOnEnter;
begin
  edt_Id_Nm.onEnter := self.onEnter;
  msk_Gt_No.onEnter := self.onEnter;
  msk_Pt_No.onEnter := self.onEnter;
  edt_Bo_So.onEnter := self.onEnter;
  msk_Tl_No.onEnter := self.onEnter;

end;

end.


