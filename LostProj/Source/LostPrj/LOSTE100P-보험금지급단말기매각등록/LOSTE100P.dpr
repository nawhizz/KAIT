program LOSTE100P;

uses
  Forms,
  u_LOSTE100P in 'u_LOSTE100P.pas' {frm_LOSTE100P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����� �ͼӴܸ��� ����Է�(�ϰ�)(LOSTD110P)';
  Application.CreateForm(Tfrm_LOSTE100P, frm_LOSTE100P);
  Application.Run;
end.
