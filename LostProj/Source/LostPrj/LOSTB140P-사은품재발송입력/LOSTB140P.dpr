program LOSTB140P;

uses
  Forms,
  u_LOSTB140P in 'u_LOSTB140P.pas' {frm_LOSTB140P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 재발송 입력(LOSTB140P)';
  Application.CreateForm(Tfrm_LOSTB140P, frm_LOSTB140P);
  Application.Run;
end.
