unit u_LOSTZ700P_child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,localCloud, ComObj;

const
  TITLE   = '경찰청기관코드 등록';
  PGM_ID  = 'LOSTZ700P';

type
  Tfrm_LOSTZ700P_CHILD = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    edt_org_nm: TEdit;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_gr_id: TMaskEdit;
    pnl_Command: TPanel;
    Bevel4: TBevel;
    Label3: TLabel;
    Bevel5: TBevel;
    Label4: TLabel;
    cmb_org_tp_cd: TComboBox;
    cmb_ctl_lct_cd: TComboBox;
    edt_hi_org_id: TEdit;
    Bevel8: TBevel;
    Label7: TLabel;
    edt_zp_cd: TMaskEdit;
    Bevel9: TBevel;
    Label8: TLabel;
    edt_addr: TMaskEdit;
    TMAX: TTMAX;
    Bevel12: TBevel;
    edt_addr_dtl: TMaskEdit;
    Label11: TLabel;
    btn_GPostno_Inq: TBitBtn;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    Bevel3: TBevel;
    edt_tel: TMaskEdit;
    Label2: TLabel;
    Label10: TLabel;
    chk_rodadr_yn: TCheckBox;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure btn_GPostno_InqClick(Sender: TObject);
    function ExecExternProg(progID:String):Boolean;
    procedure Link_rtn (var Msg : TMessage); message WM_LOSTPROJECT2;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    cmb_org_tp_cd_d   : TZ0xxArray;
    cmb_ctl_lct_cd_d  : TZ0xxArray;
    recvedMessage:Boolean;
    value1,value2 :String;

  public
    { Public declarations }
  end;

var
  callValue : Integer;
  frm_LOSTZ700P_CHILD : Tfrm_LOSTZ700P_CHILD;

implementation

uses cpaklibm, u_LOSTZ700P;

{$R *.DFM}

procedure Tfrm_LOSTZ700P_CHILD.setEdtKeyPress;
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

procedure Tfrm_LOSTZ700P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;


{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ700P_CHILD.FormCreate(Sender: TObject);
begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}
  {   }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
      PostMessage(self.Handle, WM_QUIT, 0,0);
      exit;
  end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);
  //initSkinForm(SkinData1);

  initComboBoxWithZ0xx('Z010.dat', cmb_org_tp_cd_d, '', '',cmb_org_tp_cd);
  initComboBoxWithZ0xx('Z011.dat', cmb_ctl_lct_cd_d, '', '',cmb_ctl_lct_cd);

  chk_rodadr_yn.Checked := false;

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ700P_CHILD.btn_CloseClick(Sender: TObject);
begin
   self.Hide;
   frm_LOSTZ700P.Enabled := True;
   frm_LOSTZ700P.Show;
   frm_LOSTZ700P.btn_InquiryClick(Sender);
end;



procedure Tfrm_LOSTZ700P_CHILD.FormShow(Sender: TObject);
var

 Button : TSpeedButton absolute Sender;
