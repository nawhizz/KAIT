program LOSTC220Q;

uses
  Forms,
  u_LOSTC220Q in 'u_LOSTC220Q.pas' {frm_LOSTC220Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC220Q, frm_LOSTC220Q);
  Application.Run;
end.
