program LOSTZ250P;

uses
  Forms,
  u_LOSTZ250P in 'u_LOSTZ250P.pas' {frm_LOSTZ250P},
  u_LOSTZ250P_CHILD in 'u_LOSTZ250P_CHILD.pas' {frm_LOSTZ250P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTZ250P, frm_LOSTZ250P);
  Application.CreateForm(Tfrm_LOSTZ250P_CHILD, frm_LOSTZ250P_CHILD);
  Application.Run;
end.
