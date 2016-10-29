program LOSTD500L;

uses
  Forms,
  u_LOSTD500L in 'u_LOSTD500L.pas' {frm_LOSTD500L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTD500L, frm_LOSTD500L);
  Application.Run;
end.
