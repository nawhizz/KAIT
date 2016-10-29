program LOSTA850Q;

uses
  Forms,
  u_LOSTA850Q in 'u_LOSTA850Q.pas' {frm_LOSTA850Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA850Q, frm_LOSTA850Q);
  Application.Run;
end.
