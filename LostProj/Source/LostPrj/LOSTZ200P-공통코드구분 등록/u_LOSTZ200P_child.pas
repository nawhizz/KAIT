unit u_LOSTZ200P_child;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '공통코드구분등록';
  PGM_ID  = 'LOSTZ200P';

type
  Tfrm_LOSTZ200P_CHILD = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    sts_Message: TStatusBar;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    Bevel16: TBevel;
    lbl_Inq_Str: TLabel;
    edt_Cd_Nm: TEdit;
    edt_Cd_No: TEdit;
    pnl_Command: TPanel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    sys_nm_01: TEdit;
    Bevel3: TBevel;
    Bevel5: TBevel;
    sys_nm_02: TEdit;
    Label2: TLabel;
    Bevel4: TBevel;
    sys_nm_03: TEdit;
    Bevel6: TBevel;
    sys_nm_04: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Bevel7: TBevel;
    sys_nm_05: TEdit;
    Label5: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    Bevel8: TBevel;
    Label6: TLabel;
    Panel1: TPanel;
    rdo_Sh_Yes: TRadioButton;
    rdo_Sh_No: TRadioButton;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_reset: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress ( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frm_LOSTZ200P_CHILD : Tfrm_LOSTZ200P_CHILD;

implementation

uses cpaklibm, u_LOSTZ200P;

{$R *.DFM}

procedure Tfrm_LOSTZ200P_CHILD.setEdtKeyPress;
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
 
procedure Tfrm_LOSTZ200P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTZ200P_CHILD.btn_CloseClick(Sender: TObject);
begin

   frm_LOSTZ200P.btn_InquiryClick(Sender);
   self.Hide;
   frm_LOSTZ200P.Enabled := True;
   frm_LOSTZ200P.Show;

end;

procedure Tfrm_LOSTZ200P_CHILD.FormHide(Sender: TObject);
begin
   u_LOSTZ200P.frm_LOSTZ200P.Enabled := true;
end;

procedure Tfrm_LOSTZ200P_CHILD.FormCreate(Sender: TObject);
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
  {    }
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

  btn_resetClick(Sender);
  //테스트 후에는 이 부분을 삭제할 것.
	//common_userid:= '0294'; //ParamStr(2);
	//common_username:= '정호영';
  //ParamStr(3);
	//common_usergroup:= 'KAIT'; //ParamStr(4);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTZ200P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
  frm_LOSTZ200P.Enabled := False;

  if (Button.Name = 'btn_Add') then begin
     btn_Add.Enabled := true;
     btn_Update.Enabled := false;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_Print.Enabled := False;
     btn_reset.Enabled := True;

     edt_Cd_No.Text := '';
     edt_Cd_Nm.Text := '';
     sys_nm_01.Text := '';
     sys_nm_02.Text := '';
     sys_nm_03.Text := '';
     sys_nm_04.Text := '';
     sys_nm_05.Text := '';

     edt_Cd_No.Enabled := True;
     edt_Cd_No.Enabled := True;
     edt_Cd_Nm.Enabled := True;
     sys_nm_01.Enabled := True;
     sys_nm_02.Enabled := True;
     sys_nm_03.Enabled := True;
     sys_nm_04.Enabled := True;
     sys_nm_05.Enabled := True;
     rdo_Sh_Yes.Enabled := True;
     rdo_Sh_No.Enabled := True;

     self.Show;
     edt_Cd_No.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin
     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_Print.Enabled := False;
     btn_reset.Enabled := False;

     edt_Cd_No.Enabled := false;

     edt_Cd_No.Text := STR001;
     edt_Cd_Nm.Text := STR002;
     sys_nm_01.Text := STR003;
     sys_nm_02.Text := STR004;
     sys_nm_03.Text := STR005;
     sys_nm_04.Text := STR006;
     sys_nm_05.Text := STR007;

     if STR008 = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;
     self.Show;
     edt_Cd_Nm.SelectAll;

  end else if (Button.Name = 'btn_Update') then  begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_Print.Enabled := False;
     btn_reset.Enabled := False;

     edt_Cd_No.Enabled := false;

     edt_Cd_No.Text := STR001;
     edt_Cd_Nm.Text := STR002;
     sys_nm_01.Text := STR003;
     sys_nm_02.Text := STR004;
     sys_nm_03.Text := STR005;
     sys_nm_04.Text := STR006;
     sys_nm_05.Text := STR007;
     if STR008 = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;
     edt_Cd_Nm.SelectAll;


   end else if (Button.Name = 'btn_Delete') then  begin

     btn_Add.Enabled := false;
     btn_Update.Enabled := false;
     btn_Delete.Enabled := True;
     btn_Inquiry.Enabled := false;
     btn_Print.Enabled := False;
     btn_reset.Enabled := False;

     edt_Cd_No.Enabled := false;
     edt_Cd_No.Enabled := false;
     edt_Cd_Nm.Enabled := false;
     sys_nm_01.Enabled := false;
     sys_nm_02.Enabled := false;
     sys_nm_03.Enabled := false;
     sys_nm_04.Enabled := false;
     sys_nm_05.Enabled := false;
     rdo_Sh_Yes.Enabled := False;
     rdo_Sh_No.Enabled := False;

     edt_Cd_No.Text := STR001;
     edt_Cd_Nm.Text := STR002;
     sys_nm_01.Text := STR003;
     sys_nm_02.Text := STR004;
     sys_nm_03.Text := STR005;
     sys_nm_04.Text := STR006;
     sys_nm_05.Text := STR007;
     if STR008 = 'Y' then begin
      rdo_Sh_Yes.Checked := True;
     end else begin
      rdo_Sh_No.Checked := True;
     end;

     self.Show;

   end;

   frm_LOSTZ200P.Enabled := False;

 end;


procedure Tfrm_LOSTZ200P_CHILD.btn_AddClick(Sender: TObject);
var

  USYN : String;


  LABEL LIQUIDATION;
begin


    if Length(edt_Cd_No.Text) < 1 then begin
      ShowMessage('코드구분 을 입력해 주십시오.');
      exit;
    end;

    if Length(edt_Cd_Nm.Text) < 1 then begin
      ShowMessage('코드구분명 을 입력해 주십시오.');
      exit;
    end;

    USYN := ' ';

   if rdo_Sh_Yes.Checked then begin
      USYN := 'Y';
   end else begin
      USYN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ200P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Cd_Nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', sys_nm_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', sys_nm_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', sys_nm_03.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', sys_nm_04.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', sys_nm_05.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', USYN            )   < 0) then  goto LIQUIDATION;

  //서비스 호출
  if not TMAX.Call('LOSTZ200P') then
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

