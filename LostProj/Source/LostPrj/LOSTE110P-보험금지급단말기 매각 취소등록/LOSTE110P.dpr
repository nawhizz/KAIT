program LOSTE110P;

uses
  Forms,
  u_LOSTE110P in 'u_LOSTE110P.pas' {frm_LOSTE110P};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '사업자전달 취소 입력(LOSTD120P)';
  Application.CreateForm(Tfrm_LOSTE110P, frm_LOSTE110P);
  Application.Run;
end.
