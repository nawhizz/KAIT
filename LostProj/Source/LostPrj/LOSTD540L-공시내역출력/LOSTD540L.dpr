program LOSTD540L;

uses
  Forms,
  u_LOSTD540L in 'u_LOSTD540L.pas' {frm_LOSTD540L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTD540L, frm_LOSTD540L);
  Application.Run;
end.
