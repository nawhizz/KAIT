program LOSTE270L;

uses
  Forms,
  u_LOSTE270L in 'u_LOSTE270L.pas' {frm_LOSTE270L},
  bsysprv in 'bsysprv.pas' {frm_bsysprv},
  u_landprt in 'u_landprt.pas' {frm_LANDPRT};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE270L, frm_LOSTE270L);
  Application.Run;
end.



