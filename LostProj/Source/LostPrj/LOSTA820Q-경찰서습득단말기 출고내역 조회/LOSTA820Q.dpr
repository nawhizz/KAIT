program LOSTA820Q;

uses
  Forms,
  u_LOSTA820Q in 'u_LOSTA820Q.pas' {frm_LOSTA820Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '분실폰전달내역조회';
  Application.CreateForm(Tfrm_LOSTA820Q, frm_LOSTA820Q);
  Application.Run;
end.
