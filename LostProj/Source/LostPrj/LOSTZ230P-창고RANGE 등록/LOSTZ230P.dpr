program LOSTZ230P;

uses
  Forms,
  u_LOSTZ230P in 'u_LOSTZ230P.pas' {frm_LOSTZ230P},
  u_LOSTZ230P_child in 'u_LOSTZ230P_child.pas' {frm_LOSTZ230P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ230P, frm_LOSTZ230P);
  Application.CreateForm(Tfrm_LOSTZ230P_CHILD, frm_LOSTZ230P_CHILD);
  Application.Run;
end.
