{*---------------------------------------------------------------------------
���α׷�ID    : LOSTA680L (�н��� ���� ���� ���)
���α׷� ���� : Online
�ۼ���	      : �ִ뼺
�ۼ���	      : 2011.09.02
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
unit u_LOSTA680L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, so_tmax,common_lib,SimpleSFTP, ComObj;

const
  TITLE   = '�н��� ���� ���� ���';
  PGM_ID  = 'LOSTA680L';

type
  Tfrm_LOSTA680L = class(TForm)
    Bevel2: TBevel;
    lbl_Program_Name: TLabel;
    Panel2: TPanel;
    Bevel15: TBevel;
    Label15: TLabel;
    dte_Jn_Dt_From: TDateEdit;
    dte_Jn_Dt_To: TDateEdit;
    Label2: TLabel;
    sts_Message: TStatusBar;
    pnl_Command: TPanel;
    Label3: TLabel;
    Bevel3: TBevel;
    cmb_id_cd: TComboBox;
    SkinData1: TSkinData;
    TMAX: TTMAX;
    btn_Close: TSpeedButton;
    btn_Print: TSpeedButton;
    btn_query: TSpeedButton;
    btn_reset: TSpeedButton;

    procedure PrtFormShow;
    procedure FormCreate      (Sender: TObject);
    procedure btn_CloseClick  (Sender: TObject);
    procedure dte_fromExit    (Sender: TObject);
    procedure dte_toExit      (Sender: TObject);
    procedure btn_PrintClick  (Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_resetClick(Sender: TObject);


  private
    { Private declarations }
    cmb_id_cd_d: TZ0xxArray;
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
    procedure initComponents;
  end;

var
  frm_LOSTA680L: Tfrm_LOSTA680L;

implementation
uses u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTA680L.PrtFormShow;
begin
	// ��� ���̷α� �ڽ�
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet('LOSTA680L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTA680L.FormCreate(Sender: TObject);
begin
   //======== �� ������ ���� ���������� �ۼ��ؾ� �� �κ�======================
//	�� �κ��� �׽�Ƽ �Ⱓ���� �� �ڸ�Ʈ ó���Ѵ�. �׽�Ʈ ���� �Ŀ��� �� �κ��� ������ ��.
	  if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	  ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //���뺯�� ����--common_lib.pas ������ ��.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle     := intToStr(self.Handle);
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

    //common_lib.pas�� �ִ�.
    initSkinForm(SkinData1);
    initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '��ü', ' ',cmb_id_cd);

    //�����ͽ��ٿ� ����� ������ �����ش�.
    sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTA680L.btn_CloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_LOSTA680L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_Jn_Dt_From.Date) > Trunc(dte_Jn_Dt_To.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

//OnExit event --
procedure Tfrm_LOSTA680L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_Jn_Dt_From.Date) > Trunc(dte_Jn_Dt_To.Date) then begin
		showmessage('�������ڴ� �������ں��� �۰� ������ �� �����ϴ�.');
		exit;
	end;

	if Trunc(dte_Jn_Dt_To.Date) > Trunc(date) then begin
		showmessage('�������ڴ� �������� ���ķ� ������ �� �����ϴ�.');
		exit;
	end;
end;

procedure Tfrm_LOSTA680L.disableComponents;
begin
	  btn_Print.Enabled       := False;
    btn_Close.Enabled       := False;
  	dte_Jn_Dt_From.Enabled  := False;
    dte_Jn_Dt_To.Enabled    := False;
    cmb_id_cd.Enabled       := False;

    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA680L.enableComponents;
begin
  btn_Print.Enabled       := True;
  btn_Close.Enabled       := True;
  dte_Jn_Dt_From.Enabled  := True;
  dte_Jn_Dt_To.Enabled    := True;
  cmb_id_cd.Enabled       := True;

    Application.MainForm.Cursor:= crSQLWait;
    sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
    Application.ProcessMessages;
end;

procedure Tfrm_LOSTA680L.btn_PrintClick(Sender: TObject);
var
  remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;
  serviceSuccess  :Boolean;
  FSFTP           :TSimpleSFTP;

  Label LIQUIDATION;
begin
	self.disableComponents;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA680L'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                      ) < 0) then  goto LIQUIDATION;
    //���۳���
	if (TMAX.SendString('STR001', delHyphen(dte_Jn_Dt_From.Text)  ) < 0) then  goto LIQUIDATION;
    //���ᳯ��
	if (TMAX.SendString('STR002', delHyphen(dte_Jn_Dt_To.Text)    ) < 0) then  goto LIQUIDATION;
    //��ǰ����
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  serviceSuccess := TMAX.Call('LOSTA680L');

	if not serviceSuccess then goto LIQUIDATION;

  //���� �н��� ��´�.
  remoteFilePath  := TMAX.RecvString('STR101',0);
  //���ϸ��� ��´�.
  fileName        := getFinalName(remoteFilePath, '/');
  localFilePath   := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath  := getDirPath(remoteFilePath, '/');

  //�������� ������ ���۹޾� ..\KAI\LostPrj\temp �� �����Ѵ�.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.RecvString('STR401',0)
               ,TMAX.RecvString('STR402',0)
               ,TMAX.RecvString('STR403',0)
               ,TMAX.RecvString('STR404',0)
               );

	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

  //TransferProgress(nil,0,0);
  //FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,TransferProgress,nil);
  FSFTP.GetFile(remoteFilePath ,fileName, localFilePath,True,True,False,0,nil,nil);
  FSFTP.Disconnect;
  FSFTP.Free;

  self.enableComponents;

  //��� ���̾�α׸� ������.
  Self.PrtFormShow;

  exit;

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;
  self.enableComponents;
end;

procedure Tfrm_LOSTA680L.initComponents;
begin
  // ��ư �̹��� �ʱ�ȭ
  changeBtn(Self);

  dte_Jn_Dt_From.Date := date;
  dte_Jn_Dt_To.Date   := date;

  cmb_id_cd.ItemIndex := 0;
end;

procedure Tfrm_LOSTA680L.FormShow(Sender: TObject);
begin
  initComponents;
end;

procedure Tfrm_LOSTA680L.btn_resetClick(Sender: TObject);
begin
  initComponents;
end;

end.
