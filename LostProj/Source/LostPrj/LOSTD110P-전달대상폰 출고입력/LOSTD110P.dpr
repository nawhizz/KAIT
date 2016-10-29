program LOSTD110P;

uses
  Forms,
  u_LOSTD110P in 'u_LOSTD110P.pas' {frm_LOSTD110P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사업자 귀속단말기 출고입력(일괄)(LOSTD110P)';
  Application.CreateForm(Tfrm_LOSTD110P, frm_LOSTD110P);
  Application.Run;
end.
