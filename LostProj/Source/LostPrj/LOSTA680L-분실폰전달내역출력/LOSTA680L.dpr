program LOSTA680L;

uses
  Forms,
  u_LOSTA680L in 'u_LOSTA680L.pas' {frm_LOSTA680L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н��� ���� ���� ���(LOSTA680L)';
  Application.CreateForm(Tfrm_LOSTA680L, frm_LOSTA680L);
  Application.Run;
end.
