program LOSTT240Q;

uses
  Forms,
  u_LOSTT240Q in 'u_LOSTT240Q.pas' {fm_LOSTT240Q},
  u_LOSTT240Q_CHILD in 'u_LOSTT240Q_CHILD.pas' {fm_LOSTT240Q_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������� ��� ��ȸ ����(LOSTT240Q)';
  Application.CreateForm(Tfm_LOSTT240Q, fm_LOSTT240Q);
  Application.CreateForm(Tfm_LOSTT240Q_CHILD, fm_LOSTT240Q_CHILD);
  Application.Run;
end.
