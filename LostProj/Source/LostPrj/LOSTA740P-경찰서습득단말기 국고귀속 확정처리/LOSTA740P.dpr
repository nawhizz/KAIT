program LOSTA740P;

uses
  Forms,
  u_LOSTA740P in 'u_LOSTA740P.pas' {frm_LOSTA740P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����������ܸ��� ����ͼ� Ȯ��ó��(LOSTA740P)';
  Application.CreateForm(Tfrm_LOSTA740P, frm_LOSTA740P);
  Application.Run;
end.
