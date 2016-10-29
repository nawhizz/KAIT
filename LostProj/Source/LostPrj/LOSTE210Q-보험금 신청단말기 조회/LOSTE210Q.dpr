program LOSTE210Q;

uses
  Forms,
  u_LOSTE210Q in 'u_LOSTE210Q.pas' {frm_LOSTE210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE210Q, frm_LOSTE210Q);
  Application.Run;
end.
