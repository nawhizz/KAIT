program LOSTC230Q;

uses
  Forms,
  u_LOSTC230Q in 'u_LOSTC230Q.pas' {frm_LOSTC230Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC230Q, frm_LOSTC230Q);
  Application.Run;
end.
