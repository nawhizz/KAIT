program LOSTA300Q;

uses
  Forms,
  u_LOSTA300Q in 'u_LOSTA300Q.pas' {frm_LOSTA300Q},
  LOSTA300Q_PRT_HEAD in 'LOSTA300Q_PRT_HEAD.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ȱ��κ�ǰ�԰���Ȳ(�Ϻ�)';
  Application.CreateForm(Tfrm_LOSTA300Q, frm_LOSTA300Q);
  Application.Run;
end.
