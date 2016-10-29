unit
    u_lostlogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, WinSkinData, common_lib,
  so_tmax, Fml, ComObj;

const
  TITLE   = '�нǴܸ������߰���';
  PGM_ID  = 'LOGIN';

type
  Tfrm_LOSTLOGO = class(TForm)
    Bevel1: TBevel;
    btn_Login: TButton;
    btn_Close: TButton;
    Image4: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Label3: TLabel;
    SkinData1: TSkinData;
    msk_Sabun: TEdit;
    msk_Passwd: TEdit;
    TMAX: TTMAX;
    Timer1: TTimer;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_LoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure msk_PasswdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure msk_SabunKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    underBar:Boolean;	//�ٿ�ε� ���� ������ '_'�� �����ϰ� �ִ�.
  public
    { Public declarations }
     procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
  end;

var
  frm_LOSTLOGO: Tfrm_LOSTLOGO;

implementation
{$R *.DFM}

//���Ͼ�����Ʈ(FileDownload.exe) �� �����ڵ������Ʈ(CodeUpdate.exe)���� ó�� ��
//�޼����� ������.
procedure Tfrm_LOSTLOGO.Link_rtn (var Msg : TMessage);
begin
                
    if Msg.wParam = 1 then begin 	//FileDownload.exe ���� ����
    	if Msg.LParam = 1 then
        underBar := True;  	//�ٿ�ε� ���� ������ '_'�� �ִ�.

    	ExecExternProg('CodeUpdate');	//CodeUpdate.exe �� ����.
    end
    else if Msg.WParam = 2 then begin 	//CodeUpdate.exe ���� ����

    	if underBar then
      begin
        	//ShowMessage('�α��� ���α׷��� �� ���� �մϴ�');
        	if WinExec(PChar('LostFileChange.exe '+ IntToStr(self.Handle)), SW_Show) > 31 then
            PostMessage(self.Handle, WM_QUIT, 0,0)
          else
            self.Show;
    	end else
    		self.Show;	//�ڽ��� ���δ�.
    end;

end ;

procedure Tfrm_LOSTLOGO.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTLOGO.FormCreate(Sender: TObject);
begin
  initSkinForm(SkinData1);
  {----------------------- ���� ���ø����̼� ���� ---------------------------}

  // ���α׷� ĸ�� ����
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // �׽�ũ�� ĸ�Ǽ���
  Application.Title := TITLE;

  // ���α׷� ��� ������ ����
  fSetIcon(Application);

  // ���α׷� ���� ������ ����
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // ���α׷� ���� ��ġ ����
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  common_handle := intToStr(self.Handle);

  underBar:= False;

  Timer1.Enabled:= true;
end;

//Ȯ�ι�ư Ŭ��
procedure Tfrm_LOSTLOGO.btn_LoginClick(Sender: TObject);
var
  spasswd     :String;
  commandStr  :String;

  // ��ȣȭ ���� ����
  ECPlazaSeed: OLEVariant;

  strSql, strPwd, strNm, strToday, strID, ErrMsg : String;
  liError, iSendSuccess : Integer;

  errno       :Integer;
  fid         :FIELDID;
  fldName     :String;
  erroMsg     :String;
