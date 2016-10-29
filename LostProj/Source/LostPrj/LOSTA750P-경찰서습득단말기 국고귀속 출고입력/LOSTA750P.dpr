program LOSTA750P;

uses
  Forms,
  u_LOSTA750P in 'u_LOSTA750P.pas' {frm_LOSTA750P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사업자 귀속단말기 출고입력(일괄)(LOSTD110P)';
  Application.CreateForm(Tfrm_LOSTA750P, frm_LOSTA750P);
  Application.Run;
end.
