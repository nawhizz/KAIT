program LOSTZ100P;

uses
  Forms,
  u_LOSTZ100P in 'u_LOSTZ100P.pas' {frm_LOSTZ100P};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ100P, frm_LOSTZ100P);
  Application.Run;
end.
