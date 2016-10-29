unit u_LOSTC130P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;
  
const
  TITLE   = '대행조정금액입력';
  PGM_ID  = 'LOSTC130P';

type
  Tfrm_LOSTC130P_CHILD = class(TForm)
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
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    procedure edt_cl_suChange(Sender: TObject);
    procedure edt_cl_suKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTC130P_CHILD: Tfrm_LOSTC130P_CHILD;

implementation
{$R *.dfm}
uses u_LOSTC130P;



{------------------------------------------------------------------------------}
procedure Tfrm_LOSTC130P_CHILD.FormCreate(Sender: TObject);
begin

  //공통변수 설정--common_lib.pas 참조할 것.
  common_kait       := ParamStr(1);
	common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
	common_userid     := ParamStr(3);
	common_username   := ParamStr(4);
	common_usergroup  := ParamStr(5);

  //스태터스바에 사용자 정보를 보여준다.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;

  btn_Inquiry.Enabled := false;
end;

procedure Tfrm_LOSTC130P_CHILD.btn_CloseClick(Sender: TObject);
begin
  close;
  frm_LOSTC130P.Enabled := True;
  frm_LOSTC130P.Show;
end;



procedure Tfrm_LOSTC130P_CHILD.FormShow(Sender: TObject);
var
 Button : TSpeedButton absolute Sender;
begin
  frm_LOSTC130P.Enabled := False;

  changeBtn(Self);

  btn_Add.Enabled     := False;
  btn_Delete.Enabled  := False;
  btn_Inquiry.Enabled := False;

  if (Sender.ClassName = 'TStringGrid') then begin

    btn_Add.Enabled    := False;
    btn_Update.Enabled := True;
    btn_Delete.Enabled := False;

    edt_gm_nm.Text     := GM_NM;
    edt_cl_su.Text     := IntToStr(CL_SU);
    edt_ct_am.Text     := frm_LOSTC130P.grd_display.Cells[4, frm_LOSTC130P.grd_display.Row];
    edt_bi_go.Text     := BI_GO;

    edt_gm_nm.Enabled  := False;
    edt_cl_su.Enabled  := True;
    edt_ct_am.Enabled  := False;

    edt_cl_su.SelectAll;

     
  end else if (Button.Name = 'btn_Update') then  begin

     btn_Add.Enabled    := False;
     btn_Update.Enabled := True;
     btn_Delete.Enabled := False;

     edt_gm_nm.Enabled  := False;
     edt_cl_su.Enabled  := True;
     edt_ct_am.Enabled  := False;

  end else if (Button.Name = 'btn_Delete') then  begin

     btn_Add.Enabled    := False;
     btn_Update.Enabled := False;
     btn_Delete.Enabled := True;

     edt_gm_nm.Enabled  := False;
     edt_cl_su.Enabled  := False;
     edt_ct_am.Enabled  := False;

  end;

  self.Show;
end;

procedure Tfrm_LOSTC130P_CHILD.btn_UpdateClick(Sender: TObject);
begin
   frm_LOSTC130P.grd_display.Cells[3, frm_LOSTC130P.grd_display.Row]  := edt_cl_su.Text;
   frm_LOSTC130P.grd_display.Cells[4, frm_LOSTC130P.grd_display.Row]  := edt_ct_am.Text;
   frm_LOSTC130P.grd_display.Cells[5, frm_LOSTC130P.grd_display.row]  := edt_bi_go.Text ;
   close;
end;

procedure Tfrm_LOSTC130P_CHILD.edt_cl_suChange(Sender: TObject);
var
   cnt : Integer;
   STR001 : String;
begin
  STR001 := ' ';
  if Trim(edt_cl_su.Text) = '-' then
  begin
    edt_ct_am.Text := STR001;
    edt_bi_go.Text := STR001;
    exit;
  end;

  edt_ct_am.Text := IntToStr(CT_AM);

  if Length(edt_cl_su.Text) = 0 then begin
    edt_ct_am.Text := ' ';
    edt_bi_go.Text := ' ';
    exit;
  end;

  cnt := StrToInt(edt_cl_su.Text) * 800;
  edt_ct_am.Text := convertWithCommer(IntToStr(cnt));

  edt_bi_go.Text := '정산 후 핸드폰 도착 ' + edt_cl_su.Text + '건';

end;

procedure Tfrm_LOSTC130P_CHILD.edt_cl_suKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key in ['0'..'9',#25,#08,#13,#45] then
  else
  begin
    Key := #0;
    ShowMessage('숫자만 입력하세요');
  end;
end;

procedure Tfrm_LOSTC130P_CHILD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frm_LOSTC130P.Enabled := True;
  frm_LOSTC130P.Show;
end;

end.
