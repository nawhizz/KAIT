program LOSTC250Q;

uses
  Forms,
  u_LOSTC250Q in 'u_LOSTC250Q.pas' {frm_LOSTC250Q},
  LOSTC250Q_PRT_HEAD in 'LOSTC250Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC250Q, frm_LOSTC250Q);
  Application.Run;
end.
