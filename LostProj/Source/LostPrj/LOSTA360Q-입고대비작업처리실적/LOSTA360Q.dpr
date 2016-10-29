program LOSTA360Q;

uses
  Forms,
  u_LOSTA360Q in 'u_LOSTA360Q.pas' {frm_LOSTA360Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '입고대비작업처리실적(LOSTA360Q)';
  Application.CreateForm(Tfrm_LOSTA360Q, frm_LOSTA360Q);
  Application.Run;
end.
