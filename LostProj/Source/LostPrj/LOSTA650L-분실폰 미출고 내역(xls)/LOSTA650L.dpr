program LOSTA650L;

uses
  Forms,
  u_LOSTA650L in 'u_LOSTA650L.pas' {frm_LOSTA650L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA650L, frm_LOSTA650L);
  Application.Run;
end.
