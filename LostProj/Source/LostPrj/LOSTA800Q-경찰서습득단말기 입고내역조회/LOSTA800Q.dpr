program LOSTA800Q;

uses
  Forms,
  u_LOSTA800Q in 'u_LOSTA800Q.pas' {frm_LOSTA800Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA800Q, frm_LOSTA800Q);
  Application.Run;
end.
