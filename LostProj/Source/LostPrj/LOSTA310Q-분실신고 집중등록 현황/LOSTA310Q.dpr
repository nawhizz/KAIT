program LOSTA310Q;

uses
  Forms,
  LOSTA310Q_PRT_HEAD in '..\LOSTA300Q-�κ�ǰ�԰���Ȳ(�Ϻ�)\LOSTA310Q_PRT_HEAD.pas',
  u_LOSTA310Q in 'u_LOSTA310Q.pas' {frm_LOSTA310Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA310Q, frm_LOSTA310Q);
  Application.Run;
end.
