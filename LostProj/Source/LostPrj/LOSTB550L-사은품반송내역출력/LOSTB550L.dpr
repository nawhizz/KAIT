program LOSTB550L;

uses
  Forms,
  u_LOSTB550L in 'u_LOSTB550L.pas' {frm_LOSTB550L};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사은품 반송 내역 출력(LOSTB550L)';
  Application.CreateForm(Tfrm_LOSTB550L, frm_LOSTB550L);
  Application.Run;
end.
