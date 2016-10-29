program LOSTE280L;

uses
  Forms,
  u_LOSTE280L in 'u_LOSTE280L.pas' {frm_LOSTE280L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTE280L, frm_LOSTE280L);
  Application.Run;
end.
