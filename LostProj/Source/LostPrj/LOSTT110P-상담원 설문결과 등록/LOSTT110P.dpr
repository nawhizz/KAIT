program LOSTT110P;

uses
  Forms,
  u_LOSTT110P in 'u_LOSTT110P.pas' {fm_LOSTT110P},
  u_LOSTT110P_CHILD in 'u_LOSTT110P_CHILD.pas' {fm_LOSTT110P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���� ������� ���(LOSTT100P)';
  Application.CreateForm(Tfm_LOSTT110P, fm_LOSTT110P);
  Application.CreateForm(Tfm_LOSTT110P_CHILD, fm_LOSTT110P_CHILD);
  Application.Run;
end.
