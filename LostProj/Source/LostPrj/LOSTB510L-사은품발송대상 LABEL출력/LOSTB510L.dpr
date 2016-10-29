program LOSTB510L;

uses
  Forms,
  u_LOSTB510L in 'u_LOSTB510L.pas' {frm_LOSTB510L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTB510L, frm_LOSTB510L);
  Application.Run;
end.
