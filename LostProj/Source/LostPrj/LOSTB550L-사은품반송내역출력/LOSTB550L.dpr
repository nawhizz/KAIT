program LOSTB550L;

uses
  Forms,
  u_LOSTB550L in 'u_LOSTB550L.pas' {frm_LOSTB550L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ǰ �ݼ� ���� ���(LOSTB550L)';
  Application.CreateForm(Tfrm_LOSTB550L, frm_LOSTB550L);
  Application.Run;
end.