procedure Tfrm_LOSTZ200P_CHILD.btn_UpdateClick(Sender: TObject);
var
  USYN : String;
  LABEL LIQUIDATION;
begin
    USYN := ' ';

   if rdo_Sh_Yes.Checked then begin
      USYN := 'Y';
   end else begin
      USYN := 'N';
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
	if (TMAX.SendString('INF003','LOSTZ200P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', edt_Cd_Nm.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', sys_nm_01.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', sys_nm_02.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR005', sys_nm_03.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR006', sys_nm_04.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR007', sys_nm_05.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR008', USYN            )   < 0) then  goto LIQUIDATION;



   //서비스 호출
  if not TMAX.Call('LOSTZ200P') then
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

procedure Tfrm_LOSTZ200P_CHILD.btn_DeleteClick(Sender: TObject);
 LABEL LIQUIDATION;
begin
   if MessageDlg('삭제하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :='삭제가 취소되었습니다';
      update;
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
      if (TMAX.SendString('INF003','LOSTZ200P'      )   < 0) then  goto LIQUIDATION;

      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR001', edt_Cd_No.Text  )   < 0) then  goto LIQUIDATION;

      //서비스 호출
      if not TMAX.Call('LOSTZ200P') then
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
procedure Tfrm_LOSTZ200P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   frm_LOSTZ200P.Enabled := True;
   frm_LOSTZ200P.Show;
end;

procedure Tfrm_LOSTZ200P_CHILD.btn_resetClick(Sender: TObject);
begin
  changeBtn(Self);
  btn_Update.Enabled := False;
  btn_Delete.Enabled := False;
  btn_Link.Enabled := False;
  btn_excel.Enabled := False;
  btn_Print.Enabled := False;
  btn_Inquiry.Enabled := False;

  edt_Cd_No.Text := '';
  edt_Cd_Nm.Text := '';
  sys_nm_01.Text := '';
  sys_nm_02.Text := '';
  sys_nm_03.Text := '';
  sys_nm_04.Text := '';
  sys_nm_05.Text := '';

  edt_Cd_No.Enabled := True;
  edt_Cd_No.Enabled := True;
  edt_Cd_Nm.Enabled := True;
  sys_nm_01.Enabled := True;
  sys_nm_02.Enabled := True;
  sys_nm_03.Enabled := True;
  sys_nm_04.Enabled := True;
  sys_nm_05.Enabled := True;
  rdo_Sh_Yes.Enabled := True;
  rdo_Sh_No.Enabled := True;

  

end;

end.