begin
  frm_LOSTZ700P.Enabled := False;
  if (Button.Name = 'btn_Add') then begin
    changeBtn(Self);

    btn_Add.Enabled := True;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := True;

    edt_gr_id.Enabled := True;

    edt_gr_id.Text           :='';
    edt_org_nm.Text          :='';
    cmb_org_tp_cd.ItemIndex  := 0;
    cmb_ctl_lct_cd.ItemIndex := 0;
    edt_tel.Text             :='';
    edt_zp_cd.Text           :='';
    edt_addr.Text            :='';
    edt_addr_dtl.Text        :='';
    edt_hi_org_id.Text       :='';

    self.Show;

    edt_gr_id.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin
    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gr_id.Enabled := False;

    edt_gr_id.Text           := frm_LOSTZ700P.grd_display.Cells[0,  frm_LOSTZ700P.grd_display.Row];
    edt_org_nm.Text          := frm_LOSTZ700P.grd_display.Cells[1,  frm_LOSTZ700P.grd_display.Row];
    cmb_org_tp_cd.ItemIndex  := cmb_org_tp_cd.Items.IndexOf(findNameFromCode(ORD_TP_CD,cmb_org_tp_cd_d,cmb_org_tp_cd.Items.Count));
    cmb_ctl_lct_cd.ItemIndex := cmb_ctl_lct_cd.Items.IndexOf(findNameFromCode(CTL_LCT_CD,cmb_ctl_lct_cd_d,cmb_ctl_lct_cd.Items.Count));
    edt_tel.Text             := frm_LOSTZ700P.grd_display.Cells[9,  frm_LOSTZ700P.grd_display.Row];
    edt_zp_cd.Text           := frm_LOSTZ700P.grd_display.Cells[6,  frm_LOSTZ700P.grd_display.Row];
    edt_addr.Text            := frm_LOSTZ700P.grd_display.Cells[7,  frm_LOSTZ700P.grd_display.Row];
    edt_addr_dtl.Text        := frm_LOSTZ700P.grd_display.Cells[8,  frm_LOSTZ700P.grd_display.Row];
    edt_hi_org_id.Text       := frm_LOSTZ700P.grd_display.Cells[10,  frm_LOSTZ700P.grd_display.Row];

    self.Show;

    edt_org_nm.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin

    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gr_id.Enabled := False;

    edt_gr_id.Text           := frm_LOSTZ700P.grd_display.Cells[0,  frm_LOSTZ700P.grd_display.Row];
    edt_org_nm.Text          := frm_LOSTZ700P.grd_display.Cells[1,  frm_LOSTZ700P.grd_display.Row];
    cmb_org_tp_cd.ItemIndex  := cmb_org_tp_cd.Items.IndexOf(findNameFromCode(ORD_TP_CD,cmb_org_tp_cd_d,cmb_org_tp_cd.Items.Count));
    cmb_ctl_lct_cd.ItemIndex := cmb_ctl_lct_cd.Items.IndexOf(findNameFromCode(CTL_LCT_CD,cmb_ctl_lct_cd_d,cmb_ctl_lct_cd.Items.Count));
    edt_tel.Text             := frm_LOSTZ700P.grd_display.Cells[9,  frm_LOSTZ700P.grd_display.Row];
    edt_zp_cd.Text           := frm_LOSTZ700P.grd_display.Cells[6,  frm_LOSTZ700P.grd_display.Row];
    edt_addr.Text            := frm_LOSTZ700P.grd_display.Cells[7,  frm_LOSTZ700P.grd_display.Row];
    edt_addr_dtl.Text        := frm_LOSTZ700P.grd_display.Cells[8,  frm_LOSTZ700P.grd_display.Row];
    edt_hi_org_id.Text       := frm_LOSTZ700P.grd_display.Cells[10,  frm_LOSTZ700P.grd_display.Row];

    self.Show;
    edt_org_nm.SelectAll;

  end else if (Button.Name = 'btn_Delete') then  begin

    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := True;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    edt_gr_id.Enabled := False;

    edt_gr_id.Text           := frm_LOSTZ700P.grd_display.Cells[0,  frm_LOSTZ700P.grd_display.Row];
    edt_org_nm.Text          := frm_LOSTZ700P.grd_display.Cells[1,  frm_LOSTZ700P.grd_display.Row];
    cmb_org_tp_cd.ItemIndex  := cmb_org_tp_cd.Items.IndexOf(findNameFromCode(ORD_TP_CD,cmb_org_tp_cd_d,cmb_org_tp_cd.Items.Count));
    cmb_ctl_lct_cd.ItemIndex := cmb_ctl_lct_cd.Items.IndexOf(findNameFromCode(CTL_LCT_CD,cmb_ctl_lct_cd_d,cmb_ctl_lct_cd.Items.Count));
    edt_tel.Text             := frm_LOSTZ700P.grd_display.Cells[9,  frm_LOSTZ700P.grd_display.Row];
    edt_zp_cd.Text           := frm_LOSTZ700P.grd_display.Cells[6,  frm_LOSTZ700P.grd_display.Row];
    edt_addr.Text            := frm_LOSTZ700P.grd_display.Cells[7,  frm_LOSTZ700P.grd_display.Row];
    edt_addr_dtl.Text        := frm_LOSTZ700P.grd_display.Cells[8,  frm_LOSTZ700P.grd_display.Row];
    edt_hi_org_id.Text       := frm_LOSTZ700P.grd_display.Cells[10,  frm_LOSTZ700P.grd_display.Row];

    self.Show;

  end;
end;

