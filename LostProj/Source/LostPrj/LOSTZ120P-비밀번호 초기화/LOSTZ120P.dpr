program LOSTZ120P;

uses
  Forms,
  u_LOSTZ120P in 'u_LOSTZ120P.pas' {frm_LOSTZ120P},
  u_LOSTZ120P_pop in 'u_LOSTZ120P_pop.pas' {frm_LOSTZ120P_pop};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ120P, frm_LOSTZ120P);
  Application.CreateForm(Tfrm_LOSTZ120P_pop, frm_LOSTZ120P_pop);
  Application.Run;
end.
