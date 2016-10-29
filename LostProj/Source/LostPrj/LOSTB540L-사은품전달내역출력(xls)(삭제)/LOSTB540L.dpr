program LOSTB540L;

uses
  Forms,
  u_lostp02l in 'u_lostp02l.pas' {frm_LOSTP02L};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm_LOSTP02L, frm_LOSTP02L);
  Application.Run;
end.
