program LOSTB250Q;

uses
  Forms,
  u_LOSTB250Q in 'u_LOSTB250Q.pas' {frm_LOSTB250Q},
  LOSTB250Q_PRT_HEAD in 'LOSTB250Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB250Q, frm_LOSTB250Q);
  Application.Run;
end.
