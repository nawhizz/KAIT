program LOSTC510L;

uses
  Forms,
  u_LOSTC510L in 'u_LOSTC510L.pas' {frm_LOSTC510L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC510L, frm_LOSTC510L);
  Application.Run;
end.
