program LOSTA540L;

uses
  Forms,
  u_LOSTA540L in 'u_LOSTA540L.pas' {frm_LOSTA540L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA540L, frm_LOSTA540L);
  Application.Run;
end.
