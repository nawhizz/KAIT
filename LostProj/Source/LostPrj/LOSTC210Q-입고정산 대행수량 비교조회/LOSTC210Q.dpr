program LOSTC210Q;

uses
  Forms,
  u_LOSTC210Q in 'u_LOSTC210Q.pas' {frm_LOSTC210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC210Q, frm_LOSTC210Q);
  Application.Run;
end.
