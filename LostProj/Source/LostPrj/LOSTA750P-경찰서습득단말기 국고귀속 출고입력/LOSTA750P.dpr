program LOSTA750P;

uses
  Forms,
  u_LOSTA750P in 'u_LOSTA750P.pas' {frm_LOSTA750P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����� �ͼӴܸ��� ����Է�(�ϰ�)(LOSTD110P)';
  Application.CreateForm(Tfrm_LOSTA750P, frm_LOSTA750P);
  Application.Run;
end.
