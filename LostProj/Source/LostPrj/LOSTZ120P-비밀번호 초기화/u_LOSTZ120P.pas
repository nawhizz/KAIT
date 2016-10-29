{*---------------------------------------------------------------------------
프로그램ID    : LOSTZ120P (비밀번호 초기화)
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

unit u_LOSTZ120P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData,u_LOSTZ120P_pop, ComObj;

const
  TITLE   = '비밀번호초기화';
  PGM_ID  = 'LOSTZ120P';

type
  Tfrm_LOSTZ120P = class(TForm)
    lbl_Program_Name: TLabel;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    edt_Ur_Id: TEdit;
    pop: TBitBtn;
    edt_Ur_Nm: TEdit;
    sts_Message: TStatusBar;
    btn_Login: TButton;
    btn_Close: TButton;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    procedure popClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTZ120P: Tfrm_LOSTZ120P;

  US_ID : String;

implementation

{$R *.dfm}
procedure Tfrm_LOSTZ120P.setEdtKeyPress;
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

procedure Tfrm_LOSTZ120P.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}

procedure Tfrm_LOSTZ120P.FormCreate(Sender: TObject);
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
  {  }
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
  end;

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  //테스트 후에는 이 부분을 삭제할 것.
//	common_userid:= '0294'; //ParamStr(2);
//	common_username:= '정호영';
//  ParamStr(3);
//	common_usergroup:= 'KAIT'; //ParamStr(4);

  initSkinForm(SkinData1);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

end;

procedure Tfrm_LOSTZ120P.popClick(Sender: TObject);
begin
 US_ID := '';
 US_ID := edt_Ur_Id.Text;
 frm_LOSTZ120P_pop.Show;
end;

procedure Tfrm_LOSTZ120P.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTZ120P.btn_LoginClick(Sender: TObject);
 Label LIQUIDATION;
begin

   if Length(edt_Ur_Id.text) < 1 then begin
      ShowMessage('사용자 ID를 입력해 주십시오.');
      exit;
   end;

   if Length(edt_Ur_Nm.text) < 1 then begin
      ShowMessage('사용자명 을 입력해 주십시오.');
      exit;
   end;

   if MessageDlg('비밀번호를 초기화 하시겠습니까 ?',mtConfirmation, mbOkCancel, 0) = mrCancel then
   begin
      sts_Message.Panels[1].Text :=' 취소되었습니다';
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
    if (TMAX.SendString('INF003','LOSTZ120P'      )   < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', edt_Ur_Id.Text  )   < 0) then  goto LIQUIDATION;


      //서비스 호출
    if not TMAX.Call('LOSTZ120P') then
      begin
        sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

        MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

        goto LIQUIDATION;
      end
    else
      begin
          sts_Message.Panels[1].Text := ' 수정  완료';
           ShowMessage('성공적으로 수정되었습니다.');

      end;

  LIQUIDATION:
    TMAX.InitBuffer;
    TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

    close;
end;

end.
