program LOSTD100P;

uses
  Forms,
  u_LOSTD100P in 'u_LOSTD100P.pas' {frm_LOSTD100P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '장기폰공시확정입력(LOSTD100P)';
  Application.CreateForm(Tfrm_LOSTD100P, frm_LOSTD100P);
  Application.Run;
end.
