program LOSTC120P;

uses
  Forms,
  u_LOSTC120P in 'u_LOSTC120P.pas' {frm_LOSTC120P},
  u_LOSTC120P_CHILD in 'u_LOSTC120P_CHILD.pas' {frm_LOSTC120P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC120P, frm_LOSTC120P);
  Application.CreateForm(Tfrm_LOSTC120P_CHILD, frm_LOSTC120P_CHILD);
  Application.Run;
end.
