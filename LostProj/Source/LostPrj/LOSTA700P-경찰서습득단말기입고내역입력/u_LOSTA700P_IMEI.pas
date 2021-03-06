unit u_LOSTA700P_IMEI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, so_tmax, StdCtrls, Buttons, ExtCtrls, common_lib, Atmi;

const
  TITLE   = 'IMEI정보 조회';
  PGM_ID  = 'LOSTA700P_IMEI';

type
  Tfrm_LOSTA700P_IMEI = class(TForm)
    Bevel33: TBevel;
    Label1: TLabel;
    edt_imei_cd: TEdit;
    GroupBox2: TGroupBox;
    Bevel3: TBevel;
    Label3: TLabel;
    Bevel19: TBevel;
    Label19: TLabel;
    edt_imei_md_nm: TEdit;
    edt_imei_sr_no: TEdit;
    GroupBox1: TGroupBox;
    Bevel1: TBevel;
    Label2: TLabel;
    Bevel2: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel4: TBevel;
    edt_kait_md_nm: TEdit;
    edt_kait_sr_no: TEdit;
    edt_kait_md_cd: TEdit;
    edt_kait_ph_gb: TEdit;
    btnConfirm: TBitBtn;
    btnIMEI_Inq: TBitBtn;
    Button1: TButton;
    TMAX: TTMAX;
    btnClose: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnIMEI_InqClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTA700P_IMEI: Tfrm_LOSTA700P_IMEI;

implementation

uses u_LOSTA700P;

{$R *.dfm}

procedure Tfrm_LOSTA700P_IMEI.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  h : HWND;
begin
  frm_LOSTA700P.md_cb1.Text := '';
  frm_LOSTA700P.msk_Sr_No.Text := '';
  frm_LOSTA700P.lbl_im_ei.Caption := '';

  // 자식창 숨기고 부모창을 사용가능하게 하며 보여준다.
  self.hide;
  frm_LOSTA700P.Enabled := True;

  h := FindWindow('Tfrm_LOSTA700P',nil);

  ShowWindow(h, SW_SHOW);
  ShowWindow(h, SW_RESTORE);
end;

procedure Tfrm_LOSTA700P_IMEI.FormCreate(Sender: TObject);
begin
  {----------------------- 공통 어플리케이션 설정 ---------------------------}
  //setEdtKeyPress;

  // 프로그램 캡션 설정
  Self.Caption := '[' + PGM_ID + ']' + TITLE;

  // 테스크바 캡션설정
  Application.Title := TITLE;

  // 프로그램 상단 아이콘 설정
  fSetIcon(Application);

  // 메세지 바 넓이 설정
  //pSetStsWidth(sts_Message);

  // 텍스트 선택시 전체 선택 기능
  //pSetTxtSelAll(Self);

  // 프로그램 보더 아이콘 설정
  Self.BorderIcons  := [biSystemMenu,biMinimize];

  // 프로그램 시작 위치 설정
  Self.Position     := poScreenCenter;
  {--------------------------------------------------------------------------}

  Self.BorderIcons  := [biSystemMenu,biMinimize];
  Self.Position     := poScreenCenter;

  // 에디트박스 초기화
  edt_imei_cd.Text := '';
  edt_imei_md_nm.Text := '';
  edt_imei_sr_no.Text := '';
  edt_kait_md_cd.Text := '';
  edt_kait_md_nm.Text := '';
  edt_kait_sr_no.Text := '';

  //edt_imei_cd.SetFocus;

end;

procedure Tfrm_LOSTA700P_IMEI.FormHide(Sender: TObject);
begin
   frm_LOSTA700P.Enabled := true;

   if(Length(frm_LOSTA700P.md_cb1.Text) = 0) then
      frm_LOSTA700P.md_cb1.SetFocus
   else
      frm_LOSTA700P.msk_mt_no.SetFocus;
end;

procedure Tfrm_LOSTA700P_IMEI.btnIMEI_InqClick(Sender: TObject);
var i : integer;
    component : TComponent;
    color     : TColor;
    styles    : TFontStyles;
    STR001    : string;

Label LIQUIDATION;

