program LOSTA610L;

uses
  Forms,
  u_LOSTA610L in 'u_LOSTA610L.pas' {frm_LOSTA610L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA610L, frm_LOSTA610L);
  Application.Run;
end.
