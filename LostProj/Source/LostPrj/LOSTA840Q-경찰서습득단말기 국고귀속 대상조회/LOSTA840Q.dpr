program LOSTA840Q;

uses
  Forms,
  u_LOSTA840Q in 'u_LOSTA840Q.pas' {frm_LOSTA840Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA840Q, frm_LOSTA840Q);
  Application.Run;
end.
