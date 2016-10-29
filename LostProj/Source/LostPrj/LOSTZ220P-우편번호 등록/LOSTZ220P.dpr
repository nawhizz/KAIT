program LOSTZ220P;

uses
  Forms,
  u_LOSTZ220P in 'u_LOSTZ220P.pas' {frm_LOSTZ220P},
  u_LOSTZ220P_child in 'u_LOSTZ220P_child.pas' {frm_LOSTZ220P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ220P, frm_LOSTZ220P);
  Application.CreateForm(Tfrm_LOSTZ220P_CHILD, frm_LOSTZ220P_CHILD);
  Application.Run;
end.
