program LOSTB120P;

uses
  Forms,
  u_LOSTB120P in 'u_LOSTB120P.pas' {frm_LOSTB120P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ǰ ��ü�� ���� �Է�(LOSTB120P)';
  Application.CreateForm(Tfrm_LOSTB120P, frm_LOSTB120P);
  Application.Run;
end.
