program LOSTB140P;

uses
  Forms,
  u_LOSTB140P in 'u_LOSTB140P.pas' {frm_LOSTB140P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ǰ ��߼� �Է�(LOSTB140P)';
  Application.CreateForm(Tfrm_LOSTB140P, frm_LOSTB140P);
  Application.Run;
end.
