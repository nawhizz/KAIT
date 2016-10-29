program LOSTA830Q;

uses
  Forms,
  u_LOSTA830Q in 'u_LOSTA830Q.pas' {frm_LOSTA830Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA830Q, frm_LOSTA830Q);
  Application.Run;
end.