begin
  edt_imei_md_nm.Text := '';
  edt_imei_sr_no.Text := '';
  edt_kait_md_cd.Text := '';
  edt_kait_md_nm.Text := '';
  edt_kait_sr_no.Text := '';
  edt_kait_ph_gb.Text := '';

  if(Length(edt_imei_cd.Text) <> 15) then
     begin
       ShowMessage('IMEI코드는 15자리입니다.');
       edt_imei_cd.SetFocus;
       Exit;
     end;

    STR001:= edt_imei_cd.Text;  //IMEI코드

    //서버에서 메뉴를 가져오기 위해서 TMAX로 연결한다.
    TMAX.FileName := 'C:\WINDOWS\system32\tmax.env';
    TMAX.Server   := 'KAIT_LOSTPRJ';

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

    //공통입력 부분
    if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('INF003','LOSTA100P'      )  < 0) then  goto LIQUIDATION;

    if (TMAX.SendString('INF001','S03'            )  < 0) then  goto LIQUIDATION;
    if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
    if not TMAX.Call('LOSTA260Q') then
  begin
    if (TMAX.RecvString('INF011',0) = 'Y') then
    begin

      if Pos('단말기',TMAX.RecvString('INF012',0)) = 0 then
        ShowMessage( TMAX.RecvString('INF012',0))
      else
        ShowMessage( TMAX.RecvString('INF012',0));
    end
    else
      MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  (* IMEI모델명              *) edt_imei_md_nm.Text     :=             Trim(TMAX.RecvString('STR101',0));
  (* IMIE일련번호            *) edt_imei_sr_no.Text     :=             Trim(TMAX.RecvString('STR102',0));
  (* KAIT모델코드            *) edt_kait_md_cd.Text     :=             Trim(TMAX.RecvString('STR103',0));
  (* KAIT모델명              *) edt_kait_md_nm.Text     :=             Trim(TMAX.RecvString('STR104',0));
  (* KAIT일련번호            *) edt_kait_sr_no.Text     :=             Trim(TMAX.RecvString('STR105',0));
  (* KAIT단말기종류          *) edt_kait_ph_gb.Text     :=             Trim(TMAX.RecvString('STR106',0));

  //pgm_sts1 := [1];

  edt_imei_cd.SetFocus;

LIQUIDATION:
    TMAX.InitBuffer;
  TMAX.FreeBuffer;
    TMAX.EndTMAX;
    TMAX.Disconnect;

    //edt_imei_cd.Text := '';
    edt_imei_cd.SetFocus;
end;

procedure Tfrm_LOSTA700P_IMEI.Button1Click(Sender: TObject);
begin
  edt_imei_md_nm.Text := 'SPH-W9600';
  edt_imei_sr_no.Text := '123456';

  edt_kait_md_cd.Text := '1234';
  edt_kait_md_nm.Text := 'SPH-W9600';
  edt_kait_sr_no.Text := '0000000000123456';

  edt_kait_ph_gb.Text := '셀룰러';
end;

procedure Tfrm_LOSTA700P_IMEI.btnConfirmClick(Sender: TObject);
var
  h : HWND;
begin
  frm_LOSTA700P.md_cb1.Text := edt_kait_md_nm.Text;
  frm_LOSTA700P.msk_Sr_No.Text := edt_kait_sr_no.Text;
  //if (Trim(edt_imei_md_nm.Text) <> '') then
    frm_LOSTA700P.lbl_im_ei.Caption := edt_imei_cd.Text;

  //frm_LOSTA100P.cmb_Ph_gb.Text := edt_kait_ph_gb.Text;
  if (edt_kait_ph_gb.Text = 'PCS단말기') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 0
  else if (edt_kait_ph_gb.Text = '셀룰러') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 1
  else if (edt_kait_ph_gb.Text = '라벨없음') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 2
  else if (edt_kait_ph_gb.Text = '충전기') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 3
  else if (edt_kait_ph_gb.Text = '배터리') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 4
  else if (edt_kait_ph_gb.Text = '아날로그') then
      frm_LOSTA700P.cmb_Ph_gb.itemindex := 5;

  // 자식창 숨기고 부모창을 사용가능하게 하며 보여준다.
  self.hide;
  //frm_LOSTA700P.Show;
  frm_LOSTA700P.Enabled := True;

  h := FindWindow('Tfrm_LOSTA700P',nil);
end;

procedure Tfrm_LOSTA700P_IMEI.btnCloseClick(Sender: TObject);
var
  h : HWND;
begin
  frm_LOSTA700P.md_cb1.Text := '';
  frm_LOSTA700P.msk_Sr_No.Text := '';
  frm_LOSTA700P.lbl_im_ei.Caption := '';

  // 자식창 숨기고 부모창을 사용가능하게 하며 보여준다.
  self.hide;
  frm_LOSTA700P.Enabled := True;

  h := FindWindow('Tfrm_LOSTA700P',nil);

  ShowWindow(h, SW_SHOW);
  ShowWindow(h, SW_RESTORE);
end;

end.
