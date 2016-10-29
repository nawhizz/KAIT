program LOSTA640L;

uses
  Forms,
  u_LOSTA640L in 'u_LOSTA640L.pas' {frm_LOSTA640L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTA640L, frm_LOSTA640L);
  Application.Run;
end.
