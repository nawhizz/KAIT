{*---------------------------------------------------------------------------
���α׷�ID    : LOSTAD100P (���� Ȯ�� �Է�)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2011. 09 .02
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
unit u_LOSTD100P;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  so_tmax, WinSkinData, common_lib, ComObj;

const
  TITLE   = '���� Ȯ�� �Է�';
  PGM_ID  = 'LOSTD100P';

type
  Tfrm_LOSTD100P = class(TForm)
    Bevel2      : TBevel;
    Bevel15     : TBevel;
    Bevel16     : TBevel;
    Bevel18     : TBevel;
    Bevel29     : TBevel;
    Bevel3      : TBevel;
    dte_Ip_Dt_From: TDateEdit;
    Label18     : TLabel;
    lbl_Program_Name: TLabel;
    Label16     : TLabel;
    lbl_Gs_Ct   : TLabel;
    Label15     : TLabel;
    lbl_Gs_Dt   : TLabel;
    Panel2      : TPanel;
    pnl_Command : TPanel;
    SkinData1   : TSkinData;
    btn_Add     : TSpeedButton;
    btn_Update  : TSpeedButton;
    btn_Delete  : TSpeedButton;
    btn_Inquiry : TSpeedButton;
    btn_Link    : TSpeedButton;
    btn_Print   : TSpeedButton;
    btn_Close   : TSpeedButton;
    btn_query   : TSpeedButton;
    btn_excel   : TSpeedButton;
    btn_reset   : TSpeedButton;
    sts_Message : TStatusBar;
    TMAX        : TTMAX;

    procedure FormCreate        (Sender: TObject);
    procedure btn_CloseClick    (Sender: TObject);
    procedure FormClose         (Sender: TObject);
    procedure btn_InquiryClick  (Sender: TObject);
    procedure InitComponents;
    procedure btn_AddClick      (Sender: TObject);
    procedure dte_Ip_Dt_FromKeyPress(Sender: TObject; var Key: Char);
    procedure btn_resetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTD100P: Tfrm_LOSTD100P;

implementation
uses cpaklibm;
{$R *.DFM}


procedure Tfrm_LOSTD100P.FormCreate(Sender: TObject);
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
	//�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then
  begin
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

end;

procedure Tfrm_LOSTD100P.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTD100P.FormClose(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_LOSTD100P.btn_InquiryClick(Sender: TObject);
Label LIQUIDATION;
begin
  if ( not fChkLength(dte_ip_dt_From,8,0,'�԰����� From') ) then Exit;

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
	if (TMAX.SendString('INF003','LOSTD100P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;

    //���� ȣ��
	if not TMAX.Call('LOSTD100P') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

    goto LIQUIDATION;
  end;

  lbl_Gs_Ct.Caption   := convertWithCommer(TMAX.RecvString('INT101',0));
  lbl_Gs_Dt.Caption   := InsHyphen(TMAX.RecvString('STR102',0));

  sts_Message.Panels[1].Text := ' ��ȸ �Ϸ�';

  dte_Ip_Dt_From.Enabled := False;

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
procedure Tfrm_LOSTD100P.InitComponents;
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

    btn_Update.Enabled     := false;
    btn_Delete.Enabled     := false;

    dte_Ip_Dt_From.date    := date;

    dte_Ip_Dt_From.Enabled := True;
    
    dte_Ip_Dt_From.SetFocus;

end;
procedure Tfrm_LOSTD100P.btn_AddClick(Sender: TObject);
label LIQUIDATION;
begin
  if ( not fChkLength(dte_ip_dt_From,8,0,'�԰����� From') ) then Exit;

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
	if (TMAX.SendString('INF003','LOSTD100P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','I01'                             )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delhyphen(dte_ip_dt_From.Text)   )  < 0) then  goto LIQUIDATION;

  //���� ȣ��

	if not TMAX.Call('LOSTD100P') then
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

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
end;

procedure Tfrm_LOSTD100P.dte_Ip_Dt_FromKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btn_InquiryClick(Sender);
end;

procedure Tfrm_LOSTD100P.btn_resetClick(Sender: TObject);
begin
  self.InitComponents;
end;

procedure Tfrm_LOSTD100P.FormShow(Sender: TObject);
begin
  //������Ʈ �ʱ�ȭ
  InitComponents;
end;

end.
