program LOSTB280Q;

uses
  Forms,
  u_LOSTB280Q in 'u_LOSTB280Q.pas' {frm_LOSTB280Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ü�� ����� ������ ��ȸ(LOSTB280Q)';
  Application.CreateForm(Tfrm_LOSTB280Q, frm_LOSTB280Q);
  Application.Run;
end.
