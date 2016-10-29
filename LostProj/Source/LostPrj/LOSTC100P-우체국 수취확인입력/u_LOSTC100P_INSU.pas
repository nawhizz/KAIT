unit u_LOSTC100P_INSU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,common_lib, so_tmax, ComObj;

type
  Tfrm_LOSTC100P_INSU = class(TForm)
    pnl1: TPanel;
    bvl30: TBevel;
    lbl_insu_company: TLabel;
    Bevel60: TBevel;
    lbl_ga_nm: TLabel;
    Bevel62: TBevel;
    lbl_ga_birthday: TLabel;
    Bevel63: TBevel;
    lbl_insu_req_dt: TLabel;
    Bevel64: TBevel;
    lbl_insu_allow_dt: TLabel;
    Bevel65: TBevel;
    lbl_insu_mt_no: TLabel;
    Bevel66: TBevel;
    lbl_ga_tl_no: TLabel;
    Bevel67: TBevel;
    lbl_insu_deny_dt: TLabel;
    Bevel68: TBevel;
    lbl_insu_pay_amt: TLabel;
    Bevel69: TBevel;
    lbl_sl_dt: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    btn_close: TButton;
    sts_Message: TStatusBar;
    TMAX: TTMAX;
    procedure FormShow(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_LOSTC100P_INSU: Tfrm_LOSTC100P_INSU;

implementation
uses u_LOSTC100P;

{$R *.dfm}

procedure Tfrm_LOSTC100P_INSU.FormShow(Sender: TObject);
var i : integer;
    STR001,STR002,STR003 : string;

label LIQUIDATION;
begin

  for i := 0 to ComponentCount -1 do
  begin
    if Components[i] is TLabel then
      if(Pos('lbl_',(Components[i] as TLabel).Name) > 0) and (Pos('lbl_Program_Name',(Components[i] as TLabel).Name) = 0)
        then (Components[i] as TLabel).Caption := '';
  end;

	STR001:= Copy(delHyphen(frm_LOSTC100P.msk_Ju_No.Text), 1,6); // 우체국코드
	STR002:= Copy(delHyphen(frm_LOSTC100P.msk_Ju_No.Text), 7,8); // 등록일자
  STR003:= Copy(delHyphen(frm_LOSTC100P.msk_Ju_No.Text),15,4); // 접수일련번호

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

    //공통입력 부분
	if (TMAX.SendString('INF002',common_userid    )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_username  )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF002',common_usergroup )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('INF003','LOSTC100P'      )  < 0) then  goto LIQUIDATION;

	if (TMAX.SendString('INF001','S02'            )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR001', STR001          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR002', STR002          )  < 0) then  goto LIQUIDATION;
	if (TMAX.SendString('STR003', STR003          )  < 0) then  goto LIQUIDATION;

    //서비스 호출
	if not TMAX.Call('LOSTC100P') then begin
    sts_Message.Panels[1].Text := ' '+ TMAX.RecvString('INF012',0);
    MessageBox(handle,PChar(TMAX.RecvString('INF012',0)),PChar('서비스호출 오류'),MB_OK);

    goto LIQUIDATION;
  end;

  {* 보험사코드         *} //                         := TMAX.RecvString('STR101',0);
  {* 보험사명           *} lbl_insu_company.Caption   := TMAX.RecvString('STR102',0);
  {* 가입자성명         *} lbl_ga_nm.Caption          := TMAX.RecvString('STR103',0);
  {* 이동전화번호       *} lbl_insu_mt_no.Caption     := TMAX.RecvString('STR104',0);
  {* 가입자생년월일     *} lbl_ga_birthday.Caption    := InsHyphen(TMAX.RecvString('STR105',0),'2-2-2');
  {* 가입자연락처       *} lbl_ga_tl_no.Caption       := TMAX.RecvString('STR106',0);
  {* 보험금신청일자     *} lbl_insu_req_dt.Caption    := TMAX.RecvString('STR107',0);
  {* 보험금지급중지일자 *} lbl_insu_deny_dt.Caption   := TMAX.RecvString('STR108',0);
  {* 보험금지급승인일자 *} lbl_insu_allow_dt.Caption  := TMAX.RecvString('STR109',0);
  {* 보험금지급(예정)액 *} lbl_insu_pay_amt.Caption   := TMAX.RecvString('STR110',0);
  {* 보험금처리구분코드 *} //                         := TMAX.RecvString('STR111',0);
  {* 보험금처리구분     *} //                         := TMAX.RecvString('STR112',0);
  {* 보험사매각일자     *} lbl_sl_dt.Caption          := InsHyphen(TMAX.RecvString('STR113',0));

  sts_Message.Panels[1].Text := ' 조회 완료';

LIQUIDATION:
	TMAX.InitBuffer;
  TMAX.FreeBuffer;
	TMAX.EndTMAX;
	TMAX.Disconnect;

end;

procedure Tfrm_LOSTC100P_INSU.btn_closeClick(Sender: TObject);
begin
  Self.Hide;
end;

procedure Tfrm_LOSTC100P_INSU.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Self.Hide;
end;

end.

