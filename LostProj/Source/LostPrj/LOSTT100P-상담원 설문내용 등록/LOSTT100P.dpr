program LOSTT100P;

uses
  Forms,
  u_LOSTT100P in 'u_LOSTT100P.pas' {fm_LOSTT100P},
  u_LOSTT100P_CHILD in 'u_LOSTT100P_CHILD.pas' {fm_LOSTT100P_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '상담원 설문내용 등록(LOSTT100P)';
  Application.CreateForm(Tfm_LOSTT100P, fm_LOSTT100P);
  Application.CreateForm(Tfm_LOSTT100P_CHILD, fm_LOSTT100P_CHILD);
  Application.Run;
end.
