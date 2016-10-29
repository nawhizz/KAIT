program LOSTA510L;

uses
  Forms,
  u_LOSTA510L in 'u_LOSTA510L.pas' {frm_LOSTA510L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA510L, frm_LOSTA510L);
  Application.Run;
end.
