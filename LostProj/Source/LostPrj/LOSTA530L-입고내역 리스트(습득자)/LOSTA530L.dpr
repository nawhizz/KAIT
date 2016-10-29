program LOSTA530L;

uses
  Forms,
  u_LOSTA530L in 'u_LOSTA530L.pas' {frm_LOSTA530L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA530L, frm_LOSTA530L);
  Application.Run;
end.
