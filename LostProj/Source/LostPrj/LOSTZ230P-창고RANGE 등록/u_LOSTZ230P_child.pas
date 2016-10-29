unit u_LOSTZ230P_child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '창고RANGE등록';
  PGM_ID  = 'LOSTZ230P';

type
  Tfrm_LOSTZ230P_CHILD = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    pnl_Command: TPanel;
    cmb_ph_Gb: TComboBox;
    msk_to_rn: TMaskEdit;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    TMAX: TTMAX;
    msk_fr_rn: TMaskEdit;
    btn_reset: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);
    procedure msk_fr_rnKeyPress(Sender: TObject; var Key: Char);
    procedure msk_to_rnKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cmb_ph_gb_d: TZ0xxArray;

  public
    { Public declarations }
  end;

var
  frm_LOSTZ230P_CHILD : Tfrm_LOSTZ230P_CHILD;

implementation

uses cpaklibm, u_LOSTZ230P;

{$R *.DFM}

procedure Tfrm_LOSTZ230P_CHILD.setEdtKeyPress;
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

procedure Tfrm_LOSTZ230P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ230P_CHILD.btn_CloseClick(Sender: TObject);
begin

   self.Hide;
   frm_LOSTZ230P.Enabled := True;
   frm_LOSTZ230P.Show;
   frm_LOSTZ230P.btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTZ230P_CHILD.FormHide(Sender: TObject);
begin
   u_LOSTZ230P.frm_LOSTZ230P.Enabled := true;
end;

procedure Tfrm_LOSTZ230P_CHILD.FormShow(Sender: TObject);
var

 Button : TSpeedButton absolute Sender;
begin

  frm_LOSTZ230P.Enabled := False;

  if (Button.Name = 'btn_Add') then begin
    changeBtn(Self);

    btn_Add.Enabled := True;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := True;

    msk_fr_rn.Enabled := True;
    msk_to_rn.Enabled := True;
    cmb_ph_Gb.Enabled := true;
    cmb_ph_Gb.ItemIndex := 0;
    msk_fr_rn.Text := '';
    msk_to_rn.Text := '';

    self.Show;

    cmb_ph_Gb.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin
    changeBtn(Self);

    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    msk_fr_rn.Enabled := True;
    msk_to_rn.Enabled := True;
    cmb_ph_Gb.Enabled := False;
    cmb_ph_Gb.ItemIndex := cmb_ph_gb.Items.IndexOf(findNameFromCode(CG_GB,cmb_ph_gb_d,cmb_ph_Gb.Items.Count));
    msk_fr_rn.Text :=  FR_RN;
    msk_to_rn.Text :=  TO_RN;

    self.Show;

    msk_fr_rn.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin

    changeBtn(Self);
    btn_Add.Enabled := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    msk_fr_rn.Enabled := True;
    msk_to_rn.Enabled := True;
    cmb_ph_Gb.Enabled := False;
    cmb_ph_Gb.ItemIndex := cmb_ph_gb.Items.IndexOf(findNameFromCode(CG_GB,cmb_ph_gb_d,cmb_ph_Gb.Items.Count));
    msk_fr_rn.Text :=  FR_RN;
    msk_to_rn.Text :=  TO_RN;

    self.Show;

    msk_fr_rn.SelectAll;

  end else if (Button.Name = 'btn_Delete') then  begin

   changeBtn(Self);
    btn_Add.Enabled := False;
    btn_Update.Enabled := False;
    btn_Delete.Enabled := True;
    btn_Inquiry.Enabled := False;
    btn_Print.Enabled := False;
    btn_reset.Enabled := False;

    cmb_ph_Gb.Enabled := False;
    msk_fr_rn.Enabled := False;
    msk_to_rn.Enabled := False;
    cmb_ph_Gb.ItemIndex := cmb_ph_gb.Items.IndexOf(findNameFromCode(CG_GB,cmb_ph_gb_d,cmb_ph_Gb.Items.Count));
    msk_fr_rn.Text :=  FR_RN;
    msk_to_rn.Text :=  TO_RN;

    self.Show;
  end;
end;

procedure Tfrm_LOSTZ230P_CHILD.FormCreate(Sender: TObject);
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

 // initSkinForm(SkinData1);
  initComboBoxWithZ0xx('Z083.dat', cmb_ph_gb_d, '', ' ',cmb_ph_Gb);
  
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ230P_CHILD.btn_AddClick(Sender: TObject);

  LABEL LIQUIDATION;
begin


  if (Length(msk_fr_rn.Text) < 6 ) or (Length(msk_to_rn.Text) < 6 ) then
  begin
    ShowMessage('FROM , TO RANGE 의 값은 6자리여야 합니다.');
    exit;
  end;


  if StrToInt(msk_fr_rn.Text) > StrToInt(msk_to_rn.Text) then
   begin
     showmessage('TO RANGE가 FORM RANGE 보다 작게 설정할 수 없습니다.');
     exit;
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



    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ230P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_ph_gb_d[cmb_ph_Gb.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', msk_fr_rn.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR003', msk_to_rn.Text  )   < 0) then  goto LIQUIDATION;



    //서비스 호출
	if not TMAX.Call('LOSTZ230P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

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

    btn_CloseClick(Sender);


end;

procedure Tfrm_LOSTZ230P_CHILD.btn_UpdateClick(Sender: TObject);
  LABEL LIQUIDATION;
begin

  if (Length(msk_fr_rn.Text) < 6 ) or (Length(msk_to_rn.Text) < 6 ) then
  begin
    ShowMessage('FROM , TO RANGE 의 값은 6자리여야 합니다.');
    exit;
  end;

   if StrToInt(msk_fr_rn.Text) > StrToInt(msk_to_rn.Text) then
   begin
     showmessage('TO RANGE가 FORM RANGE 보다 작게 설정할 수 없습니다.');
     exit;
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
    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ230P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendInteger('INT001', StrToInt(CG_SQ)  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', cmb_ph_gb_d[cmb_ph_Gb.ItemIndex].code  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', msk_fr_rn.Text  )   < 0) then  goto LIQUIDATION;
 	if (TMAX.SendString('STR003', msk_to_rn.Text  )   < 0) then  goto LIQUIDATION;



    //서비스 호출
	if not TMAX.Call('LOSTZ230P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end
  else
    begin
        sts_Message.Panels[1].Text := ' 수정 완료';
         ShowMessage('성공적으로 수정되었습니다.')
    end;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  btn_CloseClick(Sender);
end;

procedure Tfrm_LOSTZ230P_CHILD.btn_DeleteClick(Sender: TObject);
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
      if (TMAX.SendString('INF003','LOSTZ230P'      )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendInteger('INT001', StrToInt(CG_SQ)  )   < 0) then  goto LIQUIDATION;


        //서비스 호출
      if not TMAX.Call('LOSTZ230P') then
        begin
          sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

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

        btn_CloseClick(Sender);
end;

procedure Tfrm_LOSTZ230P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frm_LOSTZ230P.Enabled := True;
   frm_LOSTZ230P.Show;
end;

procedure Tfrm_LOSTZ230P_CHILD.btn_resetClick(Sender: TObject);
begin
    cmb_ph_Gb.ItemIndex := 0;
    msk_fr_rn.Text := '';
    msk_to_rn.Text := '';
end;

procedure Tfrm_LOSTZ230P_CHILD.msk_fr_rnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTZ230P_CHILD.msk_to_rnKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

end.
