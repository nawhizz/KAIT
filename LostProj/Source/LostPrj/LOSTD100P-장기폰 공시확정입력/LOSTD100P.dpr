program LOSTD100P;

uses
  Forms,
  u_LOSTD100P in 'u_LOSTD100P.pas' {frm_LOSTD100P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������Ȯ���Է�(LOSTD100P)';
  Application.CreateForm(Tfrm_LOSTD100P, frm_LOSTD100P);
  Application.Run;
end.
