program LOSTB530L;

uses
  Forms,
  u_LOSTB530L in 'u_LOSTB530L.pas' {frm_LOSTB530L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 발송 현황(일별)(LOSTB530L)';
  Application.CreateForm(Tfrm_LOSTB530L, frm_LOSTB530L);
  Application.Run;
end.
