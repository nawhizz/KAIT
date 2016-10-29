unit
    u_lostlogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, WinSkinData, common_lib,
  so_tmax, Fml, ComObj;

const
  TITLE   = '분실단말기집중관리';
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
    underBar:Boolean;	//다운로드 받은 파일중 '_'를 포함하고 있다.
  public
    { Public declarations }
     procedure Link_rtn(var Msg:TMessage); message WM_LOSTPROJECT;
  end;

var
  frm_LOSTLOGO: Tfrm_LOSTLOGO;

implementation
{$R *.DFM}

//파일업데이트(FileDownload.exe) 나 공통코드업데이트(CodeUpdate.exe)에서 처리 후
//메세지를 보낸다.
procedure Tfrm_LOSTLOGO.Link_rtn (var Msg : TMessage);
begin
                
    if Msg.wParam = 1 then begin 	//FileDownload.exe 에서 보냄
    	if Msg.LParam = 1 then
        underBar := True;  	//다운로드 받은 파일중 '_'가 있다.

    	ExecExternProg('CodeUpdate');	//CodeUpdate.exe 를 실행.
    end
    else if Msg.WParam = 2 then begin 	//CodeUpdate.exe 에서 보냄

    	if underBar then
      begin
        	//ShowMessage('로그인 프로그램을 재 실행 합니다');
        	if WinExec(PChar('LostFileChange.exe '+ IntToStr(self.Handle)), SW_Show) > 31 then
            PostMessage(self.Handle, WM_QUIT, 0,0)
          else
            self.Show;
    	end else
    		self.Show;	//자신을 보인다.
    end;

end ;

procedure Tfrm_LOSTLOGO.btn_CloseClick(Sender: TObject);
begin
   close;
end;

procedure Tfrm_LOSTLOGO.FormCreate(Sender: TObject);
begin
  initSkinForm(SkinData1);
  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  common_handle := intToStr(self.Handle);

  underBar:= False;

  Timer1.Enabled:= true;
end;

//확인버튼 클릭
procedure Tfrm_LOSTLOGO.btn_LoginClick(Sender: TObject);
var
  spasswd     :String;
  commandStr  :String;

  // 암호화 관련 변수
  ECPlazaSeed: OLEVariant;

  strSql, strPwd, strNm, strToday, strID, ErrMsg : String;
  liError, iSendSuccess : Integer;

  errno       :Integer;
  fid         :FIELDID;
  fldName     :String;
  erroMsg     :String;
begin
  // 암호화개체 생성
  ECPlazaSeed := CreateOleObject('ECPlaza.Seed');

	//사용자ID 입력여부 체크
	if Length( Trim(msk_Sabun.Text)) = 0 then begin
    ShowMessage('사용자ID를 입력하세요');
    msk_Sabun.SetFocus;
    exit;
  end;

	//패스워드 입력여부 체크
	if Length( Trim(msk_Passwd.Text)) = 0 then begin
    ShowMessage('패스워드를 입력하세요');
    msk_Passwd.SetFocus;
    exit;
  end;

  //패스워드를 암호화 한다.
  spasswd := Get_EncStr(Trim(msk_Passwd.Text));

  //공통변수 셋팅---common_lib.pas에 선언되어 있다.
  //common_handle   := intToStr(self.Handle);  //CreateForm에서 실행
  common_userid     := Trim(msk_Sabun.Text);
  common_username   := '서버에서 받아옴';
  common_usergroup  := '서버에서 받아옴';
  common_seedkey    := '서버에서 받아옴';

	strSql       := '';
	strPwd       := '';
	strNm        := '';
	strToday     := '';

	liError := 0;
	iSendSuccess := 0;

	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
		liError := 1;
		iSendSuccess := 0;
	end;

	if liError = 0 then begin //---4
        //Koo added
        //TMAX.Server := '192.168.1.196';

		TMAX.ReadEnvFile();
        TMAX.Connect;

		if not TMAX.Connected then begin
			ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
			liError := 2;
			iSendSuccess := 0;
		end;

		if liError = 0 then
			TMAX.AllocBuffer(1024);

		if not TMAX.BufferAlloced then begin
			ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
			liError := 3;
			iSendSuccess := 0;
		end;

		if liError = 0 then begin //---3
			TMAX.InitBuffer;

        	if not TMAX.Start then begin
 				ShowMessage('TMAX 시작에 실패 하였습니다.');
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

				if (TMAX.SendString('INF002','') < 0) then liError := 4;   //사용자ID
                if (TMAX.SendString('INF002','') < 0) then liError := 4;   //성명
				if (TMAX.SendString('INF002','') < 0) then liError := 4;   //사무소코드
				if (TMAX.SendString('INF003','LostLogin') < 0) then liError := 5;
				if (TMAX.SendString('STR001', common_userid) < 0) then liError := 7;
				if (TMAX.SendString('STR002', spasswd) < 0) then liError := 7;

				if liError = 0 then begin //---1
					if not TMAX.Call('LOSTZ900Q') then begin
                    	erroMsg:= TMAX.RecvString('INF012', 0);   //로그인 에러 메세지...

                        if Length(erroMsg)=0 then
					   		ShowMessage('로그인오류'+#13#10+'아이디나 패스워드 확인할 것')
                        else
                        	ShowMessage(erroMsg);
                        msk_Sabun.SetFocus;

						iSendSuccess := 0;
					end
					else begin
						iSendSuccess := 1;

						common_username  := TMAX.RecvString('STR101', 0); 	//사용자명
						common_usergroup := TMAX.RecvString('STR102', 0);   //사용자그룹
            common_seedkey   := Copy(ECPlazaSeed.Decrypt(TMAX.RecvString('STR104', 0), SEEDPBKAITSHOPKEY), 0, 16);   //SEED암호화키
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
      PostMessage(Handle, WM_QUIT, 0,0) 	//현재의 윈도우를 닫는다.
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
		msk_Passwd.SetFocus;  //패스워드로 이동
end;

procedure Tfrm_LOSTLOGO.FormShow(Sender: TObject);
begin
	msk_Sabun.SetFocus;
end;

procedure Tfrm_LOSTLOGO.Timer1Timer(Sender: TObject);
begin
	Timer1.Enabled:= False;

  if ParamCount = 1 then  begin	//LostFileChange.exe 가 본 프로그램을 실행 시켰슴.
    Self.Show;
    exit;
  end;

  ExecExternProg('FileDownload');	//FileDownload.exe 를 실행.
end;

end.
