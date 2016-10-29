program LOSTA520L;

uses
  Forms,
  u_LOSTA520L in 'u_LOSTA520L.pas' {frm_LOSTA520L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA520L, frm_LOSTA520L);
  Application.Run;
end.
