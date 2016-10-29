unit u_LOSTC120P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '우체국출고조정금액입력 ';
  PGM_ID  = 'LOSTC120P';

type
  Tfrm_LOSTC120P_CHILD = class(TForm)
    pnl_Command: TPanel;
    btn_Close: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Add: TSpeedButton;
    lbl_Program_Name: TLabel;
    TMAX: TTMAX;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel7: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    edt_gm_nm: TEdit;
    edt_cl_su: TEdit;
    edt_ct_am: TEdit;
    edt_bi_go: TEdit;
    sts_Message: TStatusBar;
    btn_Print: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTC120P_CHILD: Tfrm_LOSTC120P_CHILD;

implementation
{$R *.dfm}
uses u_LOSTC120P;



{------------------------------------------------------------------------------}
procedure Tfrm_LOSTC120P_CHILD.FormCreate(Sender: TObject);
begin
{   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
	if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;
}
    //공통변수 설정--common_lib.pas 참조할 것.
  common_kait:= ParamStr(1);
	common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
	common_userid:= ParamStr(3);
	common_username:= ParamStr(4);
	common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

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

    //테스트 후에는 이 부분을 삭제할 것.
//	common_userid:= '0294'; //ParamStr(2);
//	common_username:= '정호영';
//  ParamStr(3);
//	common_usergroup:= 'KAIT'; //ParamStr(4);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  btn_Inquiry.Enabled := false;


end;

procedure Tfrm_LOSTC120P_CHILD.btn_CloseClick(Sender: TObject);
begin
  close;
end;



procedure Tfrm_LOSTC120P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
    if (Sender.ClassName = 'TStringGrid') then begin

     btn_Add.Enabled := False;
     btn_Update.Enabled := True;
     btn_Delete.Enabled := False;

     edt_gm_nm.Text := GM_NM;
     edt_cl_su.Text := IntToStr(CL_SU);
     edt_ct_am.Text := IntToStr(CT_AM);
     edt_bi_go.Text := BI_GO;

     edt_gm_nm.Enabled := False;
     edt_cl_su.Enabled := False;
     
  end else if (Button.Name = 'btn_Update') then  begin

     btn_Add.Enabled := False;
     btn_Update.Enabled := True;
     btn_Delete.Enabled := False;

  end else if (Button.Name = 'btn_Delete') then  begin

     btn_Add.Enabled := False;
     btn_Update.Enabled := False;
     btn_Delete.Enabled := True;

  end;

   self.Show;


end;

procedure Tfrm_LOSTC120P_CHILD.btn_UpdateClick(Sender: TObject);
begin
   frm_LOSTC120P.grd_display.Cells[3, frm_LOSTC120P.grd_display.Row]  := edt_ct_am.Text;
   frm_LOSTC120P.grd_display.Cells[4, frm_LOSTC120P.grd_display.row] := edt_bi_go.Text ;
   close;
end;

end.
