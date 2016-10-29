program LOSTA120P;

uses
  Forms,
  u_LOSTA120P in 'u_LOSTA120P.pas' {frm_LOSTA120P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(Tfrm_LOSTA120P, frm_LOSTA120P);
  Application.Run;
end.
