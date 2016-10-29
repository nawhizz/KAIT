program LOSTA810Q;

uses
  Forms,
  u_LOSTA810Q in 'u_LOSTA810Q.pas' {fm_LOSTA810Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실자상담조회(LOSTA200Q)';
  Application.CreateForm(Tfm_LOSTA810Q, fm_LOSTA810Q);
  Application.Run;
end.
