program LOSTA250Q;

uses
  Forms,
  u_LOSTA250Q in 'u_LOSTA250Q.pas' {frm_LOSTA250Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н��� ���� ���º� ��ȸ(LOSTA250Q)';
  Application.CreateForm(Tfrm_LOSTA250Q, frm_LOSTA250Q);
  Application.Run;
end.
