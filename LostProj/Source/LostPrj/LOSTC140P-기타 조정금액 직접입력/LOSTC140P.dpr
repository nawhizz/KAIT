program LOSTC140P;

uses
  Forms,
  u_LOSTC140P in 'u_LOSTC140P.pas' {frm_LOSTC140P},
  u_LOSTC140P_CHILD in 'u_LOSTC140P_CHILD.pas' {frm_LOSTC140P_CHILD},
  u_LOSTC140P_POP in 'u_LOSTC140P_POP.pas' {frm_LOSTC140P_POP};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC140P, frm_LOSTC140P);
  Application.CreateForm(Tfrm_LOSTC140P_CHILD, frm_LOSTC140P_CHILD);
  Application.CreateForm(Tfrm_LOSTC140P_POP, frm_LOSTC140P_POP);
  Application.Run;
end.
