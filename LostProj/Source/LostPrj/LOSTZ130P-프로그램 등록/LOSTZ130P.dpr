program LOSTZ130P;

uses
  Forms,
  u_LOSTZ130P in 'u_LOSTZ130P.pas' {frm_LOSTZ130P},
  u_LOSTZ130_CHILD in 'u_LOSTZ130_CHILD.pas' {frm_LOSTZ130P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ130P, frm_LOSTZ130P);
  Application.CreateForm(Tfrm_LOSTZ130P_CHILD, frm_LOSTZ130P_CHILD);
  Application.Run;
end.