procedure Tfrm_LOSTZ700P_CHILD.btn_AddClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_tel : String;

  USYN : String;
  LABEL LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  if( not fChkLength(edt_gr_id       ,1,1,'기관아이디'    )) then Exit;
  if( not fChkLength(edt_org_nm      ,1,1,'기관명'        )) then Exit;
  if( not fChkLength(cmb_org_tp_cd   ,1,1,'기관유형코드'  )) then Exit;
  if( not fChkLength(cmb_ctl_lct_cd  ,1,1,'지역코드'      )) then Exit;

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

  // 암호화
  seed_tel := ECPlazaSeed.Encrypt(edt_tel.Text, common_seedkey);

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ700P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'               )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_gr_id.Text      )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_org_nm.Text     )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', cmb_org_tp_cd_d[cmb_org_tp_cd.ItemIndex].code    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', cmb_ctl_lct_cd_d[cmb_ctl_lct_cd.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(edt_zp_cd.Text))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', edt_addr.Text       )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', edt_addr_dtl.Text   )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', seed_tel            )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', edt_hi_org_id.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ700P') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 등록 완료';
         ShowMessage('성공적으로 등록되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;


end;

procedure Tfrm_LOSTZ700P_CHILD.btn_UpdateClick(Sender: TObject);
var
  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;
  seed_tel : String;
  
  USYN : String;
  LABEL LIQUIDATION;
begin
  // 암호화 모듈
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

  if( not fChkLength(edt_gr_id       ,1,1,'기관아이디'    )) then Exit;
  if( not fChkLength(edt_org_nm      ,1,1,'기관명'        )) then Exit;
  if( not fChkLength(cmb_org_tp_cd   ,1,1,'기관유형코드'  )) then Exit;
  if( not fChkLength(cmb_ctl_lct_cd  ,1,1,'지역코드'      )) then Exit;

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

  // 암호화
  seed_tel := ECPlazaSeed.Encrypt(edt_tel.Text, common_seedkey);

  //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ700P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_gr_id.Text      )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR002', edt_org_nm.Text     )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR003', cmb_org_tp_cd_d[cmb_org_tp_cd.ItemIndex].code    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', cmb_ctl_lct_cd_d[cmb_ctl_lct_cd.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', delHyphen(edt_zp_cd.Text))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', edt_addr.Text       )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', edt_addr_dtl.Text   )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', seed_tel            )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR009', edt_hi_org_id.Text  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ700P') then
    begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정  완료';
         ShowMessage('성공적으로 수정되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

end;

procedure Tfrm_LOSTZ700P_CHILD.btn_DeleteClick(Sender: TObject);
LABEL LIQUIDATION;
begin
  if MessageDlg('삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='삭제가 취소되었습니다';
      exit;
   end
   else
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
      if (TMAX.SendString('INF003','LOSTZ700P'      )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR001', edt_gr_id.Text  )   < 0) then  goto LIQUIDATION;


        //서비스 호출
      if not TMAX.Call('LOSTZ700P') then
        begin
         if (TMAX.RecvString('INF011',0) = 'Y') then
           sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
         else
           MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
          goto LIQUIDATION;
        end
      else
        begin
            sts_Message.Panels[1].Text := ' 삭제 완료';
             ShowMessage('성공적으로 삭제되었습니다.')
        end;

    LIQUIDATION:
      TMAX.InitBuffer;
      TMAX.FreeBuffer;
      TMAX.EndTMAX;
      TMAX.Disconnect;
end;

procedure Tfrm_LOSTZ700P_CHILD.btn_GPostno_InqClick(Sender: TObject);
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

    if(bitBtn = btn_GpostNo_Inq) or ( mskEdt = edt_zp_cd ) then
      begin
        callValue := 0;
        value1 := edt_zp_cd.Text;
      end;
    end;

  CreateMap;	//공유메모리 생성

  // 도로명주소 체크에 따라 우편번호 팝업 선택
  if (chk_rodadr_yn.Checked = true) then self.ExecExternProg('LOSTZ840Q')
  else self.ExecExternProg('LOSTZ800Q');

end;

function Tfrm_LOSTZ700P_CHILD.ExecExternProg(progID:String):Boolean;
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
procedure Tfrm_LOSTZ700P_CHILD.Link_rtn (var Msg : TMessage);
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
          edt_zp_cd.Text        := smem^.po_no;			    //우편번호
          edt_addr.Text         := smem^.ju_so;	        //기본주소
        end;

      UnLock;

      //공유메모리를 사용 후.
      CloseMapMain;
      smem:= nil;
    end;

    edt_addr_dtl.SetFocus;

  end;
end;

procedure Tfrm_LOSTZ700P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frm_LOSTZ700P.Enabled := True;
   frm_LOSTZ700P.Show;
end;

procedure Tfrm_LOSTZ700P_CHILD.btn_resetClick(Sender: TObject);
begin
    edt_gr_id.Text           :='';
    edt_org_nm.Text          :='';
    cmb_org_tp_cd.ItemIndex  := 0;
    cmb_ctl_lct_cd.ItemIndex := 0;
    edt_tel.Text             :='';
    edt_zp_cd.Text           :='';
    edt_addr.Text            :='';
    edt_addr_dtl.Text        :='';
    edt_hi_org_id.Text       :='';

end;

end.


