program LOSTA260Q;

uses
  Forms,
  u_LOSTA260Q in 'u_LOSTA260Q.pas' {frm_LOSTA260Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰 출고 입력(LOSTA120P)';
  Application.CreateForm(Tfrm_LOSTA260Q, frm_LOSTA260Q);
  Application.Run;
end.
