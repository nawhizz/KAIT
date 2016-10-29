{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ110P (비밀번호 변경)
프로그램 종류 : Online
작성자	      : 정 홍 렬
작성일	      : 2011. 09. 15
완료일	      : ####. ##. ##
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	          :
-----------------------------------------------------------------------------*}
unit
    u_LOSTZ110P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '비밀번호 변경';
  PGM_ID  = 'LOSTZ110P';

type
  Tfrm_LOSTZ110P = class(TForm)
    msk_upwd: TMaskEdit;
    msk_Passwd: TMaskEdit;
    msk_pre: TMaskEdit;
    pnl_Program_Name: TLabel;
    Bevel2: TBevel;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Label3: TLabel;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    sts_Message: TStatusBar;
    btn_Login: TButton;
    btn_Close: TButton;
    Label2: TLabel;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTZ110P: Tfrm_LOSTZ110P;

implementation
uses cpaklibm;
{$R *.DFM}

procedure Tfrm_LOSTZ110P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ110P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}

procedure Tfrm_LOSTZ110P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ110P.FormCreate(Sender: TObject);
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

  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
  //	common_userid:= '0294'; //ParamStr(2);
	// common_username:= '정호영';
  // ParamStr(3);
	// common_usergroup:= 'KAIT'; //ParamStr(4);

  initSkinForm(SkinData1);


  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;



procedure Tfrm_LOSTZ110P.btn_LoginClick(Sender: TObject);
  LABEL LIQUIDATION;
begin


  if trim(msk_pre.text) = '' then
   begin
      showmessage('이전 비밀번호를 입력하십시오');
      exit;
   end;

   if trim(msk_upwd.text) = '' then
   begin
      showmessage('새로운 비밀번호를 입력하십시오');
      exit;
   end;

   if msk_pre.text = msk_upwd.text then
   begin
      showmessage('새로운 비밀번호가 기존의 비밀번호와 같습니다.');
      exit;
   end;

   if trim(msk_passwd.text) = '' then
   begin
      showmessage('새로운 비밀번호를 한번 더 입력하십시오');
      exit;
   end;


  if( msk_upwd.text <>  msk_Passwd.text) then begin
      ShowMessage('새비밀번호 와 재입력한번호와 일치하지 않습니다.');
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
	if (TMAX.SendString('INF003','LOSTZ110P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', common_userid) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', Get_EncStr(msk_pre.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', Get_EncStr(msk_upwd.Text)) < 0) then  goto LIQUIDATION;


    //서비스 호출
	if not TMAX.Call('LOSTZ110P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

      goto LIQUIDATION;
    end;

    sts_Message.Panels[1].Text := ' 수정  완료';
    ShowMessage('성공적으로 수정되었습니다.');
LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  close;

end;

procedure Tfrm_LOSTZ110P.FormShow(Sender: TObject);
begin

  changeBtn(Self);
  msk_pre.Text := '';
  msk_upwd.Text := '';
  msk_Passwd.Text := '';
  sts_Message.Panels[1].Text := '';

  sts_Message.Panels[1].Width := 200;



end;

end.
