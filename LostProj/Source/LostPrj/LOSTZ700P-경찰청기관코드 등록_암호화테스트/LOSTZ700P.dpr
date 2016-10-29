program LOSTZ700P;

uses
  Forms,
  u_LOSTZ700P in 'u_LOSTZ700P.pas' {frm_LOSTZ700P},
  u_LOSTZ700P_child in 'u_LOSTZ700P_child.pas' {frm_LOSTZ700P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ700P, frm_LOSTZ700P);
  Application.CreateForm(Tfrm_LOSTZ700P_CHILD, frm_LOSTZ700P_CHILD);
  Application.Run;
end.
