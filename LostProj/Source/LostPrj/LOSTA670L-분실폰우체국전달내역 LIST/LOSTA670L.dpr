program LOSTA670L;

uses
  Forms,
  u_LOSTA670L in 'u_LOSTA670L.pas' {frm_LOSTA670L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н��� ��ü�� ���޳��� LIST(LOSTA670L)';
  Application.CreateForm(Tfrm_LOSTA670L, frm_LOSTA670L);
  Application.Run;
end.
