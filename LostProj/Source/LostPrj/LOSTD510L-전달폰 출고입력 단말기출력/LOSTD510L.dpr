program LOSTD510L;

uses
  Forms,
  u_LOSTD510L in 'u_LOSTD510L.pas' {frm_LOSTD510L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTD510L, frm_LOSTD510L);
  Application.Run;
end.
