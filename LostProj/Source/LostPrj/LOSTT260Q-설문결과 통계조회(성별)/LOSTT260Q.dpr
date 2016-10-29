program LOSTT260Q;

uses
  Forms,
  u_LOSTT260Q in 'u_LOSTT260Q.pas' {fm_LOSTT260Q},
  u_LOSTT260Q_CHILD in 'u_LOSTT260Q_CHILD.pas' {fm_LOSTT260Q_CHILD};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '설문결과 통계 조회(성별)(LOSTT260Q)';
  Application.CreateForm(Tfm_LOSTT260Q, fm_LOSTT260Q);
  Application.CreateForm(Tfm_LOSTT260Q_CHILD, fm_LOSTT260Q_CHILD);
  Application.Run;
end.
