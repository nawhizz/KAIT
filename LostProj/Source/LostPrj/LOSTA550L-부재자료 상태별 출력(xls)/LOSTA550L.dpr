program LOSTA550L;

uses
  Forms,
  u_LOSTA550L in 'u_LOSTA550L.pas' {frm_LOSTA550L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA550L, frm_LOSTA550L);
  Application.Run;
end.
