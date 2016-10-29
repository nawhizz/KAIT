program LOSTC260Q;

uses
  Forms,
  LOSTC260Q_PRT_HEAD in 'LOSTC260Q_PRT_HEAD.pas',
  u_LOSTC260Q in 'u_LOSTC260Q.pas' {frm_LOSTC260Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC260Q, frm_LOSTC260Q);
  Application.Run;
end.
