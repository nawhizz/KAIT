program LOSTD110P;

uses
  Forms,
  u_LOSTD110P in 'u_LOSTD110P.pas' {frm_LOSTD110P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����� �ͼӴܸ��� ����Է�(�ϰ�)(LOSTD110P)';
  Application.CreateForm(Tfrm_LOSTD110P, frm_LOSTD110P);
  Application.Run;
end.
