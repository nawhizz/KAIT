program LOSTA660L;

uses
  Forms,
  u_LOSTA660L in 'u_LOSTA660L.pas' {frm_LOSTA660L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA660L, frm_LOSTA660L);
  Application.Run;
end.
