program LOSTA800Q;

uses
  Forms,
  u_LOSTA800Q in 'u_LOSTA800Q.pas' {frm_LOSTA800Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA800Q, frm_LOSTA800Q);
  Application.Run;
end.
