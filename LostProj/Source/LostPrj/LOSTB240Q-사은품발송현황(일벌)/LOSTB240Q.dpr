program LOSTB240Q;

uses
  Forms,
  u_LOSTB240Q in 'u_LOSTB240Q.pas' {frm_LOSTB240Q},
  LOSTB240Q_PRT_HEAD in 'LOSTB240Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB240Q, frm_LOSTB240Q);
  Application.Title :='사은품발송현황관리(LOSTB240Q)';
  Application.Run;
end.
