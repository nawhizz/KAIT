program LOSTZ240P;

uses
  Forms,
  u_LOSTZ240P in 'u_LOSTZ240P.pas' {frm_LOSTZ240P},
  u_LOSTZ240P_child in 'u_LOSTZ240P_child.pas' {frm_LOSTZ240P_CHILD},
  LOSTZ240P_PRT_HEAD in 'LOSTZ240P_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ240P, frm_LOSTZ240P);
  Application.CreateForm(Tfrm_LOSTZ240P_CHILD, frm_LOSTZ240P_CHILD);
  Application.Run;
end.
