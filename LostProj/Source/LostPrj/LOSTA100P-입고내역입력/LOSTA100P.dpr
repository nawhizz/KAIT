program LOSTA100P;

uses
  Forms,
  u_LOSTA100P in 'u_LOSTA100P.pas' {frm_LOSTA100P},
  u_LOSTA100P_IMEI in 'u_LOSTA100P_IMEI.pas' {frm_LOSTA100P_IMEI};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '입고내역 입력(LOSTA100P)';
  Application.CreateForm(Tfrm_LOSTA100P, frm_LOSTA100P);
  Application.CreateForm(Tfrm_LOSTA100P_IMEI, frm_LOSTA100P_IMEI);
  Application.Run;
end.
