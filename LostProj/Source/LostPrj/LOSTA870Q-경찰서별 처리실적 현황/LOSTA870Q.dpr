program LOSTA870Q;

uses
  Forms,
  u_LOSTA870Q in 'u_LOSTA870Q.pas' {frm_LOSTA870Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '처리자별실적현황(LOSTT230Q)';
  Application.CreateForm(Tfrm_LOSTA870Q, frm_LOSTA870Q);
  Application.Run;
end.
