program LOSTD520L;

uses
  Forms,
  u_LOSTD520L in 'u_LOSTD520L.pas' {frm_LOSTD520L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTD520L, frm_LOSTD520L);
  Application.Run;
end.
