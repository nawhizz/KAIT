program LOSTE230Q;

uses
  Forms,
  u_LOSTE230Q in 'u_LOSTE230Q.pas' {frm_LOSTE230Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE230Q, frm_LOSTE230Q);
  Application.Run;
end.
