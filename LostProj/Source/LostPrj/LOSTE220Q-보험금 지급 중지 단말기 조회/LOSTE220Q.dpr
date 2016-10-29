program LOSTE220Q;

uses
  Forms,
  u_LOSTE220Q in 'u_LOSTE220Q.pas' {frm_LOSTE220Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE220Q, frm_LOSTE220Q);
  Application.Run;
end.
