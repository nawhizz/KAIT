program LOSTB200Q;

uses
  Forms,
  u_LOSTB200Q in 'u_LOSTB200Q.pas' {frm_LOSTB200Q},
  u_LOSTB200Q_ADDR in 'u_LOSTB200Q_ADDR.pas' {frm_LOSTB200Q_ADDR},
  u_LOSTB200Q_ADDR2 in 'u_LOSTB200Q_ADDR2.pas' {frm_LOSTB200Q_ADDR2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����Ű��ڻ�������ȸ(_LOSTB200Q)';
  Application.CreateForm(Tfrm_LOSTB200Q, frm_LOSTB200Q);
  Application.CreateForm(Tfrm_LOSTB200Q_ADDR, frm_LOSTB200Q_ADDR);
  Application.CreateForm(Tfrm_LOSTB200Q_ADDR2, frm_LOSTB200Q_ADDR2);
  Application.Run;
end.
