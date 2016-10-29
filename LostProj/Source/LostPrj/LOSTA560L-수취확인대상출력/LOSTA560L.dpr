program LOSTA560L;

uses
  Forms,
  u_LOSTA560L in 'u_LOSTA560L.pas' {frm_LOSTA560L},
  bsysprv in 'bsysprv.pas' {frm_bsysprv},
  u_landprt in 'u_landprt.pas' {frm_LANDPRT};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA560L, frm_LOSTA560L);
  Application.Run;
end.



