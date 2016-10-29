program LOSTB580L;

uses
  Forms,
  u_LOSTB580L in 'u_LOSTB580L.pas' {frm_LOSTB580L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB580L, frm_LOSTB580L);
  Application.Run;
end.
