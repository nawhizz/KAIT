program LOSTA130P;

uses
  Forms,
  u_LOSTA130P in 'u_LOSTA130P.pas' {frm_LOSTA130P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н��� ��ü�� �ۺ� �Է�(LOSTA130P)';
  Application.CreateForm(Tfrm_LOSTA130P, frm_LOSTA130P);
  Application.Run;
end.
