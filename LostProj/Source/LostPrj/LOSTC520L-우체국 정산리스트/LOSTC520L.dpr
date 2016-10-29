program LOSTC520L;

uses
  Forms,
  u_LOSTC520L in 'u_LOSTC520L.pas' {frm_LOSTC520L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC520L, frm_LOSTC520L);
  Application.Run;
end.
