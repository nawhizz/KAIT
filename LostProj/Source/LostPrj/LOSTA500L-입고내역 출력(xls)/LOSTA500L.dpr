program LOSTA500L;

uses
  Forms,
  u_LOSTA500L in 'u_LOSTA500L.pas' {frm_LOSTA500L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA500L, frm_LOSTA500L);
  Application.Run;
end.
