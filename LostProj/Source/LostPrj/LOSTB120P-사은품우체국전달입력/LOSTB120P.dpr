program LOSTB120P;

uses
  Forms,
  u_LOSTB120P in 'u_LOSTB120P.pas' {frm_LOSTB120P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 우체국 전달 입력(LOSTB120P)';
  Application.CreateForm(Tfrm_LOSTB120P, frm_LOSTB120P);
  Application.Run;
end.
