program LOSTB260Q;

uses
  Forms,
  u_LOSTB260Q in 'u_LOSTB260Q.pas' {frm_LOSTB260Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ǰ �߼۴���� ����(LOSTB260Q)';
  Application.CreateForm(Tfrm_LOSTB260Q, frm_LOSTB260Q);
  Application.Run;
end.
