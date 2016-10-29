program LOSTA230Q;

uses
  Forms,
  u_LOSTA230Q in 'u_LOSTA230Q.pas' {frm_LOSTA230Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실본 입/출고 현황(LOSTA230Q)';
  Application.CreateForm(Tfrm_LOSTA230Q, frm_LOSTA230Q);
  Application.Run;
end.
