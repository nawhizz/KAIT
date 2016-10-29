program LOSTE200Q;

uses
  Forms,
  u_LOSTE200Q in 'u_LOSTE200Q.pas' {frm_LOSTE200Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE200Q, frm_LOSTE200Q);
  Application.Run;
end.
