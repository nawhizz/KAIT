program LOSTC530L;

uses
  Forms,
  u_LOSTC530L in 'u_LOSTC530L.pas' {frm_LOSTC530L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTC530L, frm_LOSTC530L);
  Application.Run;
end.
