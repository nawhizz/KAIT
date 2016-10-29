program LOSTE240Q;

uses
  Forms,
  u_LOSTE240Q in 'u_LOSTE240Q.pas' {frm_LOSTE240Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE240Q, frm_LOSTE240Q);
  Application.Run;
end.
