program LOSTA210Q;

uses
  Forms,
  u_LOSTA210Q in 'u_LOSTA210Q.pas' {frm_LOSTA210Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA210Q, frm_LOSTA210Q);
  Application.Run;
end.
