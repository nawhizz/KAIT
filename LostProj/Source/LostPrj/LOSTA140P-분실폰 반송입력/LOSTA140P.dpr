program LOSTA140P;

uses
  Forms,
  u_LOSTA140P in 'u_LOSTA140P.pas' {frm_LOSTA140P},
  u_LOSTA140P_ADDR in 'u_LOSTA140P_ADDR.pas' {frm_LOSTA140P_ADDR};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰 반송내역 입력(LOSTA140P)';
  Application.CreateForm(Tfrm_LOSTA140P, frm_LOSTA140P);
  Application.CreateForm(Tfrm_LOSTA140P_ADDR, frm_LOSTA140P_ADDR);
  Application.Run;
end.
