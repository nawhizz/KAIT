program LOSTZ800Q;

uses
  Forms,
  u_LOSTZ800Q in 'u_LOSTZ800Q.pas' {frm_LOSTZ800Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����ȣ ���(LOSTZ800Q)';
  Application.CreateForm(Tfrm_LOSTZ800Q, frm_LOSTZ800Q);
  Application.Run;
end.
