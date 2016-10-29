program LOSTA720P;

uses
  Forms,
  u_LOSTA720P in 'u_LOSTA720P.pas' {frm_LOSTA720P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(Tfrm_LOSTA720P, frm_LOSTA720P);
  Application.Run;
end.
