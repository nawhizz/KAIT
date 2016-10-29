{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB120P (����ǰ ��ü�� ���� �Է�)
���α׷� ���� : Online
�ۼ���	      : �ִ뼺
�ۼ���	      : 2011. 09. 01
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTB120P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  so_tmax, WinSkinData ,common_lib, ComObj;

const
  TITLE   = '����ǰ ��ü�� ���� �Է�';
  PGM_ID  = 'LOSTB120P';

type
  Tfrm_LOSTB120P = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel16         : TBevel;
    Bevel29         : TBevel;
    Bevel1          : TBevel;
    Bevel3          : TBevel;
    dte_Ip_Dt_From  : TDateEdit;
    dte_Ip_Dt_To    : TDateEdit;
    lbl_Sb_Ct       : TLabel;
    Label16         : TLabel;
    Label2          : TLabel;
    Label15         : TLabel;
    Label1          : TLabel;
    lbl_Program_Name: TLabel;
    lbl_Ju_Dt       : TLabel;
    Panel2          : TPanel;
    pnl_Command     : TPanel;
    sts_Message     : TStatusBar;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    btn_Add: TSpeedButton;
    btn_Update: TSpeedButton;
    btn_Delete: TSpeedButton;
    btn_Inquiry: TSpeedButton;
    btn_Link: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_Close: TSpeedButton;
    btn_query: TSpeedButton;
    btn_excel: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure FormCreate        (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure FormClose         (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure InitComponents;
    procedure btn_AddClick      (Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);
    procedure dte_Ip_Dt_ToKeyPress(Sender: TObject; var Key: Char);
    procedure dte_Ip_Dt_FromKeyPress(Sender: TObject; var Key: Char);
    procedure dte_Ip_Dt_FromExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTB120P: Tfrm_LOSTB120P;

implementation
uses cpaklibm;
{$R *.DFM}


procedure Tfrm_LOSTB120P.FormCreate(Sender: TObject);
begin
  //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then begin
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait     := ParamStr(1);
  common_caller   := ParamStr(2);
  common_handle   := intToStr(self.Handle);
  common_userid   := ParamStr(3);
  common_username := ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

    //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '��ȣ��';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

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

  // ��Ų�� �ʱ�ȭ
  initSkinForm(SkinData1);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;  
end;

procedure Tfrm_LOSTB120P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTB120P.FormClose(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_LOSTB120P.btn_InquiryClick(Sender: TObject);
Label LIQUIDATION;
begin
  if ( not fChkLength(dte_ip_dt_From,8,0,'�԰����� From') ) then Exit;
  if ( not fChkLength(dte_Ip_Dt_To  ,8,0,'�԰����� To'  ) ) then Exit;

//�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server�� ã���� �����ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX ������ ����Ǿ� ���� �ʽ��ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX �޸� �Ҵ翡 ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB120P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delhyphen(dte_ip_dt_To.Text)     )  < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTB120P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  lbl_ju_dt.Caption   := InsHyphen(TMAX.RecvString('STR101',0));
  lbl_Sb_Ct.Caption   := convertWithCommer(TMAX.RecvString('INT102',0));

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

  dte_Ip_Dt_From.Enabled  := False;
  dte_Ip_Dt_To.Enabled    := False;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

(******************************************************************************)
(* procedure name  : InitComponents                                           *)
(* procedure �� �� : ��������� ���۳�Ʈ�� �ʱ�ȭ�Ѵ�.                        *)
(*                                                                            *)
(******************************************************************************)
procedure Tfrm_LOSTB120P.InitComponents;
var
  i : Integer;
  component : TComponent;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    component := Components[i];

    if (component is TLabel) then
      if(Pos('lbl_',(component as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(component as TLabel).Name) = 0)
       then (component as TLabel).Caption := '';
  end;

  changeBtn(Self);

  dte_Ip_Dt_From.date     := date;
  dte_Ip_Dt_To.date       := date;
  btn_Update.Enabled      := False;
  btn_Delete.Enabled      := False;
  dte_Ip_Dt_From.Enabled  := True;
  dte_Ip_Dt_To.Enabled    := True;

  dte_Ip_Dt_From.SetFocus;

end;
procedure Tfrm_LOSTB120P.btn_AddClick(Sender: TObject);
label LIQUIDATION;
begin
  if dte_Ip_Dt_From.Enabled then
  begin
    ShowMessage('��ȸ �� �����ϼ���.');
    Exit;
  end;

  if ( not fChkLength(dte_ip_dt_From,8,0,'�԰����� From') ) then Exit;
  if ( not fChkLength(dte_Ip_Dt_To  ,8,0,'�԰����� To'  ) ) then Exit;

//�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server�� ã���� �����ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX ������ ����Ǿ� ���� �ʽ��ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX �޸� �Ҵ翡 ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
    goto LIQUIDATION;
	end;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB120P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delhyphen(dte_ip_dt_To.Text)     )  < 0) then  goto LIQUIDATION;

  //���� ȣ��
	if not TMAX.Call('LOSTB120P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  ShowMessage('���������� �����Ͽ����ϴ�.');

  // ������Ʈ �ʱ�ȭ
  InitComponents;

  sts_Message.Panels[1].Text := ADD_SUCCESS;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTB120P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
  InitComponents;
end;

procedure Tfrm_LOSTB120P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTB120P.dte_Ip_Dt_ToKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);  
end;

procedure Tfrm_LOSTB120P.dte_Ip_Dt_FromKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    SelectNext( sender as TWinControl, true, True);
end;

procedure Tfrm_LOSTB120P.dte_Ip_Dt_FromExit(Sender: TObject);
begin
  if (Sender as TDateEdit).Date > Date then
  begin
    ShowMessage('�ش����ڰ� ���Ϻ��� Ů�ϴ�.');
    (Sender as TDateEdit).SetFocus;
    (Sender as TDateEdit).Date := Date;
    Exit;
  end;
end;

end.
