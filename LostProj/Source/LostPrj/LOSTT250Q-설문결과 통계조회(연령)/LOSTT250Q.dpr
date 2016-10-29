program LOSTT250Q;

uses
  Forms,
  u_LOSTT250Q in 'u_LOSTT250Q.pas' {fm_LOSTT250Q},
  u_LOSTT250Q_CHILD in 'u_LOSTT250Q_CHILD.pas' {fm_LOSTT250Q_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '설문결과 통계 조회 (연령)(LOSTT250Q)';
  Application.CreateForm(Tfm_LOSTT250Q, fm_LOSTT250Q);
  Application.CreateForm(Tfm_LOSTT250Q_CHILD, fm_LOSTT250Q_CHILD);
  Application.Run;
end.
