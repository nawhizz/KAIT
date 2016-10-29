program LOSTC500L;

uses
  Forms,
  u_LOSTC500L in 'u_LOSTC500L.pas' {frm_LOSTC500L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC500L, frm_LOSTC500L);
  Application.Run;
end.
