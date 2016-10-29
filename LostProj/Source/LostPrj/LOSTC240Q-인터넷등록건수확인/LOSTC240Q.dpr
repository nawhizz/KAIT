program LOSTC240Q;

uses
  Forms,
  u_LOSTC240Q in 'u_LOSTC240Q.pas' {frm_LOSTC240Q},
  LOSTC250Q_PRT_HEAD in 'LOSTC250Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC240Q, frm_LOSTC240Q);
  Application.Run;
end.
