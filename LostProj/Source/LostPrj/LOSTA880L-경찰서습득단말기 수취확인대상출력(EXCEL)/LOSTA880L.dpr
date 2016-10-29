program LOSTA880L;

uses
  Forms,
  u_LOSTA880L in 'u_LOSTA880L.pas' {frm_LOSTA880L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA880L, frm_LOSTA880L);
  Application.Run;
end.
