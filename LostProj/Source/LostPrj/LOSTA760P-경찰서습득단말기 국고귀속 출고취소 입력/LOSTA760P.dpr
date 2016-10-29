program LOSTA760P;

uses
  Forms,
  u_LOSTA760P in 'u_LOSTA760P.pas' {frm_LOSTA760P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사업자전달 취소 입력(LOSTD120P)';
  Application.CreateForm(Tfrm_LOSTA760P, frm_LOSTA760P);
  Application.Run;
end.
