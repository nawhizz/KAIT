program LOSTB500L;

uses
  Forms,
  u_LOSTB500L in 'u_LOSTB500L.pas' {frm_LOSTB500L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB500L, frm_LOSTB500L);
  Application.Title := '사은품전달현형출력(LOSTB500L)';
  Application.Run;
end.
