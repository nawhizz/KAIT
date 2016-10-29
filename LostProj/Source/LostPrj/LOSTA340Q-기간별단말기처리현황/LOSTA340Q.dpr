program LOSTA340Q;

uses
  Forms,
  LOSTA340Q_PRT_HEAD2 in 'LOSTA340Q_PRT_HEAD2.pas',
  u_LOSTA340Q in 'u_LOSTA340Q.pas' {frm_LOSTA340Q},
  LOSTA340Q_PRT_HEAD in 'LOSTA340Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '기간별 단말기 처리 현황';
  Application.CreateForm(Tfrm_LOSTA340Q, frm_LOSTA340Q);
  Application.Run;
end.
