program LOSTA210Q;

uses
  Forms,
  u_LOSTA210Q in 'u_LOSTA210Q.pas' {frm_LOSTA210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA210Q, frm_LOSTA210Q);
  Application.Run;
end.
