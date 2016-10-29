{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ250P (우체국 정산예정일자 입력 (팝업))
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 27
완료일	      : ####. ##. ##
프로그램 개요 : 공통 코드 자료를 등록, 수정, 삭제, 조회한다.
     * TYPE절은 입력화면과 공통으로 사용하므로 IMPLEMENTATION 앞쪽에 위치....
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTZ250P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, Menus,Clipbrd, monthEdit, ComObj;

const
  TITLE   = '우체국정산예정일자 입력';
  PGM_ID  = 'LOSTZ250P';

type
  Tfrm_LOSTZ250P_CHILD = class(TForm)
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmb_ac_gu: TComboBox;
    edt_ac_dt: TEdit;
    sts_Message: TStatusBar;
    edt_ac_ym: TCalendarMonth;
    edt_du_dt: TDateEdit;
    btn_reset: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure edt_ac_ymChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure btn_resetClick(Sender: TObject);

  private
    { Private declarations }
    cmb_ac_gu_d: TZ0xxArray;
  public
    { Public declarations }
  end;

var
  frm_LOSTZ250P_CHILD: Tfrm_LOSTZ250P_CHILD;

implementation
{$R *.dfm}
uses u_LOSTZ250P;

procedure Tfrm_LOSTZ250P_CHILD.setEdtKeyPress;
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

procedure Tfrm_LOSTZ250P_CHILD.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{-----------------------------------------------------------------------------}

procedure Tfrm_LOSTZ250P_CHILD.FormCreate(Sender: TObject);
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
  {     }
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


  initComboBoxWithZ0xx('Z081.dat', cmb_ac_gu_d, '', ' ',cmb_ac_gu);
  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ250P_CHILD.FormShow(Sender: TObject);
var
   DateSet : String;
   Button : TSpeedButton absolute Sender;

begin
  btn_Inquiry.Enabled := False;
  frm_LOSTZ250P.Enabled := False;
  sts_Message.Panels[1].Text := '';

 if (Button.Name = 'btn_Add') then begin
     changeBtn(Self);
     btn_Add.Enabled := true;
     btn_Update.Enabled := false;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_reset.Enabled := True;


     edt_du_dt.Text := '';
     edt_ac_dt.Text := '';
     cmb_ac_gu.Text := '';


     edt_ac_ym.Text := Copy(delHyphen(DateToStr(Date)),1,6);
     edt_du_dt.Date := IncMonth(StrToDate(edt_ac_ym.EditText+ '-07'),+1);
     
     edt_ac_ym.Enabled := True;
     edt_du_dt.Enabled := True;
     edt_ac_dt.Enabled := False;
     cmb_ac_gu.Enabled := False;
     cmb_ac_gu.ItemIndex := 0;

     self.Show;
     edt_ac_ym.SetFocus;

  end else if (Sender.ClassName = 'TStringGrid') then begin

     changeBtn(Self);
     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_reset.Enabled := False;

     edt_ac_ym.Text := delHyphen(AC_YM);
    // cmb_ac_gu.ItemIndex := cmb_ac_gu.Items.IndexOf(findNameFromCode(AC_GU,cmb_ac_gu_d,cmb_ac_gu.Items.Count));
     edt_ac_dt.Text := AC_DT;

     edt_du_dt.Text := InsHyphen(DU_DT);

     if Length(AC_DT) > 0 then begin
      edt_ac_ym.Enabled := False;
      edt_du_dt.Enabled := False;
      edt_ac_dt.Enabled := False;
      cmb_ac_gu.Enabled := True ;
      cmb_ac_gu.ItemIndex := 3;


     end else begin
      edt_ac_ym.Enabled := False;
      edt_du_dt.Enabled := True;
      edt_ac_dt.Enabled := False;
      cmb_ac_gu.Enabled := False;
      cmb_ac_gu.ItemIndex := 0;

     end;

  end else if (Button.Name = 'btn_Update') then  begin

     changeBtn(Self);
     btn_Add.Enabled := false;
     btn_Update.Enabled := true;
     btn_Delete.Enabled := false;
     btn_Inquiry.Enabled := false;
     btn_reset.Enabled := False;

     edt_ac_ym.Text := delHyphen(AC_YM);
     cmb_ac_gu.ItemIndex := cmb_ac_gu.Items.IndexOf(findNameFromCode(AC_GU,cmb_ac_gu_d,cmb_ac_gu.Items.Count));
     edt_ac_dt.Text := AC_DT;

     edt_du_dt.Text := InsHyphen(DU_DT);

     if Length(AC_DT) > 0 then begin
      edt_ac_ym.Enabled := False;
      edt_du_dt.Enabled := False;
      edt_ac_dt.Enabled := False;
      cmb_ac_gu.Enabled := True ;
      cmb_ac_gu.ItemIndex := 3;

     end else begin
      edt_ac_ym.Enabled := False;
      edt_du_dt.Enabled := True;
      edt_ac_dt.Enabled := False;
      cmb_ac_gu.Enabled := False;
      cmb_ac_gu.ItemIndex := 0;

     end;

  end else if (Button.Name = 'btn_Delete') then  begin

     changeBtn(Self);
     btn_Add.Enabled := False;
     btn_Update.Enabled := False;
     btn_Delete.Enabled := True;
     btn_Inquiry.Enabled := False;
     btn_reset.Enabled := False;

     edt_ac_ym.Enabled := False;
     edt_du_dt.Enabled := False;
     edt_ac_dt.Enabled := False;
     cmb_ac_gu.Enabled := False;

     edt_ac_ym.Text := AC_YM;
     edt_du_dt.Text := DU_DT;
     cmb_ac_gu.ItemIndex := 1;


  end;
     self.Show;
end;

procedure Tfrm_LOSTZ250P_CHILD.btn_CloseClick(Sender: TObject);
begin
  frm_LOSTZ250P.btn_InquiryClick(Sender);
  close;
  frm_LOSTZ250P.Enabled := True;
  frm_LOSTZ250P.Show;
end;

procedure Tfrm_LOSTZ250P_CHILD.btn_AddClick(Sender: TObject);
  LABEL LIQUIDATION;
begin
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
	if (TMAX.SendString('INF003','LOSTZ250P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'I01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', edt_ac_ym.Text  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(edt_du_dt.Text)  )   < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ250P') then
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

  frm_LOSTZ250P.btn_InquiryClick(Sender);
  frm_LOSTZ250P.Enabled := True;
  frm_LOSTZ250P.Show;
  close;

end;

procedure Tfrm_LOSTZ250P_CHILD.btn_UpdateClick(Sender: TObject);
  LABEL LIQUIDATION;
begin
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
	if (TMAX.SendString('INF003','LOSTZ250P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR001', delHyphen(edt_ac_ym.Text)  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(edt_du_dt.Text)  )   < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', cmb_ac_gu_d[cmb_ac_gu.ItemIndex].code) < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTZ250P') then
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

  frm_LOSTZ250P.btn_InquiryClick(Sender);
  frm_LOSTZ250P.Enabled := True;
  frm_LOSTZ250P.Show;
  close;
end;

procedure Tfrm_LOSTZ250P_CHILD.btn_DeleteClick(Sender: TObject);
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
      if (TMAX.SendString('INF003','LOSTZ250P'      )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('INF001', 'D01'           )   < 0) then  goto LIQUIDATION;
      if (TMAX.SendString('STR001', edt_ac_ym.Text  )   < 0) then  goto LIQUIDATION;


        //서비스 호출
      if not TMAX.Call('LOSTZ250P') then
        begin
          if (TMAX.RecvString('INF011',0) = 'Y') then
           sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
          else
           MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);
          goto LIQUIDATION;
        end
      else
        begin
            sts_Message.Panels[1].Text := '삭제 완료';
             ShowMessage('성공적으로 삭제되었습니다.')
        end;

    LIQUIDATION:
      TMAX.InitBuffer;
      TMAX.FreeBuffer;
      TMAX.EndTMAX;
      TMAX.Disconnect;

  frm_LOSTZ250P.btn_InquiryClick(Sender);
  frm_LOSTZ250P.Enabled := True;
  frm_LOSTZ250P.Show;
  close;

end;

procedure Tfrm_LOSTZ250P_CHILD.edt_ac_ymChange(Sender: TObject);
begin
   edt_du_dt.Date := IncMonth(StrToDate(edt_ac_ym.EditText+ '-07'),+1);
end;

procedure Tfrm_LOSTZ250P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTZ250P.Enabled := True;
  frm_LOSTZ250P.Show;
end;

procedure Tfrm_LOSTZ250P_CHILD.btn_resetClick(Sender: TObject);
begin

  edt_ac_ym.Text := Copy(delHyphen(DateToStr(Date)),1,6);
  edt_du_dt.Date := IncMonth(StrToDate(edt_ac_ym.EditText+ '-07'),+1);

end;

end.
