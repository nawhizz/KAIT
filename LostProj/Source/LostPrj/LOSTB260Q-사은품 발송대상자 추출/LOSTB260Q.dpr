program LOSTB260Q;

uses
  Forms,
  u_LOSTB260Q in 'u_LOSTB260Q.pas' {frm_LOSTB260Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 발송대상자 추출(LOSTB260Q)';
  Application.CreateForm(Tfrm_LOSTB260Q, frm_LOSTB260Q);
  Application.Run;
end.
