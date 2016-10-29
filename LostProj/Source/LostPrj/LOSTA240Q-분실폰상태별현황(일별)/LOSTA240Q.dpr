program LOSTA240Q;

uses
  Forms,
  u_LOSTA240Q in 'u_LOSTA240Q.pas' {frm_LOSTA240Q},
  LOSTA240Q_PRT_HEAD in 'LOSTA240Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰상태별현황(일별)';
  Application.CreateForm(Tfrm_LOSTA240Q, frm_LOSTA240Q);
  Application.Run;
end.
