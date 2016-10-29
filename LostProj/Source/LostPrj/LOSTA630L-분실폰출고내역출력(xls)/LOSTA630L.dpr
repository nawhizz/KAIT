program LOSTA630L;

uses
  Forms,
  u_LOSTA630L in 'u_LOSTA630L.pas' {frm_LOSTA630L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA630L, frm_LOSTA630L);
  Application.Run;
end.
