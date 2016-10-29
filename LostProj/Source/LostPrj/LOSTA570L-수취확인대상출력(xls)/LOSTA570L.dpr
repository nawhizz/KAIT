program LOSTA570L;

uses
  Forms,
  u_LOSTA570L in 'u_LOSTA570L.pas' {frm_LOSTA570L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA570L, frm_LOSTA570L);
  Application.Run;
end.
