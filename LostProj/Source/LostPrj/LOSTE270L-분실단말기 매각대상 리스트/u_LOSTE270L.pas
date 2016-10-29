{*---------------------------------------------------------------------------
���α׷�ID    : LOSTE270L (�нǴܸ��� �Ű���� ����Ʈ)
���α׷� ���� : Online
�ۼ���	      : �� �� ��
�ۼ���	      : 2012. 01. 19
�Ϸ���	      : ####. ##. ##
���α׷� ���� :
-------------------------------------------------------------------------------
<���� ����>
��������      :
�ۼ���	      :
���泻��      :
ó����ȣ      :
Ver	          :
-----------------------------------------------------------------------------*}
unit u_LOSTE270L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, inifiles, common_lib, so_tmax, SimpleSFTP, ComObj;

const
  TITLE   = '�нǴܸ��� �Ű���� ����Ʈ';
  PGM_ID  = 'LOSTE270L';

type
  Tfrm_LOSTE270L = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel3          : TBevel;
    cmb_in_su       : TComboBox;
    dte_from        : TDateEdit;
    Label3          : TLabel;
    Label15         : TLabel;
    lbl_Program_Name: TLabel;
    pnl_Command     : TPanel;
    Panel2          : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    TMAX            : TTMAX;
    btn_Close       : TSpeedButton;
    btn_Print       : TSpeedButton;
    btn_query       : TSpeedButton;
    btn_Reset       : TSpeedButton;
    procedure PrtFormShow;
    procedure FormCreate    (Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
    procedure Edt_onKeyPress(Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow      (Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);

  private
    { Private declarations }
    cmb_in_su_d: TZ0xxArray;

    qryStr : String;

  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;
  end;

var
  frm_LOSTE270L: Tfrm_LOSTE270L;

implementation
uses u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTE270L.disableComponents;
begin

  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;

end;

procedure Tfrm_LOSTE270L.enableComponents;
begin
  changeBtn(Self);

  btn_Print.Enabled := True;
	dte_from.Enabled  := True;
  cmb_in_su.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTE270L.PrtFormShow;
begin
	// ��� ���̷α� �ڽ�
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(PGM_ID + '.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;

procedure Tfrm_LOSTE270L.setEdtKeyPress;
 var i : Integer;
     edt : TEdit;
 begin
   for i := 0 to componentCount -1 do
   begin
     if (Components[i] is TEdit) then
     begin
       (Components[i] as TEdit).OnKeyPress := Self.Edt_onKeyPress;
     end;
   end;
end;

procedure Tfrm_LOSTE270L.Edt_onKeyPress ( Sender : TObject; var key : Char);
 begin
   if (key = #13) then
     SelectNext( ActiveControl as TEdit , true, True);
end;

{----------------------------------------------------------------------------}
procedure Tfrm_LOSTE270L.FormCreate(Sender: TObject);
begin

  //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
	if ParamCount <> 6 then
  begin
    ShowMessage('�α��� �� ����ϼ���');
    PostMessage(self.Handle, WM_QUIT, 0,0);
    exit;
  end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait       := ParamStr(1);
  common_caller     := ParamStr(2);
  common_handle     := intToStr(self.Handle);
  common_userid     := ParamStr(3);
  common_username   := ParamStr(4);
  common_usergroup  := ParamStr(5);
  common_seedkey    := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
//  common_userid     := '0294';    //ParamStr(2);
//  common_username   := '��ȣ��';  //ParamStr(3);
//  common_usergroup  := 'SYSM';    //ParamStr(4);

  {----------------------- ���� ���ø����̼� ���� ---------------------------}
  setEdtKeyPress;
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  Application.Title := TITLE;
  fSetIcon(Application);
  pSetStsWidth(sts_Message);
  pSetTxtSelAll(Self);

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     :=  poScreenCenter;
  {--------------------------------------------------------------------------}  

  initComboBoxWithZ0xx('Z085.dat', cmb_in_su_d, '��ü', ' ',cmb_in_su);

  initSkinForm(SkinData1);

  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTE270L.btn_PrintClick(Sender: TObject);
var

  count1,i        : Integer;

	remoteFilePath  :String;
  fileName        :String;
  localFilePath   :String;

  serviceSuccess:Boolean;
	FSFTP:TSimpleSFTP;

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
	if (TMAX.SendString('INF002',common_userid                            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username                          ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup                         ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003',PGM_ID                                   ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                                    ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)                ) < 0) then  goto LIQUIDATION;
  if (TMAX.SendString('STR002', cmb_in_su_d[cmb_in_su.ItemIndex].code   ) < 0) then  goto LIQUIDATION;

  serviceSuccess := TMAX.Call(PGM_ID);

  if not serviceSuccess then
  begin
     if (TMAX.RecvString('INF011',0) = 'Y') then
       sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0)
     else
       MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('����ȣ�� ����'),MB_OK);

     goto LIQUIDATION;
   end;

  // ��Ƚ�� ī����
  count1 := TMAX.RecvInteger('INF013',0);

  if count1 < 1 then
  begin
    ShowMessage('����� �ڷᰡ �����ϴ�.');
    goto LIQUIDATION;
  end;

  //���� �н��� ��´�.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  qryStr        := TMAX.RecvString('INF014',0);

  //���ϸ��� ��´�.
  fileName      := getFinalName(remoteFilePath, '/');
  localFilePath := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath:= getDirPath(remoteFilePath, '/');

  //�������� ������ ���۹޾� ..\KAI\LostPrj\temp �� �����Ѵ�.
  FSFTP:=TSimpleSFTP.Create;

  FSFTP.Connect(TMAX.Host
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
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet(getDirPath(fileName,'_') + '.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;

  exit;

LIQUIDATION:
  TMAX.InitBuffer;
  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

  self.enableComponents;
end;

procedure Tfrm_LOSTE270L.btn_ResetClick(Sender: TObject);
begin
	dte_from.Date       := date;

  cmb_in_su.ItemIndex := 0;

  changeBtn(Self);
end;

procedure Tfrm_LOSTE270L.btn_queryClick(Sender: TObject);
var
	cmdStr  :String;
  filePath:String;
  f:TextFile;
begin
	if qryStr ='' then
    	exit;

  filePath:='..\Temp\' + PGM_ID + '_QRY.txt';
  AssignFile(f, filePath);
  Rewrite(f);
  WriteLn(f, qryStr);
  CloseFile(f);

  cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
  WinExec(PChar(cmdStr), SW_SHOW);
end;

procedure Tfrm_LOSTE270L.FormShow(Sender: TObject);
begin
    btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTE270L.btn_CloseClick(Sender: TObject);
begin
  close;
end;

end.
