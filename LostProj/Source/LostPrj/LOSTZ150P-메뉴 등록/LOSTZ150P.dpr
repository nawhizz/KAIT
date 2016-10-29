program LOSTZ150P;

uses
  Forms,
  u_LOSTZ150P in 'u_LOSTZ150P.pas' {frm_LOSTZ150P},
  u_LOSTZ150P_CHILD in 'u_LOSTZ150P_CHILD.pas' {frm_LOSTZ150P_child},
  u_LOSTZ150P_pop in 'u_LOSTZ150P_pop.pas' {frm_LOSTZ150P_pop};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ150P, frm_LOSTZ150P);
  Application.CreateForm(Tfrm_LOSTZ150P_child, frm_LOSTZ150P_child);
  Application.CreateForm(Tfrm_LOSTZ150P_pop, frm_LOSTZ150P_pop);
  Application.Run;
end.
