program LOSTD120P;

uses
  Forms,
  u_LOSTD120P in 'u_LOSTD120P.pas' {frm_LOSTD120P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��������� ��� �Է�(LOSTD120P)';
  Application.CreateForm(Tfrm_LOSTD120P, frm_LOSTD120P);
  Application.Run;
end.