begin
  // ��ȣȭ��ü ����
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

	//�����ID �Է¿��� üũ
	if Length( Trim(msk_Sabun.Text)) = 0 then begin
    ShowMessage('�����ID�� �Է��ϼ���');
    msk_Sabun.SetFocus;
    exit;
  end;

	//�н����� �Է¿��� üũ
	if Length( Trim(msk_Passwd.Text)) = 0 then begin
    ShowMessage('�н����带 �Է��ϼ���');
    msk_Passwd.SetFocus;
    exit;
  end;

  //�н����带 ��ȣȭ �Ѵ�.
  spasswd := Get_EncStr(Trim(msk_Passwd.Text));

  //���뺯�� ����---common_lib.pas�� ����Ǿ� �ִ�.
  //common_handle   := intToStr(self.Handle);  //CreateForm���� ����
  common_userid     := Trim(msk_Sabun.Text);
  common_username   := '�������� �޾ƿ�';
  common_usergroup  := '�������� �޾ƿ�';
  common_seedkey    := '�������� �޾ƿ�';

	strSql       := '';
	strPwd       := '';
	strNm        := '';
	strToday     := '';

	liError := 0;
	iSendSuccess := 0;

	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server�� ã���� �����ϴ�.');
		liError := 1;
		iSendSuccess := 0;
	end;

	if liError = 0 then begin //---4
        //Koo added
        //TMAX.Server := '192.168.1.196';

		TMAX.ReadEnvFile();
        TMAX.Connect;

		if not TMAX.Connected then begin
			ShowMessage('TMAX ������ ����Ǿ� ���� �ʽ��ϴ�.');
			liError := 2;
			iSendSuccess := 0;
		end;

		if liError = 0 then
			TMAX.AllocBuffer(1024);

		if not TMAX.BufferAlloced then begin
			ShowMessage('TMAX �޸� �Ҵ翡 ���� �Ͽ����ϴ�.');
			liError := 3;
			iSendSuccess := 0;
		end;

		if liError = 0 then begin //---3
			TMAX.InitBuffer;

        	if not TMAX.Start then begin
 				ShowMessage('TMAX ���ۿ� ���� �Ͽ����ϴ�.');
 				liError := 4;
                iSendSuccess := 0;
			end;

			if liError = 0 then begin //---2
               	//fid := Fldid(PChar('FDL_1'));
            	//fid := Fldid(PChar('STR001'));
            	//fid := Fldid(PChar('INT001'));

				if (TMAX.SendString('INF001','S01') < 0) then  begin
                	liError := 5;
                    //errno := getfberrno;

                	//fid := Fldid(PChar('INF001'));
                    //errno := getfberrno;

                    //fldName := StrPas(tpgetenv(PChar('FDLFILE')));
                    //errno := getfberrno;
                end;

				if (TMAX.SendString('INF002','') < 0) then liError := 4;   //�����ID
                if (TMAX.SendString('INF002','') < 0) then liError := 4;   //����
				if (TMAX.SendString('INF002','') < 0) then liError := 4;   //�繫���ڵ�
				if (TMAX.SendString('INF003','LostLogin') < 0) then liError := 5;
				if (TMAX.SendString('STR001', common_userid) < 0) then liError := 7;
				if (TMAX.SendString('STR002', spasswd) < 0) then liError := 7;

				if liError = 0 then begin //---1
					if not TMAX.Call('LOSTZ900Q') then begin
                    	erroMsg:= TMAX.RecvString('INF012', 0);   //�α��� ���� �޼���...

                        if Length(erroMsg)=0 then
					   		ShowMessage('�α��ο���'+#13#10+'���̵� �н����� Ȯ���� ��')
                        else
                        	ShowMessage(erroMsg);
                        msk_Sabun.SetFocus;

						iSendSuccess := 0;
					end
					else begin
						iSendSuccess := 1;

						common_username  := TMAX.RecvString('STR101', 0); 	//����ڸ�
						common_usergroup := TMAX.RecvString('STR102', 0);   //����ڱ׷�
            common_seedkey   := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR104', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED��ȣȭŰ
					end;
                end;//---1
			end;//---2
		end;//---3
  end;//---4

	if iSendSuccess = 1 then
    TMAX.InitBuffer;

  TMAX.FreeBuffer;
  TMAX.EndTMAX;
  TMAX.Disconnect;

	if iSendSuccess = 1 then begin
    if ExecExternProg('LostMain') then
      PostMessage(Handle, WM_QUIT, 0,0) 	//������ �����츦 �ݴ´�.
  end;
end;

procedure Tfrm_LOSTLOGO.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
      btn_Login.OnClick (Sender) ;
end;

procedure Tfrm_LOSTLOGO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//   Capiend;
end;

procedure Tfrm_LOSTLOGO.msk_PasswdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      btn_Login.OnClick (Sender) ;
end;

procedure Tfrm_LOSTLOGO.msk_SabunKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_RETURN then
		msk_Passwd.SetFocus;  //�н������ �̵�
end;

procedure Tfrm_LOSTLOGO.FormShow(Sender: TObject);
begin
	msk_Sabun.SetFocus;
end;

procedure Tfrm_LOSTLOGO.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled:= False;

  if ParamCount = 1 then  begin	//LostFileChange.exe �� �� ���α׷��� ���� ���׽�.
    Self.Show;
    exit;
  end;

  ExecExternProg('FileDownload');	//FileDownload.exe �� ����.
end;

end.
