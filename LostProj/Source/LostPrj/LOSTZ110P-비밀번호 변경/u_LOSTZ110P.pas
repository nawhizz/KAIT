{*---------------------------------------------------------------------------
���α׷�ID    : LOSTZ110P (��й�ȣ ����)
���α׷� ���� : Online
�ۼ���	      : �� ȫ ��
�ۼ���	      : 2011. 09. 15
�Ϸ���	      : ####. ##. ##
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
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
  TITLE   = '��й�ȣ ����';
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

  {----------------------- ���� ���ø����̼� ���� ---------------------------}
   setEdtKeyPress;
   Self.Caption := '[' + PGM_ID + ']' + TITLE;

   Application.Title := TITLE;
   fSetIcon(Application);
   pSetStsWidth(sts_Message);
   pSetTxtSelAll(Self);

   Self.BorderIcons  := [biSystemMenu,biMinimize];
   Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
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

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  //	common_userid:= '0294'; //ParamStr(2);
	// common_username:= '��ȣ��';
  // ParamStr(3);
	// common_usergroup:= 'KAIT'; //ParamStr(4);

  initSkinForm(SkinData1);


  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;



procedure Tfrm_LOSTZ110P.btn_LoginClick(Sender: TObject);
  LABEL LIQUIDATION;
begin


  if trim(msk_pre.text) = '' then
   begin
      showmessage('���� ��й�ȣ�� �Է��Ͻʽÿ�');
      exit;
   end;

   if trim(msk_upwd.text) = '' then
   begin
      showmessage('���ο� ��й�ȣ�� �Է��Ͻʽÿ�');
      exit;
   end;

   if msk_pre.text = msk_upwd.text then
   begin
      showmessage('���ο� ��й�ȣ�� ������ ��й�ȣ�� �����ϴ�.');
      exit;
   end;

   if trim(msk_passwd.text) = '' then
   begin
      showmessage('���ο� ��й�ȣ�� �ѹ� �� �Է��Ͻʽÿ�');
      exit;
   end;


  if( msk_upwd.text <>  msk_Passwd.text) then begin
      ShowMessage('����й�ȣ �� ���Է��ѹ�ȣ�� ��ġ���� �ʽ��ϴ�.');
      exit;
    end;

  //�������� �޴��� �������� ���ؼ� TMAX�� �����Ѵ�.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server   := 'KAIT_LOSTPRJ';

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
	if (TMAX.SendString('INF002',common_userid    )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTZ110P'      )   < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001', 'U01'           )   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', common_userid) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', Get_EncStr(msk_pre.Text)) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR003', Get_EncStr(msk_upwd.Text)) < 0) then  goto LIQUIDATION;


    //���� ȣ��
	if not TMAX.Call('LOSTZ110P') then
    begin
      sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);

      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

      goto LIQUIDATION;
    end;

    sts_Message.Panels[1].Text := ' ����  �Ϸ�';
    ShowMessage('���������� �����Ǿ����ϴ�.');
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
