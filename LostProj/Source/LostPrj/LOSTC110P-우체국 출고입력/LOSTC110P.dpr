program LOSTC110P;

uses
  Forms,
  u_LOSTC110P in 'u_LOSTC110P.pas' {frm_LOSTC110P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ü��ó�� ��� �Է�(LOSTC110P)';
  Application.CreateForm(Tfrm_LOSTC110P, frm_LOSTC110P);
  Application.Run;
end.
