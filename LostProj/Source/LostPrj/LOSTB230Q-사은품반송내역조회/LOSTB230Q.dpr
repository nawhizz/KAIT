program LOSTB230Q;

uses
  Forms,
  u_LOSTB230Q in 'u_LOSTB230Q.pas' {fm_LOSTB230Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfm_LOSTB230Q, fm_LOSTB230Q);
  Application.Run;
end.
