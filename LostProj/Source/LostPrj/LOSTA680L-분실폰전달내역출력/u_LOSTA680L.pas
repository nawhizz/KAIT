{*---------------------------------------------------------------------------
프로그램ID    : LOSTA680L (분실폰 전달 내역 출력)
프로그램 종류 : Online
작성자	      : 최대성
작성일	      : 2011.09.02
완료일	      : ####. ##. ##
프로그램 개요 :
-------------------------------------------------------------------------------
<버전 관리>
변경일자      :
작성자	      :
변경내용      :
처리번호      :
Ver	      :
-----------------------------------------------------------------------------*}
unit u_LOSTA680L;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolEdit, Mask, ComCtrls, checklst, cpakmsg,
  WinSkinData, so_tmax,common_lib,SimpleSFTP, ComObj;

const
  TITLE   = '분실폰 전달 내역 출력';
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
	// 출력 다이로그 박스
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
   //======== 각 윈도우 마다 공통적으로 작성해야 할 부분======================
//	이 부분은 테스티 기간동안 만 코멘트 처리한다. 테스트 끝난 후에는 이 부분을 해제할 것.
	  if ParamCount <> 6 then begin //실행 프로그램은 제외하고 파라메터 값만 카운트 한다.
    	  ShowMessage('로그인 후 사용하세요');
        PostMessage(self.Handle, WM_QUIT, 0,0);
        exit;
    end;

    //공통변수 설정--common_lib.pas 참조할 것.
    common_kait     := ParamStr(1);
    common_caller   := ParamStr(2);
    common_handle     := intToStr(self.Handle);
    common_userid   := ParamStr(3);
    common_username := ParamStr(4);
    common_usergroup:= ParamStr(5);
    common_seedkey  := ParamStr(6);

    //테스트 후에는 이 부분을 삭제할 것.
//    common_userid     := '0294';    //ParamStr(2);
//    common_username   := '정호영';  //ParamStr(3);
//    common_usergroup  := 'KAIT';    //ParamStr(4);

  {----------------------- 공통 어플리케이션 설정 ---------------------------}

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 내부 캡션 설정
  lbl_Program_Name.Caption := TITLE;

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 메세지 바 넓이 설정
  pSetStsWidth(sts_Message);

  // 텍스트 선택시 전체 선택 기능
  pSetTxtSelAll(Self);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

    //common_lib.pas에 있다.
    initSkinForm(SkinData1);
    initComboBoxWithZ0xx('Z001.dat', cmb_id_cd_d, '전체', ' ',cmb_id_cd);

    //스태터스바에 사용자 정보를 보여준다.
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
		showmessage('이전일자는 이후일자보다 크게 설정할 수 없습니다.');
		exit;
    end;
end;

//OnExit event --
procedure Tfrm_LOSTA680L.dte_toExit(Sender: TObject);
begin
	sts_Message.Panels[1].Text := '';

	if Trunc(dte_Jn_Dt_From.Date) > Trunc(dte_Jn_Dt_To.Date) then begin
		showmessage('이후일자는 이전일자보다 작게 설정할 수 없습니다.');
		exit;
	end;

	if Trunc(dte_Jn_Dt_To.Date) > Trunc(date) then begin
		showmessage('이후일자는 현재일자 이후로 설정할 수 없습니다.');
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
    sts_Message.Panels[1].Text := '데이터 처리중...잠시 기다려 주십시오.';
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
    sts_Message.Panels[1].Text := '데이터 처리완료.';
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

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
	TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
  TMAX.Server := 'KAIT_LOSTPRJ';

	if not TMAX.Ping then begin
		ShowMessage('['+TMAX.Server+'] TMAX Server를 찾을수 없습니다.');
        goto LIQUIDATION;
	end;

	TMAX.ReadEnvFile();
  TMAX.Connect;

	if not TMAX.Connected then begin
		ShowMessage('TMAX 서버에 연결되어 있지 않습니다.');
        goto LIQUIDATION;
	end;

	TMAX.AllocBuffer(1024);
	if not TMAX.BufferAlloced then begin
		ShowMessage('TMAX 메모리 할당에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;
	if not TMAX.Start then begin
		ShowMessage('TMAX 시작에 실패 하였습니다.');
        goto LIQUIDATION;
	end;

	TMAX.InitBuffer;

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid              ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username            ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup           ) < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTA680L'                ) < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','P01'                      ) < 0) then  goto LIQUIDATION;
    //시작날자
	if (TMAX.SendString('STR001', delHyphen(dte_Jn_Dt_From.Text)  ) < 0) then  goto LIQUIDATION;
    //종료날자
	if (TMAX.SendString('STR002', delHyphen(dte_Jn_Dt_To.Text)    ) < 0) then  goto LIQUIDATION;
    //상품구분
	if (TMAX.SendString('STR003', cmb_id_cd_d[cmb_id_cd.ItemIndex].code) < 0) then  goto LIQUIDATION;

  //서비스 호출
  serviceSuccess := TMAX.Call('LOSTA680L');

	if not serviceSuccess then goto LIQUIDATION;

  //파일 패스를 얻는다.
  remoteFilePath  := TMAX.RecvString('STR101',0);
  //파일명을 얻는다.
  fileName        := getFinalName(remoteFilePath, '/');
  localFilePath   := '..\temp\' + getDirPath(fileName,'_') + '.txt';
  remoteFilePath  := getDirPath(remoteFilePath, '/');

  //서버에서 파일을 전송받아 ..\KAI\LostPrj\temp 에 저장한다.
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

  //출력 다이어로그를 보여줌.
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
  // 버튼 이미지 초기화
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
