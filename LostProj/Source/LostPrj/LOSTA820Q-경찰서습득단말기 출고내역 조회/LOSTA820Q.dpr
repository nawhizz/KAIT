program LOSTA820Q;

uses
  Forms,
  u_LOSTA820Q in 'u_LOSTA820Q.pas' {frm_LOSTA820Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�н������޳�����ȸ';
  Application.CreateForm(Tfrm_LOSTA820Q, frm_LOSTA820Q);
  Application.Run;
end.
