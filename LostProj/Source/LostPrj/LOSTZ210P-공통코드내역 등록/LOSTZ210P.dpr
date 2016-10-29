program LOSTZ210P;

uses
  Forms,
  u_LOSTZ210P in 'u_LOSTZ210P.pas' {frm_LOSTZ210P},
  u_LOSTZ210P_child in 'u_LOSTZ210P_child.pas' {frm_LOSTZ210P_CHILD},
  u_LOSTZ210P_POP in 'u_LOSTZ210P_POP.pas' {frm_LOSTZ210P_POP};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ210P, frm_LOSTZ210P);
  Application.CreateForm(Tfrm_LOSTZ210P_CHILD, frm_LOSTZ210P_CHILD);
  Application.CreateForm(Tfrm_LOSTZ210P_POP, frm_LOSTZ210P_POP);
  Application.Run;
end.
