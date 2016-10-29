program LOSTA300Q;

uses
  Forms,
  u_LOSTA300Q in 'u_LOSTA300Q.pas' {frm_LOSTA300Q},
  LOSTA300Q_PRT_HEAD in 'LOSTA300Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '재활용부분품입고현황(일별)';
  Application.CreateForm(Tfrm_LOSTA300Q, frm_LOSTA300Q);
  Application.Run;
end.
