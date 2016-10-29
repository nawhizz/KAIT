program LOSTZ200P;

uses
  Forms,
  u_LOSTZ200P in 'u_LOSTZ200P.pas' {frm_LOSTZ200P},
  u_LOSTZ200P_child in 'u_LOSTZ200P_child.pas' {frm_LOSTZ200P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ200P, frm_LOSTZ200P);
  Application.CreateForm(Tfrm_LOSTZ200P_CHILD, frm_LOSTZ200P_CHILD);
  Application.Run;
end.
