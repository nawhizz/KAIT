program LOSTA860Q;

uses
  Forms,
  u_LOSTA860Q in 'u_LOSTA860Q.pas' {frm_LOSTA860Q};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA860Q, frm_LOSTA860Q);
  Application.Run;
end.
