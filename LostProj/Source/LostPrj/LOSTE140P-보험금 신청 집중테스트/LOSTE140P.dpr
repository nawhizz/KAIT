program LOSTE140P;

uses
  Forms,
  u_LOSTE140P in 'u_LOSTE140P.pas' {frm_LOSTE140P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��������� ��� �Է�(LOSTD120P)';
  Application.CreateForm(Tfrm_LOSTE140P, frm_LOSTE140P);
  Application.Run;
end.
