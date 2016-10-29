program LOSTB270Q;

uses
  Forms,
  u_LOSTB270Q in 'u_LOSTB270Q.pas' {frm_LOSTB270Q};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 재발송대상자 추출';
  Application.CreateForm(Tfrm_LOSTB270Q, frm_LOSTB270Q);
  Application.Run;
end.
