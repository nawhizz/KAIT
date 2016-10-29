program LOSTC130P;

uses
  Forms,
  u_LOSTC130P in 'u_LOSTC130P.pas' {frm_LOSTC130P},
  u_LOSTC130P_CHILD in 'u_LOSTC130P_CHILD.pas' {frm_LOSTC130P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC130P, frm_LOSTC130P);
  Application.CreateForm(Tfrm_LOSTC130P_CHILD, frm_LOSTC130P_CHILD);
  Application.Run;
end.
