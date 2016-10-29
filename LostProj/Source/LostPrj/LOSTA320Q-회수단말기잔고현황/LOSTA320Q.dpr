program LOSTA320Q;

uses
  Forms,
  u_LOSTA320Q in 'u_LOSTA320Q.pas' {frm_LOSTA320Q},
  LOSTA320Q_PRT_HEAD in 'LOSTA320Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '회수단말기잔고현황(LOSTA320Q)';
  Application.CreateForm(Tfrm_LOSTA320Q, frm_LOSTA320Q);
  Application.Run;
end.
