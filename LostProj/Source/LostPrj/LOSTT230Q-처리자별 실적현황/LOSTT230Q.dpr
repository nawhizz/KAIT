program LOSTT230Q;

uses
  Forms,
  u_LOSTT230Q in 'u_LOSTT230Q.pas' {frm_LOSTT230Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '처리자별실적현황(LOSTT230Q)';
  Application.CreateForm(Tfrm_LOSTT230Q, frm_LOSTT230Q);
  Application.Run;
end.
