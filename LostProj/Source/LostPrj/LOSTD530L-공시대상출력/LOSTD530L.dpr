program LOSTD530L;

uses
  Forms,
  u_LOSTD530L in 'u_LOSTD530L.pas' {frm_LOSTD530L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTD530L, frm_LOSTD530L);
  Application.Run;
end.
