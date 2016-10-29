program LOSTB560L;

uses
  Forms,
  u_LOSTB560L in 'u_LOSTB560L.pas' {frm_LOSTB560L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB560L, frm_LOSTB560L);
  Application.Run;
end.
