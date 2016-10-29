{*---------------------------------------------------------------------------
���α׷�ID    : LOSTB550L (����ǰ �ݼ� ���� ���)
���α׷� ���� : Online
�ۼ���	      : �ִ뼺
�ۼ���	      : 2011. 08. 17
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
unit u_LOSTB550L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, inifiles, common_lib, so_tmax, SimpleSFTP, ComObj;

const
  TITLE   = '����ǰ�ݼ۳������';
  PGM_ID  = 'LOSTB550L';

type
  Tfrm_LOSTB550L = class(TForm)
    Bevel2          : TBevel;
    Bevel15         : TBevel;
    Bevel4          : TBevel;
    Bevel1          : TBevel;
    cmb_sp_cd       : TComboBox;
    cmb_prt_gu      : TComboBox;
    dte_from        : TDateEdit;
    dte_to          : TDateEdit;
    lbl_Program_Name: TLabel;
    Label2          : TLabel;
    Label1          : TLabel;
    Label15         : TLabel;
    Label4          : TLabel;
    pnl_Command     : TPanel;
    Panel2          : TPanel;
    SkinData1       : TSkinData;
    sts_Message     : TStatusBar;
    TMAX            : TTMAX;
    btn_Print: TSpeedButton;
    btn_Reset: TSpeedButton;
    btn_query: TSpeedButton;
    btn_Close: TSpeedButton;

    procedure PrtFormShow;
    procedure FormCreate      (Sender: TObject);
    procedure btn_CloseClick  (Sender: TObject);
    procedure dte_fromExit    (Sender: TObject);
    procedure dte_toExit      (Sender: TObject);
    procedure btn_PrintClick  (Sender: TObject);
    procedure btn_ResetClick(Sender: TObject);

    procedure Edt_onKeyPress( Sender : TObject; var key : Char);
    procedure setEdtKeyPress;
    procedure FormShow(Sender: TObject);
    procedure btn_queryClick(Sender: TObject);
  private
    { Private declarations }
    qryStr : String;
  public
    { Public declarations }
    procedure disableComponents;
    procedure enableComponents;

  end;

var
  frm_LOSTB550L: Tfrm_LOSTB550L;
  arrSpCd : TZ0xxArray;  

implementation
uses u_landprt;
{$R *.DFM}

procedure Tfrm_LOSTB550L.setEdtKeyPress;
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

procedure Tfrm_LOSTB550L.Edt_onKeyPress ( Sender : TObject; var key : Char);
begin
 if (key = #13) then
   SelectNext( ActiveControl as TEdit , true, True);
end;

procedure Tfrm_LOSTB550L.disableComponents;
begin
  disableBtn(Self);

  Application.MainForm.Cursor:= crSQLWait;
  sts_Message.Panels[1].Text := '������ ó����...��� ��ٷ� �ֽʽÿ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB550L.enableComponents;
begin
  changeBtn(Self);

  dte_from.Enabled := True;
  dte_to.Enabled := True;
  cmb_sp_cd.Enabled := True;
  cmb_prt_gu.Enabled := True;

  Application.MainForm.Cursor:= crDefault;
  sts_Message.Panels[1].Text := '������ ó���Ϸ�.';
  Application.ProcessMessages;
end;

procedure Tfrm_LOSTB550L.PrtFormShow;
begin
	// ��� ���̷α� �ڽ�
	frm_LANDPRT := Tfrm_LANDPRT.Create(self);
	frm_LANDPRT.FormSet('LostB550L.txt', lbl_Program_Name.Caption);
	try
		frm_LANDPRT.ShowModal;
	finally
		frm_LANDPRT.Free;
	end;
end;
{----------------------------------------------------------------------------}
procedure Tfrm_LOSTB550L.FormCreate(Sender: TObject);
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
  {     }
	if ParamCount <> 6 then begin //���� ���α׷��� �����ϰ� �Ķ���� ���� ī��Ʈ �Ѵ�.
    	ShowMessage('�α��� �� ����ϼ���');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

  //���뺯�� ����--common_lib.pas ������ ��.
  common_kait:= ParamStr(1);
  common_caller:= ParamStr(2);
  common_handle:= intToStr(self.Handle);
  common_userid:= ParamStr(3);
  common_username:= ParamStr(4);
  common_usergroup:= ParamStr(5);
  common_seedkey  := ParamStr(6);

  //�׽�Ʈ �Ŀ��� �� �κ��� ������ ��.
  //common_userid   := '0294';    //ParamStr(2);
  //common_username := '��ȣ��';  //ParamStr(3);
  //common_usergroup:= 'KAIT';    //ParamStr(4);

  //common_lib.pas�� �ִ�.
  initSkinForm(SkinData1);

  initComboBoxWithZ0xx('Z035.dat',arrSpCd,'��ü','',cmb_sp_cd);


  //�����ͽ��ٿ� ����� ������ �����ش�.
  sts_Message.Panels[2].Text := '['+ common_userid +']'+ common_username;
end;

procedure Tfrm_LOSTB550L.btn_CloseClick(Sender: TObject);
begin
     close;
end;

//OnExit event - 
procedure Tfrm_LOSTB550L.dte_fromExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';
	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then begin
		showmessage('�������ڴ� �������ں��� ũ�� ������ �� �����ϴ�.');
		exit;
    end;
end;

//OnExit event --
procedure Tfrm_LOSTB550L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_from.Date) > Trunc(dte_to.Date) then
  begin
		showmessage('�������ڴ� �������ں��� �۰� ������ �� �����ϴ�.');
		exit;
	end;

	if Trunc(dte_to.Date) > Trunc(date) then
  begin
		showmessage('�������ڴ� �������� ���ķ� ������ �� �����ϴ�.');
		exit;
	end;
end;

//'���' ��ư Ŭ��
procedure Tfrm_LOSTB550L.btn_PrintClick(Sender: TObject);
var
  count1,i : Integer;

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

	TMAX.InitBuffer;

    //�����Է� �κ�
	if (TMAX.SendString('INF002',common_userid)   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup)< 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTB550L')     < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01') < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('STR001', delHyphen(dte_from.Text)) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', delHyphen(dte_to.Text))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', copy(cmb_prt_gu.Items[cmb_prt_gu.itemIndex],41,1))   < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR004', arrSpCd[cmb_sp_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //���� ȣ��
  serviceSuccess := TMAX.Call('LOSTB550L');

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

  if count1 < 1 then begin
    ShowMessage('����� �ڷᰡ �����ϴ�.');
    goto LIQUIDATION;
  end;

  //���� ���
  qryStr:= TMAX.RecvString('INF014',0);
  
  //���� �н��� ��´�.
  remoteFilePath:= TMAX.RecvString('STR101',0);

  //���ϸ��� ��´�.
  fileName:= getFinalName(remoteFilePath, '/');
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

procedure Tfrm_LOSTB550L.btn_ResetClick(Sender: TObject);
begin
  cmb_sp_cd.ItemIndex := 0;

  cmb_prt_gu.ItemS.Insert(0, '��ü                                    1');
  cmb_prt_gu.ItemS.Insert(1, '��߼�����                              2');
  cmb_prt_gu.ItemIndex := 0;

  changeBtn(Self);

  dte_from.Date := date-30;
  dte_to.Date := date;
end;

procedure Tfrm_LOSTB550L.FormShow(Sender: TObject);
begin
  btn_ResetClick(Sender);
end;

procedure Tfrm_LOSTB550L.btn_queryClick(Sender: TObject);
var
	cmdStr:String;
    filePath:String;
    f:TextFile;
begin
	if qryStr ='' then
    	exit;

    filePath:='..\Temp\LOSTB550L_QRY.txt';
    AssignFile(f, filePath);
    Rewrite(f);
	WriteLn(f, qryStr);
    CloseFile(f);

    cmdStr := 'C:\Program Files\Windows NT\Accessories\wordpad.exe '+ filePath;
    WinExec(PChar(cmdStr), SW_SHOW);
end;

End.
