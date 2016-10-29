program LOSTB570L;

uses
  Forms,
  u_LOSTB570L in 'u_LOSTB570L.pas' {frm_LOSTB570L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품재발송LABEL출력(LOSTB570L)';
  Application.CreateForm(Tfrm_LOSTB570L, frm_LOSTB570L);
  Application.Run;
end.
