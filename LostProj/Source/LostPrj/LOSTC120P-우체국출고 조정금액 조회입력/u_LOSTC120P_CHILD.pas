unit u_LOSTC120P_CHILD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, Grids, common_lib,Func_Lib,
  so_tmax, WinSkinData, ComObj;

const
  TITLE   = '��ü����������ݾ��Է� ';
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
{   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;
}
    //���뺯�� ����--common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
	common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
	common_userid:= ParamStr(3);
	common_username:= ParamStr(4);
	common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ���� ĸ�� ����
  lbl_Program_Name.Caption := TITLE;

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // �޼��� �� ���� ����
  pSetStsWidth(sts_Message);

  // �ؽ�Ʈ ���ý� ��ü ���� ���
  pSetTxtSelAll(Self);

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}  

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//	common_userid:= '0294'; //ParamStr(2);
//	common_username:= '��ȣ��';
//  ParamStr(3);
//	common_usergroup:= 'KAIT'; //ParamStr(4);

  //�����ͽ��ٿ� ����� ������ �����ش�.
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
