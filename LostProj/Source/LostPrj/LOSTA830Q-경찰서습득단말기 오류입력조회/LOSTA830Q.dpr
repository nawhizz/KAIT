program LOSTA830Q;

uses
  Forms,
  u_LOSTA830Q in 'u_LOSTA830Q.pas' {frm_LOSTA830Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA830Q, frm_LOSTA830Q);
  Application.Run;
end.
