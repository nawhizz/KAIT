program LOSTA840Q;

uses
  Forms,
  u_LOSTA840Q in 'u_LOSTA840Q.pas' {frm_LOSTA840Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA840Q, frm_LOSTA840Q);
  Application.Run;
end.
