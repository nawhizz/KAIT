program LOSTA580L;

uses
  Forms,
  u_LOSTA580L in 'u_LOSTA580L.pas' {frm_LOSTA580L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA580L, frm_LOSTA580L);
  Application.Run;
end.
