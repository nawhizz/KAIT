program LOSTA850Q;

uses
  Forms,
  u_LOSTA850Q in 'u_LOSTA850Q.pas' {frm_LOSTA850Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA850Q, frm_LOSTA850Q);
  Application.Run;
end.
