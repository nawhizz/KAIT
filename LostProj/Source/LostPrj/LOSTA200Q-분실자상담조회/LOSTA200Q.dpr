program LOSTA200Q;

uses
  Forms,
  u_LOSTA200Q in 'u_LOSTA200Q.pas' {fm_LOSTA200Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실자상담조회(LOSTA200Q)';
  Application.CreateForm(Tfm_LOSTA200Q, fm_LOSTA200Q);
  Application.Run;
end.
