program LOSTB600L;

uses
  Forms,
  u_LOSTB600L in 'u_LOSTB600L.pas' {frm_LOSTB600L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB600L, frm_LOSTB600L);
  Application.Run;
end.
